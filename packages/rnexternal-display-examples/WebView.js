// @flow

import React, { useState } from 'react'
import { SafeAreaView, View, Button } from 'react-native'
import WebView from 'react-native-webview'
import ExternalDisplay, { getScreens } from 'react-native-external-display'
import SceneManager from './SceneManager'

type Props = {
  onBack: () => void,
}

export default function Example(props: Props) {
  const { onBack } = props
  const [info, setInfo] = useState(getScreens())
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
            <WebView
              source={{ uri: 'https://reactnative.dev/' }}
              allowsInlineMediaPlayback
              allowsFullscreenVideo
              style={{ flex: 1 }}
            />
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
