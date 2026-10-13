# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionMessage < OpenAI::Internal::Type::BaseModel
        # The parsed contents of the message, if JSON schema is specified.
        sig { returns(T.nilable(T.anything)) }
        attr_accessor :parsed
      end

      class ChatCompletionMessageFunctionToolCall < OpenAI::Internal::Type::BaseModel
        class Function < OpenAI::Internal::Type::BaseModel
          # The parsed contents of the arguments.
          sig { returns(T.anything) }
          attr_accessor :parsed
        end
      end
    end
  end
end
