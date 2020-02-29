/**
 * @format
 * @flow strict-local
 */

import { NativeModules } from 'react-native'
import EventEmitter from './EventEmitter'

const { RNExternalDisplayEvent } = NativeModules

let screenInfo = RNExternalDisplayEvent.SCREEN_INFO

EventEmitter.addListener(
  '@RNExternalDisplay_screenDidConnect',
  info => (screenInfo = info),
)

EventEmitter.addListener(
  '@RNExternalDisplay_screenDidChange',
  info => (screenInfo = info),
)

EventEmitter.addListener(
  '@RNExternalDisplay_screenDidDisconnect',
  info => (screenInfo = info),
)

type ScreenInfo = {
  [screenId: string]: {
    width: number,
    height: number,
    mirrored?: boolean,
  },
}

export const getScreens = (): ScreenInfo => screenInfo
