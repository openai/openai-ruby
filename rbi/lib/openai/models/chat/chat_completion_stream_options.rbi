# typed: strong

module OpenAI
  module Models
    ChatCompletionStreamOptions = T.type_alias { Chat::ChatCompletionStreamOptions }

    module Chat
      class ChatCompletionStreamOptions < OpenAI::BaseModel
        sig { returns(T.nilable(T::Boolean)) }
        def include_usage
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def include_usage=(_)
        end

        sig { params(include_usage: T::Boolean).returns(T.attached_class) }
        def self.new(include_usage: nil)
        end

        sig { override.returns({include_usage: T::Boolean}) }
        def to_hash
        end
      end
    end
  end
end
