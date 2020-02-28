// @flow

import React from 'react'
import { View, Button } from 'react-native'

type Props = {
  navigation: {
    push: Function,
  },
}

export default function Home(props: Props) {
  const { navigation } = props
  return (
    <View
      style={{ flex: 1, backgroundColor: 'black', justifyContent: 'center' }}
    >
      <Button
        title="SimpleTextInterval"
        onPress={() => navigation.push('SimpleTextInterval')}
      />
      <Button title="Video" onPress={() => navigation.push('Video')} />
      <Button title="Modal" onPress={() => navigation.push('Modal')} />
    </View>
  )
}
