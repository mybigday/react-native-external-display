#import "RNExternalDisplay.h"
#import "RNExternalDisplayView.h"
#import <React/RCTUIManager.h>
#import <React/RCTLog.h>

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
  view.delegate = self;
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

- (void) checkScreen
{
  NSString *screenId = @"";
  for (RNExternalDisplayView *view in _views) {
    NSString *viewScreenId = [view screen];
    if (![viewScreenId isEqualToString:@""] && [screenId isEqualToString:viewScreenId]) {
      RCTLogError(@"Detected two or more RNExternalDisplayView to register the same screen id': %@.", screenId);
    }
    if (![viewScreenId isEqualToString:@""]) {
      screenId = viewScreenId;
    }
  }
}

- (void)removeView:(RNExternalDisplayView*)target
{
  NSUInteger index = 0;
  for (RNExternalDisplayView *view in _views) {
    if (view == target) {
      [_views removePointerAtIndex:index];
    }
    index++;
  }
}

@end
