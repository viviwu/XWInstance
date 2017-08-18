/**
 * vivi wu
 * ideaMap
 //
 //  Created by viviwu on 2017/1/15.
 //  Copyright © 2017年 viviwu. All rights reserved.
 *
 * See LICENSE
 */

#import <objc/runtime.h>
#import <objc/message.h>
#import "XWCacao.h"
#import "XWLog.h"
#import "XWObjcProperty.h"
#import "NSObject+XWCacao.h"

static NSString *const XW_AUTOWIRE_METHOD_PREFIX = @"XW_autowire_";
static NSString *const XW_MANUALWIRE_METHOD_PREFIX = @"XW_manualwire_";
static NSString *const XW_SCOPE_METHOD = @"XW_scope";

#pragma mark Static
NSArray *subclasses_of_class(Class parentClass) {
    int classCount = objc_getClassList(NULL, 0);
    Class *classes = (Class *) malloc(sizeof(Class) * classCount);

    classCount = objc_getClassList(classes, classCount);
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < classCount; i++) {
        Class superClass = classes[i];

        do {
            superClass = class_getSuperclass(superClass);
        } while (superClass && superClass != parentClass);

        if (superClass == nil) {
            continue;
        }

        [result addObject:classes[i]];
    }

    free(classes);

    return result;
}

NSArray *classes_conforming_to_protocol(Protocol *aProtocol) {
    int classCount = objc_getClassList(NULL, 0);
    Class *classes = (Class *) malloc(sizeof(Class) * classCount);

    classCount = objc_getClassList(classes, classCount);
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0; i < classCount; i++) {
        if (class_conformsToProtocol(classes[i], aProtocol)) {
            [result addObject:classes[i]];
        }
    }

    free(classes);

    return result;
}

BOOL class_is_bean(Class cls) {
    if (class_conformsToProtocol(cls, @protocol(XWBean))) {
        return YES;
    }

    unsigned int methodCount;
    Method *methods = class_copyMethodList(object_getClass(cls), &methodCount);

    BOOL result = NO;
    for (int i = 0; i < methodCount; i++) {
        if (@selector(isBean) == method_getName(methods[i])) {
            result = YES;
            break;
        }
    }

    free(methods);

    return result;
}

@implementation XWContext {
    NSMutableArray *_beanContainers;
    BOOL _contextInitialized;
}

@synthesize beanContainers = _beanContainers;

#pragma mark Public
- (void)initContext {
    if (_contextInitialized) {
        return;
    }

    _contextInitialized = YES;

    NSArray *classesOfBeans = subclasses_of_class([NSObject class]);
    [self initializeBeans:classesOfBeans];
    [self initializeManualBeans:classes_conforming_to_protocol(@protocol(XWManualBeanProvider))];

    [self autowireBeans];

    [self callPostConstruct];
}

- (void)addBeanContainer:(XWBeanContainer *)beanContainer {
    for (XWBeanContainer *existingBean in self.beanContainers) {
        if ([existingBean.identifier isEqualToString:beanContainer.identifier]) {
            log4Warn(@"Trying to add a bean with the same identifier '%@'.", existingBean.identifier);
            return;
        }
    }

    [_beanContainers addObject:beanContainer];
}

- (XWBeanContainer *)beanContainerWithIdentifier:(NSString *)identifier {
    for (XWBeanContainer *bean in self.beanContainers) {
        if ([identifier isEqualToString:bean.identifier]) {
            return bean;
        }
    }

    return nil;
}

- (id)beanWithClass:(Class)clazz {
    return [self beanWithIdentifier:[clazz description]];
}

- (id)beanWithIdentifier:(NSString *)identifier {
    return [self beanContainerWithIdentifier:identifier].targetSource;
}

- (NSString *)identifierForBean:(id)bean {
    for (XWBeanContainer *beanContainer in self.beanContainers) {
        if (bean == beanContainer.targetSource) {
            return beanContainer.identifier;
        }
    }

    return nil;
}

- (void)autowireSeed:(id)seed {
    [self autowireTargetSource:seed methodPrefix:XW_MANUALWIRE_METHOD_PREFIX];
}

- (void)replaceBeanWithIdentifier:(NSString *)identifier withBean:(id)aBean {
    XWBeanContainer *newBean = [XWBeanContainer beanContainerWithIdentifier:identifier bean:aBean];

    XWBeanContainer *oldBean;
    for (XWBeanContainer *bean in self.beanContainers) {
        if ([bean isEqual:newBean]) {
            oldBean = bean;
            break;
        }
    }

    [_beanContainers removeObject:oldBean];
    [_beanContainers addObject:newBean];
}

- (void)reautowireBeans {
    [self autowireBeans];
}

#pragma mark NSObject
- (id)init {
    self = [super init];
    if (self) {
        _beanContainers = [[NSMutableArray alloc] init];
    }

    return self;
}

+ (XWContext *)sharedContext {
    static XWContext *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

#pragma mark Private
- (void)initializeBeans:(NSArray *)classes {
    for (Class cls in classes) {
        if (class_is_bean(cls)) {
            log4Debug(@"Bean of class '%@' found.", cls);

            NSString *className = [cls classAsString];
            id beanInstance = [[cls alloc] init];

            XWBeanContainer *cacao = [XWBeanContainer beanContainerWithIdentifier:className bean:beanInstance];
            [self addBeanContainer:cacao];
        }
    }
}

- (void)initializeManualBeans:(NSArray *)classes {
    for (Class cls in classes) {
        log4Debug(@"Adding manual beans of %@", cls);
        [self addAllBeans:[cls beanContainers]];
    }
}

- (void)addAllBeans:(NSArray *)manyBeans {
    [_beanContainers addObjectsFromArray:manyBeans];
}

- (NSString *)classNameOfProperty:(NSString *)propertyName andClass:(Class)cls {
    NSArray *properties = [cls objcProperties];

    for (XWObjcProperty *property in properties) {
        if ([property.name isEqualToString:propertyName]) {
            return property.nameOfClass;
        }
    }

    return nil;
}

- (void)autowireBeans {
    for (XWBeanContainer *bean in self.beanContainers) {
        [self autowireTargetSource:bean.targetSource methodPrefix:XW_AUTOWIRE_METHOD_PREFIX];
    }
}

- (void)autowireTargetSource:(id)targetSource methodPrefix:(NSString *)methodPrefix {
    Class superclass = [targetSource class];
    do {
        [self autowireTargetSource:targetSource asClass:superclass methodPrefix:methodPrefix];
        superclass = class_getSuperclass(superclass);
    } while (superclass && superclass != [NSObject class]);
}

- (void)autowireTargetSource:(id)targetSource asClass:(Class)cls methodPrefix:(NSString *)methodPrefix {
    unsigned int methodCount;
    Method *methods = class_copyMethodList(object_getClass(cls), &methodCount);

    for (int i = 0; i < methodCount; i++) {
        SEL sel = method_getName(methods[i]);
        NSString *methodName = [[NSString alloc] initWithCString:sel_getName(sel) encoding:NSUTF8StringEncoding];

        if ([methodName length] < [methodPrefix length]) {
            continue;
        }

        if (![[methodName substringToIndex:[methodPrefix length]] isEqualToString:methodPrefix]) {
            continue;
        }
//#warning "- Project - Build Settings - ENABLE_STRICT_OBJC_MSGSEND" == NO 
      id propertyKey = objc_msgSend(cls , sel);
        NSString *nameOfBeanClass = [self classNameOfProperty:propertyKey andClass:cls];

        id beanToBeAutowired = [self beanContainerWithIdentifier:nameOfBeanClass].targetSource;
        [targetSource setValue:beanToBeAutowired forKey:propertyKey];

        log4Debug(@"Autowiring property '%@' of type '%@' from '%@'.", propertyKey, nameOfBeanClass, NSStringFromClass(cls));
    }

    free(methods);
}

- (void)callPostConstruct {
    NSMutableArray *beans = [[NSMutableArray alloc] init];
    for (XWBeanContainer *beanContainer in _beanContainers) {
        if (class_conformsToProtocol([beanContainer.targetSource class], @protocol(XWInitializingBean))) {
            [beans addObject:beanContainer.targetSource];
        }
    }

    NSArray *sortedBeans = [beans sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSUInteger orderA = (NSUInteger) ([a respondsToSelector:@selector(XW_postConstructOrder)] ? [a XW_postConstructOrder] : NSUIntegerMax);
        NSUInteger orderB = (NSUInteger) ([b respondsToSelector:@selector(XW_postConstructOrder)] ? [b XW_postConstructOrder] : NSUIntegerMax);

        if (orderA < orderB) {
            return NSOrderedAscending;
        }

        if (orderA > orderB) {
            return NSOrderedDescending;
        }

        return NSOrderedSame;
    }];

    for (id bean in sortedBeans) {
        [bean postConstruct];
    }
}

@end
