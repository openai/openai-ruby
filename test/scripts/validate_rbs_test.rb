# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "pathname"
require "rbconfig"
require "tmpdir"
require "yaml"

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
    assert_includes(stdout, "RBS::ParsingError")
    assert_match(/[ab]\.rbs/, stdout)
  end

  def test_reports_nul_with_the_exact_file
    stdout, stderr, status = run_validation(
      {
        "a.rbs" => "module Good\nend\n\x00",
        "b.rbs" => "module Invalid\n  type bad = MissingType\nend\n"
      }
    )

    refute_predicate(status, :success?)
    assert_empty(stdout)
    assert_includes(stderr, "sig/a.rbs: string contains null byte")
  end

  def test_runs_rbs_parse_and_validate_with_manifest_libraries
    dependencies = %w[
      English
      base64
      cgi
      date
      erb
      etc
      json
      net/http
      openssl
      pathname
      rbconfig
      securerandom
      set
      stringio
      time
      uri
    ]
    stdout, stderr, status, calls = run_validation(
      {"valid.rbs" => "module Example\nend\n"},
      dependencies: dependencies,
      fake_rbs_results: [0, 0]
    )

    assert_predicate(status, :success?, stderr)
    assert_empty(stderr)
    assert_includes(stdout, "Validated 1 RBS file with no errors.")
    assert_equal(%w[parse sig], calls.first)
    assert_equal(
      %w[
        -I
        sig
        --no-collection
        -r
        base64
        -r
        cgi
        -r
        date
        -r
        erb
        -r
        json
        -r
        net-http
        -r
        openssl
        -r
        pathname
        -r
        securerandom
        -r
        time
        -r
        uri
        validate
      ],
      calls.last
    )
  end

  def test_stops_after_parse_errors
    _stdout, _stderr, status, calls = run_validation(
      {"invalid.rbs" => "module Example\n"},
      fake_rbs_results: [1]
    )

    refute_predicate(status, :success?)
    assert_equal([%w[parse sig]], calls)
  end

  def test_preserves_file_scoped_use_directives
    _stdout, stderr, status = run_validation(
      {
        "declarations.rbs" => "module Example\n  class Value\n  end\nend\n",
        "uses.rbs" => <<~RBS
          use Example::*
          module UsesExample
            def value: () -> Value
          end
        RBS
      }
    )

    assert_predicate(status, :success?, stderr)
  end

  def test_a_use_directive_does_not_affect_other_files
    stdout, stderr, status = run_validation(
      {
        "a.rbs" => "use Example::*\nmodule Example\n  class Foo\n  end\nend\n",
        "b.rbs" => "module Invalid\n  type bad = Foo\nend\n"
      }
    )

    refute_predicate(status, :success?)
    assert_includes("#{stdout}\n#{stderr}", "RBS::NoTypeFoundError")
    assert_includes("#{stdout}\n#{stderr}", "b.rbs")
  end

  def test_preserves_multiline_type_name_resolution_directives
    stdout, stderr, status = run_validation(
      {
        "a.rbs" => "#\nresolve-type-names: false\nmodule Good\nend\n",
        "b.rbs" => "class Broken\n  def call: () -> Missing\nend\n"
      }
    )

    refute_predicate(status, :success?)
    assert_includes("#{stdout}\n#{stderr}", "RBS::NoTypeFoundError")
    assert_includes("#{stdout}\n#{stderr}", "b.rbs")
  end

  def test_reports_semantic_errors
    stdout, stderr, status = run_validation(
      {
        "invalid.rbs" => <<~RBS
          module Example
            class Box[A]
            end

            type invalid = Box[String, Integer]
          end
        RBS
      }
    )

    refute_predicate(status, :success?)
    output = "#{stdout}\n#{stderr}"
    assert_includes(output, "RBS::InvalidTypeApplicationError")
    assert_includes(output, "::Example::Box expects parameters [A], but given args [::String, ::Integer]")
    assert_match(/invalid\.rbs:5:/, output)
  end

  def test_reports_syntax_errors
    stdout, _stderr, status = run_validation(
      {"invalid.rbs" => "module Example\n  def broken: () ->\nend\n"}
    )

    refute_predicate(status, :success?)
    assert_includes(stdout, "RBS::ParsingError")
    assert_match(/invalid\.rbs:3:/, stdout)
  end

  def test_reports_malformed_utf8
    stdout, stderr, status = run_validation(
      {"invalid.rbs" => "module Example\n\xFF\nend\n".b}
    )

    refute_predicate(status, :success?)
    assert_includes("#{stdout}\n#{stderr}", "sig/invalid.rbs: invalid byte sequence in UTF-8")
  end

  def test_emits_github_annotations_for_semantic_errors
    stdout, _stderr, status = run_validation(
      {"invalid.rbs" => "module Example\n  type invalid = MissingType\nend\n"},
      env: {"CI" => "1"}
    )

    refute_predicate(status, :success?)
    assert_match(/^::error file=.*invalid\.rbs,line=2,col=18,.*::/, stdout)
    assert_includes(stdout, "RBS::NoTypeFoundError")
  end

  def test_emits_github_annotations_for_syntax_errors
    stdout, _stderr, status = run_validation(
      {"invalid.rbs" => "module Example\n  def broken: () ->\nend\n"},
      env: {"CI" => "1"}
    )

    refute_predicate(status, :success?)
    assert_match(/^::error file=.*invalid\.rbs,line=3,.*::/, stdout)
    assert_includes(stdout, "RBS::ParsingError")
  end

  private

  def run_validation(signatures, dependencies: [], env: {}, fake_rbs_results: nil)
    env = {"CI" => nil}.merge(env)

    Dir.mktmpdir("openai-rbs-validation-test") do |dir|
      root = Pathname(dir)
      sig = root.join("sig")
      sig.mkpath
      root.join("manifest.yaml").write(YAML.dump({"dependencies" => dependencies}))

      signatures.each do |name, contents|
        path = sig.join(name)
        path.dirname.mkpath
        path.binwrite(contents)
      end

      log = fake_rbs_results && install_fake_rbs(root)
      if log
        env = env.merge(
          "FAKE_RBS_LOG" => log.to_s,
          "FAKE_RBS_RESULTS" => fake_rbs_results.join(","),
          "RBS_COMMAND" => root.join("bin/rbs").to_s
        )
      end

      stdout, stderr, status = Open3.capture3(env, RbConfig.ruby, SCRIPT.to_s, chdir: root.to_s)
      calls = log&.file? ? log.readlines(chomp: true).map { _1.split("\t") } : []
      [stdout, stderr, status, calls]
    end
  end

  def install_fake_rbs(root)
    bin = root.join("bin")
    bin.mkpath
    executable = bin.join("rbs")
    executable.write(
      <<~RUBY
        #!/usr/bin/env ruby
        # frozen_string_literal: true

        log = ENV.fetch("FAKE_RBS_LOG")
        call = File.file?(log) ? File.foreach(log).count : 0
        File.open(log, "a") { _1.puts(ARGV.join("\\t")) }
        results = ENV.fetch("FAKE_RBS_RESULTS").split(",").map { Integer(_1) }
        exit(results.fetch(call, results.last))
      RUBY
    )
    executable.chmod(0o755)
    root.join("rbs.log")
  end
end
