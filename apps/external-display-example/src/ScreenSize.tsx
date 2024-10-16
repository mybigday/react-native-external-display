// @flow

import React, { useState } from 'react'
import { SafeAreaView, Text, View } from 'react-native'
import ExternalDisplay, {
  useExternalDisplay,
  useScreenSize,
} from 'react-native-external-display'
import ScreenControl from './utils/ScreenControl'

const InScreen = () => {
  const { id, width, height } = useScreenSize() || {}
  return (
    <View
      style={{
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#333',
      }}
    >
      <Text style={{ color: 'red', fontSize: 28, textAlign: 'center' }}>
        ID: {id || '(Main)'}
      </Text>
      <Text style={{ color: 'red', fontSize: 28, textAlign: 'center' }}>
        Width: {width || '(Main)'}
      </Text>
      <Text style={{ color: 'red', fontSize: 28, textAlign: 'center' }}>
        Height: {height || '(Main)'}
      </Text>
    </View>
  )
}

type Props = {
  onBack: () => void
}

export default function Example(props: Props) {
  const { onBack } = props
  const info = useExternalDisplay()
  const [on, setOn] = useState(true)
  const [mount, setMount] = useState(true)
  const [screen, setScreen] = useState<string | null>(null)
  return (
    <SafeAreaView
      style={{
        flex: 1,
        backgroundColor: 'black',
      }}
    >
      <View style={{ flex: 1 }}>
        {mount && (
          <ExternalDisplay
            mainScreenStyle={{ flex: 1 }}
            fallbackInMainScreen
            screen={on && (screen || Object.keys(info)[0])}
          >
            <InScreen />
          </ExternalDisplay>
        )}
      </View>
      <ScreenControl
        on={on}
        mount={mount}
        onSelectScreen={setScreen}
        onChangeMount={setMount}
        onToggle={setOn}
        onBack={onBack}
      />
    </SafeAreaView>
  )
}
