// @flow

import React, { useEffect, useState } from 'react'
import { SafeAreaView, Text, View, Button } from 'react-native'
import ExternalDisplay, { getScreens } from 'react-native-external-display'
import SceneManager from './SceneManager'

type Props = {
  onBack: () => void,
}

export default function Example(props: Props) {
  const { onBack } = props
  const [t, setT] = useState(0)
  const [info, setInfo] = useState(getScreens())

  const [on, setOn] = useState(true)
  const [mount, setMount] = useState(true)
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
            screen={on && Object.keys(info)[0]}
            onScreenConnect={setInfo}
            onScreenDisconnect={setInfo}
          >
            <View
              style={{
                flex: 1,
                justifyContent: 'center',
                alignItems: 'center',
                backgroundColor: '#333',
                height: 100,
              }}
            >
              <Text style={{ color: 'red', fontSize: 40 }}>{t}</Text>
            </View>
          </ExternalDisplay>
        )}
      </View>
      <Button onPress={() => setOn((d) => !d)} title={on ? 'OFF' : 'ON'} />
      <Button
        onPress={() => setMount((d) => !d)}
        title={mount ? 'UNMOUNT' : 'MOUNT'}
      />
      <SceneManager />
      <Button onPress={onBack} title="BACK" />
    </SafeAreaView>
  )
}
