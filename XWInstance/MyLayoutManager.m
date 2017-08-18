//
//  MyLayoutManager.m
//  XWInstance
//
//  Created by Qway on 2017/8/18.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import "MyLayoutManager.h"

@interface MyLayoutManager ()

@property (nonatomic, assign) int retainNO;

@end

@implementation MyLayoutManager

-(instancetype)init{
  self = [super init];
  if (self) {
    _retainNO=0;
    NSLog(@"%s", __func__);
  }
  return self;
}

- (void)doLayout {
  NSLog(@"doLayout ---%d", _retainNO++);
}

@end
