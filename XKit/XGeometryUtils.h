
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CGGeometry.h>

static inline CGRect NewRect(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return CGRectMake(x, y, width, height);
}

static inline CGRect NewRectWithSize(CGFloat x, CGFloat y, CGSize size) {
    return CGRectMake(x, y, size.width, size.height);
}

static inline CGRect NewRectWithOrigin(CGPoint origin, CGFloat width, CGFloat height) {
    return CGRectMake(origin.x, origin.y, width, height);
}

static inline CGRect NewRectWithOriginAndSize(CGPoint origin, CGSize size) {
    return CGRectMake(origin.x, origin.y, size.width, size.height);
//  return CGRectMake(origin.x, origin.y+size.height*0.25, size.width, size.height);
}

static inline CGRect NewRectWithTwoPoints(CGPoint a, CGPoint b) {
    return CGRectMake(MIN(a.x, b.x), MIN(a.y, b.y), MAX(a.x, b.x) - MIN(a.x, b.x), MAX(a.y, b.y) - MIN(a.y, b.y));
//    More readable version of the above:
//    CGRect NewRectWithTwoPoints(CGPoint a, CGPoint b) {
//    CGFloat startX = MIN(a.x, b.x);
//    CGFloat startY = MIN(a.y, b.y);
//
//    CGFloat endX = MAX(a.x, b.x);
//    CGFloat endY = MAX(a.y, b.y);
//
//    CGFloat width = endX - startX;
//    CGFloat height = endY - startY;
//
//    return CGRectMake(startX, startY, width, height);
}

static inline CGRect NewRectExpanding(CGRect rect, CGFloat dw, CGFloat dh) {
    return CGRectInset(rect, -dw, -dh);
}

static inline CGPoint NewPoint(CGFloat x, CGFloat y) {
    return CGPointMake(x, y);
}

static inline CGPoint NewPointFlipping(CGPoint originalPoint, CGFloat height) {
    return NewPoint(originalPoint.x, height - originalPoint.y);
}

static inline CGSize NewSize(CGFloat width, CGFloat height) {
    return CGSizeMake(width, height);
}

static inline BOOL NSIntersectsRect(CGRect r1, CGRect r2){
    CGRect rect = CGRectIntersection(r1, r2);
    if (!CGRectEqualToRect(rect, CGRectZero)) {
        return YES;
    } else {
        return NO;
    }
}
//CGRectIntersection(<#CGRect r1#>, <#CGRect r2#>)
static const CGFloat MAX_CGFLOAT = 1E+37;

