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
  scene.session.userInfo = @{@"type": @"@RNExternalDisplay_create"};

  UIWindowScene *windowScene = (UIWindowScene *)scene;

  self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
  self.window.frame = windowScene.coordinateSpace.bounds;
  self.window.rootViewController = [RNExternalDisplayWindowViewController initWithCompletionHandler: ^void (void) {
    [[NSNotificationCenter defaultCenter] postNotificationName:RN_EXTERNAL_SCENE_EVENT_TYPE_CHANGE object:nil];
  }];
}

@end


@implementation RNEXternalAppDelegateUtil

+ (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
  NSString* activityType = options.userActivities.anyObject.activityType;

  // Check duplicate on new window, If main scene is already connected, use `create` instead
  bool isMainDuplicated = false;
  NSSet *scenes = [UIApplication sharedApplication].connectedScenes;
  for (UIScene *scene in scenes) {
    if (
      [self isSceneTypeCreate:scene] &&
      (scene.activationState == UISceneActivationStateForegroundActive ||
      scene.activationState == UISceneActivationStateBackground)
    ) {
      isMainDuplicated = true;
    }
  }

  if (
    isMainDuplicated ||
    [activityType isEqualToString:@"create"] ||
    connectingSceneSession.role == UIWindowSceneSessionRoleExternalDisplay
  ) {
    UISceneConfiguration *configuration = [[UISceneConfiguration alloc] initWithName:@"RNExternalSceneCreate" sessionRole:@"Create"];
    configuration.delegateClass = RNExternalSceneDelegate.class;
    return configuration;
  }

  UISceneConfiguration *configuration = [[UISceneConfiguration alloc] initWithName:@"RNExternalSceneMain" sessionRole:UIWindowSceneSessionRoleApplication];
  configuration.delegateClass = RNExternalSceneMainDelegate.class;
  return configuration;
}

+ (bool)isSceneTypeCreate:(UIScene *)scene {
  NSString* type = nil;
  if ([scene.session.userInfo isKindOfClass:[NSDictionary class]]) {
    type = scene.session.userInfo[@"type"];
  }
  return [type isEqual:RN_EXTERNAL_SCENE_TYPE_CREATE];
}

@end
