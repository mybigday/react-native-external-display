// @flow

import React, { useState } from 'react'
import { SafeAreaView, View, Text, Button, Animated } from 'react-native'
import ExternalDisplay, { getScreens } from 'react-native-external-display'
import {
  GestureHandlerRootView,
  Swipeable,
  TouchableOpacity,
  RectButton,
} from 'react-native-gesture-handler'
import ScreenControl from './utils/ScreenControl'

type Props = {
  onBack: () => void
}

export default function Example(props: Props) {
  const { onBack } = props
  const [info, setInfo] = useState(getScreens())

  const [on, setOn] = useState(true)
  const [mount, setMount] = useState(true)
  const [screen, setScreen] = useState<string | null>(null)
  return (
    <SafeAreaView
      style={{
        flex: 1,
        backgroundColor: 'black',
      }}
    >
      <GestureHandlerRootView style={{ flex: 1 }}>
        {mount && (
          <ExternalDisplay
            mainScreenStyle={{ flex: 1 }}
            fallbackInMainScreen
            screen={on && (screen || Object.keys(info)[0])}
            onScreenConnect={setInfo}
            onScreenDisconnect={setInfo}
          >
            <View
              style={{
                flex: 1,
                justifyContent: 'center',
                alignItems: 'center',
                backgroundColor: '#333',
              }}
            >
              <Button
                title="React Native Button"
                onPress={() => alert('Working')}
              />
              <TouchableOpacity
                onPress={() => {
                  alert('Working')
                }}
                style={{ padding: 8 }}
              >
                <Text style={{ color: 'white', fontSize: 16 }}>
                  Gesture Handler Button
                </Text>
              </TouchableOpacity>

              <Swipeable
                renderLeftActions={(progress, dragX) => {
                  const trans = dragX.interpolate({
                    inputRange: [0, 50, 100, 101],
                    outputRange: [-20, 0, 0, 1],
                  })
                  return (
                    <RectButton
                      style={{
                        padding: 8,
                        backgroundColor: 'blue',
                        justifyContent: 'center',
                      }}
                      onPress={() => {
                        alert('Working')
                      }}
                    >
                      <Animated.Text
                        style={[
                          {
                            color: 'white',
                            fontSize: 16,
                            transform: [{ translateX: trans }],
                          },
                        ]}
                      >
                        Alert
                      </Animated.Text>
                    </RectButton>
                  )
                }}
              >
                <Text style={{ padding: 8, color: 'white', fontSize: 16 }}>
                  Gesture Handler Swipeable (Left)
                </Text>
              </Swipeable>
            </View>
          </ExternalDisplay>
        )}
      </GestureHandlerRootView>
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
