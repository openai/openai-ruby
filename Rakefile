# frozen_string_literal: true

require "pathname"
require "securerandom"
require "shellwords"

require "minitest/test_task"
require "rake/clean"
require "rubocop/rake_task"

tapioca = "sorbet/tapioca"
ignore_file = ".ignore"

CLEAN.push(*%w[.idea/ .ruby-lsp/ .yardoc/ doc/ Gemfile.lock], *FileList["*.gem"], ignore_file)

CLOBBER.push(*%w[sorbet/rbi/annotations/ sorbet/rbi/gems/], tapioca)

multitask(:default) do
  sh(*%w[rake --tasks])
end

desc("Preview docs; use `PORT=<PORT>` to change the port")
multitask(:"docs:preview") do
  sh(*%w[yard server --reload --quiet --bind [::] --port], ENV.fetch("PORT", "8808"))
end

desc("Run test suites; use `TEST=path/to/test.rb` to run a specific test file")
multitask(:test) do
  rb =
    FileList[ENV.fetch("TEST", "./test/**/*_test.rb")]
    .map { "require_relative(#{_1.dump});" }
    .join

  ruby(*%w[-w -e], rb, verbose: false) { fail unless _1 }
end

rubo_find = %w[find ./lib ./test ./rbi -type f -and ( -name *.rb -or -name *.rbi ) -print0]
xargs = %w[xargs --no-run-if-empty --null --max-procs=0 --max-args=300 --]

desc("Lint `*.rb(i)`")
multitask(:"lint:rubocop") do
  rubocop = %w[rubocop --fail-level E]
  rubocop += %w[--format github] if ENV.key?("CI")

  # some lines cannot be shortened
  rubocop += %w[--except Lint/RedundantCopDisableDirective,Layout/LineLength]

  lint = xargs + rubocop
  sh("#{rubo_find.shelljoin} | #{lint.shelljoin}")
end

desc("Format `*.rb(i)`")
multitask(:"format:rubocop") do
  fmt = xargs + %w[rubocop --fail-level F --autocorrect --format simple --]
  sh("#{rubo_find.shelljoin} | #{fmt.shelljoin}")
end

desc("Format `*.rbs`")
multitask(:"format:syntax_tree") do
  find = %w[find ./sig -type f -name *.rbs -print0]
  inplace = /darwin|bsd/ =~ RUBY_PLATFORM ? ["-i", ""] : %w[-i]
  uuid = SecureRandom.uuid

  # `syntax_tree` has trouble with `rbs`'s class & module aliases

  sed_bin = /darwin/ =~ RUBY_PLATFORM ? "/usr/bin/sed" : "sed"
  sed = xargs + [sed_bin, "-E", *inplace, "-e"]
  # annotate unprocessable aliases with a unique comment
  pre = sed + ["s/(class|module) ([^ ]+) = (.+$)/# \\1 #{uuid}\\n\\2: \\3/", "--"]
  fmt = xargs + %w[stree write --plugin=rbs --]
  # remove the unique comment and unprocessable aliases to type aliases
  subst = <<~SED
    s/# (class|module) #{uuid}/\\1/
    t l1
    b

    : l1
    N
    s/\\n *([^:]+): (.+)$/ \\1 = \\2/
  SED
  # for each line:
  #   1. try transform the unique comment into `class | module`, if successful, branch to label `l1`.
  #   2. at label `l1`, join previously annotated line with `class | module` information.
  pst = sed + [subst, "--"]

  success = false

  # transform class aliases to type aliases, which syntax tree has no trouble with
  sh("#{find.shelljoin} | #{pre.shelljoin}")
  # run syntax tree to format `*.rbs` files
  sh("#{find.shelljoin} | #{fmt.shelljoin}") do
    success = _1
  end
  # transform type aliases back to class aliases
  sh("#{find.shelljoin} | #{pst.shelljoin}")

  # always run post-processing to remove comment marker
  fail unless success
end

desc("Format everything")
multitask(format: [:"format:rubocop", :"format:syntax_tree"])

desc("Typecheck `*.rbs`")
multitask(:"typecheck:steep") do
  sh(*%w[steep check])
end

desc("Typecheck `*.rbi`")
multitask(:"typecheck:sorbet") do
  sh(*%w[srb typecheck])
end

file(tapioca) do
  sh(*%w[tapioca init])
end

desc("Typecheck everything")
multitask(typecheck: [:"typecheck:steep", :"typecheck:sorbet"])

desc("Lint and typecheck")
multitask(lint: [:"lint:rubocop", :typecheck])

desc("Build yard docs")
multitask(:"build:docs") do
  sh(*%w[yard])
end

desc("Build ruby gem")
multitask(:"build:gem") do
  # optimizing for grepping through the gem bundle: many tools honour `.ignore` files, including VSCode
  #
  # both `rbi` and `sig` directories are navigable by their respective tool chains and therefore can be ignored by tools such as `rg`
  Pathname(ignore_file).write(<<~GLOB)
    rbi/*
    sig/*
  GLOB

  sh(*%w[gem build -- openai.gemspec])
  rm_rf(ignore_file)
end

desc("Release ruby gem")
multitask(release: [:"build:gem"]) do
  sh(*%w[gem push], *FileList["*.gem"])
end
