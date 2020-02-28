import React, { useState } from 'react'
import { SafeAreaView, View, Button } from 'react-native'
import Video from 'react-native-video'
import ExternalDisplay, { getScreens } from 'react-native-external-display'

export default function Example() {
  const [info, setInfo] = useState(getScreens())
  const [on, setOn] = useState(true)
  const [mount, setMount] = useState(true)
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
            <Video
              source={{
                uri: 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4',
              }}
              style={{ flex: 1 }}
              repeat
              muted
            />
          </ExternalDisplay>
        )}
      </View>
      <Button onPress={() => setOn(d => !d)} title={on ? 'OFF' : 'ON'} />
      <Button
        onPress={() => setMount(d => !d)}
        title={mount ? 'UNMOUNT' : 'MOUNT'}
      />
    </SafeAreaView>
  )
}
