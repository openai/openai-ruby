# typed: strong

module OpenAI
  module Models
    ChatCompletionFunctionMessageParam = T.type_alias { Chat::ChatCompletionFunctionMessageParam }

    module Chat
      class ChatCompletionFunctionMessageParam < OpenAI::BaseModel
        # The contents of the function message.
        sig { returns(T.nilable(String)) }
        def content
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def content=(_)
        end

        # The name of the function to call.
        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        # The role of the messages author, in this case `function`.
        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        sig { params(content: T.nilable(String), name: String, role: Symbol).returns(T.attached_class) }
        def self.new(content:, name:, role: :function)
        end

        sig { override.returns({content: T.nilable(String), name: String, role: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
