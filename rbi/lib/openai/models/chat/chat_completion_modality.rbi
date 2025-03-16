# typed: strong

module OpenAI
  module Models
    ChatCompletionModality = T.type_alias { Chat::ChatCompletionModality }

    module Chat
      class ChatCompletionModality < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        TEXT = :text
        AUDIO = :audio
      end
    end
  end
end
