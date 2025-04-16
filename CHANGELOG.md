# Changelog

## 0.1.0-alpha.4 (2025-04-16)

Full Changelog: [v0.1.0-alpha.3...v0.1.0-alpha.4](https://github.com/openai/openai-ruby/compare/v0.1.0-alpha.3...v0.1.0-alpha.4)

### ⚠ BREAKING CHANGES

* bump min supported ruby version to 3.1 (oldest non-EOL) ([#93](https://github.com/openai/openai-ruby/issues/93))
* remove top level type aliases to relocated classes ([#91](https://github.com/openai/openai-ruby/issues/91))
* use descriptive prefixes for enum names that start with otherwise illegal identifiers ([#89](https://github.com/openai/openai-ruby/issues/89))

### Features

* add reference links in yard ([#79](https://github.com/openai/openai-ruby/issues/79)) ([98262c8](https://github.com/openai/openai-ruby/commit/98262c8dac11599791892eb70d0f84bc449fac92))
* add stubs documenting coming soon streaming helpers ([d455e9b](https://github.com/openai/openai-ruby/commit/d455e9b54cb8b218eef751ced83a495cce10d14d))
* allow all valid `JSON` types to be encoded ([#102](https://github.com/openai/openai-ruby/issues/102)) ([5f5ee8b](https://github.com/openai/openai-ruby/commit/5f5ee8b1cb3e849f15b30160c1d7af624f151788))
* **api:** Add evalapi to sdk ([#113](https://github.com/openai/openai-ruby/issues/113)) ([230bbfd](https://github.com/openai/openai-ruby/commit/230bbfdf8e7dbf2f1a44c33142cd7235bcbe0339))
* **api:** add o3 and o4-mini model IDs ([4d3d4b7](https://github.com/openai/openai-ruby/commit/4d3d4b7f2e0fae12f24d57d287f2c9c4520eda76))
* **api:** adding gpt-4.1 family of model IDs ([b4183d5](https://github.com/openai/openai-ruby/commit/b4183d5c93f776044a8a2de55f46ede75e5f9d2e))
* **api:** manual updates ([#116](https://github.com/openai/openai-ruby/issues/116)) ([aef32b1](https://github.com/openai/openai-ruby/commit/aef32b15e84beadd56690d8e216c7370e526618c))
* **api:** manual updates ([#83](https://github.com/openai/openai-ruby/issues/83)) ([33c9252](https://github.com/openai/openai-ruby/commit/33c92528e9d996e2fde5bffebeb718d6c6dbac8e))
* **api:** manual updates ([#84](https://github.com/openai/openai-ruby/issues/84)) ([4755fff](https://github.com/openai/openai-ruby/commit/4755fff8b720f7e7afcfc452b2ad103b5e0a3c85))
* **api:** manual updates ([#88](https://github.com/openai/openai-ruby/issues/88)) ([2db2fb6](https://github.com/openai/openai-ruby/commit/2db2fb60507fc71ad51b875b956d1fb3f43bc263))
* **api:** manual updates ([#92](https://github.com/openai/openai-ruby/issues/92)) ([5b6d96e](https://github.com/openai/openai-ruby/commit/5b6d96ea61826256832395e644ff0351b939e133))
* bump min supported ruby version to 3.1 (oldest non-EOL) ([#93](https://github.com/openai/openai-ruby/issues/93)) ([5c4feaa](https://github.com/openai/openai-ruby/commit/5c4feaaf6dfae40e2a32591bfa8ac30cb4cfbddb))
* **client:** enable setting base URL from environment variable ([b9da54b](https://github.com/openai/openai-ruby/commit/b9da54b1f0ddae4af6404a11436b7daf21c47f6f))
* example code snippets ([67c590b](https://github.com/openai/openai-ruby/commit/67c590b17efa59900fa3e893773fa2ac8ad92f45))
* implement `to_json` for base model ([#86](https://github.com/openai/openai-ruby/issues/86)) ([f333c1c](https://github.com/openai/openai-ruby/commit/f333c1c68d8469fcf5714856063df7fe2c0a5d1e))
* link response models to their methods in yard doc ([#81](https://github.com/openai/openai-ruby/issues/81)) ([0f4332a](https://github.com/openai/openai-ruby/commit/0f4332a08bf3b41f338b31d4b5b95ce15b5e4c4e))
* remove top level type aliases to relocated classes ([#91](https://github.com/openai/openai-ruby/issues/91)) ([4588640](https://github.com/openai/openai-ruby/commit/4588640c6f367490721e5584a9207e9c8169c409))
* support query, header, and body params that have identical names ([#101](https://github.com/openai/openai-ruby/issues/101)) ([f70c567](https://github.com/openai/openai-ruby/commit/f70c5673f3ab5127e74834b073367cd1b2c6868e))
* support solargraph generics ([#96](https://github.com/openai/openai-ruby/issues/96)) ([80829ad](https://github.com/openai/openai-ruby/commit/80829ad0c12256b96a1a65f3938276cc38c3d4f4))
* use Pathname alongside raw IO handles for file uploads ([#119](https://github.com/openai/openai-ruby/issues/119)) ([8728785](https://github.com/openai/openai-ruby/commit/8728785e80fdeb9d2b4beb526fc4c5ef4890fc82))


### Bug Fixes

* converter should transform stringio into string where applicable ([#104](https://github.com/openai/openai-ruby/issues/104)) ([c2f3c12](https://github.com/openai/openai-ruby/commit/c2f3c125d08c2c32b189bb2808779ef818db5844))
* inaccuracies in the README.md ([7d42afa](https://github.com/openai/openai-ruby/commit/7d42afa3747ee6cfeb437580f7ff21dd26d505e2))
* **internal:** update release-please to use ruby strategy for README.md ([#123](https://github.com/openai/openai-ruby/issues/123)) ([27f89a9](https://github.com/openai/openai-ruby/commit/27f89a9bc3b2255584b77af81da0cb3393b11b8f))
* pre-release version string should match ruby, not semver conventions ([#95](https://github.com/openai/openai-ruby/issues/95)) ([18c01b1](https://github.com/openai/openai-ruby/commit/18c01b11ef59eecd67866bbeab92f70bdeef9578))
* raise connection error for errors that result from HTTP transports ([#120](https://github.com/openai/openai-ruby/issues/120)) ([d7d7a54](https://github.com/openai/openai-ruby/commit/d7d7a543b54e7048b94bfeb3705c3cce38f5e60b))
* use descriptive prefixes for enum names that start with otherwise illegal identifiers ([#89](https://github.com/openai/openai-ruby/issues/89)) ([647efa0](https://github.com/openai/openai-ruby/commit/647efa0ab24e92c2ab643f81f9ac6acce71390ba))


### Chores

* add README docs for using solargraph when installing gem from git ([#118](https://github.com/openai/openai-ruby/issues/118)) ([368c337](https://github.com/openai/openai-ruby/commit/368c3377d901ffe33c70ada5cb2bec73c3645c91))
* always fold up method bodies in sorbet type definitions ([#108](https://github.com/openai/openai-ruby/issues/108)) ([1967acc](https://github.com/openai/openai-ruby/commit/1967accf07c8548226d482844e8b5d9fa2a8728c))
* attempt to clean up underlying transport when streams are GC'd ([#117](https://github.com/openai/openai-ruby/issues/117)) ([4a43313](https://github.com/openai/openai-ruby/commit/4a43313d36a87949894cbdc5020363db84b98917))
* demonstrate how to make undocumented requests in README ([#94](https://github.com/openai/openai-ruby/issues/94)) ([fbd8130](https://github.com/openai/openai-ruby/commit/fbd8130d7b6da0577bf79538c5e57eb59c760038))
* do not use literals for version in type definitions ([#97](https://github.com/openai/openai-ruby/issues/97)) ([57bc1e7](https://github.com/openai/openai-ruby/commit/57bc1e79c782047df423c4300eb3657dbfe3fd06))
* docs/README tweaks ([#570](https://github.com/openai/openai-ruby/issues/570)) ([ccbf6a2](https://github.com/openai/openai-ruby/commit/ccbf6a2f31bd925f66b1fd409533f91efb6f7091))
* document LSP support in read me ([#100](https://github.com/openai/openai-ruby/issues/100)) ([1a0a335](https://github.com/openai/openai-ruby/commit/1a0a335e1a43b7f4354357a0bd9fc4b1e3bc362b))
* easier to read examples in README.md ([#111](https://github.com/openai/openai-ruby/issues/111)) ([2435ef5](https://github.com/openai/openai-ruby/commit/2435ef547b8d62495268b84be59aaaf9c7ca65b8))
* ensure readme.md is bumped when release please updates versions ([#122](https://github.com/openai/openai-ruby/issues/122)) ([0431cff](https://github.com/openai/openai-ruby/commit/0431cff6bd112eaa59c7b1edc12c445cbb40d62d))
* extract error classes into own module ([#87](https://github.com/openai/openai-ruby/issues/87)) ([a8595ff](https://github.com/openai/openai-ruby/commit/a8595ffe8131130677d0fc3a6437ab5cb97c9814))
* fix readme typo ([#125](https://github.com/openai/openai-ruby/issues/125)) ([f329b13](https://github.com/openai/openai-ruby/commit/f329b1395613da0a44bfa9c200bd1ce17e80cf27))
* improve yard docs readability ([#80](https://github.com/openai/openai-ruby/issues/80)) ([76cf765](https://github.com/openai/openai-ruby/commit/76cf7656934c07ac0937586106dcbe7ac2ab22be))
* **internal:** always run post-processing when formatting when syntax_tree ([15fff97](https://github.com/openai/openai-ruby/commit/15fff9792998379c7968ed84c54dcfab3a89bb74))
* **internal:** expand CI branch coverage ([#124](https://github.com/openai/openai-ruby/issues/124)) ([5e73790](https://github.com/openai/openai-ruby/commit/5e73790b50d53e32ae510a3ff8ca324aa32b363f))
* **internal:** fix examples ([#114](https://github.com/openai/openai-ruby/issues/114)) ([8abe02b](https://github.com/openai/openai-ruby/commit/8abe02b356a7a16c372ce963a90f1552beefa029))
* **internal:** loosen internal type restrictions ([35babf9](https://github.com/openai/openai-ruby/commit/35babf91517944246a8099673a2e0b5f290e6da0))
* **internal:** minor touch ups on sdk internals ([1d828d1](https://github.com/openai/openai-ruby/commit/1d828d12fad59167ada3a87b43998cccbd3031e9))
* **internal:** misc small improvements ([#105](https://github.com/openai/openai-ruby/issues/105)) ([fa32836](https://github.com/openai/openai-ruby/commit/fa32836fb4ca72b9d2c5cf1f5b33bb94c8284caa))
* **internal:** more concise handling of parameter naming conflicts ([#110](https://github.com/openai/openai-ruby/issues/110)) ([a6c4233](https://github.com/openai/openai-ruby/commit/a6c42335f7de10ed64bc270928f60c5bb3e78551))
* **internal:** mostly README touch ups ([eaf6038](https://github.com/openai/openai-ruby/commit/eaf6038a541c896d60c9121fe3170b17c64fba28))
* **internal:** protect SSE parsing pipeline from broken UTF-8 characters ([334b99e](https://github.com/openai/openai-ruby/commit/334b99e29d7c05cd0d81f7a2b5da7aca5ea0b1f8))
* **internal:** reduce CI branch coverage ([0737020](https://github.com/openai/openai-ruby/commit/0737020941d6832c448da78ac8da1ed40b7de2c7))
* **internal:** rubocop rules ([#107](https://github.com/openai/openai-ruby/issues/107)) ([036211d](https://github.com/openai/openai-ruby/commit/036211d98ec3aff3b6a1a4056545d97443702af4))
* **internal:** run rubocop linter in parallel ([#106](https://github.com/openai/openai-ruby/issues/106)) ([bc4e591](https://github.com/openai/openai-ruby/commit/bc4e591a3984b22d6753f28bb4b9c8e65430e4d6))
* **internal:** skip broken test ([#115](https://github.com/openai/openai-ruby/issues/115)) ([1e39fe5](https://github.com/openai/openai-ruby/commit/1e39fe5a706f17d65abe929bae95681dbb20c0ae))
* **internal:** version bump ([#78](https://github.com/openai/openai-ruby/issues/78)) ([2126d20](https://github.com/openai/openai-ruby/commit/2126d201cd465f6b1fd7863edcadf3242d5e7bec))
* loosen const and integer coercion rules ([#121](https://github.com/openai/openai-ruby/issues/121)) ([c95e3d8](https://github.com/openai/openai-ruby/commit/c95e3d88461e2a0a3784cf4f53dc68df5bd85ff7))
* make client tests look prettier ([#112](https://github.com/openai/openai-ruby/issues/112)) ([5d78108](https://github.com/openai/openai-ruby/commit/5d7810839a084fd5c709bdd2ff4c4678643d372a))
* make internal types pretty print ([655a382](https://github.com/openai/openai-ruby/commit/655a38204053a77a2b4135deed8c7a0ace4a63c3))
* misc sdk polish ([#99](https://github.com/openai/openai-ruby/issues/99)) ([bedd502](https://github.com/openai/openai-ruby/commit/bedd502be3018a8a6c135c0ee95f9fb7a2f46f1a))
* move private classes into internal module ([#90](https://github.com/openai/openai-ruby/issues/90)) ([9c96bde](https://github.com/openai/openai-ruby/commit/9c96bdee7f242a039d104bc6bf10115289267f80))
* order client variables by "importance" ([#85](https://github.com/openai/openai-ruby/issues/85)) ([03c5192](https://github.com/openai/openai-ruby/commit/03c5192590469f8e0ed8aec590fc307e821d6d7b))
* relax sorbet enum parameters to allow `String` in addition to `Symbol` ([#82](https://github.com/openai/openai-ruby/issues/82)) ([5ddeea8](https://github.com/openai/openai-ruby/commit/5ddeea81a64a8e3a60de4eda17ff71bf03132604))
* rename confusing `Type::BooleanModel` to `Type::Boolean` ([#103](https://github.com/openai/openai-ruby/issues/103)) ([d98024f](https://github.com/openai/openai-ruby/commit/d98024ff8468de90215b31d829495891752899db))
* simplify internal utils ([#98](https://github.com/openai/openai-ruby/issues/98)) ([7c09129](https://github.com/openai/openai-ruby/commit/7c091297160bbd953f15ea3219171b7e47293d2c))
* touch up readme sorbet example ([b4d1d9e](https://github.com/openai/openai-ruby/commit/b4d1d9e264eb602548d4d76e057147871cd6ab02))
* update yard comment formatting ([#109](https://github.com/openai/openai-ruby/issues/109)) ([8d9ee28](https://github.com/openai/openai-ruby/commit/8d9ee28357c153d2cef5b5f11a8329e5ad7e4a22))
* workaround build errors ([42a052c](https://github.com/openai/openai-ruby/commit/42a052ce03c425d17b8546544532cd46065dcfdb))


### Documentation

* update documentation links to be more uniform ([e6d53dc](https://github.com/openai/openai-ruby/commit/e6d53dcaa4d7b77850dabd2889039887d4ec39ae))

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
