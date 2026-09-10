# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentReasoningItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentReasoningItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the reasoning item.
        sig { returns(String) }
        attr_accessor :id

        # The status of an agent output item.
        sig { returns(T.nilable(OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol)) }
        attr_accessor :status

        # The reasoning summaries produced by the agent.
        sig { returns(T::Array[OpenAI::Beta::SummaryText]) }
        attr_accessor :summary

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `reasoning`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A reasoning item produced by the agent.
        sig do
          params(

            id: String,

            status: T.nilable(OpenAI::Beta::AgentOutputItemStatus::OrSymbol),

            summary: T::Array[OpenAI::Beta::SummaryText::OrHash],

            turn_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the reasoning item.
          id:,

          # The status of an agent output item.
          status:,

          # The reasoning summaries produced by the agent.
          summary:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The item type. Always `reasoning`.

          type: :reasoning
        )
        end

        sig do
          override.returns(
            {
              id: String,
              status: T.nilable(OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol),
              summary: T::Array[OpenAI::Beta::SummaryText],
              turn_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
