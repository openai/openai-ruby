# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionToolMessageParam < OpenAI::BaseModel
        # The contents of the tool message.
        sig { returns(T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText])) }
        def content
        end

        sig do
          params(_: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]))
            .returns(T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]))
        end
        def content=(_)
        end

        # The role of the messages author, in this case `tool`.
        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        # Tool call that this message is responding to.
        sig { returns(String) }
        def tool_call_id
        end

        sig { params(_: String).returns(String) }
        def tool_call_id=(_)
        end

        sig do
          params(
            content: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]),
            tool_call_id: String,
            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content:, tool_call_id:, role: :tool)
        end

        sig do
          override
            .returns(
              {
                content: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]),
                role: Symbol,
                tool_call_id: String
              }
            )
        end
        def to_hash
        end

        # The contents of the tool message.
        module Content
          extend OpenAI::Union

          Variants =
            type_template(:out) { {fixed: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText])} }

          ChatCompletionContentPartTextArray =
            T.let(OpenAI::ArrayOf[OpenAI::Models::Chat::ChatCompletionContentPartText], OpenAI::Converter)

          class << self
            sig { override.returns([String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]]) }
            def variants
            end
          end
        end
      end
    end

    ChatCompletionToolMessageParam = Chat::ChatCompletionToolMessageParam
  end
end
