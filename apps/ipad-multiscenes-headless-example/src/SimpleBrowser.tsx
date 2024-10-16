import React, { useState, useRef } from 'react'
import { View, Text, TextInput, Button } from 'react-native'
import WebView from 'react-native-webview'
import { SceneManager } from 'react-native-external-display'

const defaultURLs = [
  'https://reactnative.dev',
  'https://google.com',
  'https://apple.com',
  'https://github.com',
  'https://www.npmjs.com',
]

type Props = {
  screen: {}
  screenId: string
  screenIndex: number
}

export default function SimpleBrowser(props: Props) {
  const { screenId, screenIndex } = props

  const [url, setUrl] = useState(
    defaultURLs[Math.floor(Math.random() * defaultURLs.length)],
  )
  const webview = useRef(null)

  return (
    <View style={{ flex: 1 }}>
      <View style={{ alignItems: 'center', padding: 10 }}>
        <Text style={{ color: 'white', fontSize: 20, textAlign: 'center' }}>
          {`ID: ${screenId} (${screenIndex})`}
        </Text>
      </View>

      <View style={{ flexDirection: 'row', alignItems: 'center', padding: 4 }}>
        <Text style={{ color: 'white' }}>URL:</Text>
        <TextInput
          style={{ flex: 1, color: 'white' }}
          value={url}
          onChangeText={setUrl}
          autoCapitalize="none"
        />
        <Button
          title="New Window"
          onPress={() => {
            SceneManager.requestScene({
              userInfo: { testField: 'testValue' },
            })
          }}
        />
        <Button
          title="Close"
          onPress={() => SceneManager.closeScene(screenId)}
        />
      </View>
      <WebView
        ref={webview}
        source={{ uri: url }}
        style={{ flex: 1 }}
        allowsInlineMediaPlayback
        allowsFullscreenVideo={false}
      />
    </View>
  )
}
