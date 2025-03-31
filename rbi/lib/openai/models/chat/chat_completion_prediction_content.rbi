# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionPredictionContent < OpenAI::BaseModel
        # The content that should be matched when generating a model response. If
        #   generated tokens would match this content, the entire model response can be
        #   returned much more quickly.
        sig { returns(T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText])) }
        attr_accessor :content

        # The type of the predicted content you want to provide. This type is currently
        #   always `content`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Static predicted output content, such as the content of a text file that is
        #   being regenerated.
        sig do
          params(
            content: T.any(String, T::Array[T.any(OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Util::AnyHash)]),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content:, type: :content)
        end

        sig do
          override
            .returns(
              {content: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]), type: Symbol}
            )
        end
        def to_hash
        end

        # The content that should be matched when generating a model response. If
        #   generated tokens would match this content, the entire model response can be
        #   returned much more quickly.
        module Content
          extend OpenAI::Union

          sig { override.returns([String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]]) }
          def self.variants
          end

          ChatCompletionContentPartTextArray =
            T.let(OpenAI::ArrayOf[OpenAI::Models::Chat::ChatCompletionContentPartText], OpenAI::Type::Converter)
        end
      end
    end

    ChatCompletionPredictionContent = Chat::ChatCompletionPredictionContent
  end
end
