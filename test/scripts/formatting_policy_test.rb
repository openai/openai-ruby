# frozen_string_literal: true

require "minitest/autorun"
require "open3"
require "rubocop"
require "tmpdir"

class FormattingPolicyTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def test_rubocop_only_enables_correctness_and_security_checks
    config = RuboCop::ConfigStore.new.for_dir(ROOT)
    enabled = RuboCop::Cop::Registry.global.select do |cop|
      config.for_cop(cop)["Enabled"] == true
    end

    assert_equal(%w[Lint Security], enabled.map { _1.department.to_s }.uniq.sort)
    assert(config.for_cop("Lint/Syntax")["Enabled"])
    assert(config.for_cop("Security/Eval")["Enabled"])
    assert_equal("disable", config["AllCops"]["NewCops"])
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
