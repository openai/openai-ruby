# frozen_string_literal: true

module OpenAI
  module LocalAudio
    class Error < OpenAI::Errors::Error
    end

    class DependencyError < Error
    end

    class UnsupportedPlatformError < Error
    end

    class DeviceError < Error
    end

    class PlaybackError < Error
    end

    class TimeoutError < Error
    end

    class FormatError < Error
    end

    class CaptureOverflowError < Error
    end

    class PlaybackPositionError < Error
    end

    class PlaybackInterruptedError < Error
    end

    class WorkerError < Error
    end

    class StateError < Error
    end
  end
end
