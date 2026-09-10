# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # The effective output format for generated text.
      module TextFormat
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Generates ordinary text without a structured-output constraint.
        variant :text, -> { OpenAI::Beta::TextFormat::Text }

        # Constrains generated text to a JSON Schema.
        variant :json_schema, -> { OpenAI::Beta::TextFormat::JSONSchema }

        class Text < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the object. Always `text`.
          #
          #   @return [Symbol, :text]
          required :type, const: :text

          # @!method initialize(type: :text)
          #   Generates ordinary text without a structured-output constraint.
          #
          #   @param type [Symbol, :text]
          #     The type of the object. Always `text`.
        end

        class JSONSchema < OpenAI::Internal::Type::BaseModel
          # @!attribute schema
          #   The JSON Schema that generated text must match.
          #
          #   @return [Hash{Symbol=>Object}]
          required :schema, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!attribute type
          #   The type of the object. Always `json_schema`.
          #
          #   @return [Symbol, :json_schema]
          required :type, const: :json_schema

          # @!method initialize(schema:, type: :json_schema)
          #   Constrains generated text to a JSON Schema.
          #
          #   @param schema [Hash{Symbol=>Object}]
          #     The JSON Schema that generated text must match.
          #
          #   @param type [Symbol, :json_schema]
          #     The type of the object. Always `json_schema`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::TextFormat::Text, OpenAI::Models::Beta::TextFormat::JSONSchema)]
      end
    end
  end
end
