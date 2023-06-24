#import <UIKit/UIKit.h>

@interface RNExternalDisplayWindowViewController : UIViewController

+ (instancetype)initWithCompletionHandler:(void (^)(void))completionHandler;

@end


@interface RNExternalSceneMainDelegate : UIResponder <UIWindowSceneDelegate>
@end


@interface RNExternalSceneDelegate : UIResponder <UIWindowSceneDelegate>
@end

@interface RNEXternalAppDelegateUtil : NSObject

+ (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options;

@end