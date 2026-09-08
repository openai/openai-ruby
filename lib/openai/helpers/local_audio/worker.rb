# frozen_string_literal: true

module OpenAI
  module LocalAudio
    # The process owns one native stream generation. Ruby threads never enter a
    # native device callback. Control has an independent pipe from output media.
    # @api private
    class Worker
      CONTROL_TIMEOUT = 5.0
      CLEANUP_TIMEOUT = 2.0

      def self.executable
        require "openai_audio"

        unless OpenAIAudio::PROTOCOL_VERSION == 1 && File.executable?(OpenAIAudio.worker_path)
          raise DependencyError, "Install a compatible openai-audio native companion (protocol 1)."
        end

        OpenAIAudio.worker_path
      rescue LoadError
        raise DependencyError.new("Live devices require the optional openai-audio gem."), cause: nil
      end

      def initialize(
        mode:,
        device:,
        buffer_duration:,
        frame_samples: 480,
        control_timeout: CONTROL_TIMEOUT,
        cleanup_timeout: CLEANUP_TIMEOUT
      )
        @control_timeout = MediaProcess.duration(control_timeout, name: :control_timeout)
        @cleanup_timeout = MediaProcess.duration(cleanup_timeout, name: :cleanup_timeout)
        @mutex = Mutex.new
        @changed = ConditionVariable.new
        @write_lock = Mutex.new
        @control_lock = Mutex.new
        @frame_bytes = frame_samples * 2
        @sequence = 0
        @responses = {}
        @frames = []
        bytes = buffer_duration * 48_000
        raise ArgumentError, "buffer_duration is not representable" unless bytes.finite?
        @buffer_bytes = [bytes.ceil, @frame_bytes].max
        @queued_bytes = 0
        control_reader, @control = IO.pipe(binmode: true)
        @output, output_writer = IO.pipe(binmode: true)
        media_reader, @media = IO.pipe(binmode: true)
        begin
          @pid = Process.spawn(
            MediaProcess.environment,
            self.class.executable,
            mode.to_s,
            device || "default",
            buffer_duration.to_s,
            frame_samples.to_s,
            in: control_reader,
            out: output_writer,
            err: media_reader,
            unsetenv_others: true,
            close_others: true
          )
        ensure
          [control_reader, output_writer, media_reader].each(&:close)
        end

        @reader = Thread.new { receive }
        @reader.report_on_exception = false
        wait_for { @ready }
        initialized = true
      ensure
        close unless initialized
      end

      def inspect = "#<OpenAI::LocalAudio::Worker>"

      def start = command("start")
      def fence = command("gate")

      def interrupt
        @mutex.synchronize { return @position if @terminal }
        command("abort")
      end

      def write(bytes)
        @write_lock.synchronize do
          offset = 0
          while offset < bytes.bytesize
            chunk = bytes.byteslice(offset, 8192)
            media_request(chunk)
            offset += chunk.bytesize
          end
        end

        bytes.bytesize
      end

      def finish
        @write_lock.synchronize { media_request("".b) }
        nil
      end

      def wait
        wait_for(timeout: nil) { @terminal }
        @mutex.synchronize { @position }
      end

      def next_frame
        wait_for(timeout: nil) { !@frames.empty? || @closed }
        @mutex.synchronize do
          frame = @frames.shift
          @queued_bytes -= frame[1].bytesize if frame && frame[1]
          frame
        end
      end

      def close
        return unless @mutex
        @mutex.synchronize do
          return if @closed
          @closed = true
          @frames.clear
          @queued_bytes = 0
          @changed.broadcast
        end

        @control&.close unless @control&.closed?
        deadline = MediaProcess.clock + @cleanup_timeout
        if @pid
          result = nil
          until result || MediaProcess.clock >= deadline
            result = Process.waitpid2(@pid, Process::WNOHANG)
            sleep(0.01) unless result
          end

          unless result
            begin
              Process.kill("KILL", @pid)
            rescue Errno::ESRCH
              nil
            end

            Process.waitpid(@pid)
          end

          @pid = nil
        end

      ensure
        [@media, @output].compact.each { |io| io.close unless io.closed? }
        @reader&.join(@cleanup_timeout) unless @reader == Thread.current
      end

      private def command(operation)
        @control_lock.synchronize { send_command(operation) }
      end

      private def send_command(operation)
        id = @mutex.synchronize do
          check_state
          @sequence += 1
          @control.write("#{@sequence} #{operation}\n")
          @sequence
        end

        wait_for { @responses.key?(id) }
        @mutex.synchronize { @responses.delete(id) }
      end

      private def media_request(bytes)
        id = @mutex.synchronize do
          check_state
          raise PlaybackInterruptedError, "Playback has ended." if @terminal
          @sequence += 1
        end

        packet = [id, bytes.bytesize].pack("VV") + bytes
        offset = 0
        # A media write is interruptible even when native staging is full.
        while offset < packet.bytesize
          @mutex.synchronize do
            check_state
            raise PlaybackInterruptedError, "Playback was interrupted." if @terminal
          end

          count = @media.write_nonblock(packet.byteslice(offset..), exception: false)
          count == :wait_writable ? @media.wait_writable(0.02) : offset += count
        end

        wait_for(timeout: nil) { @responses.key?(id) || @terminal }
        @mutex.synchronize do
          raise PlaybackInterruptedError, "Playback was interrupted." unless @responses.key?(id)
          @responses.delete(id)
        end

      rescue IOError, SystemCallError
        raise WorkerError.new("Native audio media pipe failed."), cause: nil
      end

      private def wait_for(timeout: @control_timeout)
        deadline = MediaProcess.clock + timeout if timeout
        @mutex.synchronize do
          loop do
            raise @error if @error
            return if yield
            raise StateError, "Audio device is closed." if @closed
            remaining = deadline && (deadline - MediaProcess.clock)
            raise TimeoutError, "Native audio control timed out." if remaining && remaining <= 0
            @changed.wait(@mutex, remaining)
          end
        end

      rescue TimeoutError
        close
        raise
      end

      private def check_state
        raise @error if @error
        raise StateError, "Audio device is closed." if @closed
      end

      private def receive
        while (line = @output.gets(256))
          match = /\A(\d+) ([a-z_]+) (\d+)\n\z/.match(line)
          raise WorkerError, "Invalid native audio protocol." unless match
          id, code, value = match[1].to_i, match[2], match[3].to_i
          if code == "pcm"
            unless value.positive? && value.even? && value <= @frame_bytes
              raise WorkerError, "Invalid native audio frame size."
            end

            frame = @output.read(value)
          end

          @mutex.synchronize do
            case code
            when "ready"
              @ready = true
            when "started", "accepted"
              @responses[id] = value
            when "fenced"
              @frames << [value, nil].freeze
              @responses[id] = value
            when "interrupted", "finished"
              @terminal = true
              @position = value
              @responses[id] = value unless id.zero?
            when "pcm"
              raise WorkerError, "Incomplete native audio frame." unless frame && frame.bytesize == value && value.even?
              if @queued_bytes + frame.bytesize > @buffer_bytes
                raise CaptureOverflowError, "Microphone consumer fell behind."
              end

              unless @closed
                @frames << [id, frame.b.freeze].freeze
                @queued_bytes += frame.bytesize
              end

            when "closed"
              raise DeviceError, "Native audio device closed unexpectedly." unless @closed
            when "capture_error"
              raise CaptureOverflowError, "Capture continuity was lost."
            when "playback_error"
              raise PlaybackPositionError, "Playback timing or device continuity was lost."
            else
              raise WorkerError, "Unknown native audio protocol response."
            end

            @changed.broadcast
          end
        end

        raise DeviceError, "Native audio worker exited unexpectedly." unless @closed
      rescue StandardError
        @mutex.synchronize do
          @error ||= $! unless @closed
          @changed.broadcast
        end

        @control.close unless @control.closed?
      end
    end
  end
end
