import RNExternalDisplayEvent from './NativeRNExternalDisplayEvent'

export default {
  isAvailable: () => !!RNExternalDisplayEvent.SUPPORT_MULTIPLE_SCENES,
  requestScene: (options) => RNExternalDisplayEvent.requestScene?.(options),
  closeScene: (sceneId) => RNExternalDisplayEvent.closeScene?.(sceneId),
  isMainSceneActive: () => RNExternalDisplayEvent.isMainSceneActive?.(),
  resumeMainScene: () => RNExternalDisplayEvent.resumeMainScene?.(),
}
