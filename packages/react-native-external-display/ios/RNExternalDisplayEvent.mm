#import <React/RCTBridgeModule.h>
#import "RNExternalDisplayEvent.h"
#import "RNExternalDisplayWindowViewController.h"
#ifdef RCT_NEW_ARCH_ENABLED
#import <RNExternalDisplaySpec/RNExternalDisplaySpec.h>
#endif

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
  return @{
    @"SCREEN_INFO": screenInfo,
    @"SUPPORT_MULTIPLE_SCENES": [UIApplication sharedApplication].supportsMultipleScenes ? @YES : @NO,
  };
}

RCT_EXPORT_METHOD(init:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(handleScreenDidConnectNotification:) name:UISceneWillConnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenDidDisconnectNotification:) name:UISceneDidDisconnectNotification object:nil];

    // Listen resize event
    [center addObserver:self selector:@selector(handleScreenDidChangeNotification:) name:@"RNExternalDisplaySceneChange" object:nil];
    resolve(@{});
  });
}

RCT_EXPORT_METHOD(requestScene:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"create"];
    [UIApplication.sharedApplication
      requestSceneSessionActivation:nil
      userActivity:userActivity
      options:nil
      errorHandler:^(NSError * _Nonnull error) {
        reject(@"error", @"error", error);
      }
    ];
    resolve(@YES);
  });
}

RCT_EXPORT_METHOD(closeScene:(NSString *)sceneId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSSet *scenes = [UIApplication sharedApplication].connectedScenes;
    for (UIWindowScene* scene in scenes) {
      if ([scene.session.persistentIdentifier isEqual:sceneId]) {
        [UIApplication.sharedApplication
          requestSceneSessionDestruction:scene.session
          options:nil
          errorHandler:^(NSError * _Nonnull error) {
            reject(@"error", @"error", error);
          }
        ];
        resolve(@YES);
        return;
      }
    }
    reject(@"error", @"error", nil);
  });
}

-(NSArray *)supportedEvents {
  return@[
    @"@RNExternalDisplay_screenDidConnect",
    @"@RNExternalDisplay_screenDidChange",
    @"@RNExternalDisplay_screenDidDisconnect"
  ];
}

-(NSDictionary *)getScreenInfo {
  NSSet *scenes = [UIApplication sharedApplication].connectedScenes;
  NSMutableDictionary *screenInfo = [[NSMutableDictionary alloc] init];
  for (UIWindowScene* scene in scenes) {
    NSString* type = nil;
    if ([scene.session.userInfo isKindOfClass:[NSDictionary class]]) {
      type = scene.session.userInfo[@"type"];
    }
    if (
      ![scene.session.role isEqual:UIWindowSceneSessionRoleApplication] ||
      (type != nil && [type isEqual:@"@RNExternalDisplay_create"])
    ) {
      UIWindow *window = scene.windows.firstObject;
      [screenInfo
        setValue:@{
          @"id": scene.session.persistentIdentifier,
          @"width": @(window.bounds.size.width),
          @"height": @(window.bounds.size.height),
          @"mirrored": @(scene.screen.mirroredScreen == UIScreen.mainScreen),
#if !TARGET_OS_TV
          @"wantsSoftwareDimming": @(scene.screen.wantsSoftwareDimming),
#endif
          // @"maximumFramesPerSecond": @(screen.maximumFramesPerSecond),
        }
        forKey:scene.session.persistentIdentifier
      ];
    }
  }
  return screenInfo;
}

- (void) handleScreenDidConnectNotification: (NSNotification *)notification{
  dispatch_async(dispatch_get_main_queue(), ^{
    NSDictionary* screenInfo = [self getScreenInfo];
    [self sendEventWithName:@"@RNExternalDisplay_screenDidConnect" body:screenInfo];
  });
}

- (void) handleScreenDidChangeNotification: (NSNotification *)notification{
  dispatch_async(dispatch_get_main_queue(), ^{
    NSDictionary* screenInfo = [self getScreenInfo];
    [self sendEventWithName:@"@RNExternalDisplay_screenDidChange" body:screenInfo];
  });
}

- (void) handleScreenDidDisconnectNotification: (NSNotification *)notification{
  dispatch_async(dispatch_get_main_queue(), ^{
    NSDictionary* screenInfo = [self getScreenInfo];
    [self sendEventWithName:@"@RNExternalDisplay_screenDidDisconnect" body:screenInfo];
  });
}

- (void) invalidate {
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  [center removeObserver:self name:UISceneWillConnectNotification object:nil];
  [center removeObserver:self name:UISceneDidDisconnectNotification object:nil];
  [center removeObserver:self name:@"RNExternalDisplaySceneChange" object:nil];
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeRNExternalDisplayEventSpecJSI>(params);
}
#endif

@end
