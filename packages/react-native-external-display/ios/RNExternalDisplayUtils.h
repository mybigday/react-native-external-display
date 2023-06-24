#import <UIKit/UIKit.h>

@interface RNExternalDisplayWindowViewController : UIViewController

+ (instancetype)initWithCompletionHandler:(void (^)(void))completionHandler;

@end


@interface RNExternalSceneMainDelegate : UIResponder <UIWindowSceneDelegate>
@end


@interface RNExternalSceneDelegate : UIResponder <UIWindowSceneDelegate>
@end
