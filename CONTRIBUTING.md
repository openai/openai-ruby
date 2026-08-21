## Setting up the environment

See the [versioning policy](VERSIONING.md) before changing the public API,
minimum Ruby version, dependencies, or release behavior.

Review the [security requirements](#security-requirements) before installing
dependencies, changing SDK behavior, or running live examples.

This repository contains a `.ruby-version` file, which should work with either [rbenv](https://github.com/rbenv/rbenv) or [asdf](https://github.com/asdf-vm/asdf) with the [ruby plugin](https://github.com/asdf-vm/asdf-ruby).

Please follow the instructions for your preferred version manager to install the Ruby version specified in the `.ruby-version` file.

To set up the repository, run:

```bash
$ ./scripts/bootstrap
```

This installs the dependencies used by the normal test, lint, typecheck, and
package workflows. Documentation tooling has a separate bundle; see
[Documentation](#documentation).

## Security requirements

- **Secrets and fixtures:** Never commit API keys, access tokens, private keys,
  credentials, or customer data. Load secrets from environment variables such
  as `OPENAI_API_KEY`; use clearly fake values in examples, tests, snapshots,
  and WebMock fixtures.
- **Logs and diagnostics:** Redact authorization headers, cookies, signed URLs,
  credential-bearing query parameters, customer data, and sensitive
  request/response bodies, prompts, or uploaded files from logs, exceptions,
  error messages, fixtures, and CI artifacts. Clearly fake or sanitized
  payloads may remain in tests and diagnostics.
- **Dependencies:** Review `Gemfile`, `Gemfile.lock`, `gemfiles/*.gemfile`,
  `gemfiles/*.gemfile.lock`, `docs/Gemfile`, `docs/Gemfile.lock`, and
  `openai.gemspec` changes, including direct and transitive gems, sources,
  locked Git revisions, native extensions, and install/build scripts. Do not
  run unreviewed scripts or accept unexplained lockfile changes.
- **CI and publishing:** Pin GitHub Actions to full commit SHAs, grant minimum
  per-job permissions, and preserve `permissions: {}`,
  `persist-credentials: false`, protected release environments, and RubyGems
  trusted publishing. Restrict `id-token: write` to the publishing job; protect
  GitHub App private keys and do not introduce long-lived publishing tokens.
- **Sensitive changes:** Request `@openai/sdks-team` review for authentication,
  network endpoints/transports, redirects, TLS, uploads and file paths,
  JSON/YAML/Marshal deserialization, request logging, webhooks, dependencies,
  and CI/release changes. Add targeted regression/security tests for affected
  credential, network, file, serialization, or publishing boundaries.
- **Vulnerability reports:** Follow [SECURITY.md](SECURITY.md). Never report a
  suspected vulnerability in a public issue, pull request, or discussion.

## Modifying/Adding code

Most of the SDK is generated code. Modifications to code will be persisted between generations, but may result in merge conflicts between manual patches and changes from the generator. The generator will never modify the contents of `lib/openai/helpers/` and `examples/` directory.

## Adding and running examples

All files in the `examples/` directory are not modified by the generator and can be freely edited or added to.

```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../lib/openai"

# ...
```

```bash
$ chmod +x './examples/<your-example>.rb'

# run the example against your api
$ ruby './examples/<your-example>.rb'
```

## Using the repository from source

If you’d like to use the repository from source, you can either install from git or reference a cloned repository:

To install via git in your `Gemfile`:

```ruby
gem "openai", git: "https://github.com/openai/openai-ruby"
```

Alternatively, reference local copy of the repo:

```bash
$ git clone -- 'https://github.com/openai/openai-ruby' '<path-to-repo>'
```

```ruby
gem "openai", path: "<path-to-repo>"
```

## Running commands

Running `rake` by itself will show all runnable commands.

```bash
$ bundle exec rake
```

## Running tests

Most tests require you to [set up a mock server](https://github.com/dgellow/steady) against the OpenAPI spec to run the tests.

```sh
$ ./scripts/mock
```

```bash
$ bundle exec rake test
```

The primary bundle intentionally omits the optional AWS SDK. Install the
dedicated Bedrock bundle and run its tests separately:

```bash
$ BUNDLE_GEMFILE=gemfiles/bedrock.gemfile bundle install
$ BUNDLE_GEMFILE=gemfiles/bedrock.gemfile bundle exec rake test:bedrock
```

When regenerating `gemfiles/bedrock.gemfile.lock`, preserve the
`x-release-please` markers around the local `openai` version. Release Please
uses them to update this lockfile; Bundler can remove them when rewriting it.

### Running examples end-to-end

The live example suite executes every example marked as `covered` in
`examples/e2e.yml`. It requires `OPENAI_API_KEY`, makes real API requests, and
writes JSON and Markdown execution reports under `tmp/examples-e2e/` by default.

Keep `OPENAI_API_KEY` in the environment. Prefer the offline inventory check,
which makes no API requests:

```bash
$ bundle exec rake test:examples:inventory
```

Live reports include example paths, pass/fail status, timing, and structural
failure diagnostics. Existing stdout/stderr report fields remain present but are
always null. Captured output and exception messages are omitted from JSON
reports, Markdown summaries, and the explicitly selected CI artifacts. Running
the live suite still makes real API requests:

```bash
$ bundle exec rake test:examples:e2e
```

Every `examples/**/*.rb` file must be classified as covered or explicitly
excluded with a reason. In GitHub Actions, live execution is available only
through the manually dispatched `Examples E2E` workflow.

## Linting and formatting

[rubyfmt](https://github.com/fables-tales/rubyfmt) owns Ruby source and `*.rbi` signature layout. The `scripts/rubyfmt` launcher uses version 0.14.1 and downloads a checksum-verified release into your user cache when needed. To use an existing installation, set `RUBYFMT` to an executable of that exact version.

[rubocop](https://github.com/rubocop/rubocop) remains responsible for correctness and security checks. The existing CI lint task checks rubyfmt output and RBS formatting. [syntax_tree](https://github.com/ruby-syntax-tree/syntax_tree) continues to format `*.rbs` files; its check and write modes use the same implementation.

All Ruby sources are formatted; file-level opt-outs are rejected. Two existing handwritten pattern-matching expressions use equivalent forms that avoid rubyfmt 0.14.1 bugs. Their source comments explain why, and regression tests check that both complete files format into valid Ruby and remain unchanged on a second pass.

There are two separate type checkers supported by this library: [sorbet](https://github.com/sorbet/sorbet) and [steep](https://github.com/soutaro/steep) are used for verifying `*.rbi` and `*.rbs` files respectively.

To lint and typecheck:

```bash
$ bundle exec rake lint
```

To run the available formatters:

```bash
$ bundle exec rake format
```

## Editor Support

### Ruby LSP

[Ruby LSP](https://github.com/Shopify/ruby-lsp) has quite good support for go to definition, but not auto-completion.

This can be installed along side Solargraph.

### Solargraph

[Solargraph](https://solargraph.org) has quite good support for auto-completion, but not go to definition.

This can be installed along side Ruby LSP.

### Sorbet

[Sorbet](https://sorbet.org) should mostly work out of the box when editing this library directly. However, there are a some caveats due to the colocation of `*.rb` and `*.rbi` files in the same project. These issues should not otherwise manifest when this library is used as a dependency.

1. For go to definition usages, sorbet might get confused and may not always navigate to the correct location.

2. For each generic type in `*.rbi` files, a spurious "Duplicate type member" error is present.

## Documentation

Documentation dependencies are intentionally isolated from the primary
contributor bundle. Install them with:

```bash
$ ./scripts/docs install
```

To build the documentation, run:

```bash
$ ./scripts/docs build
```

To preview the documentation, run:

```bash
$ PORT=8808 ./scripts/docs preview
```

The existing `bundle exec rake build:docs` and
`bundle exec rake docs:preview` tasks delegate to the same docs bundle.
