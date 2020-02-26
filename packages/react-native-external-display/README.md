# react-native-external-display

> React Native view renderer in External Display.

## Installation

- Add dependency with `yarn add react-native-external-display`
- You may need to run `react-native link react-native-external-display` or autolinking.

## Usage

Example

```js
import ExternalDisplay, { getScreens } from 'react-native-external-display'

const screenInfo = getScreens()

<ExternalDisplay
  mainScreenStyle={{ flex: 1 }}
  fallbackInMainScreen
  screen={Object.keys(screenInfo)[0]}
  onScreenConnect={info => {}}
  onScreenDisconnect={info => {}}
>
  <View
    style={{
      flex: 1
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: '#333',
    }}
  >
    <Text style={{ color: 'red', fontSize: 40 }}>External Display</Text>
  </View>
</ExternalDisplay>
```

## `getScreens(): ScreenInfo`

```flow
type ScreenInfo = {
  [screenId: string]: {
    width: number,
    height: number,
    mirrored?: boolean,
  },
}
```

## `<ExternalDisplay />`

#### Props (Extend [`ViewProps`](https://reactnative.dev/docs/view#props))

| Prop                   | Type                                                                     | Note                                                                                                                                           |
| ---------------------- | ------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| `fallbackInMainScreen` | `Boolean`                                                                | Render `children` in main screen if no detected external display target. It's useful if you don't want the component instances to be re-mount. |
| `mainScreenStyle`      | [`ViewProps.style`](https://reactnative.dev/docs/view-style-props#props) | Style of `fallbackInMainScreen` render `children` wrap view container.                                                                         |
| `screen`               | `String`                                                                 | Render external display target, you can get `screenId` from `ScreenInfo` type                                                                  |

#### Events

| Event Name           | Returns      | Notes                            |
| -------------------- | ------------ | -------------------------------- |
| `onScreenConnect`    | `ScreenInfo` | When an external monitor added   |
| `onScreenDisconnect` | `ScreenInfo` | When an external monitor removed |

## License

[MIT](https://github.com/mybigday/react-native-external-display/blob/master/LICENSE.md)
