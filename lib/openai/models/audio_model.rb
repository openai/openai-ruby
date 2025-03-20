# frozen_string_literal: true

module OpenAI
  module Models
    module AudioModel
      extend OpenAI::Enum

      WHISPER_1 = :"whisper-1"
      GPT_4O_TRANSCRIBE = :"gpt-4o-transcribe"
      GPT_4O_MINI_TRANSCRIBE = :"gpt-4o-mini-transcribe"

      finalize!
    end
  end
end
