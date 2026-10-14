# frozen_string_literal: true

require "rbconfig"
require "tmpdir"

# RuboCop configuration loading can temporarily change cwd. Keep those changes
# in separate processes, after formatting has completed.
module ParallelLintChecks
  TASKS = %w[lint:rubocop_directives lint:rubyfmt lint:rbs_format lint:rubocop:inspect].freeze

  def self.run(root:)
    children = []
    interrupted = nil
    previous_handlers = {}
    begin
      # Record cancellation until every spawned PID is registered and cleanup is
      # complete. Raising inside a trap can interrupt either critical operation.
      %w[INT TERM].each do |name|
        previous_handlers[name] = Signal.trap(name) { interrupted ||= name }
      end

      successful = Dir.mktmpdir("openai-ruby-lint-") do |directory|
        begin
          TASKS.each_with_index do |task, index|
            break if interrupted

            child = {task: task, output: File.join(directory, "#{index}.log")}
            children << child
            begin
              File.open(child.fetch(:output), "wb") do |output|
                # Reuse the activated bundle without invoking Bundler's CLI again.
                child[:pid] = Process.spawn(
                  RbConfig.ruby,
                  "-rbundler/setup",
                  Gem.bin_path("rake", "rake"),
                  task,
                  chdir: root,
                  out: output,
                  err: output,
                  pgroup: true
                )
              end

            rescue SystemCallError => error
              child[:error] = error
            end
          end

          pending = children.select { _1.key?(:pid) }
          until pending.empty? || interrupted
            pending.delete_if do |child|
              result = Process.wait2(child.fetch(:pid), Process::WNOHANG)
              next false unless result

              child[:status] = result.last
              # Clean up each finished lane without waiting for unrelated checks.
              stop(child.fetch(:pid))
              child[:group_stopped] = true
            end

            sleep(0.01) unless pending.empty? || interrupted
          end

          children.all? { _1[:status]&.success? }
        ensure
          # A cancelled coordinator must not leave RuboCop/xargs descendants running.
          pending = children.select { _1.key?(:pid) && !_1[:group_stopped] }
          pending.each { stop(_1.fetch(:pid)) }
          pending.each do |child|
            next if child.key?(:status)

            child[:status] = Process.wait2(child.fetch(:pid)).last
          rescue Errno::ECHILD
            # An exception can arrive after wait2 reaped the child, before assignment.
            nil
          end

          # Retain diagnostics on interruption before the private log directory is removed.
          children.each do |child|
            status = child[:status]
            outcome = if child[:error]
              "could not start: #{child.fetch(:error).message}"
            elsif status.nil?
              "interrupted"
            elsif status.signaled?
              "signal #{status.termsig}"
            else
              "exit #{status.exitstatus}"
            end

            $stdout.puts("=== #{child.fetch(:task)}: #{outcome} ===")
            $stdout.flush
            File.open(child.fetch(:output), "rb") { IO.copy_stream(_1, $stdout) } if File.file?(child.fetch(:output))
          end
        end
      end

      successful
    ensure
      begin
        Signal.trap("INT", previous_handlers.fetch("INT")) if previous_handlers.key?("INT")
      ensure
        Signal.trap("TERM", previous_handlers.fetch("TERM")) if previous_handlers.key?("TERM")
      end
      # A signal can be recorded until its original handler is restored.
      raise SignalException, interrupted if interrupted
    end
  end

  def self.stop(pid)
    Process.kill("KILL", -pid)

  rescue Errno::ESRCH
    nil
  end
end
