# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      module SpeechModel
        extend OpenAI::Internal::Type::Enum

        TTS_1 = :"tts-1"
        TTS_1_HD = :"tts-1-hd"
        GPT_4O_MINI_TTS = :"gpt-4o-mini-tts"
        GPT_4O_MINI_TTS_2025_12_15 = :"gpt-4o-mini-tts-2025-12-15"

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
