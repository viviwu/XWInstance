#import "NSAttributedString+X.h"

@implementation NSAttributedString (X)

- (UIFont *)fontOfTheBeginning {
    // TODO: when the string is empty, then
    // NSMutableRLEArray objectAtIndex:effectiveRange:: Out of bounds
    // is thrown here. Dunno why...

    NSDictionary *dictionary=nil;
    UIFont * font = nil;
    @try {
//        dictionary = [self fontAttributesInRange:NSMakeRange(0, 0)];
        dictionary = [self attributesAtIndex:0 effectiveRange:nil];
        font = [dictionary objectForKey:NSFontAttributeName];
    } @catch (NSException *ex) {
        font = nil;
    }

    return font;
}

- (id)initWithHtmlFragment:(NSString *)htmlFragment {
    
    NSData *htmlAsData = [[NSData alloc] initWithBytes:[htmlFragment UTF8String] length:[htmlFragment lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
//    return [self initWithHTML:htmlAsData documentAttributes:NULL];
    if (htmlAsData) {
        NSString * str = [[NSString alloc]initWithData:htmlAsData encoding:NSUTF8StringEncoding];
        return [[NSAttributedString alloc] initWithString:str];
    }else{
        return nil;
    }
}

@end
