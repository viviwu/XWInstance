/**
 * vivi wu
 * ideaMap
 //
 //  Created by viviwu on 2017/1/15.
 //  Copyright © 2017年 viviwu. All rights reserved.
 *
 * See LICENSE
 */

@protocol XWInitializingBean <NSObject>

@required
- (void)postConstruct;

@optional
- (NSUInteger)XW_postConstructOrder;

@end
