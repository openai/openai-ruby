# typed: strong

module OpenAI
  module Models
    class AudioModel < OpenAI::Enum
      abstract!

      Value = type_template(:out) { {fixed: Symbol} }

      WHISPER_1 = :"whisper-1"
      GPT_4O_TRANSCRIBE = :"gpt-4o-transcribe"
      GPT_4O_MINI_TRANSCRIBE = :"gpt-4o-mini-transcribe"
    end
  end
end
