# typed: strong

module OpenAI
  module Models
    # The format of the output, in one of these options: `json`, `text`, `srt`,
    #   `verbose_json`, or `vtt`.
    class AudioResponseFormat < OpenAI::Enum
      abstract!

      JSON = :json
      TEXT = :text
      SRT = :srt
      VERBOSE_JSON = :verbose_json
      VTT = :vtt

      class << self
        sig { override.returns(T::Array[Symbol]) }
        def values
        end
      end
    end
  end
end
