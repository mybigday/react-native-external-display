/**
 * @format
 * @flow strict-local
 */

import React, { useContext } from 'react'
import { StyleSheet } from 'react-native'
import type { ViewProps } from 'react-native/Libraries/Components/View/ViewPropTypes'
import RNExternalDisplay from './js/NativeRNExternalDisplay'
import { getScreens } from './js/screens'
import type { Screen } from './js/screens'
import { useExternalDisplay } from './js/useExternalDisplay'
import SceneManager from './js/SceneManager'

const styles = {
  screen: StyleSheet.absoluteFill,
}

const ScreenContext = React.createContext(null)

export const useScreenSize = (): Screen => useContext(ScreenContext)

type Props = {
  ...ViewProps,
  style?: ViewProps.style,
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
    style,
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
    <ScreenContext.Provider value={scr}>
      <RNExternalDisplay
        pointerEvents={!scr ? 'box-none' : 'auto'}
        {...nativeProps}
        style={[
          scr && styles.screen,
          scr && {
            width: scr.width,
            height: scr.height,
          },
          style,
          !scr && mainScreenStyle,
        ]}
        screen={scr ? screen : ''}
        fallbackInMainScreen={fallbackInMainScreen}
      />
    </ScreenContext.Provider>
  )
}

ExternalDisplayView.defaultProps = {
  style: undefined,
  mainScreenStyle: undefined,
  screen: '',
  fallbackInMainScreen: false,
  onScreenConnect: () => {},
  onScreenChange: () => {},
  onScreenDisconnect: () => {},
}

export { getScreens, useExternalDisplay, SceneManager }

export default ExternalDisplayView
