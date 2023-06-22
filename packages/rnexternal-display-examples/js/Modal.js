// @flow

import React, { useEffect, useState } from 'react'
import { SafeAreaView, Text, View, Button, Modal } from 'react-native'
import ExternalDisplay, { getScreens } from 'react-native-external-display'

type Props = {
  onBack: () => void,
}

export default function Example(props: Props) {
  const { onBack } = props
  const [t, setT] = useState(0)
  const [info, setInfo] = useState(getScreens())
  const [on, setOn] = useState(true)
  const [mount, setMount] = useState(true)
  const [open, setOpen] = useState(true)
  useEffect(() => {
    const interval = setInterval(() => setT(d => d + 1), 1000)
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
            {/* Wrap view to avoid error */}
            <View>
              <Modal animationType="slide" visible={open}>
                <View
                  style={{
                    flex: 1,
                    justifyContent: 'center',
                    alignItems: 'center',
                    backgroundColor: '#333',
                  }}
                >
                  <Text style={{ color: 'red', fontSize: 40 }}>{t}</Text>
                  <Button title="Close" onPress={() => setOpen(false)} />
                </View>
              </Modal>
            </View>
          </ExternalDisplay>
        )}
      </View>
      <Button
        onPress={() => setOpen(d => !d)}
        title={open ? 'Close' : 'Open'}
      />
      <Button onPress={() => setOn(d => !d)} title={on ? 'OFF' : 'ON'} />
      <Button
        onPress={() => setMount(d => !d)}
        title={mount ? 'UNMOUNT' : 'MOUNT'}
      />
      <Button onPress={onBack} title="BACK" />
    </SafeAreaView>
  )
}
