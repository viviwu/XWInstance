//
//  UIView+X.m
//  XKit
//
//  Created by Qway on 2017/7/28.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import "UIView+X.h"

@implementation UIView (X)

-(UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(CGRect)visibleRect
{
    return self.layer.visibleRect;
}

//-(UIImage *)imageForView:(UIView *)view {
//    
//    UIGraphicsBeginImageContext(view.frame.size);
//    
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return  viewImage；
//}

@end
