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
    Dir.mktmpdir do |directory|
      path = File.join(directory, "example with spaces.rb")
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
      test/openai/internal/type/base_model_test.rb
    ].each do |path|
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

  def test_rubyfmt_covers_the_same_sources_as_rubocop_except_rbi
    # RuboCop changes directory while loading config. Keep discovery outside
    # the parallel test process so it cannot race another test's chdir block.
    source = <<~RUBY
      require "json"
      require_relative "scripts/rubyfmt_policy"
      puts JSON.generate({
        paths: RubyfmtPolicy.paths,
        expected: RuboCopDirectiveGuard.rubocop_target_paths.reject { _1.end_with?(".rbi") },
        steepfile: RubyfmtPolicy.paths(["Steepfile"]),
        empty: RubyfmtPolicy.paths([]),
        exemptions: RubyfmtPolicy.violations(RubyfmtPolicy.paths)
      })
    RUBY
    stdout, stderr, status = Open3.capture3("bundle", "exec", "ruby", "-e", source, chdir: ROOT)
    assert(status.success?, "#{stdout}\n#{stderr}")
    result = JSON.parse(stdout)
    assert_equal(result.fetch("expected"), result.fetch("paths"))
    assert_includes(result.fetch("paths").map { File.basename(_1) }, "Steepfile")
    assert_equal([File.join(ROOT, "Steepfile")], result.fetch("steepfile"))
    assert_empty(result.fetch("empty"))
    assert_empty(result.fetch("exemptions"))
  end

  def test_lint_rejects_native_exemptions
    Dir.mktmpdir do |directory|
      path = File.join(directory, "example.rb")
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
end
