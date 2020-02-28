import React from 'react'
import { NavigationContainer } from '@react-navigation/native'
import { createStackNavigator } from '@react-navigation/stack'

import Home from './Home'
import Video from './Video'
import SimpleTextInterval from './SimpleTextInterval'
import Modal from './Modal'

const Stack = createStackNavigator()

const screenOptions = {
  cardStyle: {
    backgroundColor: 'black',
  },
}
const options = {
  headerTitleAlign: 'center',
  headerStyle: { backgroundColor: 'black' },
  headerTitleStyle: { color: '#ccc' },
}

function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator screenOptions={screenOptions}>
        <Stack.Screen name="Home" component={Home} options={options} />
        <Stack.Screen name="Video" component={Video} options={options} />
        <Stack.Screen
          name="SimpleTextInterval"
          component={SimpleTextInterval}
          options={options}
        />
        <Stack.Screen name="Modal" component={Modal} options={options} />
      </Stack.Navigator>
    </NavigationContainer>
  )
}

export default App
