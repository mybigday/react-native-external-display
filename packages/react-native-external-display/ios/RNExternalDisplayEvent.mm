#import <React/RCTBridgeModule.h>
#import "RNExternalDisplayEvent.h"
#import "RNExternalDisplayUtils.h"
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

- (bool) supportMultipleScenes {
  bool supportMultipleScenes = false;
  if (@available(iOS 13.0, tvOS 13.0, *)) {
    supportMultipleScenes = [UIApplication sharedApplication].supportsMultipleScenes;
  }
  return supportMultipleScenes;
}

- (NSDictionary *)constantsToExport
{
  NSDictionary* screenInfo = [self getScreenInfo];
  return @{
    @"SCREEN_INFO": screenInfo,
    @"SUPPORT_MULTIPLE_SCENES": @([self supportMultipleScenes]),
  };
}

RCT_EXPORT_METHOD(init:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  if (@available(iOS 13.0, tvOS 13.0, *)) {
    [center addObserver:self selector:@selector(handleScreenDidConnectNotification:) name:UISceneWillConnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenDidDisconnectNotification:) name:UISceneDidDisconnectNotification object:nil];
  } else {
    [center addObserver:self selector:@selector(handleScreenDidConnectNotification:) name:UIScreenDidConnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenDidDisconnectNotification:) name:UIScreenDidDisconnectNotification object:nil];
  }
  // Listen resize event
  [center addObserver:self selector:@selector(handleScreenDidChangeNotification:) name:RN_EXTERNAL_SCENE_EVENT_TYPE_CHANGE object:nil];
  resolve(@{});
}

RCT_EXPORT_METHOD(requestScene:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  if (![self supportMultipleScenes]) {
    reject(@"error", @"Not supported multiple scenes", nil);
    return;
  }
  dispatch_async(dispatch_get_main_queue(), ^{
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:RN_EXTERNAL_SCENE_TYPE_CREATE];
    [UIApplication.sharedApplication
      requestSceneSessionActivation:nil
      userActivity:userActivity
      options:nil
      errorHandler:nil // NOTE: No completion handler here so it is hard to use promise
    ];
    resolve(@YES);
  });
}

RCT_EXPORT_METHOD(closeScene:(NSString *)sceneId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  if (![self supportMultipleScenes]) {
    reject(@"error", @"Not supported multiple scenes", nil);
    return;
  }
  dispatch_async(dispatch_get_main_queue(), ^{
    NSSet *scenes = [UIApplication sharedApplication].connectedScenes;
    for (UIWindowScene* scene in scenes) {
      if ([scene.session.persistentIdentifier isEqual:sceneId]) {
        [UIApplication.sharedApplication
          requestSceneSessionDestruction:scene.session
          options:nil
          errorHandler:nil // NOTE: No completion handler here so it is hard to use promise
        ];
        resolve(@YES);
        return;
      }
    }
    reject(@"error", @"No scene found", nil);
  });
}

RCT_EXPORT_METHOD(isMainSceneActive:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  if (![self supportMultipleScenes]) {
    reject(@"error", @"Not supported multiple scenes", nil);
    return;
  }
  dispatch_async(dispatch_get_main_queue(), ^{
    resolve(@([RNExternalAppDelegateUtil isMainSceneActive]));
  });
}

RCT_EXPORT_METHOD(resumeMainScene:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  if (![self supportMultipleScenes]) {
    reject(@"error", @"Not supported multiple scenes", nil);
    return;
  }
  dispatch_async(dispatch_get_main_queue(), ^{
    [UIApplication.sharedApplication
      requestSceneSessionActivation:nil
      userActivity:nil // No activity as main scene
      options:nil
      errorHandler:nil // NOTE: No completion handler here so it is hard to use promise
    ];
    resolve(@YES);
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
    if (
      ![scene.session.role isEqual:UIWindowSceneSessionRoleApplication] ||
      [RNExternalAppDelegateUtil isSceneTypeCreate:scene]
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
  [super invalidate];
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  if (@available(iOS 13.0, tvOS 13.0, *)) {
    [center removeObserver:self name:UISceneWillConnectNotification object:nil];
    [center removeObserver:self name:UISceneDidDisconnectNotification object:nil];
  } else {
    [center removeObserver:self name:UIScreenDidConnectNotification object:nil];
    [center removeObserver:self name:UIScreenDidDisconnectNotification object:nil];
  }
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
