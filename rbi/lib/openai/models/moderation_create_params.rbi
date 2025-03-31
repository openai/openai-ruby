# typed: strong

module OpenAI
  module Models
    class ModerationCreateParams < OpenAI::BaseModel
      extend OpenAI::Type::RequestParameters::Converter
      include OpenAI::RequestParameters

      # Input (or inputs) to classify. Can be a single string, an array of strings, or
      #   an array of multi-modal input objects similar to other models.
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
      #   [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      #   learn about available models
      #   [here](https://platform.openai.com/docs/models#moderation).
      sig { returns(T.nilable(T.any(String, OpenAI::Models::ModerationModel::OrSymbol))) }
      attr_reader :model

      sig { params(model: T.any(String, OpenAI::Models::ModerationModel::OrSymbol)).void }
      attr_writer :model

      sig do
        params(
          input: T.any(
            String,
            T::Array[String],
            T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Util::AnyHash, OpenAI::Models::ModerationTextInput)]
          ),
          model: T.any(String, OpenAI::Models::ModerationModel::OrSymbol),
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(input:, model: nil, request_options: {})
      end

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
      def to_hash
      end

      # Input (or inputs) to classify. Can be a single string, an array of strings, or
      #   an array of multi-modal input objects similar to other models.
      module Input
        extend OpenAI::Union

        sig do
          override
            .returns(
              [String, T::Array[String], T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]]
            )
        end
        def self.variants
        end

        StringArray = T.let(OpenAI::ArrayOf[String], OpenAI::Type::Converter)

        ModerationMultiModalInputArray =
          T.let(OpenAI::ArrayOf[union: OpenAI::Models::ModerationMultiModalInput], OpenAI::Type::Converter)
      end

      # The content moderation model you would like to use. Learn more in
      #   [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      #   learn about available models
      #   [here](https://platform.openai.com/docs/models#moderation).
      module Model
        extend OpenAI::Union

        sig { override.returns([String, OpenAI::Models::ModerationModel::OrSymbol]) }
        def self.variants
        end
      end
    end
  end
end
