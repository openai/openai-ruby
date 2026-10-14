# typed: strong

module OpenAI
  module Models

    module Beta

      # A content part in a session message.
      module AgentSessionMessageContent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionMessageContent::InputText,
            OpenAI::Beta::AgentSessionMessageContent::InputImage,
            OpenAI::Beta::AgentSessionMessageContent::OutputText
          )
        end

        class InputText < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentSessionMessageContent::InputText,
              OpenAI::Internal::AnyHash
            )
          end

          # The text supplied by the user.
          sig { returns(String) }
          attr_accessor :text

          # The type of the object. Always `input_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Text supplied by the user.
          sig do
            params(

              text: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The text supplied by the user.
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
              OpenAI::Beta::AgentSessionMessageContent::InputImage,
              OpenAI::Internal::AnyHash
            )
          end

          # The URL of the image supplied by the user, which may be a base64-encoded data
          # URL.
          sig { returns(String) }
          attr_accessor :image_url

          # The type of the object. Always `input_image`.
          sig { returns(Symbol) }
          attr_accessor :type

          # An image supplied by the user.
          sig do
            params(

              image_url: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The URL of the image supplied by the user, which may be a base64-encoded data
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

        class OutputText < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentSessionMessageContent::OutputText,
              OpenAI::Internal::AnyHash
            )
          end

          # The text produced by the assistant.
          sig { returns(String) }
          attr_accessor :text

          # The type of the object. Always `output_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Text produced by the assistant.
          sig do
            params(

              text: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The text produced by the assistant.
            text:,

            # The type of the object. Always `output_text`.

            type: :output_text
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

        sig { override.returns(T::Array[OpenAI::Beta::AgentSessionMessageContent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
