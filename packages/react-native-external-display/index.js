/**
 * @format
 * @flow strict-local
 */

import React, { useEffect } from 'react'
import {
  NativeModules,
  requireNativeComponent,
  NativeEventEmitter,
  DeviceEventEmitter,
  StyleSheet,
  Platform,
  Dimensions,
} from 'react-native'
import type { ViewProps } from 'react-native/Libraries/Components/View/ViewPropTypes'

const { RNExternalDisplayEvent } = NativeModules

let EventEmitter

if (Platform.OS === 'ios') {
  RNExternalDisplayEvent.init()
  EventEmitter = new NativeEventEmitter(RNExternalDisplayEvent)
} else {
  EventEmitter = DeviceEventEmitter
}

let scale
if (Platform.OS === 'ios') {
  scale = 1
} else {
  ;({ scale } = Dimensions.get('screen'))
}

const styles = {
  screen: StyleSheet.absoluteFill,
}

let screenInfo = RNExternalDisplayEvent.SCREEN_INFO

const RNExternalDisplay = requireNativeComponent('RNExternalDisplay')

type Props = {
  ...ViewProps,
  mainScreenStyle?: ViewProps.style,
  screen?: string,
  fallbackInMainScreen?: boolean,
  onScreenConnect?: Function,
  onScreenChange?: Function,
  onScreenDisconnect?: Function,
}

const ExternalDisplayView = (props: Props) => {
  const {
    screen,
    fallbackInMainScreen,
    mainScreenStyle,
    onScreenConnect,
    onScreenChange,
    onScreenDisconnect,
    ...nativeProps
  } = props
  useEffect(() => {
    const connect = EventEmitter.addListener(
      '@RNExternalDisplay_screenDidConnect',
      info => {
        if (onScreenConnect) onScreenConnect(info)
        screenInfo = info
      },
    )

    const change = EventEmitter.addListener(
      '@RNExternalDisplay_screenDidChange',
      info => {
        if (onScreenChange) onScreenChange(info)
        screenInfo = info
      },
    )

    const disconnect = EventEmitter.addListener(
      '@RNExternalDisplay_screenDidDisconnect',
      info => {
        if (onScreenDisconnect) onScreenDisconnect(info)
        screenInfo = info
      },
    )

    return () => {
      connect.remove()
      change.remove()
      disconnect.remove()
    }
  }, [])

  const scr = screenInfo[screen] || screenInfo[0]
  if (!scr && !fallbackInMainScreen) {
    return null
  }
  return (
    <RNExternalDisplay
      pointerEvents={!scr ? 'box-none' : 'auto'}
      {...nativeProps}
      style={[
        !scr && mainScreenStyle,
        scr && styles.screen,
        scr && {
          width: scr.width / scale,
          height: scr.height / scale,
        },
      ]}
      screen={screen || ''}
      fallbackInMainScreen={fallbackInMainScreen}
    />
  )
}

ExternalDisplayView.defaultProps = {
  mainScreenStyle: undefined,
  screen: '',
  fallbackInMainScreen: false,
  onScreenConnect: () => {},
  onScreenChange: () => {},
  onScreenDisconnect: () => {},
}

type ScreenInfo = {
  [screenId: string]: {
    width: number,
    height: number,
    mirrored?: boolean,
  },
}
export const getScreens = (): ScreenInfo => screenInfo

EventEmitter.addListener(
  '@RNExternalDisplay_screenDidConnect',
  info => console.log(screenInfo) || (screenInfo = info),
)

EventEmitter.addListener(
  '@RNExternalDisplay_screenDidChange',
  info => console.log(screenInfo) || (screenInfo = info),
)

EventEmitter.addListener(
  '@RNExternalDisplay_screenDidDisconnect',
  info => console.log(screenInfo) || (screenInfo = info),
)

export default ExternalDisplayView
