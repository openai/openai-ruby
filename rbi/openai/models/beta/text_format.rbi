# typed: strong

module OpenAI
  module Models

    module Beta

      # The effective output format for generated text.
      module TextFormat
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::TextFormat::Text,
            OpenAI::Beta::TextFormat::JSONSchema
          )
        end

        class Text < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::TextFormat::Text,
              OpenAI::Internal::AnyHash
            )
          end

          # The type of the object. Always `text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Generates ordinary text without a structured-output constraint.
          sig do
            params(

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The type of the object. Always `text`.

            type: :text
          )
          end

          sig do
            override.returns(
              {type: Symbol}
            )
          end
          def to_hash
          end

        end

        class JSONSchema < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::TextFormat::JSONSchema,
              OpenAI::Internal::AnyHash
            )
          end

          # The JSON Schema that generated text must match.
          sig { returns(T::Hash[Symbol, T.anything]) }
          attr_accessor :schema

          # The type of the object. Always `json_schema`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Constrains generated text to a JSON Schema.
          sig do
            params(

              schema: T::Hash[Symbol, T.anything],

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The JSON Schema that generated text must match.
            schema:,

            # The type of the object. Always `json_schema`.

            type: :json_schema
          )
          end

          sig do
            override.returns(
              {schema: T::Hash[Symbol, T.anything], type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::TextFormat::Variants]) }
        def self.variants
        end

      end

    end

  end
end
