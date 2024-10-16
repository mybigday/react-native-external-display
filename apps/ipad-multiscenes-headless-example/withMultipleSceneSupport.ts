import { ConfigPlugin, withAppDelegate } from '@expo/config-plugins'
import * as fs from 'fs'
import * as path from 'path'

// Helper function to modify AppDelegate.m
function modifyAppDelegate(appDelegate: string): string {
  const importStatement = `#import "RNExternalDisplayUtils.h"`

  // Add the import statement if it's not already present
  if (!appDelegate.includes(importStatement)) {
    appDelegate = `${importStatement}\n${appDelegate}`
  }

  const customMethod = `
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13.0)) {
  UISceneConfiguration * configuration =
    [RNExternalAppDelegateUtil application:application
      configurationForConnectingSceneSession:connectingSceneSession
      options:options
      sceneOptions:@{
        @"headless": @YES
      }
    ];
  return configuration;
}
`

  // Insert the method before the '@end' in AppDelegate
  if (!appDelegate.includes('configurationForConnectingSceneSession')) {
    appDelegate = appDelegate.replace('@end', `${customMethod}\n@end`)
  }

  return appDelegate
}

// Config plugin to modify AppDelegate.m
const withMultipleSceneSupport: ConfigPlugin = (config) => {
  return withAppDelegate(config, async (config) => {
    config.modResults.contents = modifyAppDelegate(config.modResults.contents)

    return config
  })
}

export default withMultipleSceneSupport
