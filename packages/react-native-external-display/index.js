/**
 * @format
 * @flow strict-local
 */

import React, { useContext } from 'react'
import { StyleSheet } from 'react-native'
import type { ViewProps } from 'react-native/Libraries/Components/View/ViewPropTypes'
import RNExternalDisplay from './js/ExternalDisplay'
import { getScreens } from './js/screens'
import type { Screen } from './js/screens'
import { useExternalDisplay } from './js/useExternalDisplay'

const styles = {
  screen: StyleSheet.absoluteFill,
}

const ScreenContext = React.createContext(null)

export const useScreenSize = (): Screen => useContext(ScreenContext)

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
    <ScreenContext.Provider value={scr}>
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
    </ScreenContext.Provider>
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
