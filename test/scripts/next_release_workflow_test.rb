# frozen_string_literal: true

require "minitest/autorun"
require "yaml"

class NextReleaseWorkflowTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)
  # Enforce the reviewed expressions verbatim, without interpreting Actions as JS.
  # Actions compares strings case-insensitively, including refs and retry inputs:
  # https://docs.github.com/en/actions/reference/workflows-and-actions/expressions#operators
  RELEASE_CONDITIONS = {
    "release" => "github.ref == 'refs/heads/main' && " \
      "github.repository == 'openai/openai-ruby' && " \
      "github.event.inputs.retry_publish != 'true'",
    "publish" => "!cancelled() && " \
      "github.ref == 'refs/heads/main' && " \
      "github.repository == 'openai/openai-ruby' && " \
      "(needs.release.outputs.releases_created == 'true' || " \
      "github.event.inputs.retry_publish == 'true')"
  }.freeze

  def test_release_jobs_retain_the_canonical_gates
    assert_equal(RELEASE_CONDITIONS, release_conditions(release_workflow))
  end

  def test_canonical_gates_reject_mixed_case_branch_allowances
    %w[release publish].each do |job_name|
      %w[next Next NEXT].each do |branch|
        workflow = release_workflow
        job = workflow.fetch("jobs").fetch(job_name)
        job["if"] = "(#{job.fetch("if")}) || github.ref == 'refs/heads/#{branch}'"

        refute_equal(RELEASE_CONDITIONS, release_conditions(workflow))

        job["if"] = RELEASE_CONDITIONS.fetch(job_name).sub(
          "github.ref == 'refs/heads/main'",
          "(github.ref == 'refs/heads/main' || github.ref == 'refs/heads/#{branch}')"
        )
        refute_equal(RELEASE_CONDITIONS, release_conditions(workflow))
      end
    end
  end

  def test_canonical_gates_do_not_normalize_literal_case
    # Even equivalent Actions expressions need an explicit contract update.
    # In particular, a Main literal must not silently become a JS-only assertion.
    %w[release publish].each do |job_name|
      workflow = release_workflow
      job = workflow.fetch("jobs").fetch(job_name)
      job["if"] = job.fetch("if").sub("refs/heads/main", "refs/heads/Main")

      refute_equal(RELEASE_CONDITIONS, release_conditions(workflow))
    end
  end

  def test_ci_retains_push_triggers_and_the_canonical_next_gate
    workflow = YAML.safe_load_file(File.join(ROOT, ".github/workflows/ci.yml"))
    assert_equal(
      ["**", "!gh-readonly-queue/**", "!integrated/**"],
      workflow.fetch(true).fetch("push").fetch("branches")
    )
    refute(workflow.fetch(true).key?("workflow_dispatch"))
    assert_equal(
      "github.event_name == 'pull_request' || " \
        "github.event_name == 'merge_group' || " \
        "github.ref == 'refs/heads/main' || github.ref == 'refs/heads/next'",
      workflow.fetch("jobs").fetch("checks").fetch("if").strip
    )
  end

  def test_release_trigger_target_and_environments_stay_on_the_stable_path
    workflow = release_workflow
    assert_equal(["main"], workflow.fetch(true).fetch("push").fetch("branches"))
    jobs = workflow.fetch("jobs")
    release_please = jobs.fetch("release").fetch("steps").find { _1["id"] == "release" }

    assert_equal("main", release_please.fetch("with").fetch("target-branch"))
    assert_equal("release", jobs.fetch("release").fetch("environment"))
    assert_equal("publish", jobs.fetch("publish").fetch("environment"))
    assert_equal("write", jobs.fetch("publish").fetch("permissions").fetch("id-token"))
    assert_empty(jobs.fetch("release").fetch("permissions"))
  end

  private

  def release_workflow = YAML.safe_load_file(File.join(ROOT, ".github/workflows/create-releases.yml"))

  def release_conditions(workflow)
    # Ignore line wrapping/indentation only. Preserve operators, literal case
    # and whitespace inside each line; this is an exact contract, not an evaluator.
    %w[release publish].to_h do |name|
      condition = workflow.fetch("jobs").fetch(name).fetch("if")
      [name, condition.lines.map(&:strip).join(" ")]
    end
  end
end
