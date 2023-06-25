#import <React/UIView+React.h>
#import <React/RCTInvalidating.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <React/RCTViewComponentView.h>
#define RCTView RCTViewComponentView
#else
#import <React/RCTView.h>
#endif

@protocol RNExternalDisplayViewInteractor;

@interface RNExternalDisplayView : RCTView <RCTInvalidating>

@property(nonatomic, weak) id<RNExternalDisplayViewInteractor> delegate;

- (NSString *)screen;

@end

@protocol RNExternalDisplayViewInteractor <NSObject>

- (void)checkScreen;
- (void)removeView:(RNExternalDisplayView*)target;

@end
