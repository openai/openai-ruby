# typed: strong

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

        Variants =
          T.type_alias do
            T.any(
              OpenAI::ResponseFormatText,
              OpenAI::Responses::ResponseFormatTextJSONSchemaConfig,
              OpenAI::ResponseFormatJSONObject
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Responses::ResponseFormatTextConfig::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
