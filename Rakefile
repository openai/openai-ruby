# frozen_string_literal: true

require "securerandom"
require "shellwords"

require "minitest/test_task"
require "rake/clean"
require "rubocop/rake_task"

CLEAN.push(*%w[.idea/ .ruby-lsp/ .yardoc/])

xargs = %w[xargs --no-run-if-empty --null --max-procs=0 --max-args=300 --]

multitask(default: [:test])

multitask(:test) do
  rb = 
    FileList[ENV.fetch("TEST", "./test/**/*_test.rb")]
    .map { "require_relative(#{_1.dump});" }
    .join

  ruby(*%w[-w -e], rb, verbose: false) { fail unless _1 }
end

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = %w[--fail-level E]
  if ENV.key?("CI")
    t.options += %w[--format github]
  end
end

multitask(:ruboformat) do
  find = %w[find ./lib ./test ./rbi -type f -and ( -name *.rb -or -name *.rbi ) -print0]
  fmt = xargs + %w[rubocop --fail-level F --autocorrect --format simple --]
  sh("#{find.shelljoin} | #{fmt.shelljoin}")
end

multitask(:syntax_tree) do
  find = %w[find ./sig -type f -name *.rbs -print0]
  inplace = /darwin|bsd/ =~ RUBY_PLATFORM ? %w[-i''] : %w[-i]
  uuid = SecureRandom.uuid

  # `syntax_tree` has trouble with `rbs`'s class & module aliases

  sed = xargs + %w[sed -E] + inplace + %w[-e]
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

  # transform class aliases to type aliases, which syntax tree has no trouble with
  sh("#{find.shelljoin} | #{pre.shelljoin}")
  # run syntax tree to format `*.rbs` files
  sh("#{find.shelljoin} | #{fmt.shelljoin}")
  # transform type aliases back to class aliases
  sh("#{find.shelljoin} | #{pst.shelljoin}")
end

multitask(format: [:ruboformat, :syntax_tree])

multitask(:steep) do
  sh(*%w[steep check])
end

multitask(:sorbet) do
  sh(*%w[srb typecheck])
end

file("sorbet/tapioca") do
  sh(*%w[tapioca init])
end

multitask(typecheck: [:steep, :sorbet])
multitask(lint: [:rubocop, :typecheck])

multitask(:build) do
  sh(*%w[gem build -- openai.gemspec])
end

multitask(release: [:build]) do
  sh(*%w[gem push], *FileList["openai-*.gem"])
end
