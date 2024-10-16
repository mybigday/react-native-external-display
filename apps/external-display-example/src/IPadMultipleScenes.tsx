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

  return (
    <SafeAreaView
      style={{
        flex: 1,
        backgroundColor: 'black',
      }}
    >
      <View style={{ flex: 1 }}>
        {mount &&
          Object.keys(info).map((id) => (
            <ExternalDisplay
              key={id}
              fallbackInMainScreen={false}
              screen={on && id}
            >
              <InScreen />
            </ExternalDisplay>
          ))}
      </View>
      <ScreenControl
        on={on}
        mount={mount}
        onSelectScreen={() => {}}
        onChangeMount={setMount}
        onToggle={setOn}
        onBack={onBack}
      />
    </SafeAreaView>
  )
}
