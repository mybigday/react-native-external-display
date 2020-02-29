/**
 * @format
 * @flow strict-local
 */

import React, { useState, useEffect } from 'react'
import { StyleSheet, Platform, Dimensions } from 'react-native'
import type { ViewProps } from 'react-native/Libraries/Components/View/ViewPropTypes'
import RNExternalDisplay from './js/ExternalDisplay'
import EventEmitter from './js/EventEmitter'
import { getScreens } from './js/screens'

let scale
if (Platform.OS === 'ios') {
  scale = 1
} else {
  ;({ scale } = Dimensions.get('screen'))
}

const styles = {
  screen: StyleSheet.absoluteFill,
}

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
  const [screens, setScreens] = useState(getScreens())
  useEffect(() => {
    let connect
    let change
    let disconnect

    if (onScreenConnect) {
      connect = EventEmitter.addListener(
        '@RNExternalDisplay_screenDidConnect',
        info => {
          if (onScreenConnect) onScreenConnect(info)
          setScreens(info)
        },
      )
    }

    if (onScreenChange) {
      change = EventEmitter.addListener(
        '@RNExternalDisplay_screenDidChange',
        info => {
          if (onScreenChange) onScreenChange(info)
          setScreens(info)
        },
      )
    }

    if (onScreenDisconnect) {
      disconnect = EventEmitter.addListener(
        '@RNExternalDisplay_screenDidDisconnect',
        info => {
          if (onScreenDisconnect) onScreenDisconnect(info)
          setScreens(info)
        },
      )
    }

    return () => {
      if (connect) connect.remove()
      if (change) change.remove()
      if (disconnect) disconnect.remove()
    }
  }, [onScreenConnect, onScreenChange, onScreenDisconnect])

  const scr = screens[screen]
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
      screen={scr ? screen : ''}
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

export { getScreens }

export default ExternalDisplayView
