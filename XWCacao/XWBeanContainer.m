/**
 * vivi wu
 * ideaMap
 //
 //  Created by viviwu on 2017/1/15.
 //  Copyright © 2017年 viviwu. All rights reserved.
 *
 * See LICENSE
 */

#import "XWBeanContainer.h"
#import "NSObject+XWCacao.h"


@implementation XWBeanContainer

#pragma mark Public
- (id)initWithBean:(id)bean {
    return [self initWithIdentifier:[[bean class] classAsString] bean:bean];
}

- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean {
    return [self initWithIdentifier:anIdentifier bean:aBean scope:XWBeanScopeSingleton];
}

- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean scope:(XWBeanScope)aScope {
    self = [super init];
    if (self) {
        _identifier = anIdentifier;
        _targetSource = aBean;
        _scope = aScope;
    }

    return self;
}

+ (id)beanContainerWithBean:(id)targetSource {
    return [[XWBeanContainer alloc] initWithBean:targetSource];
}

+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean {
    return [[XWBeanContainer alloc] initWithIdentifier:anIdentifier bean:aBean];
}

+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean scope:(XWBeanScope)aScope {
    return [[XWBeanContainer alloc] initWithIdentifier:anIdentifier bean:aBean scope:aScope];
}

#pragma mark NSObject
- (BOOL)isEqual:(XWBeanContainer *)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToContainer:other];
}

- (BOOL)isEqualToContainer:(XWBeanContainer *)container {
    if (self == container)
        return YES;
    if (container == nil)
        return NO;
    if (self.identifier != container.identifier && ![self.identifier isEqualToString:container.identifier])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.identifier hash];
    hash = hash * 31u + [self.targetSource hash];
    hash = hash * 31u + (NSUInteger) self.scope;
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.identifier=%@", self.identifier];
    [description appendFormat:@", self.targetSource=%@", self.targetSource];
    [description appendFormat:@", self.scope=%d", self.scope];
    [description appendString:@">"];

    return description;
}

@end
