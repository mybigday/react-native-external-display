/**
 * Metro configuration for React Native
 * https://github.com/facebook/react-native
 *
 * @format
 */
const path = require('path')
/* eslint-disable import/no-extraneous-dependencies */
const exclusionList = require('metro-config/src/defaults/exclusionList')

module.exports = {
  transformer: {
    getTransformOptions: async () => ({
      transform: {
        experimentalImportSupport: false,
        inlineRequires: true,
      },
    }),
  },
  resolver: {
    blockList: exclusionList([
      /android\/.*/,
      /ios\/.*/,
      new RegExp(path.resolve('../../node_modules/react/.*')),
      new RegExp(path.resolve('../../node_modules/react-native/.*')),
    ]),
    extraNodeModules: {
      react: path.resolve(__dirname, 'node_modules/react'),
      'react-native': path.resolve(__dirname, 'node_modules/react-native'),
    },
  },
  serializer: {
    processModuleFilter: mod => !mod.path.endsWith('/package.json'),
  },
  projectRoot: path.resolve(__dirname),
  watchFolders: [
    path.resolve(__dirname, '../../packages'),
    path.resolve(__dirname, '../../node_modules'),
  ],
}
