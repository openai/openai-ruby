# frozen_string_literal: true

module OpenAI
  module Models
    module AudioModel
      extend OpenAI::Internal::Type::Enum

      # @deprecated Announced shutdown date: 2027-02-26. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      WHISPER_1 = :"whisper-1"
      GPT_TRANSCRIBE = :"gpt-transcribe"
      # @deprecated Announced shutdown date: 2027-02-26. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_TRANSCRIBE = :"gpt-4o-transcribe"
      # @deprecated Announced shutdown date: 2027-02-26. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_MINI_TRANSCRIBE = :"gpt-4o-mini-transcribe"
      # @deprecated Announced shutdown date: 2027-02-26. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_MINI_TRANSCRIBE_2025_12_15 = :"gpt-4o-mini-transcribe-2025-12-15"
      # @deprecated Announced shutdown date: 2027-02-26. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_TRANSCRIBE_DIARIZE = :"gpt-4o-transcribe-diarize"

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end
