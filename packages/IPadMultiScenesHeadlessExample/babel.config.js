module.exports = {
  presets: ['module:metro-react-native-babel-preset'],
  env: {
    production: {
      plugins: ['closure-elimination', 'transform-remove-console'],
    },
  },
};
