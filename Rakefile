# frozen_string_literal: true

require "bundler"
require "pathname"
require "tempfile"

require "minitest/test_task"
require "rake/clean"
require "rubocop/rake_task"

require_relative "scripts/rubyfmt_policy"
require_relative "scripts/rbs_format"

examples = "examples"
ignore_file = ".ignore"
pkg = "pkg"

FILES_ENV = "FORMAT_FILE"

CLEAN.push(*%w[.idea/ .ruby-lsp/ .yardoc/ doc/], *FileList["*.gem"], pkg, ignore_file)

CLOBBER.push(*%w[sorbet/rbi/annotations/ sorbet/rbi/gems/])

multitask(:default) do
  sh(*%w[rake --tasks])
end

desc("Preview docs; use `PORT=<PORT>` to change the port")
multitask(:"docs:preview") do
  Bundler.with_original_env { sh(*%w[./scripts/docs preview]) }
end

bedrock_tests = FileList["test/openai/providers/bedrock*_test.rb"]

run_tests = lambda do |files|
  abort("No test files selected") if files.empty?

  rb = files.map { "require_relative(#{_1.dump});" }.join

  ruby(*%w[-w -e], rb, verbose: false) { fail unless _1 }
end

desc("Run non-Bedrock test suites; use `TEST=path/to/test.rb` to run a specific test file")
multitask(test: [:"test:examples:inventory"]) do
  files = FileList[ENV.fetch("TEST", "test/**/*_test.rb")]
  requested_bedrock_tests = files.to_a & bedrock_tests.to_a
  if ENV.key?("TEST") && !requested_bedrock_tests.empty?
    abort("Run Bedrock tests with `BUNDLE_GEMFILE=gemfiles/bedrock.gemfile bundle exec rake test:bedrock`")
  end

  run_tests.call(files.exclude(*bedrock_tests))
end

desc("Run Bedrock tests with the AWS test bundle")
multitask("test:bedrock") do
  run_tests.call(bedrock_tests)
end

desc("Lint `*.rb(i)`")
RuboCop::RakeTask.new(:"lint:rubocop") do |task|
  task.patterns = ["."]
  task.formatters = %w[github] if ENV.key?("CI")

  task.options = %w[--parallel --force-exclusion]
end

desc("Validate RuboCop suppression directives")
multitask(:"lint:rubocop_directives") do
  ruby(*%w[scripts/validate-rubocop-directives])
end

Rake::Task[:"lint:rubocop"].enhance([:"lint:rubocop_directives", :"lint:rubyfmt", :"lint:rbs_format"])

ruby_paths = lambda do
  inputs = if ENV.key?(FILES_ENV)
    File.readlines(ENV.fetch(FILES_ENV), chomp: true)
  else
    ["."]
  end

  RubyfmtPolicy.paths(inputs)
end

run_rubyfmt = lambda do |mode|
  paths = ruby_paths.call
  violations = RubyfmtPolicy.violations(paths)
  abort(violations.join("\n")) unless violations.empty?
  unless paths.empty?
    Tempfile.create("rubyfmt-paths") do |file|
      file.binmode
      paths.each do |path|
        file.write(path)
        file.write("\0")
      end

      file.flush
      abort("rubyfmt failed") unless system("xargs", "-0", "./scripts/rubyfmt", mode, "--", in: file.path)
    end
  end
end

desc("Check Ruby source formatting")
multitask(:"lint:rubyfmt") do
  run_rubyfmt.call("--check")
end

desc("Format Ruby source and RBI signatures with rubyfmt")
multitask(:"format:rb") do
  run_rubyfmt.call("--in-place")
end

desc("Format RBI signatures with rubyfmt")
task("format:rbi": :"format:rb")

rbs_paths = lambda do
  if ENV.key?(FILES_ENV)
    File.readlines(ENV.fetch(FILES_ENV), chomp: true).select { _1.end_with?(".rbs") }
  else
    Dir.glob("sig/**/*.rbs")
  end
end

desc("Check RBS signature formatting")
multitask(:"lint:rbs_format") do
  changed = RBSFormat.run(rbs_paths.call, check: true)
  abort("RBS formatting differs; run ./scripts/format:\n#{changed.join("\n")}") unless changed.empty?
end

desc("Format RBS signatures with Syntax Tree")
multitask(:"format:rbs") do
  RBSFormat.run(rbs_paths.call, check: false)
end

desc("Format everything")
# RuboCop temporarily changes cwd; RBS discovery must not run alongside it.
task(format: [:"format:rb", :"format:rbs"])

desc("Validate `*.rbs`")
multitask(:"validate:rbs") do
  ruby(*%w[scripts/validate-rbs])
end

directory(examples)
directory(pkg)

desc("Typecheck `*.rbi`")
multitask("typecheck:sorbet": examples) do
  # The shipped RBI directory is already listed in sorbet/config.
  sh({"SRB_SKIP_GEM_RBIS" => "1"}, *%w[srb typecheck --dir], examples)
end

desc("Typecheck and validate everything")
multitask(typecheck: [:"typecheck:sorbet", :"validate:rbs"])

desc("Validate the Ruby example E2E inventory without making live requests")
task("test:examples:inventory") do
  ruby(*%w[scripts/examples-e2e.rb --inventory-only])
end

desc("Run covered Ruby examples end-to-end against the live API")
task("test:examples:e2e") do
  ruby(*%w[scripts/examples-e2e.rb])
end

desc("Smoke-test live API authentication, responses, streaming, and optionally X.509")
task("test:live:smoke") do
  x509 = ENV.fetch("OPENAI_LIVE_SMOKE_X509", "0")
  unless %w[0 1].include?(x509)
    abort("OPENAI_LIVE_SMOKE_X509 must be 0 or 1")
  end

  ruby(*%w[scripts/live-smoke.rb])
  ruby(*%w[examples/x509_workload_identity.rb]) if x509 == "1"
end

desc("Lint and typecheck")
multitask(lint: [:"lint:rubocop", :"lint:rubocop_directives", :typecheck])

desc("Build yard docs")
multitask(:"build:docs") do
  Bundler.with_original_env { sh(*%w[./scripts/docs build]) }
end

desc("Build ruby gem")
multitask("build:gem": pkg) do
  # optimizing for grepping through the gem bundle: many tools honour `.ignore` files, including VSCode
  #
  # both `rbi` and `sig` directories are navigable by their respective tool chains and therefore can be ignored by tools such as `rg`
  Pathname(ignore_file).write(
    <<~GLOB
      rbi/*
      sig/*
    GLOB
  )

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
