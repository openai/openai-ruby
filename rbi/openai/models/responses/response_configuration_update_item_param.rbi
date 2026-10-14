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

        # An update to the conversation's response configuration. The configuration
        # remains in effect for subsequent responses until it is replaced by another
        # configuration update.
        sig do
          params(

            id: T.nilable(String),

            reasoning: OpenAI::Responses::ResponseConfigurationUpdateItemParam::Reasoning::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the configuration update item.
          id: nil,

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
              reasoning: OpenAI::Responses::ResponseConfigurationUpdateItemParam::Reasoning
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

      end

    end

  end
end
