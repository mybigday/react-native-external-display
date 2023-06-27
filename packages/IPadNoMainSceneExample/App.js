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
      {Object.entries(info).map(([id, screen], index) => (
        // TODO: This handle to avoid `Detected two or more RNExternalDisplayView` error
        // It need to fix because it not a good solution
        <React.Fragment key={id}>
          <ExternalDisplay fallbackInMainScreen={false} screen={id}>
            <SimpleBrowser screenId={id} screenIndex={index} screen={screen} />
          </ExternalDisplay>
        </React.Fragment>
      ))}
    </GestureHandlerRootView>
  )
}
