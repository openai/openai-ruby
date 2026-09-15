#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "rbconfig"

module RealtimeSmoke
  # Child output is discarded at the OS boundary, including transport diagnostics,
  # dependency warnings, exception backtraces and raw example output.
  class Launcher
    def initialize(output: $stdout, environment: ENV, worker: File.join(__dir__, "worker.rb"), deadline: 75)
      @output = output
      @environment = environment
      @worker = worker
      @deadline = deadline
    end

    def run(selection)
      unless %w[audio browser].include?(selection)
        report("configuration", "unavailable")
        return 2
      end

      unless @environment["OPENAI_REALTIME_LIVE_SMOKE"] == "1"
        report(selection, "skipped")
        return 2
      end

      if @environment.fetch("OPENAI_API_KEY", "").strip.empty?
        report(selection, "unavailable")
        return 2
      end
      # Explicit integration dependency: never substitute fabricated SDP or a
      # successful placeholder for the sibling native-browser reference workflow.
      if selection == "browser"
        report(selection, "unavailable")
        return 2
      end

      status = execute
      report(selection, status == 0 ? "passed" : "failed")
      status
    rescue StandardError
      report("harness", "failed")
      1
    end

    private def report(scenario, status)
      @output.puts(
        JSON.generate(scenario: scenario, status: status, evidence: status == "passed" ? "live_network" : "none")
      )
    end

    private def execute
      pid = Process.spawn(
        {"OPENAI_REALTIME_LIVE_SMOKE" => "1", "OPENAI_API_KEY" => @environment.fetch("OPENAI_API_KEY")},
        RbConfig.ruby,
        @worker,
        in: File::NULL,
        out: File::NULL,
        err: File::NULL,
        pgroup: true
      )
      deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + @deadline
      loop do
        result = Process.waitpid2(pid, Process::WNOHANG)
        if result
          pid = nil
          return result.last.success? ? 0 : 1
        end

        break if Process.clock_gettime(Process::CLOCK_MONOTONIC) >= deadline
        sleep(0.1)
      end

      1
    ensure
      if pid
        begin
          Process.kill("KILL", -pid)
        rescue Errno::ESRCH
          nil
        end

        begin
          Process.waitpid(pid)
        rescue Errno::ECHILD
          nil
        end
      end
    end
  end
end

exit(RealtimeSmoke::Launcher.new.run(ARGV.fetch(0, ""))) if $PROGRAM_NAME == __FILE__
