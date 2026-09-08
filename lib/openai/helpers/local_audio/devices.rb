# frozen_string_literal: true

require_relative "worker"

module OpenAI
  module LocalAudio
    Device = Data.define(:id, :name, :host_api, :max_input_channels, :max_output_channels) do
      def inspect = "#<OpenAI::LocalAudio::Device>"

      def initialize(id:, name:, host_api:, max_input_channels:, max_output_channels:)
        super(
          id: id.dup.freeze,
          name: name.dup.freeze,
          host_api: host_api.dup.freeze,
          max_input_channels: max_input_channels,
          max_output_channels: max_output_channels
        )
      end
    end

    PlaybackPosition = Data.define(:played_frames, :sample_rate, :timing_quality) do
      def initialize(played_frames:, sample_rate: 24_000, timing_quality: :device_clock_estimate)
        super
      end
    end

    class << self
      def devices = device_inventory.map(&:first).freeze

      # @api private
      def device_inventory
        reader, writer = IO.pipe(binmode: true)
        child = MediaProcess.new([Worker.executable, "devices"], input: File::NULL, output: writer, timeout: 5)
        writer.close
        data = +"".b
        while (chunk = child.read(reader))
          data << chunk
        end

        raise DeviceError, "Cannot enumerate audio devices." unless child.wait.success?
        data.lines.map do |line|
          match = /\A(\d+:([0-9a-f]*):([0-9a-f]*)) (\d+) (\d+) ([01]) ([01])\n\z/.match(line)
          raise WorkerError, "Invalid native audio device descriptor." unless match
          device = Device.new(
            id: match[1],
            name: [match[2]].pack("H*").force_encoding(Encoding::UTF_8).scrub,
            host_api: [match[3]].pack("H*").force_encoding(Encoding::UTF_8).scrub,
            max_input_channels: match[4].to_i,
            max_output_channels: match[5].to_i
          )
          [device, match[6] == "1", match[7] == "1"]
        end

      ensure
        reader&.close unless reader&.closed?
        writer&.close unless writer&.closed?
        child&.close
      end

      # @api private
      def resolve_device(device, direction:)
        unless device.nil? || device.is_a?(Device) || device.is_a?(String)
          raise ArgumentError, "device must be a LocalAudio::Device, opaque device ID, or nil"
        end

        inventory = device_inventory
        id = device.is_a?(Device) ? device.id : device
        selected = inventory.find { |entry| id ? entry[0].id == id : entry[direction == :input ? 1 : 2] }
        raise DeviceError, "The selected audio device is unavailable." unless selected
        descriptor = selected.first
        channels = direction == :input ? descriptor.max_input_channels : descriptor.max_output_channels
        raise DeviceError, "The selected device does not support this audio direction." unless channels.positive?
        descriptor.id
      end

      # @api private
      def frame_samples(duration)
        frames = MediaProcess.duration(duration, name: :frame_duration) * 24_000
        unless frames.finite? && frames.positive? && frames == frames.floor
          raise ArgumentError, "frame_duration must represent a whole number of 24 kHz samples"
        end

        frames.to_i
      end
    end

    class Microphone
      include Enumerable

      def self.open(device: nil, frame_duration: 0.02, buffer_duration: 0.25)
        raise ArgumentError, "A block is required." unless block_given?
        microphone = new(device: device, frame_duration: frame_duration, buffer_duration: buffer_duration)
        begin
          yield microphone
        ensure
          microphone.stop
        end
      end

      # @api private
      def initialize(device:, frame_duration:, buffer_duration:, control_timeout: 5, cleanup_timeout: 2)
        @control_timeout = control_timeout
        @delivered_generation = 0
        @delivery_changed = ConditionVariable.new
        samples = LocalAudio.frame_samples(frame_duration)
        buffer = MediaProcess.duration(buffer_duration, name: :buffer_duration)
        @mutex = Mutex.new
        @worker = Worker.new(
          mode: :capture,
          device: LocalAudio.resolve_device(device, direction: :input),
          buffer_duration: buffer,
          frame_samples: samples,
          control_timeout: control_timeout,
          cleanup_timeout: cleanup_timeout
        )
      end

      def each
        return enum_for(:each) unless block_given?
        each_frame { |_generation, pcm| yield pcm }
      end

      # Capture-generation metadata is private to managed input fencing.
      # @api private
      def each_frame
        return enum_for(:each_frame) unless block_given?
        @mutex.synchronize do
          raise StateError, "Microphone already has a consumer or has stopped." if @consuming || @stopped
          @consuming = true
        end

        begin
          @worker.start
          @mutex.synchronize { @started = true }
          while (frame = @worker.next_frame)
            break if @mutex.synchronize { @stopped }
            if frame[1]
              yield(*frame)
            else
              @mutex.synchronize do
                @delivered_generation = frame[0]
                @delivery_changed.broadcast
              end
            end
          end

          self
        ensure
          stop
        end
      end

      # @api private
      def fence
        generation = @worker.fence
        deadline = MediaProcess.clock + @control_timeout
        @mutex.synchronize do
          until @delivered_generation >= generation
            raise StateError, "Microphone stopped during capture fence." if @stopped
            remaining = deadline - MediaProcess.clock
            raise TimeoutError, "Capture delivery fence timed out." unless remaining.positive?
            @delivery_changed.wait(@mutex, remaining)
          end
        end

        generation
      end

      # @api private
      def started? = @mutex.synchronize { @started == true }

      def inspect = "#<OpenAI::LocalAudio::Microphone>"

      def stop
        @mutex.synchronize {
          @stopped = true
          @delivery_changed.broadcast
        }
        @worker.close
        nil
      end
    end

    class Player
      def self.open(device: nil, buffer_duration: 0.10)
        raise ArgumentError, "A block is required." unless block_given?
        player = new(device: device, buffer_duration: buffer_duration)
        begin
          yield player
        ensure
          player.close
        end
      end

      # @api private
      def initialize(device:, buffer_duration:, control_timeout: 5, cleanup_timeout: 2)
        @control_timeout, @cleanup_timeout = control_timeout, cleanup_timeout
        @buffer_duration = MediaProcess.duration(buffer_duration, name: :buffer_duration)
        @device = LocalAudio.resolve_device(device, direction: :output)
        @mutex = Mutex.new
        @worker = open_worker
      end

      def inspect = "#<OpenAI::LocalAudio::Player>"

      def begin_playback
        @mutex.synchronize do
          raise StateError, "Player is closed." if @closed
          raise StateError, "Player already has an active playback." if @playback && !@playback.terminal?
          if @playback
            @worker.close
            @worker = open_worker
          end

          @worker.start
          @playback = Playback.new(@worker)
        end
      end

      def close
        @mutex.synchronize { @closed = true }
        @worker.close
        nil
      end

      private def open_worker
        Worker.new(
          mode: :playback,
          device: @device,
          buffer_duration: @buffer_duration,
          control_timeout: @control_timeout,
          cleanup_timeout: @cleanup_timeout
        )
      end
    end

    class Playback
      # @api private
      def initialize(worker)
        @worker = worker
        @mutex = Mutex.new
        @writer = Mutex.new
        @partial = "".b
      end

      def inspect = "#<OpenAI::LocalAudio::Playback>"

      def write(pcm)
        raise ArgumentError, "pcm must be a String of binary PCM16 bytes" unless pcm.is_a?(String)
        @writer.synchronize do
          @mutex.synchronize do
            raise PlaybackInterruptedError, "Playback was interrupted." if @interrupted
            raise StateError, "Playback input is finished." if @finished
          end

          bytes = @partial + pcm.b
          @partial = bytes.bytesize.odd? ? bytes.byteslice(-1, 1) : "".b
          @worker.write(bytes.byteslice(0, bytes.bytesize - @partial.bytesize))
        end

        pcm.bytesize
      end

      def finish
        @writer.synchronize do
          @mutex.synchronize do
            raise PlaybackInterruptedError, "Playback was interrupted." if @interrupted
            return self if @finished
            raise FormatError, "PCM input ends with an incomplete sample." unless @partial.empty?
            @finished = true
          end

          @worker.finish
        end

        self
      end

      def wait
        @mutex.synchronize do
          return @position if @position
          raise StateError, "Call finish before waiting for playback." unless @finished
        end

        position = PlaybackPosition.new(played_frames: @worker.wait)
        @mutex.synchronize { @position ||= position }
      end

      def interrupt
        @mutex.synchronize do
          return @position if @position
          @interrupted = true
        end

        position = PlaybackPosition.new(played_frames: @worker.interrupt)
        @mutex.synchronize { @position ||= position }
      end

      # @api private
      def terminal? = @mutex.synchronize { !@position.nil? }
    end
  end
end
