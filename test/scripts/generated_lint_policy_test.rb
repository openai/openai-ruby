# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "open3"

class GeneratedLintPolicyTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def test_number_conversion_uses_only_the_generated_webhook_exception
    # Config loading can change the process working directory; isolate it from
    # the parallel test suite.
    source = <<~RUBY
      require "json"
      require "rubocop"
      config = RuboCop::ConfigStore.new.for_dir(Dir.pwd)
      puts JSON.generate({
        number_conversion: config.for_cop("Lint/NumberConversion")
      })
    RUBY
    stdout, stderr, status = Open3.capture3("bundle", "exec", "ruby", "-e", source, chdir: ROOT)
    assert(status.success?, "#{stdout}\n#{stderr}")
    config = JSON.parse(stdout)
    assert_equal(true, config.fetch("number_conversion").fetch("Enabled"))
    assert_equal(
      [File.join(ROOT, "lib/openai/resources/webhooks.rb")],
      config.fetch("number_conversion").fetch("Exclude")
    )
  end

  def test_webhook_exception_does_not_exempt_other_generated_or_handwritten_paths
    {
      "lib/openai/resources/webhooks.rb" => 0,
      "lib/openai/resources/models.rb" => 1,
      "lib/openai/helpers/webhooks.rb" => 1
    }.each do |path, expected_offenses|
      stdout, stderr, status = Open3.capture3(
        "bundle",
        "exec",
        "rubocop",
        "--only",
        "Lint/NumberConversion",
        "--force-exclusion",
        "--format",
        "json",
        "--stdin",
        path,
        stdin_data: "value = '123'\nvalue.to_i\n",
        chdir: ROOT
      )
      assert_equal(expected_offenses.zero? ? 0 : 1, status.exitstatus, "#{stdout}\n#{stderr}")
      assert_equal(expected_offenses, JSON.parse(stdout).fetch("summary").fetch("offense_count"))
    end
  end
end
