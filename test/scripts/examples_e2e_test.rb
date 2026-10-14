# frozen_string_literal: true

require "minitest/autorun"
require "minitest/mock"
require "open3"
require "pathname"
require "rbconfig"
require "tmpdir"
require "yaml"

require_relative "../../scripts/examples-e2e"

class ExamplesE2EInventoryTest < Minitest::Test
  def test_rejects_non_mapping_manifest_roots
    [nil, [], "invalid"].each do |document|
      with_manifest(document) do |inventory, manifest_path|
        error = assert_raises(OpenAIExamplesE2E::ConfigurationError) { inventory.validate! }

        assert_equal("#{manifest_path}: manifest root must be a mapping", error.message)
      end
    end
  end

  def test_rejects_non_mapping_example_configurations
    [nil, [], "invalid"].each do |configuration|
      document = {
        "version" => 1,
        "examples" => {"examples/example.rb" => configuration}
      }

      with_manifest(document) do |inventory, manifest_path|
        error = assert_raises(OpenAIExamplesE2E::ConfigurationError) { inventory.validate! }

        assert_equal(
          "#{manifest_path}: examples/example.rb: example configuration must be a mapping",
          error.message
        )
      end
    end
  end

  def test_rejects_non_string_exclusion_reasons
    [nil, false, 1, []].each do |reason|
      with_inventory(status: "excluded", reason: reason) do |inventory|
        error = assert_raises(OpenAIExamplesE2E::ConfigurationError) { inventory.validate! }

        assert_includes(error.message, "excluded examples need a non-empty string reason")
      end
    end
  end

  def test_accepts_a_non_empty_string_exclusion_reason
    with_inventory(status: "excluded", reason: "Requires separate credentials.") do |inventory|
      assert_same(inventory, inventory.validate!)
    end
  end

  private

  def with_inventory(status:, reason:)
    document = {
      "version" => 1,
      "examples" => {
        "examples/example.rb" => {"status" => status, "reason" => reason}
      }
    }

    with_manifest(document) { |inventory, _manifest_path| yield(inventory) }
  end

  def with_manifest(document)
    Dir.mktmpdir("openai-examples-e2e-test") do |directory|
      root = Pathname(directory)
      example_path = root.join("examples/example.rb")
      example_path.dirname.mkpath
      example_path.write("# frozen_string_literal: true\n")

      manifest_path = root.join("examples/e2e.yml")
      manifest_path.write(YAML.dump(document))

      inventory = OpenAIExamplesE2E::Inventory.new(root: root, manifest_path: manifest_path)
      yield(inventory, manifest_path)
    end
  end
end

class ExamplesE2EReportSecurityTest < Minitest::Test
  MODEL_RESPONSE = "FAKE_PRIVATE_MODEL_RESPONSE"
  ACCESS_TOKEN = "fake-access-token-example"
  SIGNED_URL = "https://example.test/download?sig=fake-signed-url-secret"
  EXCEPTION_BODY = "FAKE_PRIVATE_EXCEPTION_BODY"

  def test_failed_subprocess_streams_never_enter_report_representations
    with_example(source: sensitive_failing_example) do |root, example|
      result = OpenAIExamplesE2E::Executor.new(root: root, timeout: 5).call(example)
      report = report_for(result)
      serialized_result = report.to_h.fetch(:results).fetch(0)

      refute(result.success)
      assert_equal("example exited with status 7", result.error)
      assert_includes(result.stdout, MODEL_RESPONSE)
      assert_includes(result.stdout, ACCESS_TOKEN)
      assert_includes(result.stdout, SIGNED_URL)
      assert_includes(result.stderr, EXCEPTION_BODY)
      assert_nil(serialized_result.fetch(:stdout))
      assert_nil(serialized_result.fetch(:stderr))
      assert_kind_of(Numeric, serialized_result.fetch(:duration_seconds))
      assert_reports_exclude(report, MODEL_RESPONSE, ACCESS_TOKEN, SIGNED_URL, EXCEPTION_BODY)
    end
  end

  def test_result_constructor_and_report_preserve_legacy_field_contract
    assert_equal(
      %i[path success duration_seconds stdout stderr error],
      OpenAIExamplesE2E::Result.members
    )
    result = OpenAIExamplesE2E::Result.new(
      path: "examples/example.rb",
      success: false,
      duration_seconds: 0.25,
      stdout: MODEL_RESPONSE,
      stderr: SIGNED_URL,
      error: "example exited with status 7"
    )

    assert_equal(MODEL_RESPONSE, result.stdout)
    assert_equal(SIGNED_URL, result.stderr)
    serialized_result = report_for(result).to_h.fetch(:results).fetch(0)
    assert_equal(%i[path successful duration_seconds error stdout stderr], serialized_result.keys)
    assert_nil(serialized_result.fetch(:stdout))
    assert_nil(serialized_result.fetch(:stderr))
    assert_reports_exclude(report_for(result), MODEL_RESPONSE, SIGNED_URL)
  end

  def test_successful_subprocess_streams_never_enter_report_representations
    source = <<~RUBY
      puts #{MODEL_RESPONSE.dump}
      warn #{SIGNED_URL.dump}
    RUBY

    with_example(source: source, expected_output: MODEL_RESPONSE) do |root, example|
      result = OpenAIExamplesE2E::Executor.new(root: root, timeout: 5).call(example)
      report = report_for(result)

      assert(result.success)
      assert_nil(result.error)
      assert_equal("#{MODEL_RESPONSE}\n", result.stdout)
      assert_equal("#{SIGNED_URL}\n", result.stderr)
      assert_reports_exclude(report, MODEL_RESPONSE, SIGNED_URL)
      assert_includes(report.to_markdown, "| `examples/example.rb` | passed |")
    end
  end

  def test_executor_preserves_stream_truncation_without_serializing_output
    output = ("x" * OpenAIExamplesE2E::Executor::MAX_CAPTURED_CHARACTERS) + MODEL_RESPONSE

    with_example(source: "print #{output.dump}\n", expected_output: MODEL_RESPONSE) do |root, example|
      result = OpenAIExamplesE2E::Executor.new(root: root, timeout: 5).call(example)

      assert(result.success)
      assert_match(/\A\.\.\. output truncated \.\.\.\n/, result.stdout)
      assert(result.stdout.end_with?(MODEL_RESPONSE))
      assert_reports_exclude(report_for(result), MODEL_RESPONSE)
    end
  end

  def test_missing_expected_output_never_enters_failure_diagnostics
    with_example(source: "puts 'ordinary output'\n", expected_output: MODEL_RESPONSE) do |root, example|
      result = OpenAIExamplesE2E::Executor.new(root: root, timeout: 5).call(example)

      assert_equal("expected output not found", result.error)
      assert_reports_exclude(report_for(result), MODEL_RESPONSE)
    end
  end

  def test_runner_exception_messages_never_enter_failure_diagnostics
    with_example(source: "puts 'ordinary output'\n") do |root, example|
      failing_path = lambda do |*_arguments|
        raise RuntimeError, "#{EXCEPTION_BODY} #{ACCESS_TOKEN} #{SIGNED_URL}"
      end

      result = root.stub(:join, failing_path) do
        OpenAIExamplesE2E::Executor.new(root: root, timeout: 5).call(example)
      end

      assert_equal("runner error: RuntimeError", result.error)
      assert_reports_exclude(report_for(result), EXCEPTION_BODY, ACCESS_TOKEN, SIGNED_URL)
    end
  end

  def test_output_size_failures_retain_only_structural_diagnostics
    with_example(source: "print #{MODEL_RESPONSE.dump}\n") do |root, example|
      example = example.with(expected_output: nil, minimum_output_bytes: 100)
      result = OpenAIExamplesE2E::Executor.new(root: root, timeout: 5).call(example)

      assert_equal("expected at least 100 output bytes, got #{MODEL_RESPONSE.bytesize}", result.error)
      assert_equal(MODEL_RESPONSE, result.stdout)
      assert_reports_exclude(report_for(result), MODEL_RESPONSE)
    end
  end

  def test_written_reports_and_github_step_summary_exclude_sensitive_output
    with_example(source: sensitive_failing_example) do |root, _example|
      report_directory = root.join("artifacts")
      step_summary = root.join("github-step-summary.md")
      output, error_output, status = run_cli(
        root: root,
        report_directory: report_directory,
        step_summary: step_summary
      )

      assert_equal(1, status.exitstatus, error_output)

      artifact_paths = report_directory.children.sort
      assert_equal(%w[report.json summary.md], artifact_paths.map { _1.basename.to_s })
      [*artifact_paths, step_summary].each do |path|
        [MODEL_RESPONSE, ACCESS_TOKEN, SIGNED_URL, EXCEPTION_BODY].each do |sensitive_value|
          refute_includes(path.read, sensitive_value, "#{path.basename} exposed sensitive example output")
        end
      end

      report = JSON.parse(report_directory.join("report.json").read)
      assert_equal(%w[inventory successful results exclusions], report.keys)
      assert_equal({"covered" => 1, "excluded" => 0, "total" => 1, "percentage" => 100.0}, report["inventory"])
      refute(report["successful"])
      serialized_result = report.fetch("results").fetch(0)
      assert_equal(%w[path successful duration_seconds error stdout stderr], serialized_result.keys)
      assert_equal("example exited with status 7", serialized_result.fetch("error"))
      assert_nil(serialized_result.fetch("stdout"))
      assert_nil(serialized_result.fetch("stderr"))
      assert_includes(output, "FAILED: example exited with status 7")
      [MODEL_RESPONSE, ACCESS_TOKEN, SIGNED_URL, EXCEPTION_BODY].each do |sensitive_value|
        refute_includes(output, sensitive_value, "runner output exposed sensitive example output")
      end
    end
  end

  def test_successful_cli_preserves_exit_status_report_names_and_schema
    with_example(source: "puts 'expected output'\n") do |root, _example|
      report_directory = root.join("artifacts")
      output, error_output, status = run_cli(
        root: root,
        report_directory: report_directory,
        arguments: ["--timeout", "5"]
      )

      assert_equal(0, status.exitstatus, error_output)
      assert_includes(output, "passed")
      assert_equal(%w[report.json summary.md], report_directory.children.sort.map { _1.basename.to_s })
      report = JSON.parse(report_directory.join("report.json").read)
      assert(report.fetch("successful"))
      serialized_result = report.fetch("results").fetch(0)
      assert_equal(%w[path successful duration_seconds error stdout stderr], serialized_result.keys)
      assert_nil(serialized_result.fetch("error"))
      assert_nil(serialized_result.fetch("stdout"))
      assert_nil(serialized_result.fetch("stderr"))
    end
  end

  def test_inventory_only_cli_runs_without_api_key_and_preserves_report_schema
    with_example(source: "puts 'expected output'\n") do |root, _example|
      report_directory = root.join("artifacts")
      output, error_output, status = run_cli(
        root: root,
        report_directory: report_directory,
        arguments: ["--inventory-only"],
        api_key: nil
      )

      assert_equal(0, status.exitstatus, error_output)
      refute_includes(output, "==> examples/example.rb")
      report = JSON.parse(report_directory.join("report.json").read)
      assert_equal(%w[inventory successful results exclusions], report.keys)
      assert_equal([], report.fetch("results"))
      assert(report.fetch("successful"))
      assert_includes(report_directory.join("summary.md").read, "100.00% exercised (1/1 examples)")
    end
  end

  def test_live_cli_without_api_key_preserves_configuration_failure
    with_example(source: "puts 'expected output'\n") do |root, _example|
      report_directory = root.join("artifacts")
      _output, error_output, status = run_cli(root: root, report_directory: report_directory, api_key: nil)

      assert_equal(1, status.exitstatus)
      assert_includes(error_output, "ERROR: OPENAI_API_KEY is required to run live example tests")
      refute(report_directory.exist?)
    end
  end

  def test_invalid_cli_argument_preserves_parse_failure
    with_example(source: "puts 'expected output'\n") do |root, _example|
      report_directory = root.join("artifacts")
      _output, error_output, status = run_cli(
        root: root,
        report_directory: report_directory,
        arguments: ["--unknown-option"]
      )

      assert_equal(1, status.exitstatus)
      assert_includes(error_output, "ERROR: invalid option: --unknown-option")
      refute(report_directory.exist?)
    end
  end

  def test_workflow_uploads_only_allowlisted_report_files
    workflow_path = File.expand_path("../../.github/workflows/examples-e2e.yml", __dir__)
    workflow = YAML.safe_load_file(workflow_path, aliases: false)
    job = workflow.fetch("jobs").fetch("examples-e2e")
    upload_step = job.fetch("steps").find { _1["name"] == "Upload example result reports" }

    assert_equal(
      ["${{ runner.temp }}/examples-e2e/report.json", "${{ runner.temp }}/examples-e2e/summary.md"],
      upload_step.fetch("with").fetch("path").lines.map(&:strip)
    )
    assert_equal("${{ always() }}", upload_step.fetch("if"))
    assert_equal(14, upload_step.fetch("with").fetch("retention-days"))
    job.fetch("steps").filter_map { _1["uses"] }.each do |action|
      assert_match(%r{@[0-9a-f]{40}\z}, action)
    end

    assert_equal({}, workflow.fetch("permissions"))
    assert_equal({"contents" => "read"}, job.fetch("permissions"))
    assert_equal("ci", job.fetch("environment"))
    assert_includes(job.fetch("if"), "github.ref == 'refs/heads/main'")
    assert_includes(job.fetch("if"), "github.repository == 'openai/openai-ruby'")
    assert_equal(false, job.fetch("steps").fetch(0).fetch("with").fetch("persist-credentials"))
  end

  private

  def sensitive_failing_example
    <<~RUBY
      puts "model response: #{MODEL_RESPONSE}"
      puts "Authorization: Bearer #{ACCESS_TOKEN}"
      puts #{SIGNED_URL.dump}
      warn "RuntimeError: #{EXCEPTION_BODY}"
      exit 7
    RUBY
  end

  def with_example(source:, expected_output: "expected output")
    Dir.mktmpdir("openai-examples-e2e-security-test") do |directory|
      root = Pathname(directory)
      example_path = root.join("examples/example.rb")
      example_path.dirname.mkpath
      example_path.write(source)
      root.join("examples/e2e.yml").write(
        YAML.dump(
          "version" => 1,
          "examples" => {
            "examples/example.rb" => {"status" => "covered", "expected_output" => expected_output}
          }
        )
      )

      example = OpenAIExamplesE2E::Example.new(
        path: "examples/example.rb",
        status: "covered",
        expected_output: expected_output,
        minimum_output_bytes: nil,
        reason: nil
      )
      yield(root, example)
    end
  end

  def report_for(result)
    inventory = OpenAIExamplesE2E::InventorySummary.new(
      covered: 1,
      excluded: 0,
      total: 1,
      percentage: 100.0
    )
    OpenAIExamplesE2E::Report.new(inventory: inventory, results: [result], excluded_examples: [])
  end

  def run_cli(root:, report_directory:, arguments: [], step_summary: nil, api_key: "sk-fake-examples-e2e-test")
    runner_path = File.expand_path("../../scripts/examples-e2e.rb", __dir__)
    Open3.capture3(
      {"OPENAI_API_KEY" => api_key, "GITHUB_STEP_SUMMARY" => step_summary&.to_s},
      RbConfig.ruby,
      "-r",
      runner_path,
      "-e",
      "exit(OpenAIExamplesE2E::CLI.new(root: ARGV.shift).run(ARGV))",
      root.to_s,
      "--report-dir",
      report_directory.to_s,
      *arguments
    )
  end

  def assert_reports_exclude(report, *sensitive_values)
    {"JSON" => JSON.generate(report.to_h), "Markdown" => report.to_markdown}.each do |format, contents|
      sensitive_values.each do |sensitive_value|
        refute_includes(contents, sensitive_value, "#{format} report exposed sensitive example output")
      end
    end
  end
end
