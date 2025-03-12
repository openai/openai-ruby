# typed: strong

module OpenAI
  module Models
    module Audio
      class SpeechModel < OpenAI::Enum
        abstract!

        TTS_1 = :"tts-1"
        TTS_1_HD = :"tts-1-hd"

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
