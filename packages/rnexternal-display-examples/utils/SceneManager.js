// @flow

import React from 'react'
import { StyleSheet, View, Button, Text } from 'react-native'
import { SceneManager, useExternalDisplay } from 'react-native-external-display'

const styles = StyleSheet.create({
  screen: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: { color: '#ccc', fontSize: 16 },
})

type Props = {
  onSelectScreen: () => void,
}

export default function SceneManagerComponent(props: Props) {
  const screens = useExternalDisplay()

  if (!SceneManager.isAvailable()) return null
  return (
    <>
      {Object.keys(screens).map((id) => (
        <View key={id} style={styles.screen}>
          <Text style={styles.text}>{`Screen: ${id}`}</Text>
          <Button title="SELECT" onPress={() => props.onSelectScreen(id)} />
          <Button
            title="CLOSE"
            onPress={() => SceneManager.closeScene(id)}
          />
        </View>
      ))}

      <Button
        title="REQUEST NEW SCENE"
        onPress={() => {
          SceneManager.requestScene({
            testField: '1',
          })
        }}
      />
    </>
  )
}
