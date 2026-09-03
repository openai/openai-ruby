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

        # A configuration update that applies to subsequent responses until it is replaced
        # by another configuration update.
        sig do
          params(

            id: String,

            reasoning: OpenAI::Responses::ResponseConfigurationUpdateItem::Reasoning::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the configuration update item.
          id:,

          # The reasoning configuration applied by this update.
          reasoning: nil,

          # The item type. Always `configuration_update`.

          type: :configuration_update
        )
        end

        sig do
          override.returns(
            {id: String, type: Symbol, reasoning: OpenAI::Responses::ResponseConfigurationUpdateItem::Reasoning}
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

      end

    end

  end
end
