# Changelog

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
