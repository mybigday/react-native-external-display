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

- (void)invalidateWindow {
  if (_window) {
    [UIApplication.sharedApplication.delegate.window makeKeyAndVisible];
  }
  _window = nil;
}

- (void)invalidate {
  [self invalidateWindow];
}

- (void)updateScreen {
  if (!_subview) {
    return;
  }
  NSArray *screens = [UIScreen screens];
  int index = [_screen intValue];
  if (index > 0 && index < [screens count]) {
    // NSLog(@"[RNExternalDisplay] Selected External Display");
    UIScreen* screen = [screens objectAtIndex:index];
    _window = [[UIWindow alloc] initWithFrame:screen.bounds];
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = _subview;
    _window.rootViewController = rootViewController;
    [_window setScreen:screen];
    [_window makeKeyAndVisible];
  } else if (_fallbackInMainScreen) {
    [super insertSubview:_subview atIndex:0];
  }
}

- (void)setScreen:(NSString*)screen {
  if (screen != _screen) {
    [self invalidateWindow];
  }
  _screen = screen;
  [self updateScreen];
}

- (void)setFallbackInMainScreen:(BOOL)fallbackInMainScreen {
  _fallbackInMainScreen = fallbackInMainScreen;
  if (!_window) {
    [self updateScreen];
  }
}

@end
