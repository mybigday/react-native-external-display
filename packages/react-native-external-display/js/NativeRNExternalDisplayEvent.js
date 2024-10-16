// @flow strict-local
import type { TurboModule } from 'react-native/Libraries/TurboModule/RCTExport'
import { TurboModuleRegistry } from 'react-native'

export interface Spec extends TurboModule {
  getInitialScreens: () => {||};
  init: () => void;

  // Scene API (iOS only)
  requestScene: (options: {}) => boolean;
  closeScene: (sceneId: string) => boolean;
  isMainSceneActive: () => boolean;
  resumeMainScene: () => boolean;
}

export default (TurboModuleRegistry.get<Spec>('RNExternalDisplayEvent'): ?Spec)
