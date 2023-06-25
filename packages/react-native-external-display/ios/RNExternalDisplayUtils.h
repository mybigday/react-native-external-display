#import <UIKit/UIKit.h>

@interface RNExternalDisplayWindowViewController : UIViewController

+ (instancetype)initWithCompletionHandler:(void (^)(void))completionHandler;

@end


@interface RNExternalSceneMainDelegate : UIResponder <UIWindowSceneDelegate>
@end

#define RN_EXTERNAL_SCENE_EVENT_TYPE_CHANGE @"RNExternalDisplaySceneChange"

@interface RNExternalSceneDelegate : UIResponder <UIWindowSceneDelegate>
@end


#define RN_EXTERNAL_SCENE_TYPE_CREATE @"@RNExternalDisplay_create"

@interface RNExternalAppDelegateUtil : NSObject

+ (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options;
+ (bool)isMainSceneActive;
+ (bool)isSceneTypeCreate:(UIScene *)scene;

@end