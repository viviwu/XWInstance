//
//  DetailViewController.h
//  XWInstance
//
//  Created by Qway on 2017/8/18.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XWCacao/XWCacao.h>

@interface DetailViewController : UIViewController 

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

