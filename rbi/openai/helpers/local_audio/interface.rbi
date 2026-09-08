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
