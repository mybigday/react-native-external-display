# IPadNoMainSceneExample

## Usage

```bash
$ cd ios && pod install && cd -
$ react-native run-ios --simulator "iPad Pro (11-inch)"
```

To enable Stage Manager on iPad simulator:
- Option 1 - Setting: Choose Home Screen & Multitasking. Tap Stage Manager at the bottom of the Home Screen & Multitasking screen.
- Option 2 - Command: `xcrun simctl spawn booted defaults write -g SBChamoisWindowingEnabled -bool true`

Please visit [Multiple Scenes support on iPad targets](../../docs/IOSMultipleScenesSupport.md) for more details.
