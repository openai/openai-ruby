# typed: strong

module OpenAI
  module LocalAudio
    sig {
      params(duration: Numeric, device: T.nilable(T.any(String, Integer)), timeout: T.nilable(Numeric)).returns(
        OpenAI::FilePart
      )
    }
    def self.record(duration:, device: nil, timeout: nil)
    end

    sig {
      params(source: T.any(IO, StringIO, OpenAI::FilePart), format: Symbol, timeout: T.nilable(Numeric)).returns(
        NilClass
      )
    }
    def self.play(source, format: :auto, timeout: nil)
    end

    sig { returns(T::Array[OpenAI::LocalAudio::Device]) }
    def self.devices
    end

    class Error < OpenAI::Errors::Error
    end

    class DependencyError < OpenAI::LocalAudio::Error
    end

    class UnsupportedPlatformError < OpenAI::LocalAudio::Error
    end

    class DeviceError < OpenAI::LocalAudio::Error
    end

    class PlaybackError < OpenAI::LocalAudio::Error
    end

    class TimeoutError < OpenAI::LocalAudio::Error
    end

    class FormatError < OpenAI::LocalAudio::Error
    end

    class CaptureOverflowError < OpenAI::LocalAudio::Error
    end

    class PlaybackPositionError < OpenAI::LocalAudio::Error
    end

    class PlaybackInterruptedError < OpenAI::LocalAudio::Error
    end

    class WorkerError < OpenAI::LocalAudio::Error
    end

    class StateError < OpenAI::LocalAudio::Error
    end

    class Device
      sig {
        params(id: String, name: String, host_api: String, max_input_channels: Integer, max_output_channels: Integer)
          .returns(T.attached_class)
      }
      def self.new(id:, name:, host_api:, max_input_channels:, max_output_channels:)
      end

      sig { returns(String) }
      attr_reader :id
      sig { returns(String) }
      attr_reader :name
      sig { returns(String) }
      attr_reader :host_api
      sig { returns(Integer) }
      attr_reader :max_input_channels
      sig { returns(Integer) }
      attr_reader :max_output_channels
    end

    class PlaybackPosition
      sig { params(played_frames: Integer, sample_rate: Integer, timing_quality: Symbol).returns(T.attached_class) }
      def self.new(played_frames:, sample_rate: 24_000, timing_quality: :device_clock_estimate)
      end

      sig { returns(Integer) }
      attr_reader :played_frames
      sig { returns(Integer) }
      attr_reader :sample_rate
      sig { returns(Symbol) }
      attr_reader :timing_quality
    end

    class Microphone
      include Enumerable
      Elem = type_member { {fixed: String} }
      sig {
        type_parameters(:U)
          .params(
            device: T.nilable(T.any(String, OpenAI::LocalAudio::Device)),
            frame_duration: Numeric,
            buffer_duration: Numeric,
            block: T.proc.params(value: OpenAI::LocalAudio::Microphone).returns(T.type_parameter(:U))
          )
          .returns(T.type_parameter(:U))
      }
      def self.open(device: nil, frame_duration: 0.02, buffer_duration: 0.25, &block)
      end

      sig {
        params(block: T.nilable(T.proc.params(pcm: String).void)).returns(
          T.any(T::Enumerator[String], OpenAI::LocalAudio::Microphone)
        )
      }
      def each(&block)
      end
      # @api private
      sig { returns(T::Boolean) }
      def started?
      end
      # @api private
      sig { returns(Integer) }
      def fence
      end
      # @api private
      sig do
        params(block: T.nilable(T.proc.params(generation: Integer, pcm: String).void))
          .returns(T.any(T::Enumerator[T::Array[T.any(Integer, String)]], OpenAI::LocalAudio::Microphone))
      end
      def each_frame(&block)
      end

      sig { returns(NilClass) }
      def stop
      end
    end

    class Player
      sig {
        type_parameters(:U)
          .params(
            device: T.nilable(T.any(String, OpenAI::LocalAudio::Device)),
            buffer_duration: Numeric,
            block: T.proc.params(value: OpenAI::LocalAudio::Player).returns(T.type_parameter(:U))
          )
          .returns(T.type_parameter(:U))
      }
      def self.open(device: nil, buffer_duration: 0.10, &block)
      end

      sig { returns(OpenAI::LocalAudio::Playback) }
      def begin_playback
      end

      sig { returns(NilClass) }
      def close
      end
    end

    class Playback
      sig { params(pcm: String).returns(Integer) }
      def write(pcm)
      end

      sig { returns(OpenAI::LocalAudio::Playback) }
      def finish
      end

      sig { returns(OpenAI::LocalAudio::PlaybackPosition) }
      def wait
      end

      sig { returns(OpenAI::LocalAudio::PlaybackPosition) }
      def interrupt
      end
    end
  end
end
