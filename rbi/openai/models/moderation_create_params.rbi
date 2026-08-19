# typed: strong

module OpenAI
  module Models

    class ModerationCreateParams < OpenAI::Internal::Type::BaseModel

      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash = T.type_alias do
        T.any(
          OpenAI::ModerationCreateParams,
          OpenAI::Internal::AnyHash
        )
      end

      # Input (or inputs) to classify. Can be a single string, an array of strings, or
      # an array of multi-modal input objects similar to other models.
      sig { returns(OpenAI::ModerationCreateParams::Input::Variants) }
      attr_accessor :input

      # The content moderation model you would like to use. Learn more in
      # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      # learn about available models
      # [here](https://platform.openai.com/docs/models#moderation).
      sig { returns(T.nilable(T.any(String, OpenAI::ModerationModel::OrSymbol))) }
      attr_reader :model

      sig { params(model: T.any(String, OpenAI::ModerationModel::OrSymbol)).void }
      attr_writer :model

      sig do
        params(

          input: OpenAI::ModerationCreateParams::Input::Variants,

          model: T.any(String, OpenAI::ModerationModel::OrSymbol),

          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(T.attached_class)
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
            model: T.any(String, OpenAI::ModerationModel::OrSymbol),
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

        Variants = T.type_alias {
          T.any(String, T::Array[String], T::Array[OpenAI::ModerationMultiModalInput::Variants])
        }

        sig { override.returns(T::Array[OpenAI::ModerationCreateParams::Input::Variants]) }
        def self.variants
        end

        StringArray = T.let(
          OpenAI::Internal::Type::ArrayOf[String],
          OpenAI::Internal::Type::Converter
        )

        ModerationMultiModalInputArray = T.let(
          OpenAI::Internal::Type::ArrayOf[union: OpenAI::ModerationMultiModalInput],
          OpenAI::Internal::Type::Converter
        )

      end

      # The content moderation model you would like to use. Learn more in
      # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      # learn about available models
      # [here](https://platform.openai.com/docs/models#moderation).
      module Model
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(String, OpenAI::ModerationModel::TaggedSymbol) }

        sig { override.returns(T::Array[OpenAI::ModerationCreateParams::Model::Variants]) }
        def self.variants
        end

      end

    end

  end
end
