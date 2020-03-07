# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## [0.5.2](https://github.com/mybigday/react-native-external-display/compare/v0.5.1...v0.5.2) (2020-03-07)


### Bug Fixes

* **ios:** screen info initial constants ([5b2ec75](https://github.com/mybigday/react-native-external-display/commit/5b2ec757d558521a571b236a0d0604ecd7dbec15))





## [0.5.1](https://github.com/mybigday/react-native-external-display/compare/v0.5.0...v0.5.1) (2020-03-04)


### Features

* **android:** Log error when detected two or more RNExternalDisplayView to register the same screen id ([7d10933](https://github.com/mybigday/react-native-external-display/commit/7d10933eb23df9d957bfc006dc13dd07ddda9e9c))
* **ios:** Log error when detected two or more RNExternalDisplayView to register the same screen id ([ccabd0f](https://github.com/mybigday/react-native-external-display/commit/ccabd0fc2372879b04979259bc50b807957aa5c2))





# [0.5.0](https://github.com/mybigday/react-native-external-display/compare/v0.4.2...v0.5.0) (2020-03-02)


### Bug Fixes

* **android:** update build.gradle ([236c5ab](https://github.com/mybigday/react-native-external-display/commit/236c5ab0c431528431876109687ee2e9da97e3aa))


### Features

* **android:** update package name ([63b547e](https://github.com/mybigday/react-native-external-display/commit/63b547e5808c89a7ab4f74e02156eaa0ae424eb4))
* **example:** add readme ([704eae9](https://github.com/mybigday/react-native-external-display/commit/704eae9a1c72250096ac22ac1e9fd78aef8eeb36))





## [0.4.2](https://github.com/mybigday/react-native-external-display/compare/v0.4.1...v0.4.2) (2020-03-02)


### Bug Fixes

* **android:** should check child count before removeViewAt for wrap view group ([042d1f2](https://github.com/mybigday/react-native-external-display/commit/042d1f238453ed27ba42edac651a293b1329ce9e))





## [0.4.1](https://github.com/mybigday/react-native-external-display/compare/v0.4.0...v0.4.1) (2020-03-02)


### Bug Fixes

* **android:** parent view group issue on change screen ([76e732f](https://github.com/mybigday/react-native-external-display/commit/76e732fb985c2ede4474f31a0c00253dd44fdbec))





# [0.4.0](https://github.com/mybigday/react-native-external-display/compare/v0.3.1...v0.4.0) (2020-03-02)


### Features

* **js:** expose scaled screen size depends on main screen ([d565881](https://github.com/mybigday/react-native-external-display/commit/d5658810a011cc6e5e5b424952bdb39adfceca47))
* **js:** implement useScreenSize hook ([15bccc9](https://github.com/mybigday/react-native-external-display/commit/15bccc90ed5183f23fcb0a6f46311dc8e7ce806f))





## [0.3.1](https://github.com/mybigday/react-native-external-display/compare/v0.3.0...v0.3.1) (2020-03-01)


### Features

* **js:** add default options for useExternalDisplay ([48b9cad](https://github.com/mybigday/react-native-external-display/commit/48b9cad4943e74d499d975f89dc322534fc5abd1))





# [0.3.0](https://github.com/mybigday/react-native-external-display/compare/v0.2.0...v0.3.0) (2020-02-29)


### Features

* **js:** implement useExternalDisplay hook ([#5](https://github.com/mybigday/react-native-external-display/issues/5)) ([17792c6](https://github.com/mybigday/react-native-external-display/commit/17792c6ac548f8b003d2d393ac5f8498e55f1f21))





# [0.2.0](https://github.com/mybigday/react-native-external-display/compare/v0.1.6...v0.2.0) (2020-02-29)


### Bug Fixes

* **android:** Wrap new ReactViewGroup for target external screen view ([44a3f49](https://github.com/mybigday/react-native-external-display/commit/44a3f49202162a8124b6cd519b1c759f63903d61)), closes [#1](https://github.com/mybigday/react-native-external-display/issues/1)
* **ios:** Wrap new RCTView for target external screen view ([41b6efc](https://github.com/mybigday/react-native-external-display/commit/41b6efcd3992087019e47c67fcfb9a5982c134d2))


### Features

* **ios:** always call [super insertReactSubview], and render fallback depends on didUpdateReactSubviews ([a0c2c43](https://github.com/mybigday/react-native-external-display/commit/a0c2c432cd44525b9036ab1b6321a6c6acc5c85e))
* **ios:** call makeKeyAndVisible for main window after invalidateWindow ([a8bbea2](https://github.com/mybigday/react-native-external-display/commit/a8bbea2bf9330f7d4c89faf7d407749af4602111))
* **ios:** implement RCTInvalidating method ([e9c2ede](https://github.com/mybigday/react-native-external-display/commit/e9c2ede5318f97518f2c0cec7aabe4e9aff8e2e1))





## [0.1.6](https://github.com/mybigday/react-native-external-display/compare/v0.1.5...v0.1.6) (2020-02-28)


### Features

* **ios:** add tvos deployment target ([a2faa45](https://github.com/mybigday/react-native-external-display/commit/a2faa453882099e1924564d403d9eb5258e47cbc))





## [0.1.5](https://github.com/mybigday/react-native-external-display/compare/v0.1.4...v0.1.5) (2020-02-28)


### Bug Fixes

* **ios:** do not remove subview from superview on invalidate ([ef093b7](https://github.com/mybigday/react-native-external-display/commit/ef093b72cced68232271e9c2fa1e4e1db1640578))


### Features

* **example:** update modal example ([423ea55](https://github.com/mybigday/react-native-external-display/commit/423ea553506688cbf7742b28be1574a886f52175))





## [0.1.4](https://github.com/mybigday/react-native-external-display/compare/v0.1.3...v0.1.4) (2020-02-28)


### Bug Fixes

* **ios:** updateScreen after setFallbackInMainScreen ([9b4f333](https://github.com/mybigday/react-native-external-display/commit/9b4f333217107eb10854cafe9f70e927516c6287))





## [0.1.3](https://github.com/mybigday/react-native-external-display/compare/v0.1.2...v0.1.3) (2020-02-28)

**Note:** Version bump only for package rn-external-display





## [0.1.2](https://github.com/mybigday/react-native-external-display/compare/v0.1.1...v0.1.2) (2020-02-28)


### Bug Fixes

* s.source in podspec ([7e34d10](https://github.com/mybigday/react-native-external-display/commit/7e34d10a0a152c8c8baca24457c816a352a2d01c))





## [0.1.1](https://github.com/mybigday/react-native-external-display/compare/v0.1.0...v0.1.1) (2020-02-28)


### Bug Fixes

* **ios:** wrap new UIViewController for external window ([cb36491](https://github.com/mybigday/react-native-external-display/commit/cb36491371a2c79b0b50aefc446df6a3616ad846))


### Features

* **example:** add modal example ([77ad54e](https://github.com/mybigday/react-native-external-display/commit/77ad54ee2e9781a118bc29fac0078f5eb007affa))
