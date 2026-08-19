# frozen_string_literal: true

require "minitest/autorun"
require "json"
require "open3"
require "tmpdir"
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

  def test_codeql_has_stable_required_checks_for_actions_and_ruby
    workflow = YAML.safe_load_file(WORKFLOW)
    analyze = workflow.fetch("jobs").fetch("analyze")

    assert_equal("CodeQL (${{ matrix.language }})", analyze.fetch("name"))
    assert_equal(%w[actions ruby], analyze.fetch("strategy").fetch("matrix").fetch("language"))
    assert_includes(workflow.fetch(true), "pull_request")
    assert_includes(workflow.fetch(true), "merge_group")
  end

  def test_codeql_preserves_published_security_results
    workflow = YAML.safe_load_file(WORKFLOW)
    analyze = workflow.fetch("jobs").fetch("analyze")
    step = analyze.fetch("steps").find { _1.fetch("name") == "Perform CodeQL analysis" }

    assert_equal("write", analyze.fetch("permissions").fetch("security-events"))
    assert_equal("analyze", step.fetch("id"))
    assert_equal(
      "${{ runner.temp }}/codeql-results/${{ matrix.language }}",
      step.fetch("with").fetch("output")
    )
    refute_equal("never", step.fetch("with")["upload"])
  end

  def test_findings_gate_accepts_clean_sarif
    output, error, status = run_findings_gate("clean.sarif" => {"runs" => [{"results" => []}]})

    assert(status.success?, "#{output}\n#{error}")
  end

  def test_findings_gate_rejects_missing_sarif
    output, _error, status = run_findings_gate({})

    refute(status.success?)
    assert_includes(output, "CodeQL produced no SARIF results for ruby")
  end

  def test_findings_gate_rejects_invalid_sarif
    ["invalid-json", {"runs" => []}, {"runs" => [{}]}].each do |sarif|
      output, _error, status = run_findings_gate("invalid.sarif" => sarif)

      refute(status.success?, sarif.inspect)
      assert_includes(output, "CodeQL produced invalid SARIF for ruby")
    end
  end

  def test_findings_gate_rejects_findings_in_any_sarif_file
    sarif = {"runs" => [{"results" => [{"ruleId" => "ruby/security", "message" => {"text" => "unsafe"}}]}]}
    output, _error, status = run_findings_gate(
      "clean.sarif" => {"runs" => [{"results" => []}]},
      "findings.sarif" => sarif
    )

    refute(status.success?)
    assert_includes(output, "title=ruby/security::unsafe")
  end

  def test_findings_gate_escapes_github_workflow_commands
    sarif = {
      "runs" => [
        {
          "results" => [
            {
              "ruleId" => "ruby,rule:1\n::warning::injected",
              "message" => {"text" => "first%line\r\n::warning::injected"},
              "locations" => [
                {
                  "physicalLocation" => {
                    "artifactLocation" => {"uri" => "lib/a,b:c%file.rb\r\n::notice::injected"},
                    "region" => {"startLine" => 7}
                  }
                }
              ]
            }
          ]
        }
      ]
    }

    output, _error, status = run_findings_gate("findings.sarif" => sarif)

    refute(status.success?)
    assert_equal(1, output.lines.length)
    assert_includes(output, "file=lib/a%2Cb%3Ac%25file.rb%0D%0A%3A%3Anotice%3A%3Ainjected,line=7")
    assert_includes(output, "title=ruby%2Crule%3A1%0A%3A%3Awarning%3A%3Ainjected")
    assert_includes(output, "::first%25line%0D%0A::warning::injected")
  end

  private

  def run_findings_gate(files)
    workflow = YAML.safe_load_file(WORKFLOW)
    step = workflow.fetch("jobs").fetch("analyze").fetch("steps").find do
      _1.fetch("name") == "Reject CodeQL findings"
    end

    Dir.mktmpdir("openai-codeql-workflow-test") do |directory|
      files.each do |name, sarif|
        content = sarif.is_a?(String) ? sarif : JSON.generate(sarif)
        File.write(File.join(directory, name), content)
      end

      Open3.capture3({"CODEQL_LANGUAGE" => "ruby", "SARIF_DIRECTORY" => directory}, "bash", "-c", step.fetch("run"))
    end
  end
end
