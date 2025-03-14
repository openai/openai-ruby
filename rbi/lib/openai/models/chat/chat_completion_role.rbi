# typed: strong

module OpenAI
  module Models
    ChatCompletionRole = T.type_alias { Chat::ChatCompletionRole }

    module Chat
      # The role of the author of a message
      class ChatCompletionRole < OpenAI::Enum
        abstract!

        DEVELOPER = :developer
        SYSTEM = :system
        USER = :user
        ASSISTANT = :assistant
        TOOL = :tool
        FUNCTION = :function

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
