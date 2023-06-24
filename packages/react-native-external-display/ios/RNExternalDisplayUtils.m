#import <Foundation/Foundation.h>
#import <React/RCTView.h>
#import "RNExternalDisplayWindowViewController.h"

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
