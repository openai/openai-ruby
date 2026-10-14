# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "open3"
require "rbconfig"
require "socket"
require "timeout"
require "tmpdir"

require_relative "../../scripts/parallel_lint_checks"

class LintTaskSchedulingTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def test_checks_overlap_in_separate_processes_and_observe_completed_formatting
    with_fixture do |directory|
      with_barrier(directory, commands: %w[format lint:rubocop]) do |connections, records, wait_thread|
        assert_equal(4, records.map { _1.fetch("pid") }.uniq.length)
        assert_equal(ParallelLintChecks::TASKS.sort, records.map { _1.fetch("task") }.sort)
        assert(records.all? { _1.fetch("input") == "formatted" })
        refute(wait_thread.join(0), "coordinator returned while checks were blocked")
        connections.each { _1.puts("continue") }
      end

      assert_equal("formatted", File.read(File.join(directory, "input")))
    end
  end

  def test_every_leaf_failure_is_reported_without_skipping_other_checks
    with_fixture do |directory|
      File.write(File.join(directory, "input"), "formatted")
      [*ParallelLintChecks::TASKS.map { [_1] }, ParallelLintChecks::TASKS].each do |failures|
        output, error, status = run_fixture(directory, {"LINT_TEST_FAILURES" => JSON.generate(failures)})
        refute(status.success?, "#{output}\n#{error}")
        ParallelLintChecks::TASKS.each do |name|
          assert_includes(output, "#{name}: completed")
          assert_includes(output, "#{name}: exit #{failures.include?(name) ? 7 : 0}")
        end
      end
    end
  end

  def test_spawn_failure_still_waits_for_and_reports_other_checks
    with_fixture do |directory|
      File.write(File.join(directory, "input"), "formatted")
      output, error, status = run_fixture(directory, {"LINT_TEST_SPAWN_FAILURE" => "1"})
      refute(status.success?, "#{output}\n#{error}")
      assert_includes(output, "lint:rubyfmt: could not start:")
      (ParallelLintChecks::TASKS - ["lint:rubyfmt"]).each do |name|
        assert_includes(output, "#{name}: completed")
        assert_includes(output, "#{name}: exit 0")
      end
    end
  end

  def test_changed_input_is_rechecked_without_mutation
    with_fixture do |directory|
      input = File.join(directory, "input")
      File.write(input, "formatted")
      _output, error, status = run_fixture(directory)
      assert(status.success?, error)
      before_mode = File.stat(input).mode
      File.write(input, "changed")
      output, error, status = run_fixture(directory)
      refute(status.success?, "#{output}\n#{error}")
      ParallelLintChecks::TASKS.each { assert_includes(output, "#{_1}: exit 8") }
      assert_equal("changed", File.read(input))
      assert_equal(before_mode, File.stat(input).mode)
    end
  end

  def test_signaled_leaf_does_not_hide_other_results
    skip("POSIX signal delivery test") if Gem.win_platform?

    with_fixture do |directory|
      File.write(File.join(directory, "input"), "formatted")
      output, error, status = run_fixture(directory, {"LINT_TEST_SIGNAL" => "1"})
      refute(status.success?, "#{output}\n#{error}")
      assert_includes(output, "lint:rubyfmt: signal #{Signal.list.fetch("KILL")}")
      (ParallelLintChecks::TASKS - ["lint:rubyfmt"]).each do |name|
        assert_includes(output, "#{name}: completed")
      end
    end
  end

  def test_format_failure_starts_no_checks
    with_fixture do |directory|
      output, _error, status = run_fixture(directory, {"LINT_TEST_FORMAT_FAILURE" => "1"}, %w[format lint:rubocop])
      refute(status.success?)
      refute_includes(output, "completed")
      refute_includes(output, "=== lint:")
      assert_equal("unformatted", File.read(File.join(directory, "input")))
    end
  end

  def test_interrupt_closes_all_child_and_descendant_connections
    skip("POSIX signal delivery test") if Gem.win_platform?

    with_fixture do |directory|
      File.write(File.join(directory, "input"), "formatted")
      with_barrier(directory, descendants: true, success: false) do |connections, _records, wait_thread|
        Process.kill("TERM", wait_thread.pid)
        Timeout.timeout(30) { connections.each { assert_nil(_1.gets) } }
      end
    end
  end

  def test_signaled_first_leader_does_not_leave_its_descendant_running
    assert_signaled_leader_cleanup(ParallelLintChecks::TASKS.first)
  end

  def test_cancellation_during_spawn_does_not_leave_unregistered_children
    %w[INT TERM].each { assert_cancellation_cleanup("launch", _1) }
  end

  def test_repeated_cancellation_does_not_interrupt_child_cleanup
    %w[INT TERM].each { assert_cancellation_cleanup("cleanup", _1) }
  end

  def test_cancellation_during_handler_restoration_is_propagated
    %w[INT TERM].each { assert_cancellation_cleanup("restore_before", _1) }
  end

  def test_cancellation_from_restored_handler_preserves_both_previous_handlers
    %w[INT TERM].each { assert_cancellation_cleanup("restore_after", _1) }
  end

  def test_signaled_last_leader_is_cleaned_up_while_earlier_checks_wait
    assert_signaled_leader_cleanup(ParallelLintChecks::TASKS.last)
  end

  def assert_signaled_leader_cleanup(task)
    with_fixture do |directory|
      File.write(File.join(directory, "input"), "formatted")
      with_barrier(directory, descendants: task, success: false) do |connections, records, wait_thread|
        leader = records.index { _1.fetch("task") == task }
        descendant = records.index { _1.fetch("task") == "descendant" }
        Process.kill("KILL", records.fetch(leader).fetch("pid"))
        Timeout.timeout(30) do
          assert_nil(connections.fetch(leader).gets)
          assert_nil(connections.fetch(descendant).gets)
        end

        refute(wait_thread.join(0), "unrelated checks should still be waiting at the barrier")
        connections.each_with_index do |connection, index|
          connection.puts("continue") unless [leader, descendant].include?(index)
        end
      end
    end
  end

  def test_autocorrect_aliases_keep_the_original_actions
    result = run_rakefile_probe(
      <<~RUBY
        require "json"
        require "rake"
        load "Rakefile"
        invoked = []
        %w[auto_correct autocorrect autocorrect_all].each do |name|
          prefix = Gem.win_platform? ? "lint:rubocop:" : "lint:rubocop:inspect:"
          leaf = Rake::Task[prefix + name]
          leaf.clear_actions
          leaf.enhance { invoked << name }
          Rake::Task["lint:rubocop:" + name].invoke
        end
        puts JSON.generate(invoked: invoked)
      RUBY
    )
    assert_equal(%w[auto_correct autocorrect autocorrect_all], result.fetch("invoked"))
  end

  def test_lint_propagates_existing_check_failures_and_still_runs_both_typechecks
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
        Rake::Task["validate:rbs"].enhance { invoked << "validate:rbs" }
        begin
          Rake::Task["lint"].invoke
        rescue RuntimeError => error
          puts JSON.generate(error: error.message, invoked: invoked)
        end
      RUBY
    )
    assert_equal("synthetic rubocop failure", result.fetch("error"))
    assert_equal(%w[lint:rubocop typecheck:sorbet validate:rbs], result.fetch("invoked").sort)
  end

  private

  def assert_cancellation_cleanup(phase, signal)
    skip("POSIX signal delivery test") if Gem.win_platform?

    # Inject real signals at the vulnerable boundaries, without relying on timing.
    # Every real child is tracked by the probe and reaped even if the helper leaks it.
    source = <<~'RUBY'
      require "json"
      require "rake"
      require ARGV.fetch(0)
      phase, signal = ARGV.drop(1)
      spawn = Process.method(:spawn)
      kill = Process.method(:kill)
      wait2 = Process.method(:wait2)
      pids = []
      deliveries = 0
      cancelled = false
      trap = Signal.method(:trap)
      previous_handlers = %w[INT TERM].to_h do |name|
        handler = proc { raise SignalException, name }
        trap.call(name, handler)
        [name, handler]
      end
      Signal.define_singleton_method(:trap) do |name, *args, &block|
        restoring = name == signal && args.first.equal?(previous_handlers.fetch(name)) && deliveries.zero?
        if restoring && phase == "restore_before"
          deliveries += 1
          kill.call(signal, Process.pid)
        end
        result = trap.call(name, *args, &block)
        if restoring && phase == "restore_after"
          deliveries += 1
          kill.call(signal, Process.pid)
        end
        result
      end
      Process.define_singleton_method(:spawn) do |*args, **options|
        command = phase.start_with?("restore_") ? "exit 0" : "sleep 60"
        pid = spawn.call(RbConfig.ruby, "-e", command, pgroup: true, out: File::NULL, err: File::NULL)
        pids << pid
        if phase == "launch" && pids.length == 1
          deliveries += 1
          kill.call(signal, Process.pid)
        end
        pid
      end
      Process.define_singleton_method(:wait2) do |*args|
        if phase == "cleanup" && deliveries.zero?
          deliveries += 1
          kill.call(signal, Process.pid)
        end
        wait2.call(*args)
      end
      Process.define_singleton_method(:kill) do |*args|
        if phase == "cleanup" && args.last.negative? && deliveries == 1
          deliveries += 1
          kill.call(signal, Process.pid)
        end
        kill.call(*args)
      end
      begin
        ParallelLintChecks.run(root: Dir.pwd)
      rescue SignalException
        cancelled = true
      ensure
        living = pids.select do |pid|
          wait2.call(pid, Process::WNOHANG).nil?
        rescue Errno::ECHILD
          false
        end
        pids.each do |pid|
          begin
            kill.call("KILL", -pid)
          rescue Errno::ESRCH
            nil
          end
          begin
            wait2.call(pid)
          rescue Errno::ECHILD
            nil
          end
        end
        restored = previous_handlers.map { |name, handler| trap.call(name, handler).equal?(handler) }
        puts JSON.generate(cancelled: cancelled, deliveries: deliveries, living: living, restored: restored)
      end
    RUBY
    stdout, stderr, status = Open3.capture3(
      RbConfig.ruby,
      "-e",
      source,
      File.join(ROOT, "scripts/parallel_lint_checks.rb"),
      phase,
      signal,
      chdir: ROOT
    )
    assert(status.success?, "#{stdout}\n#{stderr}")
    result = JSON.parse(stdout.lines.last)
    assert(result.fetch("cancelled"), "#{phase}: #{signal} must propagate cancellation")
    assert_equal(phase == "cleanup" ? 2 : 1, result.fetch("deliveries"))
    assert_empty(result.fetch("living"), "#{phase}: #{signal} left children running after cleanup")
    assert_equal([true, true], result.fetch("restored"), "#{phase}: #{signal} must restore both previous handlers")
  end

  def with_fixture
    skip("Separate-process lint gate uses POSIX process groups") if Gem.win_platform?

    Dir.mktmpdir("ruby-lint-scheduling-test-") do |directory|
      File.write(File.join(directory, "input"), "unformatted")
      Dir.mkdir(File.join(directory, "elsewhere"))
      helper = File.join(ROOT, "scripts/parallel_lint_checks.rb")
      File.write(
        File.join(directory, "Rakefile"),
        "require #{helper.dump}\n" + <<~'RUBY'
            require "json"
            require "socket"
            task(:format) do
              abort("format failed") if ENV["LINT_TEST_FORMAT_FAILURE"]
              File.write("input", "formatted")
            end
            task(:"lint:rubocop") do
              if ENV["LINT_TEST_SPAWN_FAILURE"]
                require "minitest/mock"
                spawn = Process.method(:spawn)
                failing_spawn = lambda do |*args, **options|
                  raise Errno::ENOENT, "synthetic spawn failure" if args.include?("lint:rubyfmt")
                  spawn.call(*args, **options)
                end
                Process.stub(:spawn, failing_spawn) do
                  abort("checks failed") unless ParallelLintChecks.run(root: __dir__)
                end
              else
                abort("checks failed") unless ParallelLintChecks.run(root: __dir__)
              end
            end
            ParallelLintChecks::TASKS.each do |name|
              task(name) do
                Process.kill("KILL", Process.pid) if ENV["LINT_TEST_SIGNAL"] && name == "lint:rubyfmt"
                input = File.read("input")
                if ENV["LINT_TEST_PORT"]
                  Dir.chdir("elsewhere") if name == ParallelLintChecks::TASKS.first
                  if name == ENV["LINT_TEST_DESCENDANTS"]
                    descendant = Process.spawn(
                      RbConfig.ruby, "-rsocket", "-rjson", "-e",
                      'TCPSocket.open("127.0.0.1", ENV.fetch("LINT_TEST_PORT")) do |socket|; ' \
                      'socket.puts(JSON.generate(pid: Process.pid, task: "descendant", input: "formatted")); ' \
                      'socket.flush; socket.gets; end'
                    )
                  end
                  TCPSocket.open("127.0.0.1", ENV.fetch("LINT_TEST_PORT")) do |socket|
                    socket.puts(JSON.generate(pid: Process.pid, task: name, input: input))
                    socket.flush
                    abort("barrier closed") unless socket.gets == "continue\n"
                  end
                  Process.waitpid(descendant) if descendant
                end
                puts "#{name}: completed"
                exit(8) unless input == "formatted"
                exit(7) if JSON.parse(ENV.fetch("LINT_TEST_FAILURES", "[]")).include?(name)
              end
            end
          RUBY
      )
      yield directory
    end
  end

  def fixture_command(commands)
    [RbConfig.ruby, "-rbundler/setup", Gem.bin_path("rake", "rake"), *commands]
  end

  def fixture_env(extra = {})
    {"BUNDLE_GEMFILE" => File.join(ROOT, "Gemfile")}.merge(extra)
  end

  def run_fixture(directory, env = {}, commands = ["lint:rubocop"])
    Open3.capture3(fixture_env(env), *fixture_command(commands), chdir: directory)
  end

  def with_barrier(directory, commands: ["lint:rubocop"], descendants: false, success: true)
    TCPServer.open("127.0.0.1", 0) do |server|
      env = fixture_env("LINT_TEST_PORT" => server.addr[1].to_s)
      env["LINT_TEST_DESCENDANTS"] = descendants == true ? ParallelLintChecks::TASKS.first : descendants if descendants
      Open3.popen3(env, *fixture_command(commands), chdir: directory) do |input, output, error, wait_thread|
        input.close
        connections = []
        records = []
        readers = [output, error].map { |io| Thread.new { io.read } }
        completed = false
        failure = nil
        begin
          Timeout.timeout(30) do
            (descendants ? 5 : 4).times do
              socket = server.accept
              connections << socket
              records << JSON.parse(socket.gets)
            end
          end

          yield connections, records, wait_thread
          completed = true
        rescue StandardError => error
          failure = error
        ensure
          connections.each(&:close)
          if !completed && wait_thread.alive?
            begin
              Process.kill("TERM", wait_thread.pid)
            rescue Errno::ESRCH
              nil
            end
          end
          # Join readers before Open3 closes their streams, including on barrier failure.
          stdout, stderr = readers.map(&:value)
          status = wait_thread.value
        end

        if failure
          flunk(
            "#{failure.class}: #{failure.message}; received #{records.map { _1.fetch("task") }.inspect}\n#{stdout}\n#{stderr}"
          )
        end

        assert_equal(success, status.success?, "#{stdout}\n#{stderr}")
      end
    end
  end

  def run_rakefile_probe(source)
    stdout, stderr, status = Open3.capture3(RbConfig.ruby, "-e", source, chdir: ROOT)
    assert(status.success?, "#{stdout}\n#{stderr}")
    JSON.parse(stdout)
  end
end
