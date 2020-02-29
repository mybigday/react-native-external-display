import {
  NativeEventEmitter,
  DeviceEventEmitter,
  NativeModules,
  Platform,
} from 'react-native'

const { RNExternalDisplayEvent } = NativeModules

if (Platform.OS === 'ios') {
  RNExternalDisplayEvent.init()
}

export default Platform.OS === 'ios'
  ? new NativeEventEmitter(RNExternalDisplayEvent)
  : DeviceEventEmitter
