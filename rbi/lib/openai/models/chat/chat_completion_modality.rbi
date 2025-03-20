# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionModality < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        TEXT = :text
        AUDIO = :audio
      end
    end

    ChatCompletionModality = Chat::ChatCompletionModality
  end
end
