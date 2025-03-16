# typed: strong

module OpenAI
  module Models
    class AudioModel < OpenAI::Enum
      abstract!

      Value = type_template(:out) { {fixed: Symbol} }

      WHISPER_1 = :"whisper-1"
    end
  end
end
