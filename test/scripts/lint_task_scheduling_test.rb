# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "open3"
require "rbconfig"

class LintTaskSchedulingTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def test_lint_keeps_existing_checks_and_runs_cwd_sensitive_work_serially
    result = run_rakefile_probe(
      <<~RUBY
        require "json"
        require "rake"
        require "timeout"
        require "tmpdir"

        load "Rakefile"

        lint = Rake::Task["lint"]
        rubocop = Rake::Task["lint:rubocop"]
        typecheck = Rake::Task["typecheck"]
        rubocop_prerequisites = rubocop.prerequisites
        typecheck_prerequisites = typecheck.prerequisites

        %w[
          lint:rubocop
          lint:rubocop_directives
          lint:rubyfmt
          lint:rbs_format
          typecheck
          typecheck:sorbet
          validate:rbs
        ].each { Rake::Task[_1].clear_actions }

        entered = Queue.new
        released = Queue.new
        invoked = []
        observed_cwd = nil
        Dir.mktmpdir do |directory|
          %w[lint:rubocop_directives lint:rubyfmt lint:rbs_format validate:rbs].each do |name|
            Rake::Task[name].enhance { invoked << name }
          end
          rubocop.enhance do
            invoked << "lint:rubocop"
            Dir.chdir(directory) do
              entered << true
              Timeout.timeout(1) { released.pop }
            rescue Timeout::Error
              nil
            end
          end
          Rake::Task["typecheck:sorbet"].enhance do
            invoked << "typecheck:sorbet"
            Timeout.timeout(2) { entered.pop }
            observed_cwd = Dir.pwd
            released << true
          end

          lint.invoke
        end

        puts JSON.generate(
          lint_class: lint.class.name,
          invoked: invoked,
          rubocop_prerequisites: rubocop_prerequisites,
          typecheck_prerequisites: typecheck_prerequisites,
          observed_cwd: observed_cwd
        )
      RUBY
    )

    assert_equal("Rake::Task", result.fetch("lint_class"))
    assert_equal(
      %w[
        lint:rbs_format
        lint:rubocop
        lint:rubocop_directives
        lint:rubyfmt
        typecheck:sorbet
        validate:rbs
      ],
      result.fetch("invoked").sort
    )
    assert_equal(
      %w[lint:rubocop_directives lint:rubyfmt lint:rbs_format],
      result.fetch("rubocop_prerequisites")
    )
    assert_equal(%w[typecheck:sorbet validate:rbs], result.fetch("typecheck_prerequisites"))
    assert_equal(ROOT, result.fetch("observed_cwd"))
  end

  def test_lint_propagates_existing_check_failures
    result = run_rakefile_probe(
      <<~RUBY
        require "json"
        require "rake"

        load "Rakefile"

        %w[
          lint:rubocop
          lint:rubocop_directives
          lint:rubyfmt
          lint:rbs_format
          typecheck
          typecheck:sorbet
          validate:rbs
        ].each { Rake::Task[_1].clear_actions }
        invoked = []
        Rake::Task["lint:rubocop"].enhance do
          invoked << "lint:rubocop"
          raise "synthetic rubocop failure"
        end
        Rake::Task["typecheck:sorbet"].enhance { invoked << "typecheck:sorbet" }

        begin
          Rake::Task["lint"].invoke
        rescue RuntimeError => error
          puts JSON.generate(error: error.message, invoked: invoked)
        end
      RUBY
    )

    assert_equal("synthetic rubocop failure", result.fetch("error"))
    assert_equal(%w[lint:rubocop typecheck:sorbet], result.fetch("invoked"))
  end

  private

  def run_rakefile_probe(source)
    stdout, stderr, status = Open3.capture3(
      RbConfig.ruby,
      "-e",
      source,
      chdir: ROOT
    )
    assert(status.success?, "#{stdout}\n#{stderr}")

    JSON.parse(stdout)
  end
end
