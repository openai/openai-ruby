# typed: strong

module OpenAI
  module Models
    module Audio
      class SpeechModel < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        TTS_1 = :"tts-1"
        TTS_1_HD = :"tts-1-hd"
        GPT_4O_MINI_TTS = :"gpt-4o-mini-tts"
      end
    end
  end
end
