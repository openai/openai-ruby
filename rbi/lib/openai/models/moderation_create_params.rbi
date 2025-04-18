# typed: strong

module OpenAI
  module Models
    class ModerationCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # Input (or inputs) to classify. Can be a single string, an array of strings, or
      # an array of multi-modal input objects similar to other models.
      sig do
        returns(
          T.any(
            String,
            T::Array[String],
            T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
          )
        )
      end
      attr_accessor :input

      # The content moderation model you would like to use. Learn more in
      # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      # learn about available models
      # [here](https://platform.openai.com/docs/models#moderation).
      sig { returns(T.nilable(T.any(String, OpenAI::Models::ModerationModel::OrSymbol))) }
      attr_reader :model

      sig { params(model: T.any(String, OpenAI::Models::ModerationModel::OrSymbol)).void }
      attr_writer :model

      sig do
        params(
          input: T.any(
            String,
            T::Array[String],
            T::Array[
              T.any(
                OpenAI::Models::ModerationImageURLInput,
                OpenAI::Internal::AnyHash,
                OpenAI::Models::ModerationTextInput
              )
            ]
          ),
          model: T.any(String, OpenAI::Models::ModerationModel::OrSymbol),
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(input:, model: nil, request_options: {}); end

      sig do
        override
          .returns(
            {
              input: T.any(
                String,
                T::Array[String],
                T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
              ),
              model: T.any(String, OpenAI::Models::ModerationModel::OrSymbol),
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash; end

      # Input (or inputs) to classify. Can be a single string, an array of strings, or
      # an array of multi-modal input objects similar to other models.
      module Input
        extend OpenAI::Internal::Type::Union

        sig do
          override
            .returns(
              [String, T::Array[String], T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]]
            )
        end
        def self.variants; end

        StringArray = T.let(OpenAI::Internal::Type::ArrayOf[String], OpenAI::Internal::Type::Converter)

        ModerationMultiModalInputArray =
          T.let(
            OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::ModerationMultiModalInput],
            OpenAI::Internal::Type::Converter
          )
      end

      # The content moderation model you would like to use. Learn more in
      # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      # learn about available models
      # [here](https://platform.openai.com/docs/models#moderation).
      module Model
        extend OpenAI::Internal::Type::Union

        sig { override.returns([String, OpenAI::Models::ModerationModel::TaggedSymbol]) }
        def self.variants; end
      end
    end
  end
end
