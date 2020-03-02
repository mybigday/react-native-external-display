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

type ScreenInfo = {
  [screenId: string]: {
    width: number,
    height: number,
    mirrored?: boolean,
  },
}

export const getScreens = (): ScreenInfo => screenInfo
