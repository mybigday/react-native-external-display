import React, { useState } from 'react'
import { SafeAreaView, Text, View, Button } from 'react-native'
import ExternalDisplay, {
  useExternalDisplay,
  useScreenSize,
} from 'react-native-external-display'

const InScreen = () => {
  const { id, width, height } = useScreenSize() || {}
  return (
    <View
      style={{
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#333',
      }}
    >
      <Text style={{ color: 'red', fontSize: 40 }}>
        ID:
        {' '}
        {id || '(Main)'}
      </Text>
      <Text style={{ color: 'red', fontSize: 40 }}>
        Width: 
        {' '}
        {width || '(Main)'}
      </Text>
      <Text style={{ color: 'red', fontSize: 40 }}>
        Height: 
        {' '}
        {height || '(Main)'}
      </Text>
    </View>
  )
}

export default function Example() {
  const info = useExternalDisplay()
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
          >
            <InScreen />
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
