/**
 * @format
 * @flow strict-local
 */
import { useState, useEffect } from 'react'
import { getScreens } from './screens'
import listenEvent from './EventEmitter'

type ExternalDisplayOptions = {
  onScreenConnect: Function,
  onScreenChange: Function,
  onScreenDisconnect: Function,
}

export const useExternalDisplay = ({
  onScreenConnect,
  onScreenChange,
  onScreenDisconnect,
}?: ExternalDisplayOptions = {}) => {
  const [screens, setScreens] = useState(getScreens())

  useEffect(() => {
    const { connect, change, disconnect } = listenEvent({
      onScreenConnect: info => {
        setScreens(info)
        if (onScreenConnect) onScreenConnect(info)
      },
      onScreenChange: info => {
        setScreens(info)
        if (onScreenChange) onScreenChange(info)
      },
      onScreenDisconnect: info => {
        setScreens(info)
        if (onScreenDisconnect) onScreenDisconnect(info)
      },
    })
    return () => {
      connect.remove()
      change.remove()
      disconnect.remove()
    }
  }, [])

  return screens
}
