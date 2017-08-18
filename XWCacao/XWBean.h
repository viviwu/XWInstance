/**
 * vivi wu
 * ideaMap
 //
 //  Created by viviwu on 2017/1/15.
 //  Copyright © 2017年 viviwu. All rights reserved.
 *
 * See LICENSE
 */


typedef enum {
    XWBeanScopeSingleton = 0,
    XWBeanScopePrototype,
} XWBeanScope;


/**
* If a class implements XWBean protocol, XWCacao will automatically instantiate it as a bean.
*/
@protocol XWBean
@end
