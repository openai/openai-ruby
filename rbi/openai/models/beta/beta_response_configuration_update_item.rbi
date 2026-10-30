# typed: strong

module OpenAI
  module Models

    BetaResponseConfigurationUpdateItem = Beta::BetaResponseConfigurationUpdateItem

    module Beta

      class BetaResponseConfigurationUpdateItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseConfigurationUpdateItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the configuration update item.
        sig { returns(String) }
        attr_accessor :id

        # The item type. Always `configuration_update`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that produced this item.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItem::Agent)) }
        attr_reader :agent

        sig { params(agent: OpenAI::Beta::BetaResponseConfigurationUpdateItem::Agent::OrHash).void }
        attr_writer :agent

        # The reasoning configuration applied by this update.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::OrHash).void }
        attr_writer :reasoning

        # The text output configuration for subsequent responses.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text)) }
        attr_reader :text

        sig { params(text: OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text::OrHash).void }
        attr_writer :text

        # A configuration update for subsequent responses. Each setting stays in effect
        # until a later update replaces that setting.
        sig do
          params(

            id: String,

            agent: OpenAI::Beta::BetaResponseConfigurationUpdateItem::Agent::OrHash,

            reasoning: OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::OrHash,

            text: OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the configuration update item.
          id:,

          # The agent that produced this item.
          agent: nil,

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
              agent: OpenAI::Beta::BetaResponseConfigurationUpdateItem::Agent,
              reasoning: OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning,
              text: OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseConfigurationUpdateItem::Agent,
              OpenAI::Internal::AnyHash
            )
          end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that produced this item.
          sig do
            params(

              agent_name: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The canonical name of the agent that produced this item.

            agent_name:
          )
          end

          sig do
            override.returns(
              {agent_name: String}
            )
          end
          def to_hash
          end

        end

        class Reasoning < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning,
              OpenAI::Internal::AnyHash
            )
          end

          # The reasoning effort used for subsequent responses until another configuration
          # update replaces it.
          sig {
            returns(T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::TaggedSymbol))
          }
          attr_accessor :effort

          # The reasoning configuration applied by this update.
          sig do
            params(

              effort: T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::OrSymbol)
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
              {effort: T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::TaggedSymbol)}
            )
          end
          def to_hash
          end

          # The reasoning effort used for subsequent responses until another configuration
          # update replaces it.
          module Effort
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            NONE = T.let(:none, OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::TaggedSymbol)
            MINIMAL = T.let(
              :minimal,
              OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::TaggedSymbol
            )
            LOW = T.let(:low, OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::TaggedSymbol)
            MEDIUM = T.let(:medium, OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::TaggedSymbol)
            XHIGH = T.let(:xhigh, OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::TaggedSymbol)
            MAX = T.let(:max, OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::TaggedSymbol)

            sig {
              override.returns(
                T::Array[OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort::TaggedSymbol]
              )
            }
            def self.values
            end
          end
        end

        class Text < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text,
              OpenAI::Internal::AnyHash
            )
          end

          # Use a JSON schema for structured output or text to return to plain text.
          sig { returns(OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text::Format::Variants) }
          attr_accessor :format_

          # The text output configuration for subsequent responses.
          sig do
            params(

              format_: T.any(
                OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text::Format::Text::OrHash,
                OpenAI::Beta::BetaResponseFormatTextJSONSchemaConfig::OrHash
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
              {format_: OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text::Format::Variants}
            )
          end
          def to_hash
          end

          # Use a JSON schema for structured output or text to return to plain text.
          module Format
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text::Format::Text,
                OpenAI::Beta::BetaResponseFormatTextJSONSchemaConfig
              )
            }

            class Text < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text::Format::Text,
                  OpenAI::Internal::AnyHash
                )
              end

              # The type of response format being defined. Always `text`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Default response format. Used to generate text responses.
              sig do
                params(

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The type of response format being defined. Always `text`.

                type: :text
              )
              end

              sig do
                override.returns(
                  {type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig {
              override.returns(T::Array[OpenAI::Beta::BetaResponseConfigurationUpdateItem::Text::Format::Variants])
            }
            def self.variants
            end

          end
        end

      end

    end

  end
end
