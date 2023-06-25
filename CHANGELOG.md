# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

# [0.6.0-rc.2](https://github.com/mybigday/react-native-external-display/compare/v0.6.0-rc.1...v0.6.0-rc.2) (2023-06-25)


### Bug Fixes

* **ios:** use RCTViewComponentView as external screen wrap view on new arch ([6f0cedb](https://github.com/mybigday/react-native-external-display/commit/6f0cedb88212671c4f2ae33fd2438b112f21b034))





# [0.6.0-rc.1](https://github.com/mybigday/react-native-external-display/compare/v0.6.0-rc.0...v0.6.0-rc.1) (2023-06-22)


### Bug Fixes

* **ios:** cleanup observer at invalidate ([ca03e7d](https://github.com/mybigday/react-native-external-display/commit/ca03e7dfade49239854108ddb8b182a8836c5060))





# [0.6.0-rc.0](https://github.com/mybigday/react-native-external-display/compare/v0.5.18...v0.6.0-rc.0) (2023-06-22)


### Bug Fixes

* **example:** android build error ([386b520](https://github.com/mybigday/react-native-external-display/commit/386b520aea873d1ffac9f62e79b9c3f683ed99a2))


### Features

* **example:** bump react-native to v0.71 ([#686](https://github.com/mybigday/react-native-external-display/issues/686)) ([2a5acc2](https://github.com/mybigday/react-native-external-display/commit/2a5acc28b14333650ea5e31291f6c12b66d0abcb))
* support new architecture ([#687](https://github.com/mybigday/react-native-external-display/issues/687)) ([bcb001f](https://github.com/mybigday/react-native-external-display/commit/bcb001f5862d6ed4184698baf6d6ea49c32fc7cf))





## [0.5.18](https://github.com/mybigday/react-native-external-display/compare/v0.5.17...v0.5.18) (2022-10-22)


### Bug Fixes

* **android:** ScrollView is not working on external display ([#578](https://github.com/mybigday/react-native-external-display/issues/578)) ([9b58849](https://github.com/mybigday/react-native-external-display/commit/9b5884946099c9a633a48173f77b9bf5ee43652f))


### Features

* **example:** add scroll view example ([e7f6605](https://github.com/mybigday/react-native-external-display/commit/e7f6605b520b202dbc2b9af7924d5d164f123361))
* **ios:** move podspec to root dir of package ([3f0ac9a](https://github.com/mybigday/react-native-external-display/commit/3f0ac9a8d6be7ae30a83d731b6839119ffd4e61e))





## [0.5.17](https://github.com/mybigday/react-native-external-display/compare/v0.5.16...v0.5.17) (2022-05-17)


### Bug Fixes

* **android:** connected screen not resume if host resumed ([8a01beb](https://github.com/mybigday/react-native-external-display/commit/8a01beb927bfd5d86be563a627fae4ae3567eb68))





## [0.5.16](https://github.com/mybigday/react-native-external-display/compare/v0.5.15...v0.5.16) (2022-02-13)


### Bug Fixes

* **android:** mount child view issue on switch display ([95be339](https://github.com/mybigday/react-native-external-display/commit/95be3394c8f19dafed296e3e78ba53f3cac00f26))





## [0.5.15](https://github.com/mybigday/react-native-external-display/compare/v0.5.14...v0.5.15) (2022-02-13)


### Bug Fixes

* **android:** call dismiss on destroy screen ([84a7fdb](https://github.com/mybigday/react-native-external-display/commit/84a7fdbbb6d803a56ab124f88221a222a0d27776))
* **android:** scale on external display ([#413](https://github.com/mybigday/react-native-external-display/issues/413)) ([90b1da6](https://github.com/mybigday/react-native-external-display/commit/90b1da60c12c231e1e91f7d352d3b362ccd2db47))


### Features

* **ci:** add cache for yarn and ios build ([4f853fd](https://github.com/mybigday/react-native-external-display/commit/4f853fd89e6f9ded7ff60ad351f7dba4d73506c9))





## [0.5.14](https://github.com/mybigday/react-native-external-display/compare/v0.5.13...v0.5.14) (2021-12-14)


### Bug Fixes

* **android:** clear subview on removeViewAt during lifecycle ([395f557](https://github.com/mybigday/react-native-external-display/commit/395f5573df10d6ea2b85630b5b660e1d930d2a65))





## [0.5.13](https://github.com/mybigday/react-native-external-display/compare/v0.5.12...v0.5.13) (2021-12-13)


### Bug Fixes

* **android:** do not refresh screen on host pause / resume if no external display connected ([9a3413f](https://github.com/mybigday/react-native-external-display/commit/9a3413f35c872773beb8f2768da59868e934a9c8))





## [0.5.12](https://github.com/mybigday/react-native-external-display/compare/v0.5.11...v0.5.12) (2021-11-11)


### Bug Fixes

* **tvos:** ignore availableModes check ([76634ad](https://github.com/mybigday/react-native-external-display/commit/76634ad07b5d29fa86d27dbd0bd6202c9ce155c1))





## [0.5.11](https://github.com/mybigday/react-native-external-display/compare/v0.5.10...v0.5.11) (2021-11-11)


### Features

* **ios:** Support change screen mode to highest width mode ([#375](https://github.com/mybigday/react-native-external-display/issues/375)) ([287d015](https://github.com/mybigday/react-native-external-display/commit/287d015e51f4fddecb9e2776db7c97ea41f03c00))





## [0.5.10](https://github.com/mybigday/react-native-external-display/compare/v0.5.9...v0.5.10) (2021-07-29)


### Bug Fixes

* **android:** add missing removeLifecycleEventListener for RNExternalDisplayView ([6789740](https://github.com/mybigday/react-native-external-display/commit/67897404185f5b921fea902bc3c0f25356571cfa))





## [0.5.9](https://github.com/mybigday/react-native-external-display/compare/v0.5.8...v0.5.9) (2021-05-28)


### Features

* **android:** remove build tools version ([#298](https://github.com/mybigday/react-native-external-display/issues/298)) ([a6d5a3e](https://github.com/mybigday/react-native-external-display/commit/a6d5a3eff3613d43d1d3c8e40310fdff4b167377))
* **ci:** allow pull_request ([3671a45](https://github.com/mybigday/react-native-external-display/commit/3671a4538e4e93bfc9d21041dde53bd60b5fc6c0))


### Reverts

* Revert "chore(deps): bump react-native-screens from 2.18.1 to 3.1.0 (#274)" ([4b1621f](https://github.com/mybigday/react-native-external-display/commit/4b1621fa983c1a2d64c6846891da873629e6157e)), closes [#274](https://github.com/mybigday/react-native-external-display/issues/274)





## [0.5.8](https://github.com/mybigday/react-native-external-display/compare/v0.5.7...v0.5.8) (2021-01-26)


### Bug Fixes

* **android:** thread looper issue if JSI modules enabled ([#230](https://github.com/mybigday/react-native-external-display/issues/230)) ([74ad50b](https://github.com/mybigday/react-native-external-display/commit/74ad50bb3f3abaa05d2ac74c8e20fb0ce70e50bf))





## [0.5.6](https://github.com/mybigday/react-native-external-display/compare/v0.5.5...v0.5.6) (2020-12-12)


### Bug Fixes

* **android:** crash with accessibility enabled ([#216](https://github.com/mybigday/react-native-external-display/issues/216)) ([bca12a8](https://github.com/mybigday/react-native-external-display/commit/bca12a84b01f622f69b83832a1ac1bc65e1269ec))





## [0.5.5](https://github.com/mybigday/react-native-external-display/compare/v0.5.4...v0.5.5) (2020-09-25)


### Bug Fixes

* **ios:** react dependency for support Xcode 12 ([01fc079](https://github.com/mybigday/react-native-external-display/commit/01fc079e8721cf9ea4242b2812536ad53ffa474b))





## [0.5.4](https://github.com/mybigday/react-native-external-display/compare/v0.5.3...v0.5.4) (2020-09-21)


### Bug Fixes

* **android:** ensure parent child is removed for fallbackInMainScreen ([e62eaff](https://github.com/mybigday/react-native-external-display/commit/e62eaff6f45f686efd35f8d9b4bf63740fd29b83))





## [0.5.3](https://github.com/mybigday/react-native-external-display/compare/v0.5.2...v0.5.3) (2020-09-21)


### Bug Fixes

* **android:** remove / add external view between onHostPause and onHostResume, closes [#142](https://github.com/mybigday/react-native-external-display/issues/142) ([711562f](https://github.com/mybigday/react-native-external-display/commit/711562f7bf5415a40d3792e01e982e4fb44546db))





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
