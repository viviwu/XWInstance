#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (X)

- (UIFont *)fontOfTheBeginning;
- (id)initWithHtmlFragment:(NSString *)htmlFragment;

@end
