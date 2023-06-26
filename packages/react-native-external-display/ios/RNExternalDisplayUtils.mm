#import <Foundation/Foundation.h>
#import "RNExternalDisplayUtils.h"

#ifdef RCT_NEW_ARCH_ENABLED
#import <React/RCTViewComponentView.h>
#define RCTView RCTViewComponentView
#else
#import <React/RCTView.h>
#endif

@implementation RNExternalDisplayWindowViewController {
  void (^_completionHandler)(void);
}

+ (instancetype)initWithCompletionHandler:(void (^)(void))completionHandler {
  RNExternalDisplayWindowViewController *viewController = [[RNExternalDisplayWindowViewController alloc] init];
  viewController->_completionHandler = completionHandler;
  viewController.view = [RCTView new];
  return viewController;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    if (self->_completionHandler) {
      self->_completionHandler();
    }
  }];
}

@end


@implementation RNExternalSceneMainDelegate

@synthesize window = _window;

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
  UIApplication *app = [UIApplication sharedApplication];

  UIWindowScene *windowScene = (UIWindowScene *)scene;
  self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
  self.window.frame = windowScene.coordinateSpace.bounds;
  self.window.rootViewController = [app delegate].window.rootViewController;
  [self.window makeKeyAndVisible];
}

@end


@implementation RNExternalSceneDelegate

@synthesize window = _window;

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
  NSMutableDictionary *userInfo = [connectionOptions.userActivities.anyObject.userInfo mutableCopy];
  if (!userInfo) userInfo = [NSMutableDictionary new];
  [userInfo setValue:RN_EXTERNAL_SCENE_TYPE_CREATE forKey:@"type"];

  UIWindowScene *windowScene = (UIWindowScene *)scene;
  windowScene.session.userInfo = userInfo;

  self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
  self.window.frame = windowScene.coordinateSpace.bounds;
  self.window.rootViewController = [RNExternalDisplayWindowViewController initWithCompletionHandler: ^void (void) {
    [[NSNotificationCenter defaultCenter] postNotificationName:RN_EXTERNAL_SCENE_EVENT_TYPE_CHANGE object:nil];
  }];

  NSString *backgroundColor = userInfo[@"backgroundColor"];
  UIColor *color = nil;
  if (backgroundColor) {
    color = [self colorFromHexString:backgroundColor];
  } else {
    color = [self colorFromHexString:@"#222222"];
  }
  self.window.backgroundColor = color;
  [self.window makeKeyAndVisible];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
  unsigned rgbValue = 0;
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  [scanner setScanLocation:1]; // bypass '#' character
  [scanner scanHexInt:&rgbValue];
  return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0 green:((rgbValue & 0xFF00) >> 8) / 255.0 blue:(rgbValue & 0xFF) / 255.0 alpha:1.0];
}

@end


@implementation RNExternalAppDelegateUtil

+ (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
  NSString* activityType = options.userActivities.anyObject.activityType;

  if (
    // Check duplicate on new window, If main scene is already connected, use `create` instead
    [self isMainSceneActive] ||
    // Check is external screen
    connectingSceneSession.role == UIWindowSceneSessionRoleExternalDisplay ||
    // Check is create from method
    [activityType isEqualToString:RN_EXTERNAL_SCENE_TYPE_CREATE]
  ) {
    UISceneConfiguration *configuration = [[UISceneConfiguration alloc] initWithName:@"RNExternalSceneCreate" sessionRole:@"Create"];
    configuration.delegateClass = RNExternalSceneDelegate.class;
    return configuration;
  }

  UISceneConfiguration *configuration = [[UISceneConfiguration alloc] initWithName:@"RNExternalSceneMain" sessionRole:UIWindowSceneSessionRoleApplication];
  configuration.delegateClass = RNExternalSceneMainDelegate.class;
  return configuration;
}

+ (bool)isMainSceneActive {
  NSSet *scenes = [UIApplication sharedApplication].connectedScenes;
  bool isMainActive = false;
  for (UIScene *scene in scenes) {
    if (
      ![self isSceneTypeCreate:scene] &&
      scene.activationState != UISceneActivationStateUnattached
    ) {
      isMainActive = true;
    }
  }
  return isMainActive;
}

+ (bool)isSceneTypeCreate:(UIScene *)scene {
  NSString* type = nil;
  if ([scene.session.userInfo isKindOfClass:[NSDictionary class]]) {
    type = scene.session.userInfo[@"type"];
  }
  return [type isEqual:RN_EXTERNAL_SCENE_TYPE_CREATE];
}

@end
