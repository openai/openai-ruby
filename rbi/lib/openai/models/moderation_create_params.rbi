# typed: strong

module OpenAI
  module Models
    class ModerationCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
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
      def input
      end

      sig do
        params(
          _: T.any(
            String,
            T::Array[String],
            T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
          )
        )
          .returns(
            T.any(
              String,
              T::Array[String],
              T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
            )
          )
      end
      def input=(_)
      end

      # The content moderation model you would like to use. Learn more in
      #   [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      #   learn about available models
      #   [here](https://platform.openai.com/docs/models#moderation).
      sig { returns(T.nilable(T.any(String, OpenAI::Models::ModerationModel::OrSymbol))) }
      def model
      end

      sig do
        params(_: T.any(String, OpenAI::Models::ModerationModel::OrSymbol))
          .returns(T.any(String, OpenAI::Models::ModerationModel::OrSymbol))
      end
      def model=(_)
      end

      sig do
        params(
          input: T.any(
            String,
            T::Array[String],
            T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
          ),
          model: T.any(String, OpenAI::Models::ModerationModel::OrSymbol),
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
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

        Variants =
          type_template(:out) do
            {
              fixed: T.any(
                String,
                T::Array[String],
                T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
              )
            }
          end

        StringArray = T.let(OpenAI::ArrayOf[String], OpenAI::Converter)

        ModerationMultiModalInputArray =
          T.let(OpenAI::ArrayOf[union: OpenAI::Models::ModerationMultiModalInput], OpenAI::Converter)
      end

      # The content moderation model you would like to use. Learn more in
      #   [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      #   learn about available models
      #   [here](https://platform.openai.com/docs/models#moderation).
      module Model
        extend OpenAI::Union

        Variants = type_template(:out) { {fixed: T.any(String, OpenAI::Models::ModerationModel::OrSymbol)} }
      end
    end
  end
end
