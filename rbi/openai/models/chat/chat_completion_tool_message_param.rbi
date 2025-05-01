# typed: strong

module OpenAI
  module Models
    ChatCompletionToolMessageParam = Chat::ChatCompletionToolMessageParam

    module Chat
      class ChatCompletionToolMessageParam < OpenAI::Internal::Type::BaseModel
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
            content: T.any(
              String,
              T::Array[T.any(OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Internal::AnyHash)]
            ),
            tool_call_id: String,
            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          # The contents of the tool message.
          content:,
          # Tool call that this message is responding to.
          tool_call_id:,
          # The role of the messages author, in this case `tool`.
          role: :tool
        ); end
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
        def to_hash; end

        # The contents of the tool message.
        module Content
          extend OpenAI::Internal::Type::Union

          sig { override.returns([String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]]) }
          def self.variants; end

          ChatCompletionContentPartTextArray =
            T.let(
              OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Chat::ChatCompletionContentPartText],
              OpenAI::Internal::Type::Converter
            )
        end
      end
    end
  end
end
