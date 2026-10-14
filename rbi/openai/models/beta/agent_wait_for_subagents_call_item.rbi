# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentWaitForSubagentsCallItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentWaitForSubagentsCallItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the tool call item.
        sig { returns(String) }
        attr_accessor :id

        # The IDs of the agents to wait for.
        sig { returns(T::Array[String]) }
        attr_accessor :recipient_agent_ids

        # The ID of the agent waiting for results.
        sig { returns(String) }
        attr_accessor :sender_agent_id

        # The status of the tool call.
        sig { returns(OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol) }
        attr_accessor :status

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `wait_for_subagents_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A request to wait for one or more subagents.
        sig do
          params(

            id: String,

            recipient_agent_ids: T::Array[String],

            sender_agent_id: String,

            status: OpenAI::Beta::AgentFunctionCallStatus::OrSymbol,

            turn_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the tool call item.
          id:,

          # The IDs of the agents to wait for.
          recipient_agent_ids:,

          # The ID of the agent waiting for results.
          sender_agent_id:,

          # The status of the tool call.
          status:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The item type. Always `wait_for_subagents_call`.

          type: :wait_for_subagents_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              recipient_agent_ids: T::Array[String],
              sender_agent_id: String,
              status: OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol,
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
