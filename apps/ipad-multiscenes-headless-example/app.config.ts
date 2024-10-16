import 'ts-node/register'
import { ExpoConfig, ConfigContext } from '@expo/config'

export default ({ config }: ConfigContext): ExpoConfig => ({
  name: 'ipad-multiscenes-headless-example',
  slug: 'ipad-multiscenes-headless-example',
  version: '1.0.0',
  orientation: 'portrait',
  scheme: 'ipad-miltiscenes',
  userInterfaceStyle: 'automatic',
  splash: {
    resizeMode: 'contain',
    backgroundColor: '#ffffff',
  },
  ios: {
    supportsTablet: true,
    bundleIdentifier: 'com.externaldisplay.ipad-example',
    infoPlist: {
      UIApplicationSceneManifest: {
        UIApplicationSupportsMultipleScenes: true,
      },
      UIRequiresFullScreen: false,
    },
  },
  plugins: ['./withMultipleSceneSupport.ts'],
})
