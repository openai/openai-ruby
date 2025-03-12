# typed: strong

module OpenAI
  module Models
    ChatCompletionFunctionMessageParam = T.type_alias { Chat::ChatCompletionFunctionMessageParam }

    module Chat
      class ChatCompletionFunctionMessageParam < OpenAI::BaseModel
        sig { returns(T.nilable(String)) }
        def content
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def content=(_)
        end

        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

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
