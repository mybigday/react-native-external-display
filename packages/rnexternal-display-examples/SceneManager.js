import React from 'react'
import { View, Button } from 'react-native'
import ExternalDisplayEvent from 'react-native-external-display/js/NativeRNExternalDisplayEvent'

export default function SceneManager(props) {
  return (
    <>
      <Button
        title="REQUEST NEW SCENE"
        onPress={() => {
          ExternalDisplayEvent.requestScene({
            testField: '1',
          }).then(console.log)
        }}
      />
    </>
  )
}
