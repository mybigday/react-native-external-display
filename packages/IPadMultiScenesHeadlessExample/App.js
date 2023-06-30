import React from 'react'
import { Text } from 'react-native'
import ExternalDisplay, {
  useExternalDisplay,
  SceneManager,
} from 'react-native-external-display'
import SimpleBrowser from './SimpleBrowser'

export default function App() {
  const info = useExternalDisplay()

  return Object.keys(info).map((id, index) => {
    const screen = info[id]
    if (screen.type == SceneManager.types.EXTERNAL_DISPLAY) {
      return (
        <ExternalDisplay
          key={id}
          style={{
            flex: 1,
            alignItems: 'center',
            justifyContent: 'center',
          }}
          fallbackInMainScreen={false}
          screen={id}
        >
          <Text
            style={{
              textAlign: 'center',
              color: '#fff',
              verticalAlign: 'middle',
            }}
          >
            I&apos;m External Display!
          </Text>
        </ExternalDisplay>
      )
    }
    return (
      <ExternalDisplay key={id} fallbackInMainScreen={false} screen={id}>
        <SimpleBrowser screenId={id} screenIndex={index} screen={screen} />
      </ExternalDisplay>
    )
  })
}
