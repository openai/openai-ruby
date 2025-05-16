# typed: strong

module OpenAI
  module Models
    ChatCompletionToolMessageParam = Chat::ChatCompletionToolMessageParam

    module Chat
      class ChatCompletionToolMessageParam < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionToolMessageParam,
              OpenAI::Internal::AnyHash
            )
          end

        # The contents of the tool message.
        sig do
          returns(
            T.any(String, T::Array[OpenAI::Chat::ChatCompletionContentPartText])
          )
        end
        attr_accessor :content

        # The role of the messages author, in this case `tool`.
        sig { returns(Symbol) }
        attr_accessor :role

        # Tool call that this message is responding to.
        sig { returns(String) }
        attr_accessor :tool_call_id

        sig do
          params(
            content:
              T.any(
                String,
                T::Array[OpenAI::Chat::ChatCompletionContentPartText::OrHash]
              ),
            tool_call_id: String,
            role: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The contents of the tool message.
          content:,
          # Tool call that this message is responding to.
          tool_call_id:,
          # The role of the messages author, in this case `tool`.
          role: :tool
        )
        end

        sig do
          override.returns(
            {
              content:
                T.any(
                  String,
                  T::Array[OpenAI::Chat::ChatCompletionContentPartText]
                ),
              role: Symbol,
              tool_call_id: String
            }
          )
        end
        def to_hash
        end

        # The contents of the tool message.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                T::Array[OpenAI::Chat::ChatCompletionContentPartText]
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Chat::ChatCompletionToolMessageParam::Content::Variants
              ]
            )
          end
          def self.variants
          end

          ChatCompletionContentPartTextArray =
            T.let(
              OpenAI::Internal::Type::ArrayOf[
                OpenAI::Chat::ChatCompletionContentPartText
              ],
              OpenAI::Internal::Type::Converter
            )
        end
      end
    end
  end
end
