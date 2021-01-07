#import <React/UIView+React.h>
#import <React/RCTView.h>
#import <React/RCTInvalidating.h>

@protocol RNExternalDisplayViewInteractor;

@interface RNExternalDisplayView : RCTView <RCTInvalidating>

@property(nonatomic, weak) id<RNExternalDisplayViewInteractor> delegate;

- (NSString *)screen;

@end

@protocol RNExternalDisplayViewInteractor <NSObject>

- (void)checkScreen;
- (void)removeView:(RNExternalDisplayView*)target;

@end
