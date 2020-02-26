#import "RNExternalDisplay.h"
#import "RNExternalDisplayView.h"
#import <React/RCTUIManager.h>

@implementation RNExternalDisplay

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(screen, NSString)
RCT_EXPORT_VIEW_PROPERTY(fallbackInMainScreen, BOOL)

- (UIView *)view
{
  return [RNExternalDisplayView new];
}

@end
