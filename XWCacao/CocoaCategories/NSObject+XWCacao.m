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

#import "NSObject+XWCacao.h"
#import "XWObjcProperty.h"

@implementation NSObject (XWCacao)

+ (NSString *)classAsString {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

+ (NSArray *)objcProperties {
    
    NSArray *result = [self objcPropertiesWithoutSuperclass];

    Class superclass = class_getSuperclass(self);

    if (superclass == [NSObject class]) {
        return result;
    }
    
    return [result arrayByAddingObjectsFromArray:[superclass objcProperties]];
}

+ (NSArray *)objcPropertiesWithoutSuperclass {
    
    unsigned int nrOfProps;
    objc_property_t *properties = class_copyPropertyList(self, &nrOfProps);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:nrOfProps];
    for (int i = 0; i < nrOfProps; i++) {
        XWObjcProperty *property = [[XWObjcProperty allocWithZone:nil] initWithProperty:properties[i]];
        [result addObject:property];
    }
    
    free(properties);

    return result;
}

@end
