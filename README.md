[![CI Status](https://github.com/mybigday/react-native-external-display/workflows/CI/badge.svg)](https://github.com/mybigday/react-native-external-display)

> React Native view renderer in External Display.

- [Package (react-native-external-display)](packages/react-native-external-display)
- Example
  - Example project: [old arch](packages/RNExternalDisplayExample) / [new arch](packages/RNExternalDisplayFabricExample)
  - [Examples JS code](packages/rnexternal-display-examples)
- iPad Multiple Scenes example project: [Simple Multiple Windows Browser](packages/IPadNoMainSceneExample)

## Introdution

- iOS
  - [Displaying Content on a Connected Screen](https://developer.apple.com/documentation/uikit/windows_and_screens/displaying_content_on_a_connected_screen)
  - [Multiple Scenes support on iPad targets](docs/IOSMultipleScenesSupport.md)
- Android - [Presentation API](https://developer.android.com/reference/android/app/Presentation)

```js
import React from 'react'
import Video from 'react-native-video'
import ExternalDisplay, {
  useExternalDisplay,
} from 'react-native-external-display'

function App() {
  const screens = useExternalDisplay()

  return (
    <ExternalDisplay
      mainScreenStyle={{ flex: 1 }}
      fallbackInMainScreen
      screen={Object.keys(screens)[0]}
    >
      <Video
        source={{
          uri: 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4',
        }}
        style={{ flex: 1 }}
        repeat
        muted
      />
    </ExternalDisplay>
  )
}
```

|                                                No selected screen                                                |                                                     Selected                                                     |
| :--------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------: |
| ![IMG_1318](https://user-images.githubusercontent.com/3001525/75336253-c3807a00-58c5-11ea-9872-371b654c05fa.png) | ![IMG_1319](https://user-images.githubusercontent.com/3001525/75336265-c8452e00-58c5-11ea-84a7-35e7a2ceccfe.png) |

> iPod Touch connected to TV via AirPlay

## Known issues

#### ios

- Developer menu and keyborad shoutcuts may not work properly if you attached view renderer into external screen, until it leaves the external screen. As an alternative, you can use dev menu functions from `DevSettings` module of React Native. (Such as through [`react-native-debugger`](https://github.com/jhen0409/react-native-debugger))

#### android

- Not good support for react-native `Modal`, it always show on main screen for Android

## About iPad Split View / Slide Over

If you want the app works on iPad Split View and External screen, the app should be main screen (on left as Split View), It doesn't work on right side or as Slide Over, because it wouldn't receive `UIScreenDidConnectNotification` event.

## Related projects

- [`react-native-media-player`](https://github.com/mybigday/react-native-media-player)
- [`react-native-external-screen`](https://github.com/mackeian/react-native-external-screen)

## License

[MIT](LICENSE.md)

---

<p align="center">
  <a href="https://bricks.tools">
    <img width="90px" src="https://avatars.githubusercontent.com/u/17320237?s=200&v=4">
  </a>
  <p align="center">
    Built and maintained by <a href="https://bricks.tools">BRICKS</a>.
  </p>
</p>
