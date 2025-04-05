# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionFunctionMessageParam < OpenAI::Internal::Type::BaseModel
        # The contents of the function message.
        sig { returns(T.nilable(String)) }
        attr_accessor :content

        # The name of the function to call.
        sig { returns(String) }
        attr_accessor :name

        # The role of the messages author, in this case `function`.
        sig { returns(Symbol) }
        attr_accessor :role

        sig { params(content: T.nilable(String), name: String, role: Symbol).returns(T.attached_class) }
        def self.new(content:, name:, role: :function); end

        sig { override.returns({content: T.nilable(String), name: String, role: Symbol}) }
        def to_hash; end
      end
    end

    ChatCompletionFunctionMessageParam = Chat::ChatCompletionFunctionMessageParam
  end
end
