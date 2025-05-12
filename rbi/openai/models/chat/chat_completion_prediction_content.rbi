# typed: strong

module OpenAI
  module Models
    ChatCompletionPredictionContent = Chat::ChatCompletionPredictionContent

    module Chat
      class ChatCompletionPredictionContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionPredictionContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The content that should be matched when generating a model response. If
        # generated tokens would match this content, the entire model response can be
        # returned much more quickly.
        sig do
          returns(
            T.any(String, T::Array[OpenAI::Chat::ChatCompletionContentPartText])
          )
        end
        attr_accessor :content

        # The type of the predicted content you want to provide. This type is currently
        # always `content`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Static predicted output content, such as the content of a text file that is
        # being regenerated.
        sig do
          params(
            content:
              T.any(
                String,
                T::Array[OpenAI::Chat::ChatCompletionContentPartText::OrHash]
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The content that should be matched when generating a model response. If
          # generated tokens would match this content, the entire model response can be
          # returned much more quickly.
          content:,
          # The type of the predicted content you want to provide. This type is currently
          # always `content`.
          type: :content
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
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # The content that should be matched when generating a model response. If
        # generated tokens would match this content, the entire model response can be
        # returned much more quickly.
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
                OpenAI::Chat::ChatCompletionPredictionContent::Content::Variants
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
