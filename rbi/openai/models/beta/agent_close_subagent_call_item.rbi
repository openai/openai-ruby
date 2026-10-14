# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentCloseSubagentCallItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentCloseSubagentCallItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the tool call item.
        sig { returns(String) }
        attr_accessor :id

        # The ID of the agent to close.
        sig { returns(String) }
        attr_accessor :recipient_agent_id

        # The ID of the agent requesting the close.
        sig { returns(String) }
        attr_accessor :sender_agent_id

        # The status of the tool call.
        sig { returns(OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol) }
        attr_accessor :status

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `close_subagent_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A request to close a subagent.
        sig do
          params(

            id: String,

            recipient_agent_id: String,

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

          # The ID of the agent to close.
          recipient_agent_id:,

          # The ID of the agent requesting the close.
          sender_agent_id:,

          # The status of the tool call.
          status:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The item type. Always `close_subagent_call`.

          type: :close_subagent_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              recipient_agent_id: String,
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
