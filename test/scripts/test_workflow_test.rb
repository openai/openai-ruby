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
    write_lsof
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

  def test_cleanup_stops_every_process_listening_on_mock_port
    stale_pid = Process.spawn(RbConfig.ruby, "-e", "exit")
    Process.wait(stale_pid)
    pids = 2.times.map { Process.spawn(RbConfig.ruby, "-e", "sleep 60") }
    stdout, stderr, status = run_test_script(
      curl_mode: "unavailable_until_mock",
      lsof_pids: [stale_pid, *pids].join("\n")
    )

    assert(status.success?, "#{stdout}\n#{stderr}")
    pids.each { assert(wait_for_exit(_1), "expected cleanup to stop PID #{_1}") }
  ensure
    Array(pids).each do |pid|
      Process.kill("TERM", pid)
    rescue Errno::ESRCH
      nil
    end

    Array(pids).each do |pid|
      Process.wait(pid)
    rescue Errno::ECHILD
      nil
    end
  end

  def test_cleanup_leaves_non_listening_connections_running
    listener_pid = Process.spawn(RbConfig.ruby, "-e", "sleep 60")
    client_pid = Process.spawn(RbConfig.ruby, "-e", "sleep 60")
    stdout, stderr, status = run_test_script(
      curl_mode: "unavailable_until_mock",
      lsof_pids: listener_pid.to_s,
      lsof_connected_pids: client_pid.to_s
    )

    assert(status.success?, "#{stdout}\n#{stderr}")
    assert(wait_for_exit(listener_pid), "expected cleanup to stop listener PID #{listener_pid}")
    refute(wait_for_exit(client_pid), "expected cleanup to leave client PID #{client_pid} running")
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

  def run_test_script(curl_mode:, api_base_url: nil, lsof_pids: nil, lsof_connected_pids: nil)
    env = {
      "BUNDLE_CALLS" => @bundle_calls,
      "CURL_CALLS" => @curl_calls,
      "CURL_MODE" => curl_mode,
      "LSOF_CONNECTED_PIDS" => lsof_connected_pids,
      "LSOF_PIDS" => lsof_pids,
      "MOCK_CALLS" => @mock_calls,
      "MOCK_STARTED" => @mock_started,
      "PATH" => [@bin, ENV.fetch("PATH")].join(File::PATH_SEPARATOR),
      "TEST_API_BASE_URL" => api_base_url
    }
    Open3.capture3(env, File.join(@project, "scripts/test"), chdir: @project)
  end

  def wait_for_exit(pid)
    100.times do
      return true if Process.waitpid(pid, Process::WNOHANG)

      sleep(0.01)
    end

    false
  rescue Errno::ECHILD
    true
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

  def write_lsof
    write_executable(
      File.join(@bin, "lsof"),
      <<~BASH
        #!/usr/bin/env bash
        found=false
        if [ -n "$LSOF_PIDS" ]; then
          printf '%s\n' "$LSOF_PIDS"
          found=true
        fi
        if [[ " $* " != *" -sTCP:LISTEN "* ]] && [ -n "$LSOF_CONNECTED_PIDS" ]; then
          printf '%s\n' "$LSOF_CONNECTED_PIDS"
          found=true
        fi
        if [ "$found" = false ]; then
          exit 1
        fi
      BASH
    )
  end

  def write_mock
    write_executable(
      File.join(@project, "scripts/mock"),
      <<~BASH
        #!/usr/bin/env bash
        printf '%s\n' "$*" > "$MOCK_CALLS"
        : > "$MOCK_STARTED"
      BASH
    )
  end

  def write_executable(path, contents)
    File.write(path, contents)
    File.chmod(0o755, path)
  end
end
