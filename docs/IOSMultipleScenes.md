# Multiple Scenes on iOS

__*Platform: iOS 15.0+__

It is able to use multiple windows on iPad ([More details](https://developer.apple.com/documentation/uikit/uiscenedelegate/supporting_multiple_windows_on_ipad)): 

[TODO Screenshot iPadOS]

> iOS Simulator (iPad Pro 11-inch)

[TODO Screenshot visionOS]

> visionOS Simulator (Apple TV)

It requires some setup of the app project.

## Setup

WIP

## Test multiple scenes on iPad simulator

To enable Stage Manager on iPad simulator:
- Option 1 - Setting: Choose Home Screen & Multitasking. Tap Stage Manager at the bottom of the Home Screen & Multitasking screen.
- Option 2 - Command: `xcrun simctl spawn booted defaults write -g SBChamoisWindowingEnabled -bool true`

## Notices

WIP
