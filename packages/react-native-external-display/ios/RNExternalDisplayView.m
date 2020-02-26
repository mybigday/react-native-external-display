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

- (void)invalidate {
  if (_subview) {
    [_subview removeFromSuperview];
    _subview = nil;
  }
  _window = nil;
}

- (void)updateScreen {
  NSArray *screens = [UIScreen screens];
  int index = [_screen intValue];
  if (index > 0 && index < [screens count]) {
    NSLog(@"[RNExternalDisplay] Plug External Display");
    UIScreen* screen = [screens objectAtIndex:index];
    if (!_window) {
      _window = [[UIWindow alloc] init];
    }
    [_window setScreen:screen];
    [_window setFrame:CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height)];
    [_window insertSubview:_subview atIndex:0];
    [_window makeKeyAndVisible];
  } else if (_fallbackInMainScreen) {
    [super insertSubview:_subview atIndex:0];
  }
}

- (void)setScreen:(NSString*)screen {
  if (_subview) {
    [_subview removeFromSuperview];
  }
  if (screen != _screen) {
    _window = nil;
  }
  _screen = screen;
  [self updateScreen];
}

- (void)setFallbackInMainScreen:(BOOL)fallbackInMainScreen {
  _fallbackInMainScreen = fallbackInMainScreen;
}

@end
