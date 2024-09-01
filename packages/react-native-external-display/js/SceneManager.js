import RNExternalDisplayEvent from './NativeRNExternalDisplayEvent'

const sceneTypes = {
  EXTERNAL_DISPLAY: '@RNExternalDisplay_externalDisplay',
  CREATED_SCENE: '@RNExternalDisplay_createdScene',
}

export default {
  types: sceneTypes,
  isAvailable: () => !!RNExternalDisplayEvent.SUPPORT_MULTIPLE_SCENES,
  requestScene: (options) => RNExternalDisplayEvent.requestScene?.(options),
  closeScene: (sceneId) => RNExternalDisplayEvent.closeScene?.(sceneId),
  isMainSceneActive: () => RNExternalDisplayEvent.isMainSceneActive?.(),
  resumeMainScene: () => RNExternalDisplayEvent.resumeMainScene?.(),
}
