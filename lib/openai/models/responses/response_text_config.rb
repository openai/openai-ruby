# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseTextConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute [r] format_
        #   An object specifying the format that the model must output.
        #
        #   Configuring `{ "type": "json_schema" }` enables Structured Outputs, which
        #   ensures the model will match your supplied JSON schema. Learn more in the
        #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        #   The default format is `{ "type": "text" }` with no additional options.
        #
        #   **Not recommended for gpt-4o and newer models:**
        #
        #   Setting to `{ "type": "json_object" }` enables the older JSON mode, which
        #   ensures the message the model generates is valid JSON. Using `json_schema` is
        #   preferred for models that support it.
        #
        #   @return [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::Models::ResponseFormatJSONObject, nil]
        optional :format_, union: -> { OpenAI::Models::Responses::ResponseFormatTextConfig }, api_name: :format

        # @!parse
        #   # @return [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::Models::ResponseFormatJSONObject]
        #   attr_writer :format_

        # @!method initialize(format_: nil)
        #   Configuration options for a text response from the model. Can be plain text or
        #   structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        #
        #   @param format_ [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::Models::ResponseFormatJSONObject]
      end
    end
  end
end
