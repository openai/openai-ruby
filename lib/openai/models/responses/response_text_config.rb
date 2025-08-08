# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseTextConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute format_
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
        optional :format_, union: -> { OpenAI::Responses::ResponseFormatTextConfig }, api_name: :format

        # @!attribute verbosity
        #   Constrains the verbosity of the model's response. Lower values will result in
        #   more concise responses, while higher values will result in more verbose
        #   responses. Currently supported values are `low`, `medium`, and `high`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseTextConfig::Verbosity, nil]
        optional :verbosity, enum: -> { OpenAI::Responses::ResponseTextConfig::Verbosity }, nil?: true

        # @!method initialize(format_: nil, verbosity: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseTextConfig} for more details.
        #
        #   Configuration options for a text response from the model. Can be plain text or
        #   structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        #
        #   @param format_ [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::Models::ResponseFormatJSONObject] An object specifying the format that the model must output.
        #
        #   @param verbosity [Symbol, OpenAI::Models::Responses::ResponseTextConfig::Verbosity, nil] Constrains the verbosity of the model's response. Lower values will result in

        # Constrains the verbosity of the model's response. Lower values will result in
        # more concise responses, while higher values will result in more verbose
        # responses. Currently supported values are `low`, `medium`, and `high`.
        #
        # @see OpenAI::Models::Responses::ResponseTextConfig#verbosity
        module Verbosity
          extend OpenAI::Internal::Type::Enum

          LOW = :low
          MEDIUM = :medium
          HIGH = :high

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
