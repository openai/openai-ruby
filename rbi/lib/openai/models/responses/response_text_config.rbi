# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextConfig < OpenAI::Internal::Type::BaseModel
        # An object specifying the format that the model must output.
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
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig,
                OpenAI::Models::ResponseFormatJSONObject
              )
            )
          )
        end
        attr_reader :format_

        sig do
          params(
            format_: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig,
              OpenAI::Models::ResponseFormatJSONObject
            )
          )
            .void
        end
        attr_writer :format_

        # Configuration options for a text response from the model. Can be plain text or
        #   structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        sig do
          params(
            format_: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig,
              OpenAI::Models::ResponseFormatJSONObject
            )
          )
            .returns(T.attached_class)
        end
        def self.new(format_: nil)
        end

        sig do
          override
            .returns(
              {
                format_: T.any(
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig,
                  OpenAI::Models::ResponseFormatJSONObject
                )
              }
            )
        end
        def to_hash
        end
      end
    end
  end
end
