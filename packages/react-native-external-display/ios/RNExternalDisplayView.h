#import <React/UIView+React.h>
#import <React/RCTView.h>
#import <React/RCTInvalidating.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <React/RCTViewComponentView.h>
#endif

@protocol RNExternalDisplayViewInteractor;

@interface RNExternalDisplayView :
#ifdef RCT_NEW_ARCH_ENABLED
  RCTViewComponentView
#else
  RCTView
#endif
<RCTInvalidating>

@property(nonatomic, weak) id<RNExternalDisplayViewInteractor> delegate;

- (NSString *)screen;

@end

@protocol RNExternalDisplayViewInteractor <NSObject>

- (void)checkScreen;
- (void)removeView:(RNExternalDisplayView*)target;

@end
