import React from 'react'
import ExternalDisplay, {
  useExternalDisplay,
} from 'react-native-external-display'
import SimpleBrowser from './SimpleBrowser'
import { GestureHandlerRootView } from 'react-native-gesture-handler'

export default function App() {
  const info = useExternalDisplay()

  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      {
        // TODO: Fix race condition of RNExternalDisplayView
        // Currently sort the screens by ID to avoid the issue
        Object.keys(info).map((id, index) => {
          const screen = info[id]
          return (
            <ExternalDisplay key={id} fallbackInMainScreen={false} screen={id}>
              <SimpleBrowser screenId={id} screenIndex={index} screen={screen} />
            </ExternalDisplay>
          )
        })
      }
    </GestureHandlerRootView>
  )
}
