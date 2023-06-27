import React, { useState } from 'react'
import { View, Button } from 'react-native'
import { SceneManager } from 'react-native-external-display'

import SimpleTextInterval from './SimpleTextInterval'
import Modal from './Modal'
import ScreenSize from './ScreenSize'
import ScrollView from './ScrollView'
import WebView from './WebView'
import IPadMultipleScenes from './IPadMultipleScenes'

const exampleMap = {
  SimpleTextInterval,
  Modal,
  ScreenSize,
  ScrollView,
  WebView,
}
if (SceneManager.isAvailable()) {
  exampleMap.IPadMultipleScenes = IPadMultipleScenes
}

function App() {
  const [page, setPage] = useState(null)

  const Example = exampleMap[page]

  if (Example) {
    return <Example onBack={() => setPage(null)} />
  }

  return (
    <View
      style={{ flex: 1, backgroundColor: 'black', justifyContent: 'center' }}
    >
      {Object.keys(exampleMap).map((key) => (
        <Button key={key} title={key} onPress={() => setPage(key)} />
      ))}
    </View>
  )
}

export default App
