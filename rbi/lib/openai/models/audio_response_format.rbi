# typed: strong

module OpenAI
  module Models
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
