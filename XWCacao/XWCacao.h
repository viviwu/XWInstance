//
//  XWCacao.h
//  XWCacao
//
//  Created by Qway on 2017/8/18.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for XWCacao.
FOUNDATION_EXPORT double XWCacaoVersionNumber;

//! Project version string for XWCacao.
FOUNDATION_EXPORT const unsigned char XWCacaoVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <XWCacao/PublicHeader.h>

#import <XWCacao/XWCacao.h>
#import <XWCacao/XWContext.h>
#import <XWCacao/XWBean.h>
#import <XWCacao/XWManualBeanProvider.h>
#import <XWCacao/XWBeanContainer.h>
#import <XWCacao/XWInitializingBean.h>


#define XW_BEAN     + (BOOL)isBean { return YES; }

#define XW_AUTOWIRE_WITH_INSTANCE_VAR(propertyName, instanceName)       @synthesize propertyName = instanceName; \
+(NSString *)XW_autowire_ ## propertyName { return  @#propertyName; }

#define XW_MANUALWIRE_WITH_INSTANCE_VAR(propertyName, instanceName)       @synthesize propertyName = instanceName; \
+(NSString *)XW_manualwire_ ## propertyName { return  @#propertyName; }

#define XW_AUTOWIRE(propertyName)       @synthesize propertyName = _ ## propertyName ; \
+(NSString *)XW_autowire_ ## propertyName { return  @#propertyName; }

#define XW_MANUALWIRE(propertyName)     @synthesize propertyName = _ ## propertyName ; \
+(NSString *)XW_manualwire_ ## propertyName { return  @#propertyName; }

#define XW_POSTCONSTRUCT_ORDER(x) - (NSUInteger)XW_postConstructOrder { return (NSUInteger) x; }

#define XW_SCOPE(x)      + (XWBeanScope)XW_scope { return x; }

#ifdef XW_SHORTHAND

#define AUTOWIRE(propertyName)       @synthesize propertyName = _ ## propertyName ; \
+(NSString *)XW_autowire_ ## propertyName { return  @#propertyName; }

#define MANUALWIRE(propertyName)     @synthesize propertyName = _ ## propertyName ; \
+(NSString *)XW_manualwire_ ## propertyName { return  @#propertyName; }

#define POSTCONSTRUCT_ORDER(x) - (NSUInteger)postConstructOrder { return (NSUInteger) x; }

#define SCOPE(x)      + (XWBeanScope)XW_scope { return x; }

#endif


