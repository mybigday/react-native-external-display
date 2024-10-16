// @flow

import React, { useState, useRef, LegacyRef } from 'react'
import { SafeAreaView, View, Text, Button, ScrollView } from 'react-native'
import ExternalDisplay, { getScreens } from 'react-native-external-display'
import ScreenControl from './utils/ScreenControl'

type Props = {
  onBack: () => void
}

export default function Example(props: Props) {
  const { onBack } = props
  const [info, setInfo] = useState(getScreens())
  const [on, setOn] = useState(true)
  const [mount, setMount] = useState(true)
  const scrollViewRef: LegacyRef<ScrollView> = useRef(null)
  const [screen, setScreen] = useState<string | null>(null)
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
            screen={on && (screen || Object.keys(info)[0])}
            onScreenConnect={setInfo}
            onScreenDisconnect={setInfo}
          >
            <ScrollView
              ref={scrollViewRef}
              style={{ backgroundColor: 'black' }}
            >
              {new Array(100).fill(0).map((_, i) => (
                <Text
                   
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
          scrollViewRef.current?.scrollToEnd()
        }}
        title="Scroll down"
      />
      <Button
        onPress={() => {
          // scroll up
          scrollViewRef.current?.scrollTo({ y: 0 })
        }}
        title="Scroll up"
      />
      <ScreenControl
        on={on}
        mount={mount}
        onSelectScreen={setScreen}
        onChangeMount={setMount}
        onToggle={setOn}
        onBack={onBack}
      />
    </SafeAreaView>
  )
}
