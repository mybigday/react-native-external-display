import React, { useState } from 'react'

import { View, Button } from 'react-native'
import { SceneManager } from 'react-native-external-display'

import SimpleTextInterval from './SimpleTextInterval'
import Modal from './Modal'
import ScreenSize from './ScreenSize'
import ScrollView from './ScrollView'
import WebView from './WebView'
import IPadMultipleScenes from './IPadMultipleScenes'
import Touch from './Touch'

const exampleMap = {
  SimpleTextInterval,
  Modal,
  ScreenSize,
  ScrollView,
  WebView,
  ...(SceneManager.isAvailable()
    ? {
        IPadMultipleScenes,
        Touch,
      }
    : {}),
}

function App() {
  const [page, setPage] = useState<keyof typeof exampleMap | null>(null)

  if (page) {
    const Component = exampleMap[page]

    if (Component) {
      return <Component onBack={() => setPage(null)} />
    }
  }

  const keys = Object.keys(exampleMap) as Array<keyof typeof exampleMap>

  return (
    <View
      style={{ flex: 1, backgroundColor: 'black', justifyContent: 'center' }}
    >
      {keys.map((key) => (
        <Button key={key} title={key} onPress={() => setPage(key)} />
      ))}
    </View>
  )
}

export default App
