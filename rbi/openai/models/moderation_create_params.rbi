# typed: strong

module OpenAI
  module Models
    class ModerationCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::ModerationCreateParams, OpenAI::Internal::AnyHash)
        end

      # Input (or inputs) to classify. Can be a single string, an array of strings, or
      # an array of multi-modal input objects similar to other models.
      sig { returns(OpenAI::ModerationCreateParams::Input::Variants) }
      attr_accessor :input

      # The content moderation model you would like to use. Learn more in
      # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      # learn about available models
      # [here](https://platform.openai.com/docs/models#moderation).
      sig do
        returns(T.nilable(OpenAI::ModerationCreateParams::Model::Variants))
      end
      attr_reader :model

      sig do
        params(model: OpenAI::ModerationCreateParams::Model::Variants).void
      end
      attr_writer :model

      sig do
        params(
          input: OpenAI::ModerationCreateParams::Input::Variants,
          model: OpenAI::ModerationCreateParams::Model::Variants,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Input (or inputs) to classify. Can be a single string, an array of strings, or
        # an array of multi-modal input objects similar to other models.
        input:,
        # The content moderation model you would like to use. Learn more in
        # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
        # learn about available models
        # [here](https://platform.openai.com/docs/models#moderation).
        model: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            input: OpenAI::ModerationCreateParams::Input::Variants,
            model: OpenAI::ModerationCreateParams::Model::Variants,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # Input (or inputs) to classify. Can be a single string, an array of strings, or
      # an array of multi-modal input objects similar to other models.
      module Input
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              String,
              T::Array[String],
              T::Array[OpenAI::ModerationMultiModalInput::Variants]
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::ModerationCreateParams::Input::Variants]
          )
        end
        def self.variants
        end

        StringArray =
          T.let(
            OpenAI::Internal::Type::ArrayOf[String],
            OpenAI::Internal::Type::Converter
          )

        ModerationMultiModalInputArray =
          T.let(
            OpenAI::Internal::Type::ArrayOf[
              union: OpenAI::ModerationMultiModalInput
            ],
            OpenAI::Internal::Type::Converter
          )
      end

      # The content moderation model you would like to use. Learn more in
      # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      # learn about available models
      # [here](https://platform.openai.com/docs/models#moderation).
      module Model
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias { T.any(String, OpenAI::ModerationModel::TaggedSymbol) }

        sig do
          override.returns(
            T::Array[OpenAI::ModerationCreateParams::Model::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
