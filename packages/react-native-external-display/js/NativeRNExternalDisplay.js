/* eslint-disable no-undef */
// @flow strict-local
import type { ViewProps } from 'react-native/Libraries/Components/View/ViewPropTypes'
import type { HostComponent } from 'react-native'
import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent'

type NativeProps = $ReadOnly<{|
  ...ViewProps,
  screen: ?string,
  fallbackInMainScreen: ?boolean,
|}>

export default (codegenNativeComponent<NativeProps>(
  'RNExternalDisplay',
): HostComponent<NativeProps>)
