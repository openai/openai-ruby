# typed: strong

module OpenAI
  module Models

    module Beta

      # Content included in an input message.
      module InputContentParam
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::InputContentParam::InputText,
            OpenAI::Beta::InputContentParam::InputImage
          )
        end

        class InputText < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::InputContentParam::InputText,
              OpenAI::Internal::AnyHash
            )
          end

          # The text sent to the model.
          sig { returns(String) }
          attr_accessor :text

          # The type of the object. Always `input_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Text input to the model.
          sig do
            params(

              text: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The text sent to the model.
            text:,

            # The type of the object. Always `input_text`.

            type: :input_text
          )
          end

          sig do
            override.returns(
              {text: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class InputImage < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::InputContentParam::InputImage,
              OpenAI::Internal::AnyHash
            )
          end

          # The URL of the image sent to the model.
          sig { returns(String) }
          attr_accessor :image_url

          # The type of the object. Always `input_image`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Image input to the model.
          sig do
            params(

              image_url: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The URL of the image sent to the model.
            image_url:,

            # The type of the object. Always `input_image`.

            type: :input_image
          )
          end

          sig do
            override.returns(
              {image_url: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::InputContentParam::Variants]) }
        def self.variants
        end

      end

    end

  end
end
