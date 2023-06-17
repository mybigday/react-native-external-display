#import <React/RCTViewManager.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTInvalidating.h>

#import "RNExternalDisplayView.h"

@interface RNExternalDisplay : RCTViewManager <RCTBridgeModule, RCTInvalidating, RNExternalDisplayViewInteractor>

@end
