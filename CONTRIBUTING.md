## Setting up the environment

This repository contains a `.ruby-version` file, which should work with either [rbenv](https://github.com/rbenv/rbenv) or [asdf](https://github.com/asdf-vm/asdf) with the [ruby plugin](https://github.com/asdf-vm/asdf-ruby).

Please follow the instructions for your preferred version manager to install the Ruby version specified in the `.ruby-version` file.

To set up the repository, run:

```bash
$ ./scripts/bootstrap
```

This will install all the required dependencies.

## Modifying/Adding code

Most of the SDK is generated code. Modifications to code will be persisted between generations, but may result in merge conflicts between manual patches and changes from the generator. The generator will never modify the contents `examples/` directory.

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
gem "openai", git: "https://www.github.com/openai/openai-ruby"
```

Alternatively, reference local copy of the repo:

```bash
$ git clone -- 'https://www.github.com/openai/openai-ruby' '<path-to-repo>'
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

Most tests require you to [set up a mock server](https://github.com/stoplightio/prism) against the OpenAPI spec to run the tests.

```bash
$ npx prism mock path/to/your/openapi.yml
```

```bash
$ bundle exec rake test
```

## Linting and formatting

This repository uses [rubocop](https://github.com/rubocop/rubocop) for linting and formatting of `*.rb` and `*.rbi` files. [syntax_tree](https://github.com/ruby-syntax-tree/syntax_tree) is used for formatting `*.rbs` files.

There are two separate type checkers supported by this library: [sorbet](https://github.com/sorbet/sorbet) and [steep](https://github.com/soutaro/steep) are used for verifying `*.rbi` and `*.rbs` files respectively.

To lint and typecheck:

```bash
$ bundle exec rake lint
```

To format and fix all lint issues automatically:

```bash
$ bundle exec rake format
```

## Editor Support

### Solargraph

This library includes [Solargraph](https://solargraph.org) support for both auto-completion and go to definition.

```ruby
gem "solargraph", group: :development
```

Note: if you had installed the gem locally using `git: "..."` or `path: "..."`, you must update your [`.solargraph.yml`](https://solargraph.org/guides/configuration) to include the path to where the gem is located:

```yaml
include:
  - '<path-to-repo>/lib/**/*.rb'
```

### Sorbet

[Sorbet](https://sorbet.org) should mostly work out of the box when editing this library directly. However, there are a some caveats due to the colocation of `*.rb` and `*.rbi` files in the same project. These issues should not otherwise manifest when this library is used as a dependency.

1. For go to definition usages, sorbet might get confused and may not always navigate to the correct location.

2. For each generic type in `*.rbi` files, a spurious "Duplicate type member" error is present.

### Ruby LSP

The Ruby LSP has [best effort support](https://shopify.github.io/ruby-lsp/#guessed-types) for inferring type information from Ruby code, and as such it may not always be able to provide accurate type information.

## Documentation Preview

To preview the documentation, run:

```bash
$ bundle exec rake docs:preview [PORT=8808]
```
