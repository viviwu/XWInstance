//
//  main.m
//  XWInstance
//
//  Created by Qway on 2017/8/18.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <XWCacao/XWCacao.h>

int main(int argc, char * argv[]) {
  @autoreleasepool {
      [[XWContext sharedContext] initContext];
      return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
  }
}
