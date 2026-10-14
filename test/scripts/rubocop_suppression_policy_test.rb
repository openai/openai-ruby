# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "open3"

class RuboCopSuppressionPolicyTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def test_rejects_stale_safety_and_retired_formatting_suppressions
    %w[Lint/EmptyBlock Metrics/BlockLength Style/CaseEquality].each do |cop|
      assert_equal(
        ["Lint/RedundantCopDisableDirective"],
        offenses_for("# rubocop:disable #{cop}\nputs(:ok)\n# rubocop:enable #{cop}\n", exitstatus: 1)
      )
    end
  end

  def test_preserves_a_necessary_narrow_suppression
    source = <<~RUBY
      # rubocop:disable Lint/EmptyBlock -- exercise a consumer with no callback work
      [1].each { |value| }
      # rubocop:enable Lint/EmptyBlock
    RUBY
    assert_empty(offenses_for(source, exitstatus: 0))
  end

  def test_empty_block_is_rejected_without_its_suppression
    assert_equal(["Lint/EmptyBlock"], offenses_for("[1].each { |value| }\n", exitstatus: 1))
  end

  def test_rejects_unmatched_enable_directives
    assert_equal(
      ["Lint/RedundantCopEnableDirective"],
      offenses_for("puts(:ok)\n# rubocop:enable Lint/EmptyBlock\n", exitstatus: 1)
    )
  end

  private

  def offenses_for(source, exitstatus:)
    # Run the actual policy: --only would change which suppressions are needed.
    stdout, stderr, status = Open3.capture3(
      "bundle",
      "exec",
      "rubocop",
      "--force-exclusion",
      "--format",
      "json",
      "--stdin",
      "lib/openai/helpers/suppression_policy_probe.rb",
      stdin_data: "# frozen_string_literal: true\n#{source}",
      chdir: ROOT
    )
    assert_equal(exitstatus, status.exitstatus, "#{stdout}\n#{stderr}")
    result = JSON.parse(stdout)
    assert_equal(1, result.fetch("summary").fetch("inspected_file_count"))
    result.fetch("files").flat_map { |file| file.fetch("offenses").map { _1.fetch("cop_name") } }
  end
end
