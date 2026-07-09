# frozen_string_literal: true

require "etc"
require "pathname"
require "securerandom"
require "shellwords"

require "minitest/test_task"
require "rake/clean"
require "rubocop/rake_task"

tapioca = "sorbet/tapioca"
examples = "examples"
ignore_file = ".ignore"
pkg = "pkg"

FILES_ENV = "FORMAT_FILE"

CLEAN.push(*%w[.idea/ .ruby-lsp/ .yardoc/ doc/], *FileList["*.gem"], pkg, ignore_file)

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

# Cap parallelism at the CPU count. `--max-procs=0` spawns one process per
# 300-file batch with no upper bound; on large SDKs (thousands of files) that
# oversubscribes CPUs and stacks up rubocop processes, exhausting memory and
# slowing CI to the point of timing out.
xargs = %W[xargs --no-run-if-empty --null --max-procs=#{Etc.nprocessors} --max-args=300 --]
ruby_opt = {"RUBYOPT" => [ENV["RUBYOPT"], "--encoding=UTF-8"].compact.join(" ")}

filtered = ->(ext, dirs) do
  if ENV.key?(FILES_ENV)
    %w[sed -E -n -e] << "/\\.#{ext}$/p" << "--" << ENV.fetch(FILES_ENV)
  else
    (%w[find] + dirs + %w[-type f -and -name]) << "*.#{ext}" << "-print0"
  end
end

desc("Lint `*.rb(i)`")
multitask(:"lint:rubocop") do
  find = %w[find ./lib ./test ./rbi ./examples -type f -and ( -name *.rb -or -name *.rbi ) -print0]

  rubocop = %w[rubocop]
  rubocop += %w[--format github] if ENV.key?("CI")

  # some lines cannot be shortened
  rubocop += %w[--except Lint/RedundantCopDisableDirective,Layout/LineLength]

  lint = xargs + rubocop
  sh("#{find.shelljoin} | #{lint.shelljoin}")
end

norm_lines = %w[tr -- \n \0].shelljoin

desc("Format `*.rb`")
multitask(:"format:rb") do
  # while `syntax_tree` is much faster than `rubocop`, `rubocop` is the only formatter with full syntax support
  files = filtered["rb", %w[./lib ./test ./examples]]
  fmt = xargs + %w[rubocop --fail-level F --autocorrect --format simple --]
  sh("#{files.shelljoin} | #{norm_lines} | #{fmt.shelljoin}")
end

desc("Format `*.rbi`")
multitask(:"format:rbi") do
  files = filtered["rbi", %w[./rbi]]
  fmt = xargs + %w[stree write --]
  sh(ruby_opt, "#{files.shelljoin} | #{norm_lines} | #{fmt.shelljoin}")
end

desc("Format `*.rbs`")
multitask(:"format:rbs") do
  files = filtered["rbs", %w[./sig]]
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
  sh("#{files.shelljoin} | #{norm_lines} | #{pre.shelljoin}")
  # run syntax tree to format `*.rbs` files
  sh(ruby_opt, "#{files.shelljoin} | #{norm_lines} | #{fmt.shelljoin}") do
    success = _1
  end
  # transform type aliases back to class aliases
  sh("#{files.shelljoin} | #{norm_lines} | #{pst.shelljoin}")

  # always run post-processing to remove comment marker
  fail unless success
end

desc("Format everything")
multitask(format: [:"format:rb", :"format:rbi", :"format:rbs"])

desc("Typecheck `*.rbs`")
multitask(:"typecheck:steep") do
  sh(*%w[steep check])
end

directory(examples)
directory(pkg)

desc("Typecheck `*.rbi`")
multitask("typecheck:sorbet": examples) do
  sh(*%w[srb typecheck --dir], examples)
end

directory(tapioca) do
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
multitask(:"build:gem" => pkg) do
  # optimizing for grepping through the gem bundle: many tools honour `.ignore` files, including VSCode
  #
  # both `rbi` and `sig` directories are navigable by their respective tool chains and therefore can be ignored by tools such as `rg`
  Pathname(ignore_file).write(<<~GLOB)
    rbi/*
    sig/*
  GLOB

  # RubyGems' release-gem action waits for pkg/*.gem after running rake release,
  # so build with RubyGems' normal versioned filename and move the artifact there.
  rm_rf(FileList["*.gem", "#{pkg}/*.gem"])
  sh(*%w[gem build openai.gemspec])
  mv(*FileList["*.gem"], pkg)
  rm_rf(ignore_file)
end

desc("Release ruby gem")
multitask(release: [:"build:gem"]) do
  sh(*%w[gem push], *FileList["#{pkg}/*.gem"])
end
