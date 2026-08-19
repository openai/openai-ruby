# frozen_string_literal: true

require "minitest/autorun"
require "yaml"

class CodeQLWorkflowTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)
  WORKFLOW = File.join(ROOT, ".github/workflows/codeql.yml")
  ACTIONS = %w[github/codeql-action/init github/codeql-action/analyze].freeze

  def test_codeql_actions_use_the_same_pinned_release
    uses = File.read(WORKFLOW).scan(
      %r{^\s*uses:\s+(github/codeql-action/(?:init|analyze))@([0-9a-f]{40})\s+#\s+(v\d+\.\d+\.\d+)\s*$}
    )

    assert_equal(ACTIONS, uses.map(&:first))
    assert_equal(1, uses.map { _1.fetch(1) }.uniq.length, "CodeQL actions must use the same commit")
    assert_equal(1, uses.map { _1.fetch(2) }.uniq.length, "CodeQL actions must use the same release")
  end

  def test_dependabot_groups_every_codeql_sub_action
    dependabot = YAML.safe_load_file(File.join(ROOT, ".github/dependabot.yml"))
    updates = dependabot.fetch("updates").find { _1.fetch("package-ecosystem") == "github-actions" }
    patterns = updates.fetch("groups").fetch("codeql").fetch("patterns")

    ACTIONS.each do |action|
      assert(patterns.any? { File.fnmatch?(_1, action) }, "Dependabot does not group #{action}")
    end
  end
end
