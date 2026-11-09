# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      module SpeechModel
        extend OpenAI::Internal::Type::Enum

        # @deprecated Announced shutdown date: 2027-01-06. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        TTS_1 = :"tts-1"
        # @deprecated Announced shutdown date: 2027-01-06. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        TTS_1_HD = :"tts-1-hd"
        # @deprecated Announced shutdown date: 2027-01-06. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        GPT_4O_MINI_TTS = :"gpt-4o-mini-tts"
        # @deprecated Announced shutdown date: 2027-01-06. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        GPT_4O_MINI_TTS_2025_12_15 = :"gpt-4o-mini-tts-2025-12-15"

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
