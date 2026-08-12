# frozen_string_literal: true

require "fileutils"
require "pathname"
require "stringio"
require "tmpdir"

require_relative "../../scripts/examples-e2e"
require_relative "../openai/test_helper"

class OpenAI::Test::ExamplesE2ETest < Minitest::Test
  def setup
    super
    @root = Pathname(Dir.mktmpdir("openai-ruby-examples-e2e-test"))
    @examples_dir = @root.join("examples")
    @examples_dir.mkpath
    @manifest_path = @examples_dir.join("e2e.yml")
  end

  def teardown
    FileUtils.remove_entry(@root)
    super
  end

  def test_inventory_requires_every_example_to_be_classified
    write_example("covered.rb", "puts(\"covered\")")
    write_example("missing.rb", "puts(\"missing\")")
    write_manifest(
      {"examples/covered.rb" => {"status" => "covered", "expected_output" => "covered"}}
    )

    error = assert_raises(OpenAIExamplesE2E::ConfigurationError) do
      inventory.validate!
    end

    assert_includes(error.message, "examples/missing.rb")
  end

  def test_inventory_rejects_stale_manifest_entries
    write_example("covered.rb", "puts(\"covered\")")
    write_manifest(
      {
        "examples/covered.rb" => {"status" => "covered", "expected_output" => "covered"},
        "examples/removed.rb" => {"status" => "excluded", "reason" => "No longer present"}
      }
    )

    error = assert_raises(OpenAIExamplesE2E::ConfigurationError) do
      inventory.validate!
    end

    assert_includes(error.message, "examples/removed.rb")
  end

  def test_runner_executes_covered_examples_and_skips_exclusions
    write_example("passing.rb", "puts(\"request completed\")")
    write_example("excluded.rb", "raise(\"must not run\")")
    write_manifest(
      {
        "examples/passing.rb" => {"status" => "covered", "expected_output" => "request completed"},
        "examples/excluded.rb" => {"status" => "excluded", "reason" => "Needs another credential"}
      }
    )

    report = OpenAIExamplesE2E::Runner.new(inventory: inventory, timeout: 5, output: StringIO.new).run

    assert(report.success?)
    assert_equal(["examples/passing.rb"], report.results.map(&:path))
    assert_equal(1, report.inventory.covered)
    assert_equal(2, report.inventory.total)
    assert_in_delta(50.0, report.inventory.percentage)
  end

  def test_runner_fails_when_expected_output_is_missing
    write_example("wrong_output.rb", "puts(\"unexpected\")")
    write_manifest(
      {"examples/wrong_output.rb" => {"status" => "covered", "expected_output" => "request completed"}}
    )

    report = OpenAIExamplesE2E::Runner.new(inventory: inventory, timeout: 5, output: StringIO.new).run

    refute(report.success?)
    assert_equal("expected output not found: request completed", report.results.first.error)
  end

  def test_runner_fails_when_an_example_exits_unsuccessfully
    write_example("failing.rb", "warn(\"API failed\")\nexit(2)")
    write_manifest(
      {"examples/failing.rb" => {"status" => "covered", "expected_output" => "never printed"}}
    )

    report = OpenAIExamplesE2E::Runner.new(inventory: inventory, timeout: 5, output: StringIO.new).run

    refute(report.success?)
    assert_equal("example exited with status 2", report.results.first.error)
    assert_includes(report.results.first.stderr, "API failed")
  end

  def test_inventory_only_cli_writes_json_and_markdown_reports_without_an_api_key
    write_example("covered.rb", "puts(\"covered\")")
    write_manifest(
      {"examples/covered.rb" => {"status" => "covered", "expected_output" => "covered"}}
    )
    report_dir = @root.join("reports")
    output = StringIO.new
    error_output = StringIO.new

    status = OpenAIExamplesE2E::CLI.new(root: @root, output: output, error_output: error_output).run(
      ["--inventory-only", "--report-dir", report_dir.to_s]
    )

    assert_equal(0, status, error_output.string)
    assert(report_dir.join("report.json").file?)
    assert(report_dir.join("summary.md").file?)
    assert_includes(report_dir.join("summary.md").read, "100.00% exercised (1/1 examples)")
  end

  def test_repository_example_inventory_classifies_every_example
    repository_root = Pathname(__dir__).join("../..").expand_path
    repository_inventory = OpenAIExamplesE2E::Inventory.new(
      root: repository_root,
      manifest_path: repository_root.join("examples/e2e.yml")
    )

    repository_inventory.validate!
    summary = repository_inventory.summary

    assert_equal(22, summary.covered)
    assert_equal(25, summary.total)
    assert_in_delta(88.0, summary.percentage)
  end

  def test_simplecov_fails_when_example_coverage_is_below_the_baseline
    @root.join("lib").mkpath
    @root.join("lib/example_feature.rb").write(<<~RUBY)
      # frozen_string_literal: true

      module ExampleFeature
        def self.covered = :covered
        def self.uncovered = :uncovered
      end
    RUBY
    write_example("covered.rb", <<~RUBY)
      require_relative "../lib/example_feature"

      puts(ExampleFeature.covered)
    RUBY
    write_manifest(
      {"examples/covered.rb" => {"status" => "covered", "expected_output" => "covered"}}
    )
    write_simplecov_files(minimum: 100.0)
    report_dir = @root.join("reports")
    resultset_dir = report_dir.join("resultsets")
    coverage_dir = report_dir.join("coverage")

    report = OpenAIExamplesE2E::Runner.new(
      inventory: inventory,
      timeout: 5,
      coverage_directory: resultset_dir,
      output: StringIO.new
    ).run
    assert(report.success?)

    _output, error_output, status = Open3.capture3(
      {
        "EXAMPLES_E2E_ROOT" => @root.to_s,
        "EXAMPLES_E2E_REPORT_DIR" => report_dir.to_s
      },
      RbConfig.ruby,
      repository_root.join("scripts/collate-examples-e2e-coverage.rb").to_s
    )

    refute(status.success?)
    assert_includes(error_output, "minimum coverage")
    assert(coverage_dir.join("coverage.json").file?)
  end

  private

  def inventory
    OpenAIExamplesE2E::Inventory.new(root: @root, manifest_path: @manifest_path)
  end

  def write_example(name, body)
    path = @examples_dir.join(name)
    path.dirname.mkpath
    path.write("# frozen_string_literal: true\n\n#{body}\n")
  end

  def write_manifest(examples)
    manifest = {
      "version" => 1,
      "examples" => examples
    }
    @manifest_path.write(manifest.to_yaml)
  end

  def write_simplecov_files(minimum:)
    @root.join(".simplecov").write(<<~RUBY)
      # frozen_string_literal: true

      SimpleCov.configure do
        root #{root_dump}
        coverage_path ENV.fetch("EXAMPLES_E2E_COVERAGE_DIR")
        cover "lib/**/*.rb"
        formatters [SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::JSONFormatter]
        coverage(:line) { minimum #{minimum} }
      end
    RUBY
    @root.join(".simplecov_spawn.rb").write(repository_root.join(".simplecov_spawn.rb").read)
  end

  def root_dump = @root.to_s.dump

  def repository_root = Pathname(__dir__).join("../..").expand_path
end
