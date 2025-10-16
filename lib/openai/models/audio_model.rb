# frozen_string_literal: true

module OpenAI
  module Models
    module AudioModel
      extend OpenAI::Internal::Type::Enum

      WHISPER_1 = :"whisper-1"
      GPT_4O_TRANSCRIBE = :"gpt-4o-transcribe"
      GPT_4O_MINI_TRANSCRIBE = :"gpt-4o-mini-transcribe"
      GPT_4O_TRANSCRIBE_DIARIZE = :"gpt-4o-transcribe-diarize"

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end
