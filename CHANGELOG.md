# Changelog

## 0.7.0 (2025-06-09)

Full Changelog: [v0.6.0...v0.7.0](https://github.com/openai/openai-ruby/compare/v0.6.0...v0.7.0)

### Features

* **api:** Add tools and structured outputs to evals ([6ee3392](https://github.com/openai/openai-ruby/commit/6ee33924e9146e2450e9c43d052886ed3214cbde))


### Bug Fixes

* default content-type for text in multi-part formdata uploads should be text/plain ([105cf47](https://github.com/openai/openai-ruby/commit/105cf4717993c744ee6c453d2a99ae03f51035d4))
* tool parameter mapping for chat completions ([#156](https://github.com/openai/openai-ruby/issues/156)) ([5999b9f](https://github.com/openai/openai-ruby/commit/5999b9f6ad6dc73a290a8ef7b1b52bd89897039c))
* tool parameter mapping for responses ([#704](https://github.com/openai/openai-ruby/issues/704)) ([ac8bf11](https://github.com/openai/openai-ruby/commit/ac8bf11cf59fcc778f1658429a1fc06eaca79bba))

## 0.6.0 (2025-06-03)

Full Changelog: [v0.5.1...v0.6.0](https://github.com/openai/openai-ruby/compare/v0.5.1...v0.6.0)

### Features

* **api:** add new realtime and audio models, realtime session options ([315f0b0](https://github.com/openai/openai-ruby/commit/315f0b0ec3a663a7bc1f2c05ecc6ebfe8af99796))


### Bug Fixes

* `to_sorbet_type` should not return branded types ([4a1f14b](https://github.com/openai/openai-ruby/commit/4a1f14beeea6f1ef08d753fb3c3fa8607ebbe2c2))


### Chores

* prune whitespace ([d7335ac](https://github.com/openai/openai-ruby/commit/d7335ac4942eeccfa341eaf2fb2d45ec83df4dd3))

## 0.5.1 (2025-06-02)

Full Changelog: [v0.5.0...v0.5.1](https://github.com/openai/openai-ruby/compare/v0.5.0...v0.5.1)

### Bug Fixes

* **api:** Fix evals and code interpreter interfaces ([24a9100](https://github.com/openai/openai-ruby/commit/24a910015e6885fc19a2ad689fe70a148bed5787))

## 0.5.0 (2025-05-29)

Full Changelog: [v0.4.1...v0.5.0](https://github.com/openai/openai-ruby/compare/v0.4.1...v0.5.0)

### Features

* **api:** Config update for pakrym-stream-param ([214e516](https://github.com/openai/openai-ruby/commit/214e516f286a026e5b040ffd76b930cad7d5eabf))


### Bug Fixes

* **client:** return binary content from `get /containers/{container_id}/files/{file_id}/content` ([2b7122a](https://github.com/openai/openai-ruby/commit/2b7122ad724620269c3b403d5a584d710bed5b5c))
* sorbet types for enums, and make tapioca detection ignore `tapioca dsl` ([0e24b3e](https://github.com/openai/openai-ruby/commit/0e24b3e0a574de5c0544067c53b9e693e4cec3b1))


### Chores

* deprecate Assistants API ([4ce7530](https://github.com/openai/openai-ruby/commit/4ce753088e18a3331fccf6608889243809ce187b))

## 0.4.1 (2025-05-23)

Full Changelog: [v0.4.0-beta.1...v0.4.1](https://github.com/openai/openai-ruby/compare/v0.4.0-beta.1...v0.4.1)

### Bug Fixes

* prevent rubocop from mangling `===` to `is_a?` check ([c3a61c9](https://github.com/openai/openai-ruby/commit/c3a61c9f83b8cb79b41edadadca1a241de03d10f))

## 0.4.0-beta.1 (2025-05-23)

Full Changelog: [v0.1.0-beta.2...v0.4.0-beta.1](https://github.com/openai/openai-ruby/compare/v0.1.0-beta.2...v0.4.0-beta.1)

### Features

* structured output for responses API (text) ([#688](https://github.com/openai/openai-ruby/issues/688)) ([282ec24](https://github.com/openai/openai-ruby/commit/282ec24c89511c1cd50029fe154e10d772e23239))
* structured output for responses API (tools) ([#691](https://github.com/openai/openai-ruby/issues/691)) ([5e524ea](https://github.com/openai/openai-ruby/commit/5e524ea48020125911204c8050b49e360d7513d7))


### Chores

* **internal:** fix release workflows ([e1b31a6](https://github.com/openai/openai-ruby/commit/e1b31a6d6c3064f57e82aa1c3f48f2c797619b5a))
* **internal:** version bump ([b2dd8dd](https://github.com/openai/openai-ruby/commit/b2dd8dd1aac3ff9acf69953a0d04c74721b47e36))
* update README for public release ([#145](https://github.com/openai/openai-ruby/issues/145)) ([64e3849](https://github.com/openai/openai-ruby/commit/64e384933c2f80508002dfacf89efe74510c1330))

## 0.1.0-beta.2 (2025-05-22)

Full Changelog: [v0.1.0-beta.1...v0.1.0-beta.2](https://github.com/openai/openai-ruby/compare/v0.1.0-beta.1...v0.1.0-beta.2)

### Features

* **api:** add container endpoint ([8be52a2](https://github.com/openai/openai-ruby/commit/8be52a2bd618da97c79cb35ada46717965664a08))
* **api:** further updates for evals API ([ae7a8b8](https://github.com/openai/openai-ruby/commit/ae7a8b8fc1611aa6f645c75f865d9ae6906d9a20))
* **api:** new API tools ([9105b8b](https://github.com/openai/openai-ruby/commit/9105b8b80d2d381ed58b2b92ecfe644e7596c9a3))
* **api:** new streaming helpers for background responses ([91a278e](https://github.com/openai/openai-ruby/commit/91a278e6ac4db19c66a89d5f610c22ad3c82a1f7))
* **api:** Updating Assistants and Evals API schemas ([690b6a7](https://github.com/openai/openai-ruby/commit/690b6a78de30845f974695d0cc36a59a04adf65b))
* RBI type defs for structured output ([#684](https://github.com/openai/openai-ruby/issues/684)) ([00b25bd](https://github.com/openai/openai-ruby/commit/00b25bdb3aa8a2999114389d699cc3dc59c4089e))


### Bug Fixes

* correctly instantiate sorbet type aliases for enums and unions ([15a2b2b](https://github.com/openai/openai-ruby/commit/15a2b2bab52948f9dac83560dea419006589bd81))
* structured output union decorations ([05b69d1](https://github.com/openai/openai-ruby/commit/05b69d1be85f813e1bddf04e4042665383c1be04))


### Chores

* disable sorbet typecheck for WIP sorbet annotations in examples ([#678](https://github.com/openai/openai-ruby/issues/678)) ([a340356](https://github.com/openai/openai-ruby/commit/a3403566253a74a9f1c69a874568000eca1da656))
* **docs:** grammar improvements ([c4ef024](https://github.com/openai/openai-ruby/commit/c4ef024f3513e1d64e55960b45660e50d9bf9039))
* force utf-8 locale via `RUBYOPT` when formatting ([746abf4](https://github.com/openai/openai-ruby/commit/746abf447c01290ad3061ef77c54d3b5d781a6b7))
* **internal:** version bump ([b35ea63](https://github.com/openai/openai-ruby/commit/b35ea63d9758c4e96dd665013be2edb78ebaa8e6))
* refine Yard and Sorbet types and ensure linting is turned on for examples ([a16dd00](https://github.com/openai/openai-ruby/commit/a16dd00f99176184da0710a0fbce652718a3d067))
* use fully qualified names for yard annotations and rbs aliases ([26db76d](https://github.com/openai/openai-ruby/commit/26db76de24d82ebb593997fab8fd8df43c5f2372))
* use sorbet union aliases where available ([600f499](https://github.com/openai/openai-ruby/commit/600f499dcf61b4d3c3a8cf092ff18cb712711dc0))


### Documentation

* grammar improvements ([15511fc](https://github.com/openai/openai-ruby/commit/15511fc1e80f61abe64375b0a7eb22c5447d5288))
* grammar improvements in README.md ([d43db56](https://github.com/openai/openai-ruby/commit/d43db56ba239f91c6fb1344156e88feaee802f0c))

## 0.1.0-beta.1 (2025-05-16)

Full Changelog: [v0.1.0-alpha.5...v0.1.0-beta.1](https://github.com/openai/openai-ruby/compare/v0.1.0-alpha.5...v0.1.0-beta.1)

### Features

* **api:** add image sizes, reasoning encryption ([c4565ed](https://github.com/openai/openai-ruby/commit/c4565ed4c5ea2dc45fd8c0fb1f11b78ce1dd44ac))
* **api:** Add reinforcement fine-tuning api support ([65834c6](https://github.com/openai/openai-ruby/commit/65834c605a43d8d4b0bce44bd9048efe3dc874e8))
* **api:** adding new image model support ([641f4eb](https://github.com/openai/openai-ruby/commit/641f4eb0fadf75909a32dc48644bf0e220fbbe81))
* **api:** manual updates ([c4989d6](https://github.com/openai/openai-ruby/commit/c4989d68cbd3d95313d42f692187b58c063447a9))
* bump default connection pool size limit to minimum of 99 ([3fc0971](https://github.com/openai/openai-ruby/commit/3fc0971b30a6e683d09f18e5dda08a13f5d87cdc))
* expose base client options as read only attributes ([1d53fee](https://github.com/openai/openai-ruby/commit/1d53feee889c2db6824f0ba761b0138afdf84b24))
* expose recursive `#to_h` conversion ([734833c](https://github.com/openai/openai-ruby/commit/734833c004063cc8387f102c0eb608cb3445b2f4))
* initial structured outputs support ([#565](https://github.com/openai/openai-ruby/issues/565)) ([a613a39](https://github.com/openai/openai-ruby/commit/a613a39f25a9faee787bd696e6384d0f1ac34cb0))
* support sorbet aliases at the runtime ([0ef168a](https://github.com/openai/openai-ruby/commit/0ef168abd7e0a5a0c5f8d2e5f49ee87e81995d99))
* support specifying content-type with FilePart class ([ece942c](https://github.com/openai/openai-ruby/commit/ece942cb2c7982ed73e20321318a0f8634c22023))
* support webmock for testing ([9e1a0f1](https://github.com/openai/openai-ruby/commit/9e1a0f1db37f0778063c2a417a55ac04fee1f1b2))


### Bug Fixes

* ensure gem release is unaffected by renaming ([513acd8](https://github.com/openai/openai-ruby/commit/513acd850f86110f1820a97468f50baf3a3ae0b3))
* fix workflow syntax ([b5d45ce](https://github.com/openai/openai-ruby/commit/b5d45ce80ebfc7811446c134a1925fb0731f7971))
* **internal:** ensure formatting always uses c.utf-8 locale ([3d51f78](https://github.com/openai/openai-ruby/commit/3d51f780bcedad3ca4ff5f7823af97f891a5f85e))
* **internal:** fix formatting script for macos ([6784709](https://github.com/openai/openai-ruby/commit/67847092007552991375fa6f72ccda5925051bb0))
* JSON.fast_generate is deprecated ([591fdf0](https://github.com/openai/openai-ruby/commit/591fdf0174765fce77b857b02006efd5b37fe073))
* make a typo for `FilePart.content` ([c78ea0f](https://github.com/openai/openai-ruby/commit/c78ea0fad674def58c3d15eec516a18149777d09))


### Chores

* add generator safe directory ([5c9767e](https://github.com/openai/openai-ruby/commit/5c9767ed5d4204dd17bcda1b5a5b79d5e628e0e1))
* always check if current page is empty in `next_page?` ([8e8464e](https://github.com/openai/openai-ruby/commit/8e8464e2b6d9dc814c68f0e20268a2eafba37361))
* broadly detect json family of content-type headers ([77f7239](https://github.com/openai/openai-ruby/commit/77f7239e03a45323f70baee9d1430ecec242705c))
* bump minimum supported Ruby version to 3.2 ([41ce053](https://github.com/openai/openai-ruby/commit/41ce0535c5f7a7304c744d5e7b43a728d360c54f))
* **ci:** add timeout thresholds for CI jobs ([6fba7b2](https://github.com/openai/openai-ruby/commit/6fba7b2a1d4043b3ee41f49da43a50c305d613d3))
* **ci:** only use depot for staging repos ([57a10b0](https://github.com/openai/openai-ruby/commit/57a10b07135a824e8eee35e57a1d78f223befef9))
* **ci:** run on more branches and use depot runners ([0ae14a8](https://github.com/openai/openai-ruby/commit/0ae14a87ecc37f73077f0aaa442047452a6503b6))
* consistently use string in examples, even for enums ([cec4b05](https://github.com/openai/openai-ruby/commit/cec4b051bb0f4357032779cde2c11babe4196fcd))
* ensure examples have busybox compat shebangs ([7720dca](https://github.com/openai/openai-ruby/commit/7720dcabd020a5c672838dcf935fd9c9ba5b94e1))
* explicitly mark apis public under `Internal` module ([ca0d841](https://github.com/openai/openai-ruby/commit/ca0d841a571433528ae15974041c5ea142f9109e))
* fix misc linting / minor issues ([918ac6b](https://github.com/openai/openai-ruby/commit/918ac6bb9cec9fefe26337d6712e48c110d34320))
* **internal:** annotate request options with type aliases in sorbet ([4918836](https://github.com/openai/openai-ruby/commit/4918836aac697a899b19e4c3767126d0d86914d4))
* **internal:** codegen related update ([139a140](https://github.com/openai/openai-ruby/commit/139a140e6c5d37b638ad31a5fa8816e4d3fda5b8))
* **internal:** codegen related update ([ebf0cae](https://github.com/openai/openai-ruby/commit/ebf0cae7f0935c96eb21a980c9b3d46892d2cea7))
* **internal:** codegen related update ([71cf48f](https://github.com/openai/openai-ruby/commit/71cf48f5fe64cd8ae20615c7d019b3e1c40f2529))
* **internal:** codegen related update ([f3fc915](https://github.com/openai/openai-ruby/commit/f3fc915680f295098029d615129708a1e6a29ed3))
* **internal:** improve response envelope unwrap functionality ([a05d2c5](https://github.com/openai/openai-ruby/commit/a05d2c5d16ce052c1fb84005739e6b6d853f5e8e))
* **internal:** minor type annotation improvements ([67b0e35](https://github.com/openai/openai-ruby/commit/67b0e35c2c8d48c50c71c20a71304896a63f6b44))
* **internal:** remove unnecessary `rbi/lib` folder ([df9e099](https://github.com/openai/openai-ruby/commit/df9e0991a3aac2a5a480bfb3cf622139ca1b1373))
* **internal:** touch up formatting ([d3c5587](https://github.com/openai/openai-ruby/commit/d3c558710b94968ba45bf579cad1d8112d7534f1))
* **internal:** version bump ([ef2a5d4](https://github.com/openai/openai-ruby/commit/ef2a5d46f21a0df6b4b6ebc4e9d4dd4f6a6a6e5f))
* loosen rubocop rules that don't always make sense ([4244f89](https://github.com/openai/openai-ruby/commit/4244f8967d1583d97efa679d096eee04fd764240))
* migrate away from deprecated `JSON#fast_generate` ([3be700f](https://github.com/openai/openai-ruby/commit/3be700f04d782b538fcde678016532cfbc2eb66d))
* more accurate type annotations and aliases ([04b111d](https://github.com/openai/openai-ruby/commit/04b111dcdc2c5d458159be87a180174243a9d058))
* re-export top level models under library namespace ([8c5e78a](https://github.com/openai/openai-ruby/commit/8c5e78a1b2374c072c590f859008f69bd8d46d63))
* remove Gemfile.lock ([2306cb4](https://github.com/openai/openai-ruby/commit/2306cb447a81fd494a1a1696f99d90191103e187))
* remove Gemfile.lock during bootstrap ([c248f15](https://github.com/openai/openai-ruby/commit/c248f1522ed120fed49cb94a79a49cc8db146bf5))
* reorganize type aliases ([1815c45](https://github.com/openai/openai-ruby/commit/1815c45472109efaf891e2296f37b83b2acf275d))
* revert ignoring Gemfile.lock ([9a2827b](https://github.com/openai/openai-ruby/commit/9a2827b01a5a38985c4b92521534fc7a11f3c91a))
* show truncated parameter docs in yard ([bf84473](https://github.com/openai/openai-ruby/commit/bf844738622cd1c9a5c31bffc1e5378c132c31fd))
* validate request option coercion correctness ([c5b4f52](https://github.com/openai/openai-ruby/commit/c5b4f523e1cc110b5a944c53a1530fa0d9456eae))


### Documentation

* fix out of place README snippet ([39d155f](https://github.com/openai/openai-ruby/commit/39d155f1f3be511ab2089a8856054aa767fc6ba3))
* illustrate environmental defaults for auth variables ([7d8ee4f](https://github.com/openai/openai-ruby/commit/7d8ee4f61fee6e53a07a44b20ca36f27bf3cc463))
* **readme:** fix typo ([a6c7609](https://github.com/openai/openai-ruby/commit/a6c76091c66abaf1c9bdfaaa348f9593639cadc4))
* rewrite much of README.md for readability ([f3c721e](https://github.com/openai/openai-ruby/commit/f3c721e71de583da61bc02566200ac0dc574aa33))

## 0.1.0-alpha.5 (2025-04-18)

Full Changelog: [v0.1.0-alpha.4...v0.1.0-alpha.5](https://github.com/openai/openai-ruby/compare/v0.1.0-alpha.4...v0.1.0-alpha.5)

### Features

* implement `#hash` for data containers ([924fcb4](https://github.com/openai/openai-ruby/commit/924fcb42fa0991c491246df7667c72022190f1ee))


### Bug Fixes

* always send idempotency header when specified as a request option ([548bfaf](https://github.com/openai/openai-ruby/commit/548bfaf81a4947860ec35ff7efafb144da4863bb))
* **client:** send correct HTTP path ([896142a](https://github.com/openai/openai-ruby/commit/896142abf1bb03f1eb48e0754cbff04edd081a0e))


### Chores

* documentation improvements ([ff43d73](https://github.com/openai/openai-ruby/commit/ff43d73fe6e514d5b9f110892c3880998df8dacf))
* **internal:** configure releases ([7eb9185](https://github.com/openai/openai-ruby/commit/7eb91852c03eaba177464060631c2645d3db63d0))
* **internal:** contribute.md and contributor QoL improvements ([d060adf](https://github.com/openai/openai-ruby/commit/d060adf81aadb6b138428bdbde79633fd0dff230))
* make sorbet enums easier to read ([7c03213](https://github.com/openai/openai-ruby/commit/7c0321329658a6d2823f9022a77be5965186b94c))
* refine `#inspect` and `#to_s` for model classes ([84308a6](https://github.com/openai/openai-ruby/commit/84308a6683e6ed9d520b05e0ac828de662fe0198))
* simplify yard annotations by removing most `@!parse` directives ([16ec2e3](https://github.com/openai/openai-ruby/commit/16ec2e391b0cfdf49727099be9afa220c7ab16e5))
* update README with recommended editor plugins ([c745aef](https://github.com/openai/openai-ruby/commit/c745aef51359e1df2118006dd69470fc4714de5a))
* update readme with temporary install instructions ([8a79cc0](https://github.com/openai/openai-ruby/commit/8a79cc0a6396f0989feaefb2d4d30b6c1dc75dfe))
* use `@!method` instead of `@!parse` for virtual method type definitions ([b5fba2e](https://github.com/openai/openai-ruby/commit/b5fba2e689884dc011dec9fd2d8349c9c842d274))

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
