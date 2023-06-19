import React, { useState } from 'react'
import { View, Button } from 'react-native'

import Video from './Video'
import SimpleTextInterval from './SimpleTextInterval'
import Modal from './Modal'
import ScreenSize from './ScreenSize'
import ScrollView from './ScrollView'

const exampleMap = {
  Video,
  SimpleTextInterval,
  Modal,
  ScreenSize,
  ScrollView,
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
      <Button
        title="ScreenSize"
        onPress={() => setPage('ScreenSize')}
      />
      <Button
        title="ScrollView"
        onPress={() => setPage('ScrollView')}
      />
    </View>
  )
}

export default App
