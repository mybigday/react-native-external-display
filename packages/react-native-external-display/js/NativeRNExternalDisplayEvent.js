// @flow
import type { TurboModule } from 'react-native/Libraries/TurboModule/RCTExport'
import { TurboModuleRegistry } from 'react-native'

export interface Spec extends TurboModule {
  getInitialScreens: () => {||},
}
export default (TurboModuleRegistry.get<Spec>('RNExternalDisplayEvent'): ?Spec)
