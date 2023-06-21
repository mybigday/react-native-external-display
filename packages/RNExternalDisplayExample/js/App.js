import React, { useState } from 'react'
import { View, Button } from 'react-native'

import SimpleTextInterval from './SimpleTextInterval'
import Modal from './Modal'
import ScreenSize from './ScreenSize'
import ScrollView from './ScrollView'
import WebView from './WebView'

const exampleMap = {
  SimpleTextInterval,
  Modal,
  ScreenSize,
  ScrollView,
  WebView,
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
      <Button
        title="SimpleTextInterval"
        onPress={() => setPage('SimpleTextInterval')}
      />
      <Button title="Video" onPress={() => setPage('Video')} />
      <Button title="Modal" onPress={() => setPage('Modal')} />
      <Button title="ScreenSize" onPress={() => setPage('ScreenSize')} />
      <Button title="ScrollView" onPress={() => setPage('ScrollView')} />
      <Button title="WebView" onPress={() => setPage('WebView')} />
    </View>
  )
}

export default App
