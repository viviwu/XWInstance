
#import "XShadowedView.h"
#import <XKit/XGeometryUtils.h>

@implementation XShadowedView {
    NSShadow *_backShadow;
    UIBezierPath *_path;

    __weak UIView *_onlySubview;
}

- (void)addOnlySubview:(UIView *)subview {
    _onlySubview = subview;

    CGSize originalSize = subview.frame.size;

    [self addSubview:subview];
    [subview setFrame:NewRectWithSize(CONTAINER_BORDER_WIDTH, CONTAINER_BORDER_WIDTH, originalSize)];
    CGRect rect = self.frame;
    rect.size= NewSize(originalSize.width + 2 * CONTAINER_BORDER_WIDTH + 20, originalSize.height + 2 * CONTAINER_BORDER_WIDTH + 20);
    [self setFrame:rect];
//    [self setFrameSize:NewSize(originalSize.width + 2 * CONTAINER_BORDER_WIDTH + 20, originalSize.height + 2 * CONTAINER_BORDER_WIDTH + 20)];

    _path = [UIBezierPath bezierPathWithRect:NewRect(0, 0, originalSize.width + 2, originalSize.height + 2)];
    [_path setLineWidth:CONTAINER_BORDER_WIDTH];

    [self setNeedsDisplay];//[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)dirtyRect {
//    [NSGraphicsContext saveGraphicsState];
//    [_backShadow set];
    
    [[UIColor grayColor] setStroke];
    [[UIColor whiteColor] setFill];

    [_path fill];
    [_path stroke];
//    [NSGraphicsContext restoreGraphicsState];

    [super drawRect:dirtyRect];
}

- (id)initWithFrame:(CGRect)frameRect {
    if ((self = [super initWithFrame:frameRect])) {
        _backShadow = [[NSShadow alloc] init];
        [_backShadow setShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
        [_backShadow setShadowBlurRadius:10];
        [_backShadow setShadowOffset:NewSize(4, -4)];
    }

    return self;
}

- (BOOL)isFlipped {
    return YES;
}

@end
