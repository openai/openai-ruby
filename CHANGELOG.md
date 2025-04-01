# Changelog

## 0.1.0-alpha.3 (2025-04-01)

Full Changelog: [v0.1.0-alpha.2...v0.1.0-alpha.3](https://github.com/openai/openai-ruby/compare/v0.1.0-alpha.2...v0.1.0-alpha.3)

### ⚠ BREAKING CHANGES

* use tagged enums in sorbet type definitions ([#49](https://github.com/openai/openai-ruby/issues/49))
* support `for item in stream` style iteration on `Stream`s ([#44](https://github.com/openai/openai-ruby/issues/44))
* **model:** base model should recursively store coerced base models ([#29](https://github.com/openai/openai-ruby/issues/29))

### Features

* **api:** add `get /chat/completions` endpoint ([4570a0f](https://github.com/openai/openai-ruby/commit/4570a0fcda6721f01f2c8d5100dc98c721ef62de))
* **api:** add `get /responses/{response_id}/input_items` endpoint ([7eaee28](https://github.com/openai/openai-ruby/commit/7eaee28b2671c6dfa24ce5ce18d525da5de5703e))
* **api:** new models for TTS, STT, + new audio features for Realtime ([#46](https://github.com/openai/openai-ruby/issues/46)) ([56c2a3f](https://github.com/openai/openai-ruby/commit/56c2a3ffecc1b69d2ae96cc84de19d82b14c9c09))
* **api:** o1-pro now available through the API ([#43](https://github.com/openai/openai-ruby/issues/43)) ([e158e7e](https://github.com/openai/openai-ruby/commit/e158e7ef3e1edd6198cd9b2e8aa51ad686d80d04))
* collapse anonymous enum into unions ([#54](https://github.com/openai/openai-ruby/issues/54)) ([9fc4185](https://github.com/openai/openai-ruby/commit/9fc418595f4ff1824ed97368f566c4d1526e90dc))
* consistently accept `AnyHash` types in parameter positions in sorbet ([#57](https://github.com/openai/openai-ruby/issues/57)) ([adf7232](https://github.com/openai/openai-ruby/commit/adf7232437b8ddd302992f01ceaa7961ed790b2f))
* **internal:** converter interface should recurse without schema ([#68](https://github.com/openai/openai-ruby/issues/68)) ([2c67222](https://github.com/openai/openai-ruby/commit/2c672222cae7a01acf9ef75ab1fefdc549d92938))
* prevent tapioca from introspecting the gem internals ([#56](https://github.com/openai/openai-ruby/issues/56)) ([09df54b](https://github.com/openai/openai-ruby/commit/09df54b133e92648318c337e20bd977ca900d21d))
* support `for item in stream` style iteration on `Stream`s ([#44](https://github.com/openai/openai-ruby/issues/44)) ([517cf73](https://github.com/openai/openai-ruby/commit/517cf73e1e55be3df24276025711522968fd2375))
* use tagged enums in sorbet type definitions ([#49](https://github.com/openai/openai-ruby/issues/49)) ([c0a0340](https://github.com/openai/openai-ruby/commit/c0a03401ebe2ccdbf7ff4019a5f1cf661590cce2))


### Bug Fixes

* **api:** correct some Responses types ([#30](https://github.com/openai/openai-ruby/issues/30)) ([51b4d37](https://github.com/openai/openai-ruby/commit/51b4d37d5a5c276cec08ea6164fd3c18397d1dea))
* **client:** remove duplicate types ([#47](https://github.com/openai/openai-ruby/issues/47)) ([d26429c](https://github.com/openai/openai-ruby/commit/d26429c3f3c3fb1aab201fdd4ad2cd4c44ef6aa1))
* label optional keyword arguments in *.rbs type definitions ([#41](https://github.com/openai/openai-ruby/issues/41)) ([fe7be91](https://github.com/openai/openai-ruby/commit/fe7be916f4c309dfe1cc07d5d0c0a3de9cba2ee0))
* missing union constants in rbs and rbi type definitions ([#28](https://github.com/openai/openai-ruby/issues/28)) ([8a1a86e](https://github.com/openai/openai-ruby/commit/8a1a86e656277cedd68b180997e666a7b39daa1f))
* **model:** base model should recursively store coerced base models ([#29](https://github.com/openai/openai-ruby/issues/29)) ([ab2daf1](https://github.com/openai/openai-ruby/commit/ab2daf1d8d0f6df9aa08a41e8948bcfbd4ff32e0))
* pages should be able to accept non-converter models ([#60](https://github.com/openai/openai-ruby/issues/60)) ([ca44472](https://github.com/openai/openai-ruby/commit/ca44472a404acd570d9af5c7d9764601d457bbc8))
* path interpolation template strings ([#77](https://github.com/openai/openai-ruby/issues/77)) ([f1eec93](https://github.com/openai/openai-ruby/commit/f1eec93ebd458477507fc6502ef4fb0360f9c2f4))
* resolve tapioca derived sorbet errors ([#45](https://github.com/openai/openai-ruby/issues/45)) ([f155158](https://github.com/openai/openai-ruby/commit/f155158a6dd0c020a6f3d9b707d39e905e01c5a2))
* sorbet class aliases are not type aliases ([#40](https://github.com/openai/openai-ruby/issues/40)) ([871fcd5](https://github.com/openai/openai-ruby/commit/871fcd5b3056629155b46aa08533df587442b6c5))
* switch to github compatible markdown engine ([#73](https://github.com/openai/openai-ruby/issues/73)) ([5ea2f1a](https://github.com/openai/openai-ruby/commit/5ea2f1a8543c0bdb3537cd63da7e1ffda5c32018))
* type names ([acb2ad3](https://github.com/openai/openai-ruby/commit/acb2ad31e4ad0bd8859e113f269c3dbfadd959dd))
* **types:** improve responses type names ([#34](https://github.com/openai/openai-ruby/issues/34)) ([a82dc6f](https://github.com/openai/openai-ruby/commit/a82dc6f37205110eb08a44f252f40f1dd341d1f5))
* yard example tag formatting ([#53](https://github.com/openai/openai-ruby/issues/53)) ([f9282fc](https://github.com/openai/openai-ruby/commit/f9282fc932d66159cf6632c632a74a12162b9a28))


### Chores

* `BaseModel` fields that are `BaseModel` typed should also accept `Hash` ([#52](https://github.com/openai/openai-ruby/issues/52)) ([aab09b2](https://github.com/openai/openai-ruby/commit/aab09b2d10e2a60b1591834fe7c91f0b2a00056e))
* add `[@yieldparam](https://github.com/yieldparam)` to yard doc ([#36](https://github.com/openai/openai-ruby/issues/36)) ([aa0519b](https://github.com/openai/openai-ruby/commit/aa0519bda596cdb77c3c7fa2635199a8751f652b))
* add example directory ([#39](https://github.com/openai/openai-ruby/issues/39)) ([c62326d](https://github.com/openai/openai-ruby/commit/c62326d76587d8e519f29ad1d3bca4d02cfb7702))
* add hash of OpenAPI spec/config inputs to .stats.yml ([6bd0b48](https://github.com/openai/openai-ruby/commit/6bd0b48f06eeba23faa18039795b46dc0b07b51a))
* add type annotations for enum and union member listing methods ([#55](https://github.com/openai/openai-ruby/issues/55)) ([a2be966](https://github.com/openai/openai-ruby/commit/a2be96630a99700a1fae79c3969e72a677fff270))
* **api:** updates to supported Voice IDs ([#64](https://github.com/openai/openai-ruby/issues/64)) ([6c42664](https://github.com/openai/openai-ruby/commit/6c42664eacbaf21d8359c096c496ff50661e82cb))
* disable dangerous rubocop auto correct rule ([#62](https://github.com/openai/openai-ruby/issues/62)) ([f34ac80](https://github.com/openai/openai-ruby/commit/f34ac8099aeac766ff90268bb5b14ba0529f6fa9))
* disable overloads in `*.rbs` definitions for readable LSP errors ([#42](https://github.com/openai/openai-ruby/issues/42)) ([2364f78](https://github.com/openai/openai-ruby/commit/2364f78c6bf0b618b8b454dccbd17924a9874168))
* disable unnecessary linter rules for sorbet manifests ([#35](https://github.com/openai/openai-ruby/issues/35)) ([cf2f693](https://github.com/openai/openai-ruby/commit/cf2f6934740b1bb7c611c4bc5b9c41c5cebbe0c1))
* document Client's concurrency capability ([#33](https://github.com/openai/openai-ruby/issues/33)) ([9b08fb0](https://github.com/openai/openai-ruby/commit/9b08fb062416ca8c72e531b9389d68c2fd730af8))
* fix misc rubocop errors ([#74](https://github.com/openai/openai-ruby/issues/74)) ([40315e6](https://github.com/openai/openai-ruby/commit/40315e6ce56d1f93691fbd928254cdf24c2da8b1))
* ignore some spurious linter warnings and formatting changes ([#31](https://github.com/openai/openai-ruby/issues/31)) ([e376e31](https://github.com/openai/openai-ruby/commit/e376e31709236578305bf453cfbe8e056057d669))
* **internal:** add sorbet config for SDK local development ([#38](https://github.com/openai/openai-ruby/issues/38)) ([f8cb16b](https://github.com/openai/openai-ruby/commit/f8cb16bccf2d4fb4d13a369eaad8102ef110a550))
* **internal:** bugfix ([#51](https://github.com/openai/openai-ruby/issues/51)) ([0967a13](https://github.com/openai/openai-ruby/commit/0967a139e6dc24bfdf3b4c5e3b9770d39d610904))
* **internal:** codegen related update ([#27](https://github.com/openai/openai-ruby/issues/27)) ([83ac858](https://github.com/openai/openai-ruby/commit/83ac85861a0dd1756c46cdad962f3ab0c758d9ae))
* **internal:** minor refactoring of utils ([#67](https://github.com/openai/openai-ruby/issues/67)) ([47f9f49](https://github.com/openai/openai-ruby/commit/47f9f49b2acd2a1549d497fa542dfab368b939d3))
* **internal:** version bump ([#26](https://github.com/openai/openai-ruby/issues/26)) ([b9dde82](https://github.com/openai/openai-ruby/commit/b9dde82f091f820ea09eea4521fc2bd63d8ec32e))
* more accurate type annotations for SDK internals ([#71](https://github.com/openai/openai-ruby/issues/71)) ([2071dd2](https://github.com/openai/openai-ruby/commit/2071dd2ffbdcd49d20245c8d04c8839a3caca240))
* more aggressive tapioca detection logic for skipping compiler introspection ([#65](https://github.com/openai/openai-ruby/issues/65)) ([1da15be](https://github.com/openai/openai-ruby/commit/1da15be44dba6b54b9432b62d1fdb7551f2faff6))
* more readable output when tests fail ([#63](https://github.com/openai/openai-ruby/issues/63)) ([c3cfea9](https://github.com/openai/openai-ruby/commit/c3cfea9124334e728dcf08a294b35338c8412137))
* re-order assignment lines to make unions easier to read ([#66](https://github.com/openai/openai-ruby/issues/66)) ([50f6e5e](https://github.com/openai/openai-ruby/commit/50f6e5e2abbb007fa8786a24eb7d0bf8398499ed))
* recursively accept `AnyHash` for `BaseModel`s in arrays and hashes ([#58](https://github.com/openai/openai-ruby/issues/58)) ([92f1cba](https://github.com/openai/openai-ruby/commit/92f1cbabc8f3bb009e18ccadc11479e330dec11c))
* reduce verbosity in type declarations ([#61](https://github.com/openai/openai-ruby/issues/61)) ([9517e27](https://github.com/openai/openai-ruby/commit/9517e27589c1b88e50e22d39f29b3e1c485e1a53))
* relocate internal modules ([#70](https://github.com/openai/openai-ruby/issues/70)) ([350fe34](https://github.com/openai/openai-ruby/commit/350fe34846d92d114eb49a92464837884d1ca355))
* Remove deprecated/unused remote spec feature ([e2bffd6](https://github.com/openai/openai-ruby/commit/e2bffd65e8552e00b647b1f013cbc5fc2017ba6d))
* remove unnecessary & confusing module ([#69](https://github.com/openai/openai-ruby/issues/69)) ([c0ea470](https://github.com/openai/openai-ruby/commit/c0ea470fc329c7ccf2161a1eb8b58ea19a43565a))
* support binary responses ([#76](https://github.com/openai/openai-ruby/issues/76)) ([1b19e9b](https://github.com/openai/openai-ruby/commit/1b19e9bafa82baebd48924f01825aa2cfc2e9d68))
* switch to prettier looking sorbet annotations ([#59](https://github.com/openai/openai-ruby/issues/59)) ([0ab5871](https://github.com/openai/openai-ruby/commit/0ab5871d8fb4d9e28eee39d2c937842fd84828a1))
* update readme ([#72](https://github.com/openai/openai-ruby/issues/72)) ([21ed2b6](https://github.com/openai/openai-ruby/commit/21ed2b6915e2bec2f3be41a369bf05da345b0d5b))
* use fully qualified name in sorbet README example ([#75](https://github.com/openai/openai-ruby/issues/75)) ([273a784](https://github.com/openai/openai-ruby/commit/273a7843957997b28452d328b29e4973bda1836b))
* use multi-line formatting style for really long lines ([#37](https://github.com/openai/openai-ruby/issues/37)) ([acb95ee](https://github.com/openai/openai-ruby/commit/acb95eed637593576db09fd5d31ea4bba67e5a22))

## 0.1.0-alpha.2 (2025-03-18)

Full Changelog: [v0.1.0-alpha.1...v0.1.0-alpha.2](https://github.com/openai/openai-ruby/compare/v0.1.0-alpha.1...v0.1.0-alpha.2)

### Features

* support jsonl uploads ([#10](https://github.com/openai/openai-ruby/issues/10)) ([b3b9e40](https://github.com/openai/openai-ruby/commit/b3b9e406f0174423a12e0e7e26f8f5c469b13f7e))


### Bug Fixes

* enums should not unnecessarily convert non-members to symbol type ([#23](https://github.com/openai/openai-ruby/issues/23)) ([05294a7](https://github.com/openai/openai-ruby/commit/05294a761c6e0ed3819c9cb4d2cd11f52134cbd6))


### Chores

* add most doc strings to rbi type definitions ([#12](https://github.com/openai/openai-ruby/issues/12)) ([f711649](https://github.com/openai/openai-ruby/commit/f711649c42200d70f8545d2014e8398297e62691))
* do not label modules as abstract ([#22](https://github.com/openai/openai-ruby/issues/22)) ([bad4ec9](https://github.com/openai/openai-ruby/commit/bad4ec9ecda97c2eb4c4e9d5fabc62e2a7ab5bf2))
* document union variants in yard doc ([#16](https://github.com/openai/openai-ruby/issues/16)) ([3ffacfe](https://github.com/openai/openai-ruby/commit/3ffacfe591bbb909a59e9581ea37eceaee07f9f0))
* ensure doc strings for rbi method arguments ([#13](https://github.com/openai/openai-ruby/issues/13)) ([2c59996](https://github.com/openai/openai-ruby/commit/2c599969eac0c7ffd167f524604cc0e2ebae280c))
* error fields are now mutable in keeping with rest of SDK ([#15](https://github.com/openai/openai-ruby/issues/15)) ([0e30eb7](https://github.com/openai/openai-ruby/commit/0e30eb76a81ca76a62a89b734d5333fe4d59154f))
* **internal:** remove CI condition ([#18](https://github.com/openai/openai-ruby/issues/18)) ([db07e59](https://github.com/openai/openai-ruby/commit/db07e59ffce1577ac42d74ff57ecd18838012fcb))
* mark non-inheritable SDK internal classes as final ([#19](https://github.com/openai/openai-ruby/issues/19)) ([ed33b6b](https://github.com/openai/openai-ruby/commit/ed33b6bbe8ab4c95c88255f4cc68c34276b8662d))
* sdk client internal refactoring ([#21](https://github.com/openai/openai-ruby/issues/21)) ([927e252](https://github.com/openai/openai-ruby/commit/927e2521fedced96a8429214de8145dc4b5521a3))
* sdk internal updates ([#9](https://github.com/openai/openai-ruby/issues/9)) ([7673bb0](https://github.com/openai/openai-ruby/commit/7673bb0eb0ed542df89e5bc5dbf0247b26a97617))
* slightly more consistent type definition layout ([#17](https://github.com/openai/openai-ruby/issues/17)) ([1e4b557](https://github.com/openai/openai-ruby/commit/1e4b557e0ab1c8c6483c5e2c8dd856d5a9a2da90))
* touch up sdk usage examples ([#14](https://github.com/openai/openai-ruby/issues/14)) ([7219d46](https://github.com/openai/openai-ruby/commit/7219d463ba66a6499a84131f36b06d06de35a5ec))
* use generics instead of overloading for sorbet type definitions ([#20](https://github.com/openai/openai-ruby/issues/20)) ([a279382](https://github.com/openai/openai-ruby/commit/a279382762e14b18c6573f34bc3e825f927caaab))

## 0.1.0-alpha.1 (2025-03-13)

Full Changelog: [v0.0.1-alpha.0...v0.1.0-alpha.1](https://github.com/openai/openai-ruby/compare/v0.0.1-alpha.0...v0.1.0-alpha.1)

### Features

* support streaming uploads ([#1](https://github.com/openai/openai-ruby/issues/1)) ([8d5317a](https://github.com/openai/openai-ruby/commit/8d5317a4a3035e24de78d226658a821a8893a283))


### Bug Fixes

* enums should only coerce matching symbols into strings ([#3](https://github.com/openai/openai-ruby/issues/3)) ([0f4c842](https://github.com/openai/openai-ruby/commit/0f4c842a52c679ab0793fcdc32e5555fbbea4178))


### Chores

* improve documentation ([d9ce7ce](https://github.com/openai/openai-ruby/commit/d9ce7cedcc96ea81529fbaabf18dcab871dd412f))
* improve rbi typedef for page classes ([#6](https://github.com/openai/openai-ruby/issues/6)) ([3450adf](https://github.com/openai/openai-ruby/commit/3450adf1f6af58b6626e874866276414b71dcf22))
* **internal:** remove extra empty newlines ([#7](https://github.com/openai/openai-ruby/issues/7)) ([8ce4f87](https://github.com/openai/openai-ruby/commit/8ce4f87ca9496143d8c85000b0fb1f8b00eedea6))
* more accurate generic params for stream classes ([#8](https://github.com/openai/openai-ruby/issues/8)) ([c83ab37](https://github.com/openai/openai-ruby/commit/c83ab3717be335b49ef38663b759d14c92841f5c))
* refactor BasePage to have initializer ([#5](https://github.com/openai/openai-ruby/issues/5)) ([43e80fa](https://github.com/openai/openai-ruby/commit/43e80fa252a9b1ae4d5c219dd9d346f0b0c3194f))
* remove stale thread local checks ([#4](https://github.com/openai/openai-ruby/issues/4)) ([69e8be8](https://github.com/openai/openai-ruby/commit/69e8be897fe8cff1ed9b0ea7ef53a759a9a089ff))
