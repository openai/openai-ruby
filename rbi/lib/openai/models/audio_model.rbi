# typed: strong

module OpenAI
  module Models
    class AudioModel < OpenAI::Enum
      abstract!

      WHISPER_1 = :"whisper-1"

      class << self
        sig { override.returns(T::Array[Symbol]) }
        def values
        end
      end
    end
  end
end
