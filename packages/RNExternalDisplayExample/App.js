import React, {
  // useEffect,
  useState,
} from 'react'
import {
  SafeAreaView,
  // Text,
  // View,
  Button,
} from 'react-native'
import Video from 'react-native-video'
import ExternalDisplay, { getScreens } from 'react-native-external-display'

export default function App() {
  // const [t, setT] = useState(0)
  const [info, setInfo] = useState(getScreens())
  const [on, setOn] = useState(true)
  const [mount, setMount] = useState(true)
  // useEffect(() => {
  //   const interval = setInterval(() => setT(d => d + 1), 1000)
  //   return () => clearInterval(interval)
  // }, [])
  return (
    <>
      <SafeAreaView
        style={{
          flex: 1,
          backgroundColor: 'black',
        }}
      >
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
            {/* <View
              style={{
                justifyContent: 'center',
                alignItems: 'center',
                backgroundColor: '#333',
              }}
            >
              <Text style={{ color: 'red', fontSize: 40 }}>{t}</Text>
            </View> */}
          </ExternalDisplay>
        )}
        <Button onPress={() => setOn(d => !d)} title={on ? 'OFF' : 'ON'} />
        <Button
          onPress={() => setMount(d => !d)}
          title={mount ? 'UNMOUNT' : 'MOUNT'}
        />
      </SafeAreaView>
    </>
  )
}
