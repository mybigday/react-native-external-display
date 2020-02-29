#import "RNExternalDisplay.h"
#import "RNExternalDisplayView.h"
#import <React/RCTUIManager.h>

@implementation RNExternalDisplay
{
  NSPointerArray *_views;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(screen, NSString)
RCT_EXPORT_VIEW_PROPERTY(fallbackInMainScreen, BOOL)

- (UIView *)view
{
  RNExternalDisplayView *view = [RNExternalDisplayView new];
  if (!_views) {
    _views = [NSPointerArray weakObjectsPointerArray];
  }
  [_views addPointer:(__bridge void *)view];
  return view;
}

- (void)invalidate
{
  for (RNExternalDisplayView *view in _views) {
    [view invalidate];
  }
  _views = nil;
}

@end
