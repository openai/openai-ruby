# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "rbconfig"
require "tmpdir"

class TestWorkflowTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def setup
    @directory = Dir.mktmpdir
    @project = File.join(@directory, "project")
    @bin = File.join(@directory, "bin")
    @bundle_calls = File.join(@directory, "bundle-calls")
    @curl_calls = File.join(@directory, "curl-calls")
    @mock_calls = File.join(@directory, "mock-calls")
    @mock_started = File.join(@directory, "mock-started")

    FileUtils.mkdir_p(File.join(@project, "scripts"))
    FileUtils.mkdir_p(@bin)
    File.symlink(File.join(ROOT, "scripts/test"), File.join(@project, "scripts/test"))
    write_mock
    write_bundle
    write_curl
  end

  def teardown
    FileUtils.remove_entry(@directory)
  end

  def test_http_error_at_health_endpoint_starts_local_mock
    stdout, stderr, status = run_test_script(curl_mode: "http_error_until_mock")

    assert(status.success?, "#{stdout}\n#{stderr}")
    assert_equal(["--daemon"], calls(@mock_calls))
    assert(calls(@curl_calls).all? { _1.split.include?("--fail") })
    assert_bundle_ran
  end

  def test_failed_mock_start_leaves_preexisting_listener_running
    listener_pid = Process.spawn(RbConfig.ruby, "-e", "sleep 60")
    stdout, stderr, status = run_test_script(
      curl_mode: "http_error",
      mock_mode: "fail"
    )

    refute(status.success?, "#{stdout}\n#{stderr}")
    assert_equal(["--daemon"], calls(@mock_calls))
    refute(
      wait_for_exit(listener_pid, timeout: 1),
      "expected failed startup to leave listener PID #{listener_pid} running"
    )
  ensure
    if listener_pid
      begin
        Process.kill("TERM", listener_pid)
      rescue Errno::ESRCH
        nil
      end

      begin
        Process.wait(listener_pid)
      rescue Errno::ECHILD
        nil
      end
    end
  end

  def test_cleanup_stops_only_the_mock_owned_by_this_invocation
    owned_pid = Process.spawn(RbConfig.ruby, "-e", "sleep 60", pgroup: true)
    preexisting_ipv6_pid = Process.spawn(RbConfig.ruby, "-e", "sleep 60", pgroup: true)
    stdout, stderr, status = run_test_script(
      curl_mode: "unavailable_until_mock",
      mock_owned_pid: owned_pid.to_s
    )

    assert(status.success?, "#{stdout}\n#{stderr}")
    assert(wait_for_exit(owned_pid, timeout: 5), "expected cleanup to stop owned PID #{owned_pid}")
    refute(
      wait_for_exit(preexisting_ipv6_pid, timeout: 1),
      "expected cleanup to preserve pre-existing IPv6 listener PID #{preexisting_ipv6_pid}"
    )
  ensure
    [owned_pid, preexisting_ipv6_pid].compact.each do |pid|
      Process.kill("TERM", pid)
    rescue Errno::ESRCH
      nil
    end

    [owned_pid, preexisting_ipv6_pid].compact.each do |pid|
      Process.wait(pid)
    rescue Errno::ECHILD
      nil
    end
  end

  def test_failed_mock_readiness_cleans_up_the_owned_process_group
    owned_pid = Process.spawn(RbConfig.ruby, "-e", "sleep 60", pgroup: true)
    stdout, stderr, status = run_test_script(
      curl_mode: "unavailable_until_mock",
      mock_mode: "fail",
      mock_owned_pid: owned_pid.to_s
    )

    refute(status.success?, "#{stdout}\n#{stderr}")
    assert(wait_for_exit(owned_pid, timeout: 5), "expected failed startup to stop owned PID #{owned_pid}")
  ensure
    begin
      Process.kill("TERM", owned_pid)
    rescue Errno::ESRCH, TypeError
      nil
    end

    begin
      Process.wait(owned_pid)
    rescue Errno::ECHILD, TypeError
      nil
    end
  end

  def test_mock_launcher_cleans_up_its_process_group_after_readiness_timeout
    owned_pid = nil
    project = File.join(@directory, "mock-project")
    bin = File.join(@directory, "mock-bin")
    pid_record = File.join(@directory, "mock-pid")
    pid_file = File.join(@directory, "mock-pid-file")
    spec = File.join(project, "openapi.yml")
    FileUtils.mkdir_p(File.join(project, "scripts"))
    FileUtils.mkdir_p(bin)
    File.symlink(File.join(ROOT, "scripts/mock"), File.join(project, "scripts/mock"))
    File.write(spec, "openapi: 3.0.0\n")
    write_executable(File.join(bin, "curl"), "#!/usr/bin/env bash\nexit 22\n")
    write_executable(File.join(bin, "sleep"), "#!/usr/bin/env bash\nexit 0\n")
    write_executable(
      File.join(bin, "npm"),
      <<~BASH
        #!/usr/bin/env bash
        if [[ " $* " == *" --version "* ]]; then
          exit 0
        fi
        printf '%s\n' "$$" > "$MOCK_PID_RECORD"
        exec "$RUBY" -e 'sleep 60'
      BASH
    )

    env = {
      "MOCK_PID_RECORD" => pid_record,
      "PATH" => [bin, ENV.fetch("PATH")].join(File::PATH_SEPARATOR),
      "RUBY" => RbConfig.ruby,
      "STEADY_PID_FILE" => pid_file
    }
    stdout, stderr, status = Open3.capture3(env, File.join(project, "scripts/mock"), spec, "--daemon")
    owned_pid = Integer(File.read(pid_record), 10)

    refute(status.success?, "#{stdout}\n#{stderr}")
    assert_includes(stdout, "Timed out waiting for Steady server to start")
    assert(wait_for_process_exit(owned_pid, timeout: 5), "expected timeout to stop process group #{owned_pid}")
    refute(File.exist?(pid_file), "expected timeout to clear PID file")
  ensure
    begin
      Process.kill("TERM", -owned_pid)
    rescue Errno::ESRCH, TypeError
      nil
    end
  end

  def test_cleanup_leaves_non_listening_connections_running
    listener_pid = Process.spawn(RbConfig.ruby, "-e", "sleep 60", pgroup: true)
    client_pid = Process.spawn(RbConfig.ruby, "-e", "sleep 60")
    stdout, stderr, status = run_test_script(
      curl_mode: "unavailable_until_mock",
      mock_owned_pid: listener_pid.to_s
    )

    assert(status.success?, "#{stdout}\n#{stderr}")
    assert(wait_for_exit(listener_pid, timeout: 5), "expected cleanup to stop listener PID #{listener_pid}")
    refute(wait_for_exit(client_pid, timeout: 1), "expected cleanup to leave client PID #{client_pid} running")
  ensure
    [listener_pid, client_pid].compact.each do |pid|
      Process.kill("TERM", pid)
    rescue Errno::ESRCH
      nil
    end

    [listener_pid, client_pid].compact.each do |pid|
      Process.wait(pid)
    rescue Errno::ECHILD
      nil
    end
  end

  def test_healthy_local_mock_is_reused
    stdout, stderr, status = run_test_script(curl_mode: "healthy")

    assert(status.success?, "#{stdout}\n#{stderr}")
    assert_empty(calls(@mock_calls))
    assert_equal(2, calls(@curl_calls).length)
    assert_bundle_ran
  end

  def test_explicit_api_base_url_skips_local_mock_probe
    api_base_url = "http://example.test/v1"
    stdout, stderr, status = run_test_script(curl_mode: "unexpected", api_base_url: api_base_url)

    assert(status.success?, "#{stdout}\n#{stderr}")
    assert_includes(stdout, "Running tests against #{api_base_url}")
    assert_empty(calls(@curl_calls))
    assert_empty(calls(@mock_calls))
    assert_bundle_ran
  end

  private

  def assert_bundle_ran
    assert_equal(["exec rake test"], calls(@bundle_calls))
  end

  def calls(path)
    File.exist?(path) ? File.readlines(path, chomp: true) : []
  end

  def run_test_script(
    curl_mode:,
    api_base_url: nil,
    mock_mode: nil,
    mock_owned_pid: nil
  )
    env = {
      "BUNDLE_CALLS" => @bundle_calls,
      "CURL_CALLS" => @curl_calls,
      "CURL_MODE" => curl_mode,
      "MOCK_CALLS" => @mock_calls,
      "MOCK_MODE" => mock_mode,
      "MOCK_OWNED_PID" => mock_owned_pid,
      "MOCK_STARTED" => @mock_started,
      "PATH" => [@bin, ENV.fetch("PATH")].join(File::PATH_SEPARATOR),
      "TEST_API_BASE_URL" => api_base_url
    }
    Open3.capture3(env, File.join(@project, "scripts/test"), chdir: @project)
  end

  def wait_for_exit(pid, timeout:)
    deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + timeout
    loop do
      return true if Process.waitpid(pid, Process::WNOHANG)
      return false if Process.clock_gettime(Process::CLOCK_MONOTONIC) >= deadline

      sleep(0.01)
    end

  rescue Errno::ECHILD
    true
  end

  def wait_for_process_exit(pid, timeout:)
    deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + timeout
    loop do
      begin
        Process.kill(0, pid)
      rescue Errno::ESRCH
        return true
      end

      return false if Process.clock_gettime(Process::CLOCK_MONOTONIC) >= deadline

      sleep(0.01)
    end
  end

  def write_bundle
    write_executable(
      File.join(@bin, "bundle"),
      <<~BASH
        #!/usr/bin/env bash
        printf '%s\n' "$*" > "$BUNDLE_CALLS"
      BASH
    )
  end

  def write_curl
    write_executable(
      File.join(@bin, "curl"),
      <<~BASH
        #!/usr/bin/env bash
        printf '%s\n' "$*" >> "$CURL_CALLS"

        if [ "$CURL_MODE" = "healthy" ]; then
          exit 0
        fi
        if [ "$CURL_MODE" = "unexpected" ]; then
          exit 64
        fi
        if [ -f "$MOCK_STARTED" ]; then
          exit 0
        fi
        if [ "$CURL_MODE" = "unavailable_until_mock" ]; then
          exit 7
        fi

        # Match curl: HTTP error responses only fail when --fail is present.
        for argument in "$@"; do
          if [ "$argument" = "--fail" ]; then
            exit 22
          fi
        done
        exit 0
      BASH
    )
  end

  def write_mock
    write_executable(
      File.join(@project, "scripts/mock"),
      <<~BASH
        #!/usr/bin/env bash
        printf '%s\n' "$*" > "$MOCK_CALLS"
        if [ -n "$MOCK_OWNED_PID" ] && [ -n "$STEADY_PID_FILE" ]; then
          printf '%s\n' "$MOCK_OWNED_PID" > "$STEADY_PID_FILE"
        fi
        if [ "$MOCK_MODE" = "fail" ]; then
          exit 1
        fi
        : > "$MOCK_STARTED"
      BASH
    )
  end

  def write_executable(path, contents)
    File.write(path, contents)
    File.chmod(0o755, path)
  end
end
