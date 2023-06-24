#import <Foundation/Foundation.h>
#import <React/RCTView.h>
#import "RNExternalDisplayUtils.h"

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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RNExternalDisplaySceneChange" object:nil];
  }];
}

@end
