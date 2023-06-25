// @flow

import React, { useState, useRef } from 'react'
import { SafeAreaView, View, Text, Button, ScrollView } from 'react-native'
import ExternalDisplay, { getScreens } from 'react-native-external-display'
import SceneManager from './SceneManager'

type Props = {
  onBack: () => void,
}

export default function Example(props: Props) {
  const { onBack } = props
  const [info, setInfo] = useState(getScreens())
  const [on, setOn] = useState(true)
  const [mount, setMount] = useState(true)
  const scrollViewRef = useRef()
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
            screen={on && Object.keys(info)[0]}
            onScreenConnect={setInfo}
            onScreenDisconnect={setInfo}
          >
            <ScrollView ref={scrollViewRef} style={{ backgroundColor: 'black' }}>
              {new Array(100)
                .fill(0)
                .map((_, i) => (
                  <Text
                    // eslint-disable-next-line react/no-array-index-key
                    key={`item-${i}`}
                    style={{
                      color: 'white',
                      fontSize: 30,
                      textAlign: 'center',
                      marginVertical: 20,
                    }}
                  >
                    {i}
                  </Text>
                ))}
            </ScrollView>
          </ExternalDisplay>
        )}
      </View>
      <Button
        onPress={() => {
        // scroll down
        scrollViewRef.current.scrollToEnd()
      }}
        title="Scroll down"
      />
      <Button
        onPress={() => {
        // scroll up
        scrollViewRef.current.scrollTo({ y: 0 })
      }}
        title="Scroll up"
      />
      <Button onPress={() => setOn(d => !d)} title={on ? 'OFF' : 'ON'} />
      <Button
        onPress={() => setMount(d => !d)}
        title={mount ? 'UNMOUNT' : 'MOUNT'}
      />
      <SceneManager />
      <Button onPress={onBack} title="BACK" />
    </SafeAreaView>
  )
}
