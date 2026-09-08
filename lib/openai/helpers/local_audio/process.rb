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

      def initialize(argv, input:, output:, timeout:, capture_errors: false)
        @deadline = self.class.clock + self.class.duration(timeout, name: :timeout) unless timeout.nil?
        @error_reader, error_writer = IO.pipe(binmode: true) if capture_errors
        @pid = Process.spawn(
          self.class.environment,
          *argv,
          in: input,
          out: output,
          err: error_writer || File::NULL,
          close_others: true,
          unsetenv_others: true
        )
      rescue Errno::ENOENT
        @error_reader&.close
        raise DependencyError.new("Install the required FFmpeg/FFplay executable on PATH."), cause: nil
      rescue SystemCallError
        @error_reader&.close
        raise DeviceError.new("Cannot start the local audio executable."), cause: nil
      ensure
        error_writer&.close
      end

      def check_deadline
        raise TimeoutError, "Local audio operation timed out." if @deadline && self.class.clock >= @deadline
        errors?
      end

      # Drain at most one chunk per polling step, retaining no diagnostic content.
      def errors?
        if @error_reader && !@error_reader.closed?
          chunk = @error_reader.read_nonblock(65_536, exception: false)
          @errors = true if chunk.is_a?(String) && !chunk.empty?
        end

        !!@errors
      end

      def read(io, stop_on_exit: false)
        loop do
          check_deadline
          return io.read(65_536) if io.is_a?(StringIO)
          result = io.read_nonblock(65_536, exception: false)
          return result unless result == :wait_readable
          if stop_on_exit
            reap
            raise PlaybackError, "Audio player exited before the input ended." if @status
          end

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
        @error_reader&.close unless @error_reader&.closed?
      end

      private def reap
        return if @status
        result = Process.waitpid2(@pid, Process::WNOHANG)
        @status = result.last if result
      end

      private def signal(name)
        Process.kill(name, @pid)
      rescue Errno::EINVAL
        # Windows rejects TERM for another process; KILL still terminates it.
        raise unless name == "TERM"
        signal("KILL")
      rescue Errno::ESRCH
        nil
      end
    end
  end
end
