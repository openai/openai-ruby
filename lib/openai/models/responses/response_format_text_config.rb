# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
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
      module ResponseFormatTextConfig
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Default response format. Used to generate text responses.
        variant :text, -> { OpenAI::ResponseFormatText }

        # JSON Schema response format. Used to generate structured JSON responses.
        # Learn more about [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
        variant :json_schema, -> { OpenAI::Responses::ResponseFormatTextJSONSchemaConfig }

        # JSON object response format. An older method of generating JSON responses.
        # Using `json_schema` is recommended for models that support it. Note that the
        # model will not generate JSON without a system or user message instructing it
        # to do so.
        variant :json_object, -> { OpenAI::ResponseFormatJSONObject }

        # @!method self.variants
        #   @return [Array(OpenAI::ResponseFormatText, OpenAI::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::ResponseFormatJSONObject)]
      end
    end
  end
end
