# typed: strong

module OpenAI
  module Models
    ChatCompletionPredictionContent = Chat::ChatCompletionPredictionContent

    module Chat
      class ChatCompletionPredictionContent < OpenAI::Internal::Type::BaseModel
        # The content that should be matched when generating a model response. If
        # generated tokens would match this content, the entire model response can be
        # returned much more quickly.
        sig { returns(T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText])) }
        attr_accessor :content

        # The type of the predicted content you want to provide. This type is currently
        # always `content`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Static predicted output content, such as the content of a text file that is
        # being regenerated.
        sig do
          params(
            content: T.any(
              String,
              T::Array[T.any(OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Internal::AnyHash)]
            ),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          # The content that should be matched when generating a model response. If
          # generated tokens would match this content, the entire model response can be
          # returned much more quickly.
          content:,
          # The type of the predicted content you want to provide. This type is currently
          # always `content`.
          type: :content
        ); end
        sig do
          override
            .returns(
              {content: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]), type: Symbol}
            )
        end
        def to_hash; end

        # The content that should be matched when generating a model response. If
        # generated tokens would match this content, the entire model response can be
        # returned much more quickly.
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
