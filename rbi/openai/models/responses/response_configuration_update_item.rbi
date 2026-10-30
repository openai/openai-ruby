# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseConfigurationUpdateItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseConfigurationUpdateItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the configuration update item.
        sig { returns(String) }
        attr_accessor :id

        # The item type. Always `configuration_update`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The reasoning configuration applied by this update.
        sig { returns(T.nilable(OpenAI::Responses::ResponseConfigurationUpdateItem::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: OpenAI::Responses::ResponseConfigurationUpdateItem::Reasoning::OrHash).void }
        attr_writer :reasoning

        # The text output configuration for subsequent responses.
        sig { returns(T.nilable(OpenAI::Responses::ResponseConfigurationUpdateItem::Text)) }
        attr_reader :text

        sig { params(text: OpenAI::Responses::ResponseConfigurationUpdateItem::Text::OrHash).void }
        attr_writer :text

        # A configuration update for subsequent responses. Each setting stays in effect
        # until a later update replaces that setting.
        sig do
          params(

            id: String,

            reasoning: OpenAI::Responses::ResponseConfigurationUpdateItem::Reasoning::OrHash,

            text: OpenAI::Responses::ResponseConfigurationUpdateItem::Text::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the configuration update item.
          id:,

          # The reasoning configuration applied by this update.
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
              id: String,
              type: Symbol,
              reasoning: OpenAI::Responses::ResponseConfigurationUpdateItem::Reasoning,
              text: OpenAI::Responses::ResponseConfigurationUpdateItem::Text
            }
          )
        end
        def to_hash
        end

        class Reasoning < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseConfigurationUpdateItem::Reasoning,
              OpenAI::Internal::AnyHash
            )
          end

          # The reasoning effort used for subsequent responses until another configuration
          # update replaces it.
          sig { returns(T.nilable(OpenAI::ReasoningEffort::OrSymbol)) }
          attr_accessor :effort

          # The reasoning configuration applied by this update.
          sig do
            params(

              effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol)
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The reasoning effort used for subsequent responses until another configuration
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
              OpenAI::Responses::ResponseConfigurationUpdateItem::Text,
              OpenAI::Internal::AnyHash
            )
          end

          # Use a JSON schema for structured output or text to return to plain text.
          sig { returns(OpenAI::Responses::ResponseConfigurationUpdateItem::Text::Format::Variants) }
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
              {format_: OpenAI::Responses::ResponseConfigurationUpdateItem::Text::Format::Variants}
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
              override.returns(T::Array[OpenAI::Responses::ResponseConfigurationUpdateItem::Text::Format::Variants])
            }
            def self.variants
            end

          end
        end

      end

    end

  end
end
