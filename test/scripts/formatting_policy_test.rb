# frozen_string_literal: true

require "minitest/autorun"
require "open3"
require "rubocop"
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
    ].each { assert_includes(enabled, _1) }
    refute_includes(enabled, "Bundler/OrderedGems")
    refute_includes(enabled, "Gemspec/OrderedDependencies")
    assert_equal("disable", config["AllCops"]["NewCops"])

    # A RuboCop upgrade must make an explicit decision about new safety cops.
    RuboCop::ConfigLoader.default_configuration.each do |name, options|
      next unless name.match?(/\A(?:Lint|Security)\//) && options["Enabled"] == "pending"

      assert_includes(enabled, name)
    end
  end

  def test_ruby_formatter_does_not_rewrite_source_during_transition
    Dir.mktmpdir do |directory|
      path = File.join(directory, "example.rb")
      source = "value={hello: 'world'}\n"
      File.write(path, source)
      paths = File.join(directory, "paths")
      File.write(paths, "#{path}\n")

      stdout, stderr, status = Open3.capture3(
        "bundle", "exec", "rake", "format:rb", "FORMAT_FILE=#{paths}", chdir: ROOT
      )

      assert(status.success?, "#{stdout}\n#{stderr}")
      assert_equal(source, File.read(path))
    end
  end
end
