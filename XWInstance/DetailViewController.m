//
//  DetailViewController.m
//  XWInstance
//
//  Created by Qway on 2017/8/18.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import "DetailViewController.h"

#import "MyDrawManager.h"

////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////

@interface DetailViewController ()

@property (weak) MyDrawManager * myDrawManager;

@end

@implementation DetailViewController

XW_AUTOWIRE(myDrawManager)

- (void)configureView {
  // Update the user interface for the detail item.
  if (self.detailItem) {
      self.detailDescriptionLabel.text = [self.detailItem description];
  }
}


- (void)viewDidLoad {
  [super viewDidLoad];
  if (nil == _myDrawManager) {
    _myDrawManager = [[XWContext sharedContext] beanWithClass:[MyDrawManager class]];
  }
  
  [_myDrawManager doDraw];
  
  // Do any additional setup after loading the view, typically from a nib.
  [self configureView];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDate *)newDetailItem {
  if (_detailItem != newDetailItem) {
      _detailItem = newDetailItem;
      
      // Update the view.
      [self configureView];
  }
}


@end
