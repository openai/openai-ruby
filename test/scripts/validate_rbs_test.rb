# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "pathname"
require "rbconfig"
require "tmpdir"

class ValidateRBSScriptTest < Minitest::Test
  SCRIPT = Pathname(__dir__).join("../../scripts/validate-rbs").expand_path

  def test_validates_reopened_namespaces
    stdout, stderr, status = run_validation(
      {
        "first.rbs" => <<~RBS,
          module Example
            class First
              def value: () -> String
            end
          end
        RBS
        "second.rbs" => <<~RBS
          module Example
            class Second
              def value: () -> Integer
            end
          end
        RBS
      }
    )

    assert_predicate(status, :success?, stderr)
    assert_includes(stdout, "Validated 2 RBS files with no errors.")
  end

  def test_does_not_allow_invalid_files_to_repair_each_other
    stdout, _stderr, status = run_validation(
      {
        "a.rbs" => "class Example\n",
        "b.rbs" => "end\n"
      }
    )

    refute_predicate(status, :success?)
    assert_includes(stdout, "RBS::SyntaxError")
    assert_match(/[ab]\.rbs/, stdout)
  end

  def test_uses_one_consolidated_steep_check_on_success
    stdout, stderr, status, calls = run_validation(
      {"valid.rbs" => "module Example\nend\n"},
      fake_steep_results: [0]
    )

    assert_predicate(status, :success?, stderr)
    assert_empty(stderr)
    assert_includes(stdout, "Validated 1 RBS file with no errors.")
    assert_equal(1, calls.size)
    assert_equal(%w[check --no-type-check --jobs=1], calls.first.take(3))
    assert(calls.first.last.start_with?("--steepfile="), calls.first.inspect)
  end

  def test_rechecks_original_files_when_consolidated_check_fails
    stdout, stderr, status, calls = run_validation(
      {"valid.rbs" => "module Example\nend\n"},
      env: {"CI" => "1", "STEEP_JOBS" => "8"},
      fake_steep_results: [1, 0]
    )

    assert_predicate(status, :success?, stderr)
    assert_empty(stderr)
    assert_includes(stdout, "checking original signature files")
    assert_equal(2, calls.size)
    assert(calls.first.last.start_with?("--steepfile="), calls.first.inspect)
    assert_equal(%w[check --no-type-check --jobs=8 --format=github], calls.last)
  end

  def test_checks_original_files_directly_when_a_signature_has_use_directives
    _stdout, stderr, status, calls = run_validation(
      {"uses.rbs" => "use Example::*\nmodule UsesExample\nend\n"},
      fake_steep_results: [0]
    )

    assert_predicate(status, :success?, stderr)
    assert_empty(stderr)
    assert_equal([%w[check --no-type-check]], calls)
  end

  def test_checks_original_files_directly_when_type_name_resolution_is_file_scoped
    _stdout, stderr, status, calls = run_validation(
      {"unresolved.rbs" => "# resolve-type-names: false\nmodule Example\nend\n"},
      fake_steep_results: [0]
    )

    assert_predicate(status, :success?, stderr)
    assert_empty(stderr)
    assert_equal([%w[check --no-type-check]], calls)
  end

  def test_reports_steep_semantic_errors
    stdout, _stderr, status = run_validation(
      {
        "invalid.rbs" => <<~RBS
          module Example
            class Box[A < Numeric]
            end

            class InvalidBox < Box[String]
            end
          end
        RBS
      }
    )

    refute_predicate(status, :success?)
    assert_includes(stdout, "RBS::UnsatisfiableTypeApplication")
    assert_includes(stdout, "Type application of `::Example::Box` doesn't satisfy the constraints")
  end

  def test_reports_syntax_errors
    stdout, _stderr, status = run_validation(
      {"invalid.rbs" => "module Example\n  def broken: () ->\nend\n"}
    )

    refute_predicate(status, :success?)
    assert_includes(stdout, "RBS::SyntaxError")
  end

  def test_emits_github_annotations_in_ci
    stdout, _stderr, status = run_validation(
      {"invalid.rbs" => "module Example\n  type invalid = MissingType\nend\n"},
      env: {"CI" => "1"}
    )

    refute_predicate(status, :success?)
    assert_match(/^::error file=.*invalid\.rbs,line=2,.*::/, stdout)
    assert_includes(stdout, "RBS::UnknownTypeName")
  end

  private

  def run_validation(signatures, env: {}, fake_steep_results: nil)
    env = {"CI" => nil}.merge(env)

    Dir.mktmpdir("openai-rbs-validation-test") do |dir|
      root = Pathname(dir)
      sig = root.join("sig")
      sig.mkpath
      root.join("Steepfile").write(<<~RUBY)
        target(:lib) do
          signature("sig")
        end
      RUBY

      signatures.each do |name, contents|
        path = sig.join(name)
        path.dirname.mkpath
        path.write(contents)
      end

      log = fake_steep_results && install_fake_steep(root)
      if log
        env = env.merge(
          "FAKE_STEEP_LOG" => log.to_s,
          "FAKE_STEEP_RESULTS" => fake_steep_results.join(","),
          "STEEP_COMMAND" => root.join("bin/steep").to_s
        )
      end

      stdout, stderr, status = Open3.capture3(env, RbConfig.ruby, SCRIPT.to_s, chdir: root.to_s)
      calls = log&.file? ? log.readlines(chomp: true).map { _1.split("\t") } : []
      [stdout, stderr, status, calls]
    end
  end

  def install_fake_steep(root)
    bin = root.join("bin")
    bin.mkpath
    executable = bin.join("steep")
    executable.write(<<~RUBY)
      #!/usr/bin/env ruby
      # frozen_string_literal: true

      log = ENV.fetch("FAKE_STEEP_LOG")
      call = File.file?(log) ? File.foreach(log).count : 0
      File.open(log, "a") { _1.puts(ARGV.join("\\t")) }
      results = ENV.fetch("FAKE_STEEP_RESULTS").split(",").map { Integer(_1) }
      exit(results.fetch(call, results.last))
    RUBY
    executable.chmod(0o755)
    root.join("steep.log")
  end
end
