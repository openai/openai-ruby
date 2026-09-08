# frozen_string_literal: true

require "minitest/autorun"
require "open3"

$stdout.sync = true
$stderr.sync = true

module TestTiming
  def run
    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    super
  ensure
    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started
    warn(format("PROFILE test %.3f %s#%s", elapsed, self.class, name)) if elapsed >= 1
  end
end

Minitest::Test.prepend(TestTiming)

module SubprocessTiming
  def capture3(*args, **opts)
    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    super
  ensure
    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started
    command = args.first.is_a?(Hash) ? args[1] : args.first
    if elapsed >= 1
      warn(
        format(
          "PROFILE subprocess %.3f %s %s",
          elapsed,
          File.basename(command.to_s),
          caller.find { |line| line.include?("_test.rb") }
        )
      )
    end
  end
end

Open3.singleton_class.prepend(SubprocessTiming)
