# typed: strong

module OpenAI
  module Models
    BetaResponseFormatTextConfig = Beta::BetaResponseFormatTextConfig

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

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseFormatTextConfig::Text,
              OpenAI::Beta::BetaResponseFormatTextJSONSchemaConfig,
              OpenAI::Beta::BetaResponseFormatTextConfig::JSONObject
            )
          end

        class Text < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseFormatTextConfig::Text,
                OpenAI::Internal::AnyHash
              )
            end

          # The type of response format being defined. Always `text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Default response format. Used to generate text responses.
          sig { params(type: Symbol).returns(T.attached_class) }
          def self.new(
            # The type of response format being defined. Always `text`.
            type: :text
          )
          end

          sig { override.returns({ type: Symbol }) }
          def to_hash
          end
        end

        class JSONObject < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseFormatTextConfig::JSONObject,
                OpenAI::Internal::AnyHash
              )
            end

          # The type of response format being defined. Always `json_object`.
          sig { returns(Symbol) }
          attr_accessor :type

          # JSON object response format. An older method of generating JSON responses. Using
          # `json_schema` is recommended for models that support it. Note that the model
          # will not generate JSON without a system or user message instructing it to do so.
          sig { params(type: Symbol).returns(T.attached_class) }
          def self.new(
            # The type of response format being defined. Always `json_object`.
            type: :json_object
          )
          end

          sig { override.returns({ type: Symbol }) }
          def to_hash
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Beta::BetaResponseFormatTextConfig::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
