// @flow

import React from 'react'
import { Button, View } from 'react-native'
import SceneManager from './SceneManager'

type Props = {
  on: boolean
  mount: boolean
  onSelectScreen: (id: string) => void
  onChangeMount: (fn: (d: boolean) => boolean) => void
  onToggle: (fn: (d: boolean) => boolean) => void
  onBack: () => void
}

export default function ScreenControl(props: Props) {
  const { on, mount, onSelectScreen, onChangeMount, onToggle, onBack } = props
  return (
    <View>
      <Button onPress={() => onToggle((d) => !d)} title={on ? 'OFF' : 'ON'} />
      <Button
        onPress={() => onChangeMount((d) => !d)}
        title={mount ? 'UNMOUNT' : 'MOUNT'}
      />
      <SceneManager onSelectScreen={onSelectScreen} />
      <Button onPress={onBack} title="BACK" />
    </View>
  )
}
