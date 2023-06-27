// @flow

import React from 'react'
import { Button } from 'react-native'
import SceneManager from './SceneManager'

type Props = {
  on: boolean,
  mount: boolean,
  onSelectScreen: () => void,
  onChangeMount: (fn: (d: boolean) => boolean) => void,
  onToggle: (fn: (d: boolean) => boolean) => void,
  onBack: () => void,
}

export default function ScreenControl(props: Props) {
  const { on, mount, onSelectScreen, onChangeMount, onToggle, onBack } = props
  return (
    <>
      <Button onPress={() => onToggle((d) => !d)} title={on ? 'OFF' : 'ON'} />
      <Button
        onPress={() => onChangeMount((d) => !d)}
        title={mount ? 'UNMOUNT' : 'MOUNT'}
      />
      <SceneManager onSelectScreen={onSelectScreen} />
      <Button onPress={onBack} title="BACK" />
    </>
  )
}
