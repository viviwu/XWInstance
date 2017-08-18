/**
 * vivi wu
 * ideaMap
 //
 //  Created by viviwu on 2017/1/15.
 //  Copyright © 2017年 viviwu. All rights reserved.
 *
 * See LICENSE
 */

#import "NSString+XWCacao.h"

@implementation NSString (XWCacao)

- (BOOL)startsWithString:(NSString *)str {
    NSUInteger length = [str length];
    NSComparisonResult result = [self compare:str options:NSLiteralSearch range:NSMakeRange(0, length)];
    
    return result == NSOrderedSame;
}

@end
