import {
  NativeEventEmitter,
  DeviceEventEmitter,
  Platform,
  Dimensions,
} from 'react-native'
import RNExternalDisplayEvent from './NativeRNExternalDisplayEvent'

let scale
let EventEmitter

if (Platform.OS === 'ios') {
  RNExternalDisplayEvent.init()

  scale = 1
  EventEmitter = new NativeEventEmitter(RNExternalDisplayEvent)
} else {
  ;({ scale } = Dimensions.get('window'))
  EventEmitter = DeviceEventEmitter
}

const handleScreensChange = info =>
  Object.entries(info).reduce((result, [screenId, screen]) => {
    result[screenId] = {
      ...screen,
      width: screen.width / scale,
      height: screen.height / scale,
    }
    return result
  }, {})

console.log(RNExternalDisplayEvent)

export const getInitialScreens = () =>
  handleScreensChange(
    RNExternalDisplayEvent.getInitialScreens?.().SCREEN_INFO ||
    // Old architecture:
    RNExternalDisplayEvent.SCREEN_INFO,
  )

export default function listenEvent({
  onScreenConnect,
  onScreenChange,
  onScreenDisconnect,
}) {
  const connect = EventEmitter.addListener(
    '@RNExternalDisplay_screenDidConnect',
    info => onScreenConnect(handleScreensChange(info)),
  )

  const change = EventEmitter.addListener(
    '@RNExternalDisplay_screenDidChange',
    info => onScreenChange(handleScreensChange(info)),
  )

  const disconnect = EventEmitter.addListener(
    '@RNExternalDisplay_screenDidDisconnect',
    info => onScreenDisconnect(handleScreensChange(info)),
  )

  return {
    connect,
    change,
    disconnect,
  }
}
