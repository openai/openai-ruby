# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseConfigurationUpdateItemParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseConfigurationUpdateItemParam,
            OpenAI::Internal::AnyHash
          )
        end

        # The item type. Always `configuration_update`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The unique ID of the configuration update item.
        sig { returns(T.nilable(String)) }
        attr_accessor :id

        # Updates to reasoning configuration. Only effort is supported.
        sig { returns(T.nilable(OpenAI::Responses::ResponseConfigurationUpdateItemParam::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: OpenAI::Responses::ResponseConfigurationUpdateItemParam::Reasoning::OrHash).void }
        attr_writer :reasoning

        # The text output configuration for subsequent responses.
        sig { returns(T.nilable(OpenAI::Responses::ResponseConfigurationUpdateItemParam::Text)) }
        attr_reader :text

        sig { params(text: OpenAI::Responses::ResponseConfigurationUpdateItemParam::Text::OrHash).void }
        attr_writer :text

        # An update to the conversation's response configuration. Supply reasoning, text,
        # or both. Each setting stays in effect until a later update replaces it.
        sig do
          params(

            id: T.nilable(String),

            reasoning: OpenAI::Responses::ResponseConfigurationUpdateItemParam::Reasoning::OrHash,

            text: OpenAI::Responses::ResponseConfigurationUpdateItemParam::Text::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the configuration update item.
          id: nil,

          # Updates to reasoning configuration. Only effort is supported.
          reasoning: nil,

          # The text output configuration for subsequent responses.
          text: nil,

          # The item type. Always `configuration_update`.

          type: :configuration_update
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              id: T.nilable(String),
              reasoning: OpenAI::Responses::ResponseConfigurationUpdateItemParam::Reasoning,
              text: OpenAI::Responses::ResponseConfigurationUpdateItemParam::Text
            }
          )
        end
        def to_hash
        end

        class Reasoning < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseConfigurationUpdateItemParam::Reasoning,
              OpenAI::Internal::AnyHash
            )
          end

          # The reasoning effort to use for subsequent responses until another configuration
          # update replaces it.
          sig { returns(T.nilable(OpenAI::ReasoningEffort::OrSymbol)) }
          attr_accessor :effort

          # Updates to reasoning configuration. Only effort is supported.
          sig do
            params(

              effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol)
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The reasoning effort to use for subsequent responses until another configuration
            # update replaces it.

            effort: nil
          )
          end

          sig do
            override.returns(
              {effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol)}
            )
          end
          def to_hash
          end

        end

        class Text < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseConfigurationUpdateItemParam::Text,
              OpenAI::Internal::AnyHash
            )
          end

          # Use a JSON schema for structured output or text to return to plain text.
          sig { returns(T.any(OpenAI::ResponseFormatText, OpenAI::Responses::ResponseFormatTextJSONSchemaConfig)) }
          attr_accessor :format_

          # The text output configuration for subsequent responses.
          sig do
            params(

              format_: T.any(
                OpenAI::ResponseFormatText::OrHash,
                OpenAI::Responses::ResponseFormatTextJSONSchemaConfig::OrHash
              )
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Use a JSON schema for structured output or text to return to plain text.

            format_:
          )
          end

          sig do
            override.returns(
              {format_: T.any(OpenAI::ResponseFormatText, OpenAI::Responses::ResponseFormatTextJSONSchemaConfig)}
            )
          end
          def to_hash
          end

          # Use a JSON schema for structured output or text to return to plain text.
          module Format
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(OpenAI::ResponseFormatText, OpenAI::Responses::ResponseFormatTextJSONSchemaConfig)
            }

            sig {
              override.returns(
                T::Array[OpenAI::Responses::ResponseConfigurationUpdateItemParam::Text::Format::Variants]
              )
            }
            def self.variants
            end

          end
        end

      end

    end

  end
end
