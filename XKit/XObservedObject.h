#import <Foundation/Foundation.h>

@interface XObserverInfo : NSObject {
@private
    id _observer;
    NSString *_keyPath;
}

@property(readonly, strong) id observer;
@property(readonly, copy) NSString *keyPath;

- (id)initWithObserver:(id)anObserver keyPath:(NSString *)aKeyPath;

@end

@interface XObservedObject : NSObject

@property (readonly, strong) NSSet *observerInfos;

- (void)addObserver:(id)observer forKeyPath:(NSString *)keyPath;
- (void)removeObserver:(id)observer;

@end
