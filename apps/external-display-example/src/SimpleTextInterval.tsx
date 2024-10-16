// @flow

import React, { useEffect, useState } from 'react'
import { SafeAreaView, Text, View } from 'react-native'
import ExternalDisplay, { getScreens } from 'react-native-external-display'
import ScreenControl from './utils/ScreenControl'

type Props = {
  onBack: () => void
}

export default function Example(props: Props) {
  const { onBack } = props
  const [t, setT] = useState(0)
  const [info, setInfo] = useState(getScreens())

  const [on, setOn] = useState(true)
  const [mount, setMount] = useState(true)
  const [screen, setScreen] = useState<string | null>(null)
  useEffect(() => {
    const interval = setInterval(() => setT((d) => d + 1), 1000)
    return () => clearInterval(interval)
  }, [])
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
            mainScreenStyle={{
              flex: 1,
            }}
            fallbackInMainScreen
            screen={on && (screen || Object.keys(info)[0])}
            onScreenConnect={setInfo}
            onScreenDisconnect={setInfo}
          >
            <View
              style={{
                flex: 1,
                justifyContent: 'center',
                alignItems: 'center',
                backgroundColor: '#333',
              }}
            >
              <Text style={{ color: 'red', fontSize: 40 }}>{t}</Text>
            </View>
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
