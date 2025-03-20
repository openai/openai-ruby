# typed: strong

module OpenAI
  module Models
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

    ChatCompletionRole = Chat::ChatCompletionRole
  end
end
