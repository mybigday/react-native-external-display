import { View, NativeModules } from 'react-native'

NativeModules.RNExternalDisplayEvent = {
  init: () => {},
  SCREEN_INFO: {},
  addListener: () => {},
  removeListener: () => {},
  getConstants: () => ({
    SCREEN_INFO: {},
  }),
}

export default View
