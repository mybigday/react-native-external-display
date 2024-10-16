type SceneTypes = {
  EXTERNAL_DISPLAY: '@RNExternalDisplay_externalDisplay'
  CREATED_SCENE: '@RNExternalDisplay_createdScene'
}

declare const SceneManager: {
  types: SceneTypes
  isAvailable: () => boolean
  requestScene: (options: any) => void
  closeScene: (sceneId: string) => void
  isMainSceneActive: () => void
  resumeMainScene: () => void
}

export default SceneManager
