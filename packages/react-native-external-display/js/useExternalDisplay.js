/**
 * @format
 * @flow strict-local
 */
import { useState, useEffect } from 'react'
import { getScreens } from './screens'
import EventEmitter from './EventEmitter'

type ExternalDisplayOptions = {
  onScreenConnect: Function,
  onScreenChange: Function,
  onScreenDisconnect: Function,
}

export const useExternalDisplay = ({
  onScreenConnect,
  onScreenChange,
  onScreenDisconnect,
}: ExternalDisplayOptions) => {
  const [screens, setScreens] = useState(getScreens())

  useEffect(() => {
    const connect = EventEmitter.addListener(
      '@RNExternalDisplay_screenDidConnect',
      info => {
        setScreens(info)
        if (onScreenConnect) onScreenConnect(info)
      },
    )

    const change = EventEmitter.addListener(
      '@RNExternalDisplay_screenDidChange',
      info => {
        setScreens(info)
        if (onScreenChange) onScreenChange(info)
      },
    )

    const disconnect = EventEmitter.addListener(
      '@RNExternalDisplay_screenDidDisconnect',
      info => {
        setScreens(info)
        if (onScreenDisconnect) onScreenDisconnect(info)
      },
    )

    return () => {
      connect.remove()
      change.remove()
      disconnect.remove()
    }
  }, [])

  return screens
}
