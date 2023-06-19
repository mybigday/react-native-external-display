#import "RNExternalDisplayView.h"
#import "UIView+React.h"
#import "RCTShadowView.h"
#import <React/RCTLog.h>

@implementation RNExternalDisplayView {
  UIWindow *_window;
  UIView *_subview;
  NSString *_screen;
  BOOL _fallbackInMainScreen;
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  if (atIndex > 0) {
    RCTLogError(@"RNExternalDisplayView only allowed one child view.");
    return;
  }
  _subview = subview;
  [super insertReactSubview:_subview atIndex:atIndex];
  [self updateScreen];
}

- (void)removeReactSubview:(UIView *)subview
{
  [super removeReactSubview:subview];
}

- (void)didMoveToSuperview
{
  [super didMoveToSuperview];
  if (!self.superview) {
    [self invalidate];
  }
}

- (void)didUpdateReactSubviews {
  if (_fallbackInMainScreen && !_window) {
    [super didUpdateReactSubviews];
  }
}

- (void)invalidateWindow {
  if (_window) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIApplication.sharedApplication.delegate.window makeKeyAndVisible];
    });
  }
  _window = nil;
}

- (void)invalidate {
  [self invalidateWindow];
  [self.delegate removeView:self];
}

#if defined(TARGET_OS_TV) && TARGET_OS_TV == 1
  #define MA_APPLE_TV
#endif

- (void)updateScreen {
  if (!_subview) {
    return;
  }
  NSArray *screens = [UIScreen screens];
  int index = [_screen intValue];
  if (index > 0 && index < [screens count]) {
    // NSLog(@"[RNExternalDisplay] Selected External Display");
    UIScreen* screen = [screens objectAtIndex:index];

#if !defined(MA_APPLE_TV)
    __block UIScreenMode *highestWidthMode = NULL;

    [screen.availableModes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      UIScreenMode *currentModeInLoop = obj;
      if (!highestWidthMode || currentModeInLoop.size.width > highestWidthMode.size.width)
        highestWidthMode = currentModeInLoop;
    }];

    screen.currentMode = highestWidthMode;
    screen.overscanCompensation = UIScreenOverscanCompensationScale;
#endif

    _window = [[UIWindow alloc] initWithFrame:screen.bounds];
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = [RCTView new];
    [rootViewController.view insertSubview:_subview atIndex:0];
    _window.rootViewController = rootViewController;
    [_window setScreen:screen];
    [_window makeKeyAndVisible];
  }
}

- (void)setScreen:(NSString*)screen {
  if (screen != _screen) {
    [self invalidateWindow];
  }
  _screen = screen;
  [self.delegate checkScreen];
  [self updateScreen];
  [self didUpdateReactSubviews];
}

- (NSString *)screen {
  return _screen;
}

- (void)setFallbackInMainScreen:(BOOL)fallbackInMainScreen {
  _fallbackInMainScreen = fallbackInMainScreen;
  if (!_window) {
    [self updateScreen];
    [self didUpdateReactSubviews];
  }
}

@end
