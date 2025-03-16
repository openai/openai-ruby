# typed: strong

module OpenAI
  module Models
    ChatCompletionRole = T.type_alias { Chat::ChatCompletionRole }

    module Chat
      # The role of the author of a message
      class ChatCompletionRole < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        DEVELOPER = :developer
        SYSTEM = :system
        USER = :user
        ASSISTANT = :assistant
        TOOL = :tool
        FUNCTION = :function
      end
    end
  end
end
