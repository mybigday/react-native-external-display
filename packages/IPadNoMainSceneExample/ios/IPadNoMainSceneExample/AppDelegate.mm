#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>

// Use RNExternalAppDelegateUtil
#import "RNExternalDisplayUtils.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"IPadNoMainSceneExample";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
  UISceneConfiguration * configuration =
    [RNExternalAppDelegateUtil application:application
      configurationForConnectingSceneSession:connectingSceneSession
      options:options
      sceneOptions:@{
        @"noMainScene": @YES
      }
    ];
  // You can put custom configuration here
  return configuration;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
