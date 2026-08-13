# frozen_string_literal: true

require "open3"

require_relative "test_helper"

class OpenAI::Test::RubocopTargetCoverageTest < Minitest::Test
  def test_inspects_ruby_interfaces_and_root_ruby_files
    output, errors, status = Open3.capture3(
      "rubocop",
      "--list-target-files",
      ".",
      "--force-exclusion",
      chdir: File.expand_path("../..", __dir__)
    )

    assert_predicate(status, :success?, errors)

    targets = output.lines(chomp: true)
    required_targets = %w[rbi/openai/client.rbi rbi/openai/models.rbi Rakefile openai.gemspec]

    assert_empty(required_targets - targets, "RuboCop skipped required first-party targets")
  end
end
