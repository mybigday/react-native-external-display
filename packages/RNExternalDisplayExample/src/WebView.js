// @flow

import React, { useState } from 'react'
import { SafeAreaView, View } from 'react-native'
import WebView from 'react-native-webview'
import ExternalDisplay, { getScreens } from 'react-native-external-display'
import ScreenControl from './utils/ScreenControl'

type Props = {
  onBack: () => void,
}

export default function Example(props: Props) {
  const { onBack } = props
  const [info, setInfo] = useState(getScreens())
  const [on, setOn] = useState(true)
  const [mount, setMount] = useState(true)
  const [screen, setScreen] = useState(null)
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
            <WebView
              source={{ uri: 'https://reactnative.dev/' }}
              allowsInlineMediaPlayback
              allowsFullscreenVideo
              style={{ flex: 1 }}
            />
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
