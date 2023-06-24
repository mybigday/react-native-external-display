import React, { useState } from 'react'
import { View, Button } from 'react-native'
import ExternalDisplayEvent from 'react-native-external-display/js/NativeRNExternalDisplayEvent'

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
      {Object.keys(exampleMap).map((key) => (
        <Button key={key} title={key} onPress={() => setPage(key)} />
      ))}
      <Button title="Request new Scene" onPress={() => {
        ExternalDisplayEvent.requestScene().then(console.log)
      }} />
    </View>
  )
}

export default App
