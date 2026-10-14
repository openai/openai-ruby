#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "open3"
require "optparse"
require "pathname"
require "rbconfig"
require "tmpdir"
require "yaml"

module OpenAIExamplesE2E
  class ConfigurationError < StandardError
  end

  Example = Data.define(:path, :status, :expected_output, :minimum_output_bytes, :reason)
  InventorySummary = Data.define(:covered, :excluded, :total, :percentage)
  Result = Data.define(:path, :success, :duration_seconds, :stdout, :stderr, :error)

  class Report
    attr_reader :inventory, :results, :excluded_examples

    def initialize(inventory:, results:, excluded_examples:)
      @inventory = inventory
      @results = results
      @excluded_examples = excluded_examples
    end

    def success? = results.all?(&:success)

    def to_h
      {
        inventory: {
          covered: inventory.covered,
          excluded: inventory.excluded,
          total: inventory.total,
          percentage: inventory.percentage
        },
        successful: success?,
        results: results.map do |result|
          {
            path: result.path,
            successful: result.success,
            duration_seconds: result.duration_seconds,
            error: result.error,
            stdout: nil,
            stderr: nil
          }
        end,
        exclusions: excluded_examples.to_h { [_1.path, _1.reason] }
      }
    end

    def to_markdown
      lines = [
        "# Ruby examples end-to-end results",
        "",
        format(
          "**%<percentage>.2f%% exercised (%<covered>d/%<total>d examples); " \
            "%<excluded>d explicitly excluded.**",
          percentage: inventory.percentage,
          covered: inventory.covered,
          total: inventory.total,
          excluded: inventory.excluded
        ),
        ""
      ]

      unless results.empty?
        lines.push(
          "## Live results",
          "",
          "| Example | Result | Duration |",
          "| --- | --- | ---: |"
        )
        results.each do |result|
          outcome = result.success ? "passed" : "failed: #{escape_markdown(result.error)}"
          lines << "| `#{result.path}` | #{outcome} | #{format("%.2fs", result.duration_seconds)} |"
        end

        lines << ""
      end

      unless excluded_examples.empty?
        lines.push("## Explicit exclusions", "")
        excluded_examples.each do |example|
          lines << "- `#{example.path}` — #{example.reason}"
        end

        lines << ""
      end

      lines.join("\n")
    end

    private

    def escape_markdown(value)
      value.to_s.gsub(/[\\|]/) { "\\#{_1}" }.gsub("\n", " ")
    end
  end

  class Inventory
    VALID_STATUSES = %w[covered excluded].freeze

    attr_reader :root, :manifest_path

    def initialize(root:, manifest_path:)
      @root = Pathname(root).expand_path
      @manifest_path = Pathname(manifest_path).expand_path
    end

    def validate!
      errors = []
      errors << "manifest version must be 1" unless document["version"] == 1

      missing = discovered_paths - configured_paths
      stale = configured_paths - discovered_paths
      errors << "unclassified examples: #{missing.join(", ")}" unless missing.empty?
      errors << "manifest entries without files: #{stale.join(", ")}" unless stale.empty?

      examples.each do |example|
        unless VALID_STATUSES.include?(example.status)
          errors << "#{example.path}: status must be one of #{VALID_STATUSES.join(", ")}"
          next
        end

        if example.status == "covered"
          has_expected_output = example.expected_output.is_a?(String) && !example.expected_output.empty?
          has_minimum_output = example.minimum_output_bytes.is_a?(Integer) && example.minimum_output_bytes.positive?
          if !example.expected_output.nil? && !has_expected_output
            errors << "#{example.path}: expected_output must be a non-empty string"
          elsif !example.minimum_output_bytes.nil? && !has_minimum_output
            errors << "#{example.path}: minimum_output_bytes must be a positive integer"
          elsif !has_expected_output && !has_minimum_output
            errors << "#{example.path}: covered examples need expected_output or minimum_output_bytes"
          end
        elsif !example.reason.is_a?(String) || example.reason.empty?
          errors << "#{example.path}: excluded examples need a non-empty string reason"
        end
      end

      raise ConfigurationError, errors.join("\n") unless errors.empty?
      self
    end

    def examples
      configured_examples.sort.map do |path, config|
        Example.new(
          path: path,
          status: config["status"],
          expected_output: config["expected_output"],
          minimum_output_bytes: config["minimum_output_bytes"],
          reason: config["reason"]
        )
      end
    end

    def covered_examples = examples.select { _1.status == "covered" }
    def excluded_examples = examples.select { _1.status == "excluded" }

    def summary
      total = discovered_paths.length
      covered = covered_examples.length
      percentage = total.zero? ? 100.0 : covered.fdiv(total) * 100
      InventorySummary.new(
        covered: covered,
        excluded: total - covered,
        total: total,
        percentage: percentage.round(2)
      )
    end

    private

    def document
      @document ||= YAML.safe_load_file(manifest_path, aliases: false).tap do |value|
        unless value.is_a?(Hash)
          raise ConfigurationError, "#{manifest_path}: manifest root must be a mapping"
        end
      end

    rescue Errno::ENOENT
      raise ConfigurationError, "example E2E manifest not found: #{manifest_path}"
    end

    def configured_examples
      value = document["examples"]
      unless value.is_a?(Hash)
        raise ConfigurationError, "#{manifest_path}: manifest examples must be a mapping"
      end

      value.each do |path, configuration|
        next if configuration.is_a?(Hash)

        raise(
          ConfigurationError,
          "#{manifest_path}: #{path}: example configuration must be a mapping"
        )
      end

      value
    end

    def configured_paths = configured_examples.keys.sort

    def discovered_paths
      @discovered_paths ||= root.glob("examples/**/*.rb").map { _1.relative_path_from(root).to_s }.sort
    end
  end

  class Executor
    MAX_CAPTURED_CHARACTERS = 12_000

    def initialize(root:, timeout:)
      @root = root
      @timeout = timeout
    end

    def call(example)
      started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      stdout_value = ""
      stderr_value = ""
      status = nil
      timed_out = false
      example_path = @root.join(example.path).to_s

      Dir.mktmpdir("openai-ruby-example-e2e") do |working_directory|
        Open3.popen3(
          RbConfig.ruby,
          example_path,
          chdir: working_directory
        ) do |stdin, stdout, stderr, wait_thread|
          stdin.close
          stdout_reader = Thread.new { stdout.read }
          stderr_reader = Thread.new { stderr.read }

          timed_out = wait_thread.join(@timeout).nil?
          terminate(wait_thread) if timed_out
          status = wait_thread.value
          stdout_value = stdout_reader.value
          stderr_value = stderr_reader.value
        end
      end

      duration = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at
      error = execution_error(example, status, timed_out, stdout_value)
      Result.new(
        path: example.path,
        success: error.nil?,
        duration_seconds: duration.round(2),
        stdout: truncate(stdout_value),
        stderr: truncate(stderr_value),
        error: error
      )
    rescue StandardError => e
      duration = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at
      Result.new(
        path: example.path,
        success: false,
        duration_seconds: duration.round(2),
        stdout: truncate(stdout_value),
        stderr: truncate(stderr_value),
        error: "runner error: #{e.class}"
      )
    end

    private

    def terminate(wait_thread)
      Process.kill("TERM", wait_thread.pid)
      return if wait_thread.join(2)

      Process.kill("KILL", wait_thread.pid)
      wait_thread.join
    rescue Errno::ESRCH, Errno::ECHILD
      nil
    end

    def execution_error(example, status, timed_out, output)
      return "example timed out after #{@timeout} seconds" if timed_out
      return "example exited with status #{status.exitstatus}" unless status.success?
      if example.expected_output && !output.include?(example.expected_output)
        return "expected output not found"
      end

      if example.minimum_output_bytes && output.bytesize < example.minimum_output_bytes
        return "expected at least #{example.minimum_output_bytes} output bytes, got #{output.bytesize}"
      end

      nil
    end

    def truncate(value)
      return value if value.length <= MAX_CAPTURED_CHARACTERS

      "... output truncated ...\n#{value[-MAX_CAPTURED_CHARACTERS, MAX_CAPTURED_CHARACTERS]}"
    end
  end

  class Runner
    def initialize(inventory:, timeout:, output: $stdout)
      @inventory = inventory
      @output = output
      @executor = Executor.new(root: inventory.root, timeout: timeout)
    end

    def run
      @inventory.validate!
      results = @inventory.covered_examples.map do |example|
        @output.puts("==> #{example.path}")
        result = @executor.call(example)
        message = result.success ? "    passed (#{result.duration_seconds}s)" : "    FAILED: #{result.error}"
        @output.puts(message)
        result
      end

      Report.new(
        inventory: @inventory.summary,
        results: results,
        excluded_examples: @inventory.excluded_examples
      )
    end
  end

  class CLI
    DEFAULT_TIMEOUT = 180

    def initialize(root: Pathname(__dir__).parent, output: $stdout, error_output: $stderr)
      @root = Pathname(root).expand_path
      @output = output
      @error_output = error_output
    end

    def run(arguments)
      options = parse_options(arguments)
      inventory = Inventory.new(root: @root, manifest_path: @root.join("examples/e2e.yml"))
      inventory.validate!
      ensure_api_key! unless options[:inventory_only]

      report = if options[:inventory_only]
        Report.new(
          inventory: inventory.summary,
          results: [],
          excluded_examples: inventory.excluded_examples
        )
      else
        Runner.new(inventory: inventory, timeout: options[:timeout], output: @output).run
      end

      write_report(report, options[:report_dir])
      report.success? ? 0 : 1
    rescue ConfigurationError, OptionParser::ParseError => e
      @error_output.puts("ERROR: #{e.message}")
      1
    end

    private

    def parse_options(arguments)
      options = {
        inventory_only: false,
        report_dir: Pathname(ENV.fetch("EXAMPLES_E2E_REPORT_DIR", @root.join("tmp/examples-e2e").to_s)),
        timeout: nil
      }
      OptionParser
        .new do |parser|
          parser.banner = "Usage: scripts/examples-e2e.rb [options]"
          parser.on("--inventory-only", "Validate the example inventory without running examples") do
            options[:inventory_only] = true
          end

          parser.on("--report-dir PATH", String, "Directory for JSON and Markdown reports") do |path|
            options[:report_dir] = Pathname(path)
          end

          parser.on(
            "--timeout SECONDS",
            Integer,
            "Per-example timeout (default: #{DEFAULT_TIMEOUT})"
          ) do |seconds|
            options[:timeout] = seconds
          end
        end
        .parse!(arguments)
      options[:timeout] = effective_timeout(options[:timeout])
      options
    end

    def effective_timeout(explicit_timeout)
      timeout = explicit_timeout.nil? ? environment_timeout : explicit_timeout
      return timeout if timeout.positive?

      raise ConfigurationError, "timeout must be a positive integer number of seconds"
    end

    def environment_timeout
      Integer(ENV.fetch("EXAMPLES_E2E_TIMEOUT", DEFAULT_TIMEOUT.to_s), 10)
    rescue ArgumentError
      raise ConfigurationError, "timeout must be a positive integer number of seconds"
    end

    def ensure_api_key!
      return unless ENV.fetch("OPENAI_API_KEY", "").empty?

      raise ConfigurationError, "OPENAI_API_KEY is required to run live example tests"
    end

    def write_report(report, report_dir)
      report_dir.mkpath
      report_dir.join("report.json").write("#{JSON.pretty_generate(report.to_h)}\n")
      markdown = "#{report.to_markdown}\n"
      report_dir.join("summary.md").write(markdown)

      step_summary = ENV["GITHUB_STEP_SUMMARY"]
      File.open(step_summary, "a") { _1.write(markdown) } if step_summary && !step_summary.empty?
      @output.puts(report.to_markdown)
    end
  end
end

exit(OpenAIExamplesE2E::CLI.new.run(ARGV)) if $PROGRAM_NAME == __FILE__
