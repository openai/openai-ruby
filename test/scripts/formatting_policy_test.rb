# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "open3"
require "rubocop"
require "rbconfig"
require "tmpdir"

class FormattingPolicyTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  STYLE_SAFETY_COPS = %w[
    Style/FrozenStringLiteralComment
    Style/MissingRespondToMissing
    Style/MutableConstant
  ].freeze

  def test_rubocop_preserves_safety_checks_without_enforcing_layout
    config = RuboCop::ConfigStore.new.for_dir(ROOT)
    enabled = RuboCop::Cop::Registry.global.enabled(config).map(&:cop_name)

    formatting = enabled.grep(/\A(?:Layout|Metrics|Naming|Style)\//)
    assert_equal(STYLE_SAFETY_COPS, formatting.sort)
    %w[
      Bundler/DuplicatedGem
      Bundler/InsecureProtocolSource
      Gemspec/DuplicatedAssignment
      Gemspec/RequiredRubyVersion
      Gemspec/RequireMFA
      Lint/Syntax
      Security/Eval
      Security/IoMethods
    ]
      .each { assert_includes(enabled, _1) }
    refute_includes(enabled, "Bundler/OrderedGems")
    refute_includes(enabled, "Gemspec/OrderedDependencies")
    refute_includes(enabled, "Lint/HeredocMethodCallPosition")
    assert_equal("disable", config["AllCops"]["NewCops"])

    # A RuboCop upgrade must make an explicit decision about new safety cops.
    RuboCop::ConfigLoader.default_configuration.each do |name, options|
      next unless name.match?(/\A(?:Lint|Security)\//) && options["Enabled"] == "pending"
      # Layout belongs to rubyfmt.
      next if name == "Lint/HeredocMethodCallPosition"

      assert_includes(enabled, name)
    end
  end

  def test_rubyfmt_is_enforced_and_idempotent
    assert_rubyfmt_enforced("rb")
  end

  def test_rbi_rubyfmt_is_enforced_and_idempotent
    assert_rubyfmt_enforced("rbi")
  end

  def assert_rubyfmt_enforced(extension)
    Dir.mktmpdir do |directory|
      path = File.join(directory, "example with spaces.#{extension}")
      source = "value={hello: 'world'}\n"
      File.write(path, source)
      paths = File.join(directory, "paths")
      File.write(paths, "#{path}\n")

      _stdout, _stderr, before = Open3.capture3(
        "bundle",
        "exec",
        "rake",
        "lint:rubyfmt",
        "FORMAT_FILE=#{paths}",
        chdir: ROOT
      )
      refute(before.success?, "unformatted source should fail the CI formatting check")

      stdout, stderr, status = Open3.capture3(
        "bundle",
        "exec",
        "rake",
        "format:rb",
        "FORMAT_FILE=#{paths}",
        chdir: ROOT
      )

      assert(status.success?, "#{stdout}\n#{stderr}")
      formatted = File.read(path)
      refute_equal(source, formatted)
      stdout, stderr, status = Open3.capture3(
        "bundle",
        "exec",
        "rake",
        "lint:rubyfmt",
        "FORMAT_FILE=#{paths}",
        chdir: ROOT
      )
      assert(status.success?, "#{stdout}\n#{stderr}")
      stdout, stderr, status = Open3.capture3(
        "bundle",
        "exec",
        "rake",
        "format:rb",
        "FORMAT_FILE=#{paths}",
        chdir: ROOT
      )
      assert(status.success?, "#{stdout}\n#{stderr}")
      assert_equal(formatted, File.read(path))
    end
  end

  def test_pattern_workarounds_format_as_valid_idempotent_ruby
    %w[
      lib/openai/resources/responses.rb
      lib/openai/helpers/structured_output/response_parser.rb
      test/openai/internal/type/base_model_test.rb
      rbi/openai/internal/type/base_model.rbi
    ]
      .each do |path|
        source = File.read(File.join(ROOT, path))
        refute_match(/^#\s*rubyfmt:\s*false\s*$/, source)
        formatted, stderr, status = Open3.capture3("./scripts/rubyfmt", stdin_data: source, chdir: ROOT)
        assert(status.success?, "#{path}: #{stderr}")
        stdout, stderr, status = Open3.capture3(RbConfig.ruby, "-c", stdin_data: formatted)
        assert(status.success?, "#{path}: #{stdout}#{stderr}")
        second, stderr, status = Open3.capture3("./scripts/rubyfmt", stdin_data: formatted, chdir: ROOT)
        assert(status.success?, "#{path}: #{stderr}")
        assert_equal(formatted, second, "#{path} must format idempotently")
      end
  end

  def test_rubyfmt_covers_the_same_sources_as_rubocop
    # RuboCop changes directory while loading config. Keep discovery outside
    # the parallel test process so it cannot race another test's chdir block.
    source = <<~RUBY
      require "json"
      require_relative "scripts/rubyfmt_policy"
      puts JSON.generate({
        paths: RubyfmtPolicy.paths,
        expected: RuboCopDirectiveGuard.rubocop_target_paths,
        steepfile: RubyfmtPolicy.paths(["Steepfile"]),
        empty: RubyfmtPolicy.paths([]),
        exemptions: RubyfmtPolicy.violations(RubyfmtPolicy.paths)
      })
    RUBY
    stdout, stderr, status = Open3.capture3("bundle", "exec", "ruby", "-e", source, chdir: ROOT)
    assert(status.success?, "#{stdout}\n#{stderr}")
    result = JSON.parse(stdout)
    assert_equal(result.fetch("expected"), result.fetch("paths"))
    assert(result.fetch("paths").any? { _1.end_with?(".rbi") })
    assert_includes(result.fetch("paths").map { File.basename(_1) }, "Steepfile")
    assert_equal([File.join(ROOT, "Steepfile")], result.fetch("steepfile"))
    assert_empty(result.fetch("empty"))
    assert_empty(result.fetch("exemptions"))
  end

  def test_lint_rejects_native_exemptions
    %w[rb rbi].each { assert_native_exemption_rejected(_1) }
  end

  def assert_native_exemption_rejected(extension)
    Dir.mktmpdir do |directory|
      path = File.join(directory, "example.#{extension}")
      File.write(path, "# rubyfmt: false\nvalue={hello: 'world'}\n")
      paths = File.join(directory, "paths")
      File.write(paths, "#{path}\n")
      stdout, stderr, status = Open3.capture3(
        "bundle",
        "exec",
        "rake",
        "lint:rubyfmt",
        "FORMAT_FILE=#{paths}",
        chdir: ROOT
      )
      refute(status.success?)
      assert_includes(stdout + stderr, "rubyfmt opt-outs are not allowed")
    end
  end

  def test_rbs_check_is_non_mutating_and_preserves_aliases
    Dir.mktmpdir do |directory|
      path = File.join(directory, "example with spaces.rbs")
      source = "module Example\n  class Alias = ::String\n  module Other = ::Enumerable\n  def call: (String value)->String\nend\n"
      File.write(path, source)
      paths = File.join(directory, "paths")
      File.write(paths, "#{path}\n")

      stdout, stderr, status = Open3.capture3(
        "bundle",
        "exec",
        "rake",
        "lint:rbs_format",
        "FORMAT_FILE=#{paths}",
        chdir: ROOT
      )
      refute(status.success?)
      assert_includes(stdout + stderr, path)
      assert_equal(source, File.read(path), "check mode must not rewrite files")

      stdout, stderr, status = Open3.capture3(
        "bundle",
        "exec",
        "rake",
        "format:rbs",
        "FORMAT_FILE=#{paths}",
        chdir: ROOT
      )
      assert(status.success?, "#{stdout}\n#{stderr}")
      formatted = File.read(path)
      refute_equal(source, formatted)
      assert_includes(formatted, "class Alias = ::String")
      assert_includes(formatted, "module Other = ::Enumerable")

      stdout, stderr, status = Open3.capture3(
        "bundle",
        "exec",
        "rake",
        "lint:rbs_format",
        "FORMAT_FILE=#{paths}",
        chdir: ROOT
      )
      assert(status.success?, "#{stdout}\n#{stderr}")
      stdout, stderr, status = Open3.capture3(
        "bundle",
        "exec",
        "rake",
        "format:rbs",
        "FORMAT_FILE=#{paths}",
        chdir: ROOT
      )
      assert(status.success?, "#{stdout}\n#{stderr}")
      assert_equal(formatted, File.read(path))
    end
  end

  def test_rbs_format_failure_leaves_original_file_untouched
    Dir.mktmpdir do |directory|
      path = File.join(directory, "invalid.rbs")
      source = "class Broken\n  def invalid: (\nend\n"
      File.write(path, source)
      paths = File.join(directory, "paths")
      File.write(paths, "#{path}\n")
      _stdout, _stderr, status = Open3.capture3(
        "bundle",
        "exec",
        "rake",
        "format:rbs",
        "FORMAT_FILE=#{paths}",
        chdir: ROOT
      )
      refute(status.success?)
      assert_equal(source, File.read(path))
    end
  end

  def test_existing_ci_lint_task_enforces_both_formatters
    source = "require \"rake\"; load \"Rakefile\"; puts JSON.generate(Rake::Task[\"lint:rubocop\"].prerequisites)"
    stdout, stderr, status = Open3.capture3("bundle", "exec", "ruby", "-rjson", "-e", source, chdir: ROOT)
    assert(status.success?, "#{stdout}\n#{stderr}")
    prerequisites = JSON.parse(stdout)
    assert_includes(prerequisites, "lint:rubyfmt")
    assert_includes(prerequisites, "lint:rbs_format")
  end

  def test_format_runs_ruby_and_rbs_on_the_calling_thread
    # RuboCop's process-wide chdir must not overlap RBS discovery or file I/O.
    source = <<~RUBY
      require "json"
      require "rake"
      load "Rakefile"
      Rake.application.options.thread_pool_size = 2
      calling_thread = Thread.current
      calls = []
      %w[format:rb format:rbs].each do |name|
        task = Rake::Task[name]
        task.clear
        task.enhance do
          calls << [name, Thread.current == calling_thread]
        end
      end
      Rake::Task["format"].invoke
      puts JSON.generate(calls)
    RUBY
    stdout, stderr, status = Open3.capture3("bundle", "exec", "ruby", "-e", source, chdir: ROOT)
    assert(status.success?, "#{stdout}\n#{stderr}")
    assert_equal([["format:rb", true], ["format:rbs", true]], JSON.parse(stdout))
  end
end
