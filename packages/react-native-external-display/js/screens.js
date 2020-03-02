/**
 * @format
 * @flow strict-local
 */

import listenEvent, { getInitialScreens } from './EventEmitter'

let screenInfo = getInitialScreens()

listenEvent({
  onScreenConnect: info => (screenInfo = info),
  onScreenChange: info => (screenInfo = info),
  onScreenDisconnect: info => (screenInfo = info),
})

export type Screen = {
  id: string,
  width: number,
  height: number,
  mirrored?: boolean,
}
export type ScreenInfo = {
  [screenId: string]: Screen,
}

export const getScreens = (): ScreenInfo => screenInfo
