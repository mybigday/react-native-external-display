#import <React/RCTBridgeModule.h>
#import "RNExternalDisplayEvent.h"

@interface RNExternalDisplayEvent () <RCTBridgeModule>

@end

@implementation RNExternalDisplayEvent

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

- (NSDictionary *)constantsToExport
{
  NSDictionary* screenInfo = [self getScreenInfo];
  return @{ @"SCREEN_INFO": screenInfo };
}

RCT_EXPORT_METHOD(init:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  [center addObserver:self selector:@selector(handleScreenDidConnectNotification:) name:UIScreenDidConnectNotification object:nil];
  [center addObserver:self selector:@selector(handleScreenDidDisconnectNotification:) name:UIScreenDidDisconnectNotification object:nil];
  resolve(@{});
}

-(NSArray *)supportedEvents {
  return@[
    @"@RNExternalDisplay_screenDidConnect",
    @"@RNExternalDisplay_screenDidChange",
    @"@RNExternalDisplay_screenDidDisconnect"
  ];
}

-(NSDictionary *)getScreenInfo {
  NSArray *screens = [UIScreen screens];
  NSMutableDictionary *screenInfo = [[NSMutableDictionary alloc] init];
  for (UIScreen* screen in screens) {
    if (screen != UIScreen.mainScreen) {
      [screenInfo
        setValue:@{
          @"width": @(screen.bounds.size.width),
          @"height": @(screen.bounds.size.height),
          @"mirrored": @(screen.mirroredScreen == UIScreen.mainScreen),
          @"wantsSoftwareDimming": @(screen.wantsSoftwareDimming),
          //@"maximumFramesPerSecond": @(screen.maximumFramesPerSecond),
        }
        forKey:[NSString stringWithFormat: @"%ld", [screens indexOfObject:screen]]
      ];
    }
  }
  return screenInfo;
}

- (void) handleScreenDidConnectNotification: (NSNotification *)notification{
  NSDictionary* screenInfo = [self getScreenInfo];
  NSLog(@"Screen info: %@", screenInfo);
  [self sendEventWithName:@"@RNExternalDisplay_screenDidConnect" body:screenInfo];
}

- (void) handleScreenDidDisconnectNotification: (NSNotification *)notification{
  NSDictionary* screenInfo = [self getScreenInfo];
  NSLog(@"Screen info: %@", screenInfo);
  [self sendEventWithName:@"@RNExternalDisplay_screenDidDisconnect" body:screenInfo];
}

@end
