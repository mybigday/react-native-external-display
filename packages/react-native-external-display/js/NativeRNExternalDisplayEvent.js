// @flow strict-local
import type { TurboModule } from 'react-native/Libraries/TurboModule/RCTExport'
import { TurboModuleRegistry } from 'react-native'

export interface Spec extends TurboModule {
  getInitialScreens: () => {||},
  init: () => void,
}
export default (TurboModuleRegistry.get<Spec>('RNExternalDisplayEvent'): ?Spec)
