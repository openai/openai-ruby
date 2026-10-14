# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "open3"
require "yaml"

class NextReleaseWorkflowTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def test_next_cannot_create_or_retry_a_release
    %w[push workflow_dispatch].each do |event|
      %w[false true].each do |retry_publish|
        %w[false true].each do |releases_created|
          actual = evaluate("next", event: event, retry_publish: retry_publish, releases_created: releases_created)

          assert_equal({"release" => false, "publish" => false}, actual)
        end
      end
    end
  end

  def test_next_push_runs_ci
    workflow = YAML.safe_load_file(File.join(ROOT, ".github/workflows/ci.yml"))
    # Keep the trigger contract explicit: CI runs on pushes, not manual dispatch.
    assert_equal(
      ["**", "!gh-readonly-queue/**", "!integrated/**"],
      workflow.fetch(true).fetch("push").fetch("branches")
    )
    refute(workflow.fetch(true).key?("workflow_dispatch"))
    condition = workflow.fetch("jobs").fetch("checks").fetch("if")
    assert(evaluate("next", conditions: {ci: condition}).fetch("ci"))
  end

  def test_main_can_create_publish_and_retry_releases
    assert_equal({"release" => true, "publish" => false}, evaluate("main"))
    assert_equal(
      {"release" => true, "publish" => true},
      evaluate("main", releases_created: "true")
    )
    assert_equal(
      {"release" => false, "publish" => true},
      evaluate("main", event: "workflow_dispatch", retry_publish: "true")
    )
  end

  def test_forks_and_other_branches_cannot_publish
    %w[main next feature].each do |branch|
      result = evaluate(branch, repository: "example/openai-ruby", retry_publish: "true", releases_created: "true")
      refute(result.fetch("release"))
      refute(result.fetch("publish"))
    end

    result = evaluate("feature", retry_publish: "true", releases_created: "true")
    refute(result.fetch("release"))
    refute(result.fetch("publish"))
    refute(evaluate("main", releases_created: "true", cancelled: true).fetch("publish"))
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

  def evaluate(
    branch,
    event: "push",
    retry_publish: "false",
    releases_created: "false",
    repository: "openai/openai-ruby",
    cancelled: false,
    conditions: nil
  )
    jobs = release_workflow.fetch("jobs")
    payload = {
      conditions: conditions ||
        {
          release: jobs.fetch("release").fetch("if"),
          publish: jobs.fetch("publish").fetch("if")
        },
      github: {
        ref: "refs/heads/#{branch}",
        repository: repository,
        event_name: event,
        event: {inputs: {retry_publish: retry_publish}}
      },
      needs: {release: {outputs: {releases_created: releases_created}}},
      cancelled: cancelled
    }
    # These workflow predicates use JS-compatible boolean/comparison syntax.
    # Evaluate the actual predicates; this is not a general Actions interpreter.
    script = <<~JS
      const input = JSON.parse(require("node:fs").readFileSync(0, "utf8"));
      const result = Object.fromEntries(Object.entries(input.conditions).map(([name, condition]) => {
        const evaluate = new Function("github", "needs", "cancelled", `return Boolean(${condition});`);
        return [name, evaluate(input.github, input.needs, () => input.cancelled)];
      }));
      process.stdout.write(JSON.stringify(result));
    JS
    stdout, stderr, status = Open3.capture3("node", "-e", script, stdin_data: JSON.generate(payload))
    assert(status.success?, stderr)
    JSON.parse(stdout)
  end
end
