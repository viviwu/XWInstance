//
//  MyDrawManager.h
//  XWInstance
//
//  Created by Qway on 2017/8/18.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XWCacao/XWCacao.h>
#import "MyLayoutManager.h"

@interface MyDrawManager : NSObject <XWBean>

@property (weak) MyLayoutManager *layoutManager;

-(instancetype)init;

- (void)doDraw;




@end
