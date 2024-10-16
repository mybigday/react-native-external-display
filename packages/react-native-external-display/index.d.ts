import { getScreens } from './js/screens'
import useExternalDisplay from './js/useExternalDisplay'
import SceneManager from './js/SceneManager'
import { StyleProp, ViewProps, ViewStyle } from 'react-native'
import { Component } from 'react'

export { getScreens, useExternalDisplay, SceneManager }

type Props = {
  mainScreenStyle?: StyleProp<ViewStyle>
  screen?: string
  fallbackInMainScreen?: boolean
} & ExternalDisplayOptions &
  ViewProps

export function useScreenSize(): { id: string; width: number; height: number }

export default Component<Props>
