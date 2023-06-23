#import "AppDelegate.h"

#import <React/RCTAppSetupUtils.h>
#import <React/RCTBundleURLProvider.h>

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>
@end

@implementation SceneDelegate

@synthesize window = _window;

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {

  UIWindowScene *windowScene = (UIWindowScene *)scene;

  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
  self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
  self.window.frame = windowScene.coordinateSpace.bounds;
  self.window.rootViewController = appDelegate.window.rootViewController;
  appDelegate.window.rootViewController = nil;
  [self.window makeKeyAndVisible];

  // TEST: connect TestScene 
  NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"create"];
  [UIApplication.sharedApplication requestSceneSessionActivation:nil
                                                   userActivity:userActivity
                                                     options:nil
                                               errorHandler:nil];
}

@end


@interface TestSceneDelegate : UIResponder <UIWindowSceneDelegate>
@end

@implementation TestSceneDelegate

@synthesize window = _window;

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
  scene.session.userInfo = @{@"type": @"@RNExternalDisplay_create"};

  NSLog(@"TestSceneDelegate: scene:willConnectToSession:options:");

  UIWindowScene *windowScene = (UIWindowScene *)scene;

  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
  self.window.frame = windowScene.coordinateSpace.bounds;
  self.window.rootViewController = [[UIViewController alloc] init];
  [self.window makeKeyAndVisible];
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"RNExternalDisplayFabricExample";
  self.initialProps = @{};

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
  NSString* activityType = options.userActivities.anyObject.activityType;

  if ([activityType isEqualToString:@"create"]) {
    UISceneConfiguration *configuration = [[UISceneConfiguration alloc] init];
    configuration.delegateClass = TestSceneDelegate.class;
    return configuration;
  }

  UISceneConfiguration *configuration = [[UISceneConfiguration alloc] init];
  configuration.delegateClass = SceneDelegate.class;
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

/// This method controls whether the `concurrentRoot`feature of React18 is turned on or off.
///
/// @see: https://reactjs.org/blog/2022/03/29/react-v18.html
/// @note: This requires to be rendering on Fabric (i.e. on the New Architecture).
/// @return: `true` if the `concurrentRoot` feature is enabled. Otherwise, it returns `false`.
- (BOOL)concurrentRootEnabled
{
  return true;
}

@end
