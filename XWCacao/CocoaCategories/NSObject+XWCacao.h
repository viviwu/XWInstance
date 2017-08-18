/**
 * vivi wu
 * ideaMap
 //
 //  Created by viviwu on 2017/1/15.
 //  Copyright © 2017年 viviwu. All rights reserved.
 *
 * See LICENSE
 */

#import <Foundation/Foundation.h>

@interface NSObject (XWCacao)

/**
 * Returns the class name as string.
 */
+ (NSString *)classAsString;

/**
 * Returns an array of all Objective-C properties as XWObjcProperty including properties of all superclasses.
 * The properties of NSObject is not included.
 */
+ (NSArray *)objcProperties;

/**
 * Returns an array of all Objective-C properties as XWObjcProperty not including properties of its superclass(es).
 */
+ (NSArray *)objcPropertiesWithoutSuperclass;

@end
