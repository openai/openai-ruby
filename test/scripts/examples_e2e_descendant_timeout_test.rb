# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "pathname"
require "rbconfig"
require "stringio"
require "timeout"
require "tmpdir"
require "yaml"

require_relative "../../scripts/examples-e2e"

class ExamplesE2EDescendantTimeoutTest < Minitest::Test
  extend Minitest::Serial if defined?(Minitest::Serial)

  MARKER = "synthetic example output"
  TEST_TIMEOUT = 1
  MAXIMUM_DURATION = 4

  def test_cli_timeout_bounds_descendant_inherited_output_and_preserves_unrelated_process
    skip "POSIX process-group behavior" if Gem.win_platform?

    sentinel_pid = Process.spawn(RbConfig.ruby, "-e", "sleep 30", pgroup: true)

    with_example(source: descendant_source(parent_sleep: 30)) do |root, child_pid_path|
      child_pid = nil
      status, result, duration = run_cli(root)
      child_pid = read_pid(child_pid_path)

      assert_equal(1, status)
      assert_equal("example timed out after 1 seconds", result.fetch("error"))
      assert_operator(duration, :<, MAXIMUM_DURATION)
      assert_process_stopped(child_pid)
      assert_process_alive(sentinel_pid)
    ensure
      stop_process(child_pid || read_pid_if_present(child_pid_path))
    end
  ensure
    stop_process_group(sentinel_pid)
  end

  def test_cli_timeout_bounds_inherited_output_after_parent_exits
    skip "POSIX process-group behavior" if Gem.win_platform?

    with_example(source: descendant_source(parent_sleep: nil, child_ignores_term: true)) do |root, child_pid_path|
      child_pid = nil
      status, result, duration = run_cli(root)
      child_pid = read_pid(child_pid_path)

      assert_equal(1, status)
      assert_equal("example timed out after 1 seconds", result.fetch("error"))
      assert_operator(duration, :<, MAXIMUM_DURATION)
      assert_process_stopped(child_pid)
    ensure
      stop_process(child_pid || read_pid_if_present(child_pid_path))
    end
  end

  def test_cli_preserves_normal_output
    with_example(source: "puts #{MARKER.dump}\n") do |root, _child_pid_path|
      status, result, duration = run_cli(root)

      assert_equal(0, status)
      assert(result.fetch("successful"))
      assert_nil(result.fetch("error"))
      assert_operator(duration, :<, TEST_TIMEOUT)
    end
  end

  def test_cli_bounds_direct_timeout
    with_example(source: "puts #{MARKER.dump}\nsleep 30\n") do |root, _child_pid_path|
      status, result, duration = run_cli(root)

      assert_equal(1, status)
      assert_equal("example timed out after 1 seconds", result.fetch("error"))
      assert_operator(duration, :<, MAXIMUM_DURATION)
    end
  end

  def test_cli_preserves_successful_child_with_detached_output
    with_example(source: detached_output_descendant_source) do |root, child_pid_path|
      child_pid = nil
      status, result, duration = run_cli(root)
      child_pid = read_pid(child_pid_path)

      assert_equal(0, status)
      assert(result.fetch("successful"))
      assert_operator(duration, :<, TEST_TIMEOUT)
      assert_process_alive(child_pid)
    ensure
      stop_process(child_pid || read_pid_if_present(child_pid_path))
    end
  end

  private

  def with_example(source:)
    Dir.mktmpdir("openai-examples-e2e-descendant-timeout-test") do |directory|
      root = Pathname(directory)
      child_pid_path = root.join("child.pid")
      example_path = root.join("examples/example.rb")
      example_path.dirname.mkpath
      example_path.write(source.gsub("CHILD_PID_PATH", child_pid_path.to_s))
      root.join("examples/e2e.yml").write(
        YAML.dump(
          "version" => 1,
          "examples" => {
            "examples/example.rb" => {"status" => "covered", "expected_output" => MARKER}
          }
        )
      )

      yield(root, child_pid_path)
    end
  end

  def descendant_source(parent_sleep:, child_ignores_term: false)
    child_source = child_ignores_term ? 'trap("TERM") { }; sleep 30' : "sleep 30"
    source = <<~RUBY
      # frozen_string_literal: true

      require "rbconfig"

      child = Process.spawn(RbConfig.ruby, "-e", #{child_source.dump})
      File.write("CHILD_PID_PATH", child.to_s)
      puts #{MARKER.dump}
    RUBY
    source << "sleep #{parent_sleep}\n" if parent_sleep
    source
  end

  def detached_output_descendant_source
    <<~RUBY
      # frozen_string_literal: true

      require "rbconfig"

      child = Process.spawn(RbConfig.ruby, "-e", "sleep 30", out: File::NULL, err: File::NULL)
      File.write("CHILD_PID_PATH", child.to_s)
      puts #{MARKER.dump}
    RUBY
  end

  def run_cli(root)
    output = StringIO.new
    error_output = StringIO.new
    report_directory = root.join("artifacts")
    cli = OpenAIExamplesE2E::CLI.new(root: root, output: output, error_output: error_output)
    started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    status = Timeout.timeout(MAXIMUM_DURATION + 2) do
      cli.run(["--timeout", TEST_TIMEOUT.to_s, "--report-dir", report_directory.to_s])
    end
    duration = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at
    report = JSON.parse(report_directory.join("report.json").read)

    [status, report.fetch("results").fetch(0), duration]
  end

  def read_pid(path)
    Timeout.timeout(1) do
      sleep 0.01 until path.exist?
      Integer(path.read)
    end
  end

  def read_pid_if_present(path)
    Integer(path.read) if path&.exist?
  rescue ArgumentError
    nil
  end

  def assert_process_stopped(pid)
    Timeout.timeout(2) do
      sleep 0.01 while process_alive?(pid)
    end
  end

  def assert_process_alive(pid)
    assert(process_alive?(pid), "expected unrelated process #{pid} to remain alive")
  end

  def process_alive?(pid)
    Process.kill(0, pid)
    true
  rescue Errno::ESRCH
    false
  end

  def stop_process(pid)
    return unless pid && process_alive?(pid)

    Process.kill("TERM", pid)
    deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + 0.25
    sleep 0.01 while process_alive?(pid) && Process.clock_gettime(Process::CLOCK_MONOTONIC) < deadline
    Process.kill("KILL", pid) if process_alive?(pid)
  rescue Errno::ESRCH
    nil
  end

  def stop_process_group(pid)
    Process.kill("TERM", -pid) if pid
    Process.wait(pid) if pid
  rescue Errno::ESRCH, Errno::ECHILD
    nil
  end
end
