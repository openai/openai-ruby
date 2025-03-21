# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionToolMessageParam < OpenAI::BaseModel
        # The contents of the tool message.
        sig { returns(T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText])) }
        attr_accessor :content

        # The role of the messages author, in this case `tool`.
        sig { returns(Symbol) }
        attr_accessor :role

        # Tool call that this message is responding to.
        sig { returns(String) }
        attr_accessor :tool_call_id

        sig do
          params(
            content: T.any(String, T::Array[T.any(OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Util::AnyHash)]),
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
