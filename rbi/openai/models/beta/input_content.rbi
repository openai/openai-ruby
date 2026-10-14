# typed: strong

module OpenAI
  module Models

    module Beta

      # User-provided content recorded in a session item.
      module InputContent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::InputContent::InputText,
            OpenAI::Beta::InputContent::InputImage
          )
        end

        class InputText < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::InputContent::InputText,
              OpenAI::Internal::AnyHash
            )
          end

          # The text supplied to the agent.
          sig { returns(String) }
          attr_accessor :text

          # The type of the object. Always `input_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Text input recorded in a session item.
          sig do
            params(

              text: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The text supplied to the agent.
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
              OpenAI::Beta::InputContent::InputImage,
              OpenAI::Internal::AnyHash
            )
          end

          # The URL of the image supplied to the agent, which may be a base64-encoded data
          # URL.
          sig { returns(String) }
          attr_accessor :image_url

          # The type of the object. Always `input_image`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Image input recorded in a session item.
          sig do
            params(

              image_url: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The URL of the image supplied to the agent, which may be a base64-encoded data
            # URL.
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

        sig { override.returns(T::Array[OpenAI::Beta::InputContent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
