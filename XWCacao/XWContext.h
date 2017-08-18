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


@class XWBeanContainer;


@interface XWContext : NSObject

@property (readonly) NSArray *beanContainers;

- (void)reautowireBeans;

- (id)init;
+ (XWContext *)sharedContext;

- (void)initContext;
- (void)addBeanContainer:(XWBeanContainer *)beanContainer;

- (XWBeanContainer *)beanContainerWithIdentifier:(NSString *)identifier;

- (id)beanWithClass:(Class)clazz;
- (id)beanWithIdentifier:(NSString *)identifier;
- (NSString *)identifierForBean:(id)bean;

- (void)autowireSeed:(id)seed;
- (void)replaceBeanWithIdentifier:(NSString *)identifier withBean:(id)aBean;

@end
