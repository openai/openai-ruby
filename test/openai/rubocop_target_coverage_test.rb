# frozen_string_literal: true

require "open3"

require_relative "test_helper"

class OpenAI::Test::RubocopTargetCoverageTest < Minitest::Test
  def test_inspects_all_first_party_ruby_sources_and_interfaces
    root = File.expand_path("../..", __dir__)
    output, errors, status = Open3.capture3(
      "rubocop",
      "--list-target-files",
      ".",
      "--force-exclusion",
      chdir: root
    )

    assert_predicate(status, :success?, errors)

    targets = output.lines(chomp: true)
    # Discover independently of RuboCop so a new exclusion cannot silently
    # remove generated output, handwritten code, or tooling from the lint gate.
    required_targets = Dir.glob(
      "{lib,rbi,test,examples,scripts}/**/*.{rb,rbi}",
      base: root
    ) +
      Dir.glob("gemfiles/*.gemfile", base: root) +
      %w[
        Gemfile
        Rakefile
        Steepfile
        openai.gemspec
        docs/Gemfile
        scripts/validate-rubocop-directives
        scripts/validate-rbs
        scripts/union-characterization
      ]

    assert_empty(required_targets - targets, "RuboCop skipped required first-party targets")
  end
end
