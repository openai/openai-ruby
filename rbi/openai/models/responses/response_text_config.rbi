# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextConfig < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseTextConfig,
              OpenAI::Internal::AnyHash
            )
          end

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
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::ResponseFormatText,
                OpenAI::Responses::ResponseFormatTextJSONSchemaConfig,
                OpenAI::ResponseFormatJSONObject
              )
            )
          )
        end
        attr_reader :format_

        sig do
          params(
            format_:
              T.any(
                OpenAI::ResponseFormatText::OrHash,
                OpenAI::Responses::ResponseFormatTextJSONSchemaConfig::OrHash,
                OpenAI::ResponseFormatJSONObject::OrHash
              )
          ).void
        end
        attr_writer :format_

        # Constrains the verbosity of the model's response. Lower values will result in
        # more concise responses, while higher values will result in more verbose
        # responses. Currently supported values are `low`, `medium`, and `high`.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseTextConfig::Verbosity::OrSymbol
            )
          )
        end
        attr_accessor :verbosity

        # Configuration options for a text response from the model. Can be plain text or
        # structured JSON data. Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        sig do
          params(
            format_:
              T.any(
                OpenAI::ResponseFormatText::OrHash,
                OpenAI::Responses::ResponseFormatTextJSONSchemaConfig::OrHash,
                OpenAI::ResponseFormatJSONObject::OrHash
              ),
            verbosity:
              T.nilable(
                OpenAI::Responses::ResponseTextConfig::Verbosity::OrSymbol
              )
          ).returns(T.attached_class)
        end
        def self.new(
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
          format_: nil,
          # Constrains the verbosity of the model's response. Lower values will result in
          # more concise responses, while higher values will result in more verbose
          # responses. Currently supported values are `low`, `medium`, and `high`.
          verbosity: nil
        )
        end

        sig do
          override.returns(
            {
              format_:
                T.any(
                  OpenAI::ResponseFormatText,
                  OpenAI::Responses::ResponseFormatTextJSONSchemaConfig,
                  OpenAI::ResponseFormatJSONObject
                ),
              verbosity:
                T.nilable(
                  OpenAI::Responses::ResponseTextConfig::Verbosity::OrSymbol
                )
            }
          )
        end
        def to_hash
        end

        # Constrains the verbosity of the model's response. Lower values will result in
        # more concise responses, while higher values will result in more verbose
        # responses. Currently supported values are `low`, `medium`, and `high`.
        module Verbosity
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseTextConfig::Verbosity)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW =
            T.let(
              :low,
              OpenAI::Responses::ResponseTextConfig::Verbosity::TaggedSymbol
            )
          MEDIUM =
            T.let(
              :medium,
              OpenAI::Responses::ResponseTextConfig::Verbosity::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Responses::ResponseTextConfig::Verbosity::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseTextConfig::Verbosity::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
