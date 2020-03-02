/**
 * @format
 * @flow strict-local
 */

import React from 'react'
import { StyleSheet } from 'react-native'
import type { ViewProps } from 'react-native/Libraries/Components/View/ViewPropTypes'
import RNExternalDisplay from './js/ExternalDisplay'
import { getScreens } from './js/screens'
import { useExternalDisplay } from './js/useExternalDisplay'

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
  const screens = useExternalDisplay(props)
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
          width: scr.width,
          height: scr.height,
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

export { getScreens, useExternalDisplay }

export default ExternalDisplayView
