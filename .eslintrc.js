module.exports = {
  root: true,
  extends: [
    '@fugood/eslint-config-react',
    // 'plugin:ft-flow/recommended',
  ],
  parser: 'hermes-eslint',
  plugins: ['ft-flow'],
  env: {
    node: true,
    browser: true,
    jest: true,
  },
  rules: {
    'import/order': 0,
    'react/jsx-props-no-multi-spaces': 'off',
  },
  settings: {
    'import/resolver': {
      node: {
        extensions: [
          '.js',
          '.jsx',
          '.json',
          '.native.js',
          '.ios.js',
          '.android.js',
        ],
      },
    },
  },
}
