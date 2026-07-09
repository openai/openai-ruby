# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # An object specifying the format that the model must output.
      #
      # Configuring `{ "type": "json_schema" }` enables Structured Outputs, which
      # ensures the model will match your supplied JSON schema. Learn more in the
      # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
      #
      # The default format is `{ "type": "text" }` with no additional options.
      #
      # **Not recommended for gpt-4o and newer models:**
      #
      # Setting to `{ "type": "json_object" }` enables the older JSON mode, which
      # ensures the message the model generates is valid JSON. Using `json_schema` is
      # preferred for models that support it.
      module BetaResponseFormatTextConfig
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Default response format. Used to generate text responses.
        variant :text, -> { OpenAI::Beta::BetaResponseFormatTextConfig::Text }

        # JSON Schema response format. Used to generate structured JSON responses.
        # Learn more about [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
        variant :json_schema, -> { OpenAI::Beta::BetaResponseFormatTextJSONSchemaConfig }

        # JSON object response format. An older method of generating JSON responses.
        # Using `json_schema` is recommended for models that support it. Note that the
        # model will not generate JSON without a system or user message instructing it
        # to do so.
        variant :json_object, -> { OpenAI::Beta::BetaResponseFormatTextConfig::JSONObject }

        class Text < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of response format being defined. Always `text`.
          #
          #   @return [Symbol, :text]
          required :type, const: :text

          # @!method initialize(type: :text)
          #   Default response format. Used to generate text responses.
          #
          #   @param type [Symbol, :text] The type of response format being defined. Always `text`.
        end

        class JSONObject < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of response format being defined. Always `json_object`.
          #
          #   @return [Symbol, :json_object]
          required :type, const: :json_object

          # @!method initialize(type: :json_object)
          #   JSON object response format. An older method of generating JSON responses. Using
          #   `json_schema` is recommended for models that support it. Note that the model
          #   will not generate JSON without a system or user message instructing it to do so.
          #
          #   @param type [Symbol, :json_object] The type of response format being defined. Always `json_object`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::BetaResponseFormatTextConfig::Text, OpenAI::Models::Beta::BetaResponseFormatTextJSONSchemaConfig, OpenAI::Models::Beta::BetaResponseFormatTextConfig::JSONObject)]
      end
    end

    BetaResponseFormatTextConfig = Beta::BetaResponseFormatTextConfig
  end
end
