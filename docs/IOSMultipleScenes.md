# Multiple Scenes on iOS

__*Platform: iOS 15.0+__

It is able to use multiple windows on iPad ([More details](https://developer.apple.com/documentation/uikit/uiscenedelegate/supporting_multiple_windows_on_ipad)): 

[TODO Screenshot iPadOS]

> iOS Simulator (`iPad Pro (11-inch)`)

[TODO Screenshot visionOS]

> visionOS Simulator (`Apple Vision Pro (Designed for iPad)`)

It requires some setup of the app project.

## Setup

To support multiple scenes, these are two steps need to setup in your Xcode project:

1. Edit `Info.plist` for enable multiple scenes:

```patch
--- Info-prev.plist	2023-06-25 13:53:46
+++ Info.plist	2023-06-25 13:54:04
@@ -51,5 +51,30 @@
 	</array>
 	<key>UIViewControllerBasedStatusBarAppearance</key>
 	<false/>
+	<key>UIApplicationSceneManifest</key>
+	<dict>
+		<key>UIApplicationSupportsMultipleScenes</key>
+		<true/>
+		<key>UISceneConfigurations</key>
+		<dict>
+			<key>UIWindowSceneSessionRoleApplication</key>
+			<array>
+				<dict>
+					<key>UISceneConfigurationName</key>
+					<string>RNExternalScene</string>
+					<key>UISceneDelegateClassName</key>
+					<string>RNExternalSceneMainDelegate</string>
+				</dict>
+				<dict>
+					<key>UISceneConfigurationName</key>
+					<string>RNExternalSceneCreate</string>
+					<key>UISceneDelegateClassName</key>
+					<string>RNExternalSceneDelegate</string>
+				</dict>
+			</array>
+		</dict>
+	</dict>
+	<key>UIRequiresFullScreen</key>
+	<false/>
 </dict>
 </plist>
```

These are two scenes:
- `RNExternalSceneMainDelegate`: The main scene of the app. Please make sure it only creates one unless you're project able to building multiple react-native bridge hosts
- `RNExternalSceneDelegate`: The scene for external screen, it can be multiple.

Please also make sure the `UIRequiresFullScreen` is `false`.

2. Edit `AppDelegate.mm` to use UIScene:

```patch
--- AppDelegate-prev.mm	2023-06-25 13:48:55
+++ AppDelegate.mm	2023-06-25 13:49:58
@@ -2,6 +2,9 @@
 
 #import <React/RCTBundleURLProvider.h>
 
+// Use RNExternalAppDelegateUtil
+#import "RNExternalDisplayUtils.h"
+
 @implementation AppDelegate
 
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
@@ -14,6 +17,12 @@
   return [super application:application didFinishLaunchingWithOptions:launchOptions];
 }
 
+- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
+  UISceneConfiguration * configuration = [RNExternalAppDelegateUtil application:application configurationForConnectingSceneSession:connectingSceneSession options:options];
+  // You can put custom configuration here
+  return configuration;
+}
+
 - (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
 {
 #if DEBUG
```

The behavior of `Create Window` in the scene delegates setup:

- Create main scene with `RNExternalSceneMainDelegate` if the main scene is not active (App initialization or the main scene is closed)
- Create scene with `RNExternalSceneDelegate` if:
  - Main scene is active
  - Connected to a external screen
  - Call the `requestScene(options)` method

You can customize the scene configuration in `application:configurationForConnectingSceneSession:options:` method. Please make sure there is only one main scene can be active at the same time.

## Resizable scene

The scene resizable is depends on the orientation setting of the app. You can change the orientation setting in `Info.plist`:

```xml
<key>UISupportedInterfaceOrientations~ipad</key>
<array>
  <string>UIInterfaceOrientationLandscapeLeft</string>
  <string>UIInterfaceOrientationLandscapeRight</string>
  <string>UIInterfaceOrientationPortrait</string>
  <string>UIInterfaceOrientationPortraitUpsideDown</string>
</array>
```

## When the main scene is closed

The main scene can be closed and the app will be still running if another scenes is active.

You will need to resume the main scene if you want to use it again:
- Create Window by click app icon on dock, then click the top-left `+` button
- Call the `resumeMainScene(options)` method, you can also check the status by `isMainSceneActive()` method

For a multi-window app with exactly the same layout, maybe you can close the main scene forever (Use `closeScene` method or custom configuration), and make the root of the main app is composed of multiple `<ExternalDisplay>`.

## Test multiple scenes on iPad simulator

To enable Stage Manager on iPad simulator:
- Option 1 - Setting: Choose Home Screen & Multitasking. Tap Stage Manager at the bottom of the Home Screen & Multitasking screen.
- Option 2 - Command: `xcrun simctl spawn booted defaults write -g SBChamoisWindowingEnabled -bool true`

## Notices

These are some issues may support/fix in the future or not:

- Currently it not supported drag-and-drop to create new scene
- Currently the multiple scenes not working on macOS (Tested on 13.4), `requestSceneSessionActivation` always failed even `UIApplicationSupportsMultipleScenes` is enabled
- SafeAreaView has no effect on new scenes
