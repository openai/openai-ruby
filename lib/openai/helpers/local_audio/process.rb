# frozen_string_literal: true

require "io/wait"

module OpenAI
  module LocalAudio
    # An owned media child. No credentials, shell, inherited descriptors or diagnostics.
    # @api private
    class MediaProcess
      ENVIRONMENT_KEYS = %w[
        PATH
        HOME
        TMPDIR
        LANG
        LC_ALL
        SystemRoot
        WINDIR
        USERPROFILE
        APPDATA
        LOCALAPPDATA
        XDG_RUNTIME_DIR
        PULSE_SERVER
        SDL_AUDIODRIVER
      ]
        .freeze
      private_constant :ENVIRONMENT_KEYS

      def self.environment = ENV.to_h.slice(*ENVIRONMENT_KEYS)
      def self.clock = Process.clock_gettime(Process::CLOCK_MONOTONIC)

      def self.duration(value, name:)
        unless value.is_a?(Numeric) && value.real? && value.finite? && value.positive?
          raise ArgumentError, "#{name} must be a positive finite number of seconds"
        end

        result = value.to_f
        raise ArgumentError, "#{name} is not representable" unless result.finite?
        result
      end

      def initialize(argv, input:, output:, timeout:, error: File::NULL)
        @deadline = self.class.clock + self.class.duration(timeout, name: :timeout) if timeout
        @pid = Process.spawn(
          self.class.environment,
          *argv,
          in: input,
          out: output,
          err: error,
          close_others: true,
          unsetenv_others: true
        )
      rescue Errno::ENOENT
        raise DependencyError.new("Install the required FFmpeg/FFplay executable on PATH."), cause: nil
      rescue SystemCallError
        raise DeviceError.new("Cannot start the local audio executable."), cause: nil
      end

      def check_deadline
        raise TimeoutError, "Local audio operation timed out." if @deadline && self.class.clock >= @deadline
      end

      def read(io)
        loop do
          check_deadline
          return io.read(65_536) if io.is_a?(StringIO)
          result = io.read_nonblock(65_536, exception: false)
          return result unless result == :wait_readable
          io.wait_readable(0.05)
        end
      end

      def write(io, bytes)
        offset = 0
        while offset < bytes.bytesize
          check_deadline
          result = io.write_nonblock(bytes.byteslice(offset, 65_536), exception: false)
          if result == :wait_writable
            io.wait_writable(0.05)
          else
            offset += result
          end
        end

      rescue Errno::EPIPE
        raise PlaybackError.new("Audio player closed before receiving the input."), cause: nil
      end

      def wait
        until @status
          check_deadline
          reap
          sleep(0.01) unless @status
        end

        @status
      end

      def close
        return unless @pid
        reap
        unless @status
          signal("TERM")
          deadline = self.class.clock + 0.25
          until @status || self.class.clock >= deadline
            reap
            sleep(0.01) unless @status
          end

          unless @status
            signal("KILL")
            _, @status = Process.waitpid2(@pid)
          end
        end

      ensure
        @pid = nil
      end

      private def reap
        return if @status
        result = Process.waitpid2(@pid, Process::WNOHANG)
        @status = result.last if result
      end

      private def signal(name)
        Process.kill(name, @pid)
      rescue Errno::ESRCH
        nil
      end
    end
  end
end
