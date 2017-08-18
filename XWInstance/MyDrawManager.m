//
//  MyDrawManager.m
//  XWInstance
//
//  Created by Qway on 2017/8/18.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import "MyDrawManager.h"

@implementation MyDrawManager

XW_AUTOWIRE(layoutManager)

-(instancetype)init{
  self = [super init];
  if (self) {
    NSLog(@"%s", __func__);
  }
  return self;
}

- (void)doDraw {
  [self.layoutManager doLayout];
}

@end
