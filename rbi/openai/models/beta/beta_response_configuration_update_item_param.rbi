# typed: strong

module OpenAI
  module Models

    BetaResponseConfigurationUpdateItemParam = Beta::BetaResponseConfigurationUpdateItemParam

    module Beta

      class BetaResponseConfigurationUpdateItemParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseConfigurationUpdateItemParam,
            OpenAI::Internal::AnyHash
          )
        end

        # The item type. Always `configuration_update`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The unique ID of the configuration update item.
        sig { returns(T.nilable(String)) }
        attr_accessor :id

        # The agent that produced this item.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Agent)) }
        attr_reader :agent

        sig { params(agent: T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Agent::OrHash)).void }
        attr_writer :agent

        # Updates to reasoning configuration. Only effort is supported.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::OrHash).void }
        attr_writer :reasoning

        # An update to the conversation's response configuration. The configuration
        # remains in effect for subsequent responses until it is replaced by another
        # configuration update.
        sig do
          params(

            id: T.nilable(String),

            agent: T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Agent::OrHash),

            reasoning: OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the configuration update item.
          id: nil,

          # The agent that produced this item.
          agent: nil,

          # Updates to reasoning configuration. Only effort is supported.
          reasoning: nil,

          # The item type. Always `configuration_update`.

          type: :configuration_update
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              id: T.nilable(String),
              agent: T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Agent),
              reasoning: OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Agent,
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
              OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning,
              OpenAI::Internal::AnyHash
            )
          end

          # The reasoning effort to use for subsequent responses until another configuration
          # update replaces it.
          sig {
            returns(T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::OrSymbol))
          }
          attr_accessor :effort

          # Updates to reasoning configuration. Only effort is supported.
          sig do
            params(

              effort: T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::OrSymbol)
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
              {effort: T.nilable(OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::OrSymbol)}
            )
          end
          def to_hash
          end

          # The reasoning effort to use for subsequent responses until another configuration
          # update replaces it.
          module Effort
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            NONE = T.let(:none, OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::TaggedSymbol)
            MINIMAL = T.let(
              :minimal,
              OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::TaggedSymbol
            )
            LOW = T.let(:low, OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::TaggedSymbol)
            MEDIUM = T.let(
              :medium,
              OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::TaggedSymbol
            )
            HIGH = T.let(:high, OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::TaggedSymbol)
            XHIGH = T.let(
              :xhigh,
              OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::TaggedSymbol
            )
            MAX = T.let(:max, OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::TaggedSymbol)

            sig {
              override.returns(
                T::Array[OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort::TaggedSymbol]
              )
            }
            def self.values
            end
          end
        end

      end

    end

  end
end
