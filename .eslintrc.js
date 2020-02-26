module.exports = {
  root: true,
  extends: '@fugood/eslint-config-react',
  env: {
    node: true,
    browser: true,
    jest: true,
  },
  rules: {
    'import/order': 0,
  },
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.js', '.jsx', '.json', '.native.js'],
      },
    },
  },
}
