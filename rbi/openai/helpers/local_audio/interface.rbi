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

    # @api private
    sig { params(source: T.any(IO, StringIO, OpenAI::FilePart)).returns(T.any(IO, StringIO)) }
    def self.playback_source(source)
    end

    # @api private
    sig { params(device: T.nilable(T.any(String, Integer)), platform: String).returns([String, String]) }
    def self.capture_device(device, platform: RUBY_PLATFORM)
    end

    # @api private
    sig { params(bytes: Integer).returns(String) }
    def self.wav_header(bytes)
    end

    # @api private
    class MediaProcess
      sig { returns(T::Hash[String, String]) }
      def self.environment
      end

      sig { returns(Float) }
      def self.clock
      end

      sig { params(value: Numeric, name: T.any(String, Symbol)).returns(Float) }
      def self.duration(value, name:)
      end

      sig {
        params(
          argv: T::Array[String],
          input: T.any(IO, String),
          output: T.any(IO, String),
          timeout: T.nilable(Numeric),
          error: T.any(IO, String, Tempfile)
        )
          .void
      }
      def initialize(argv, input:, output:, timeout:, error: File::NULL)
      end

      sig { void }
      def check_deadline
      end

      sig { params(io: T.any(IO, StringIO)).returns(T.nilable(String)) }
      def read(io)
      end

      sig { params(io: IO, bytes: String).void }
      def write(io, bytes)
      end

      sig { returns(Process::Status) }
      def wait
      end

      sig { void }
      def close
      end
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

  end
end
