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
#import <XWCacao/XWBean.h>

@interface XWBeanContainer : NSObject

@property (readonly) NSString *identifier;
@property (readonly) id targetSource;
@property (readonly) XWBeanScope scope;

/**
* Initializes the bean container with the scope XWBeanScopeSingleton
*/
- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean;

/**
* Designated initializer
*/
- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean scope:(XWBeanScope)aScope;

/**
* The identifier will be bean's class name and the scope XWBeanScopeSingleton
*/
- (id)initWithBean:(id)bean;

/**
* The identifier will be bean's class name and the scope XWBeanScopeSingleton
*/
+ (id)beanContainerWithBean:(id)targetSource;

/**
* The scope will be XWBeanScopeSingleton
*/
+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean;

/**
* Designated initializer
*/
+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean scope:(XWBeanScope)aScope;

- (BOOL)isEqual:(XWBeanContainer *)other;
- (BOOL)isEqualToContainer:(XWBeanContainer *)container;
- (NSUInteger)hash;
- (NSString *)description;

@end
