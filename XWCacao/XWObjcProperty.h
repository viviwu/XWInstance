/**
 * vivi wu
 * ideaMap
 //
 //  Created by viviwu on 2017/1/15.
 //  Copyright © 2017年 viviwu. All rights reserved.
 *
 * See LICENSE
 */

/**
 * A wrapper class for objc_property_t. It currently supports:
 *  - BOOL
 *  - int
 *  - long long
 *  - float
 *  - double
 *  - object
 */

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef enum {
    UnknownXWOjcProperty = '?', // unknown type
    BoolXWObjcProperty   = 'c', // BOOL
    IntXWObjcProperty    = 'i', // 32 bit integer
    LongXWObjcProperty   = 'q', // 64 bit long, i.e. long long, not long
    FloatXWObjcProperty  = 'f', // 32 bit float
    DoubleXWObjcProperty = 'd', // 64 bit double
    ObjectXWObjcProperty = '@'  // objects
} XWObjcPropertyType;

@interface XWObjcProperty : NSObject

@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *nameOfClass;

/**
* Can be nil when the property is declared as id or id <SomeProtocol>
*/
@property (readonly, nonatomic) Class clazz;
@property (readonly, nonatomic) XWObjcPropertyType type;
@property (readonly, nonatomic) BOOL readonly;

/**
 * Initializes the XWObjcProperty which wraps the objc_property of Objective-C runtime. objc_property is not freed.
 */
- (id)initWithProperty:(objc_property_t)objc_property;

@end
