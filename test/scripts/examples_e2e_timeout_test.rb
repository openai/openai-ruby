# frozen_string_literal: true

require "minitest/autorun"
require "minitest/mock"
require "open3"
require "pathname"
require "rbconfig"
require "stringio"
require "tmpdir"
require "yaml"

require_relative "../../scripts/examples-e2e"

class ExamplesE2ETimeoutTest < Minitest::Test
  def test_rejects_invalid_effective_environment_timeouts_before_runner_or_report
    ["0", "-1", "", "not-a-number"].each do |timeout|
      with_cli(timeout: timeout) do |cli, report_directory, error_output|
        runner_started = false
        factory = lambda do |**_options|
          runner_started = true
        end

        status = OpenAIExamplesE2E::Runner.stub(:new, factory) { cli.run([]) }

        assert_equal(1, status, "timeout #{timeout.inspect}")
        refute(runner_started, "timeout #{timeout.inspect} constructed a runner")
        assert_includes(error_output.string, "positive integer")
        refute(report_directory.exist?)
      end
    end
  end

  def test_rejects_non_positive_cli_timeouts_before_runner_or_report
    ["0", "-1"].each do |timeout|
      with_cli do |cli, report_directory, error_output|
        runner_started = false
        factory = lambda do |**_options|
          runner_started = true
        end

        status = OpenAIExamplesE2E::Runner.stub(:new, factory) do
          cli.run(["--timeout", timeout])
        end

        assert_equal(1, status, "timeout #{timeout.inspect}")
        refute(runner_started, "timeout #{timeout.inspect} constructed a runner")
        assert_includes(error_output.string, "positive integer")
        refute(report_directory.exist?)
      end
    end
  end

  def test_preserves_option_parser_diagnostic_for_malformed_cli_timeout
    with_cli do |cli, report_directory, error_output|
      runner_started = false
      factory = lambda do |**_options|
        runner_started = true
      end

      status = OpenAIExamplesE2E::Runner.stub(:new, factory) do
        cli.run(["--timeout", "not-a-number"])
      end

      assert_equal(1, status)
      refute(runner_started)
      assert_includes(error_output.string, "invalid argument: --timeout not-a-number")
      refute(report_directory.exist?)
    end
  end

  def test_executable_argument_path_handles_invalid_environment_timeout
    with_cli(timeout: "not-a-number") do |_cli, report_directory, _error_output, root|
      runner_path = File.expand_path("../../scripts/examples-e2e.rb", __dir__)
      _output, error_output, status = Open3.capture3(
        {
          "EXAMPLES_E2E_REPORT_DIR" => report_directory.to_s,
          "EXAMPLES_E2E_TIMEOUT" => "not-a-number",
          "OPENAI_API_KEY" => "sk-fake-timeout-test"
        },
        RbConfig.ruby,
        "-r",
        runner_path,
        "-e",
        "exit(OpenAIExamplesE2E::CLI.new(root: ARGV.shift).run(ARGV))",
        root.to_s,
        "--inventory-only"
      )

      assert_equal(1, status.exitstatus)
      assert_includes(error_output, "ERROR: timeout must be a positive integer number of seconds")
      refute(report_directory.exist?)
    end
  end

  def test_uses_default_positive_timeout
    assert_runner_timeout(180)
  end

  def test_uses_positive_environment_timeout
    assert_runner_timeout(7, timeout: "7")
  end

  def test_valid_explicit_timeout_overrides_invalid_environment_default
    assert_runner_timeout(5, timeout: "not-a-number", arguments: ["--timeout", "5"])
  end

  def test_inventory_only_preserves_valid_behavior_without_constructing_runner
    with_cli(api_key: nil) do |cli, report_directory, error_output|
      runner_started = false
      factory = lambda do |**_options|
        runner_started = true
      end

      status = OpenAIExamplesE2E::Runner.stub(:new, factory) { cli.run(["--inventory-only"]) }

      assert_equal(0, status, error_output.string)
      refute(runner_started)
      assert(report_directory.join("report.json").exist?)
    end
  end

  private

  def assert_runner_timeout(expected_timeout, timeout: nil, arguments: [])
    with_cli(timeout: timeout) do |cli, report_directory, error_output|
      captured_timeout = nil
      runner = Minitest::Mock.new
      runner.expect(:run, empty_report)
      factory = lambda do |**options|
        captured_timeout = options.fetch(:timeout)
        runner
      end

      status = OpenAIExamplesE2E::Runner.stub(:new, factory) { cli.run(arguments) }

      assert_equal(0, status, error_output.string)
      assert_equal(expected_timeout, captured_timeout)
      assert(report_directory.join("report.json").exist?)
      runner.verify
    end
  end

  def with_cli(timeout: nil, api_key: "sk-fake-timeout-test")
    Dir.mktmpdir("openai-examples-e2e-timeout-test") do |directory|
      root = Pathname(directory)
      example_path = root.join("examples/example.rb")
      example_path.dirname.mkpath
      example_path.write("# frozen_string_literal: true\n")
      root.join("examples/e2e.yml").write(
        YAML.dump(
          "version" => 1,
          "examples" => {
            "examples/example.rb" => {"status" => "covered", "expected_output" => "synthetic"}
          }
        )
      )
      report_directory = root.join("artifacts")
      output = StringIO.new
      error_output = StringIO.new
      cli = OpenAIExamplesE2E::CLI.new(root: root, output: output, error_output: error_output)

      with_environment(
        "EXAMPLES_E2E_TIMEOUT" => timeout,
        "EXAMPLES_E2E_REPORT_DIR" => report_directory.to_s,
        "OPENAI_API_KEY" => api_key
      ) do
        yield(cli, report_directory, error_output, root)
      end
    end
  end

  def empty_report
    inventory = OpenAIExamplesE2E::InventorySummary.new(
      covered: 1,
      excluded: 0,
      total: 1,
      percentage: 100.0
    )
    OpenAIExamplesE2E::Report.new(inventory: inventory, results: [], excluded_examples: [])
  end

  def with_environment(values)
    previous = values.to_h { |name, _value| [name, ENV[name]] }
    values.each { |name, value| ENV[name] = value }
    yield
  ensure
    previous.each { |name, value| ENV[name] = value }
  end
end
