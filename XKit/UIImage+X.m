
#import "UIImage+X.h"

@implementation UIImage (X)

- (UIImage *)imageWithOpacity:(CGFloat)opacity {
//    CGSize imageSize = [self size];
//    UIImage *newImg = [[UIImage allocWithZone:nil] initWithSize:imageSize];
//    [newImg lockFocusFlipped:YES];
//    [self drawAtPoint:NewPoint(0, 0) fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:opacity];
//    [newImg unlockFocus];
    UIImage *newImg = [self imageFlippedForRightToLeftLayoutDirection];
    return newImg;
}

/**
 
 - (UIImage *)imageFlippedForRightToLeftLayoutDirection NS_AVAILABLE_IOS(9_0);
 @property (nonatomic, readonly) BOOL flipsForRightToLeftLayoutDirection NS_AVAILABLE_IOS(9_0);
 
 // Creates a version of this image with an imageOrientation property that is horizontally mirrored from this image’s. Does not affect the flipsForRightToLeftLayoutDirection property.
 - (UIImage *)imageWithHorizontallyFlippedOrientation NS_AVAILABLE_IOS(10_0);
 
 
 - (void)drawAtPoint:(CGPoint)point;                                                        // mode = kCGBlendModeNormal, alpha = 1.0
 - (void)drawAtPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
 - (void)drawInRect:(CGRect)rect;                                                           // mode = kCGBlendModeNormal, alpha = 1.0
 - (void)drawInRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
 
 - (void)drawAsPatternInRect:(CGRect)rect; // draws the image as a CGPattern

*/
@end
