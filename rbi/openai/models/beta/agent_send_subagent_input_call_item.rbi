# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSendSubagentInputCallItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSendSubagentInputCallItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the tool call item.
        sig { returns(String) }
        attr_accessor :id

        # The input sent to the receiving agent.
        sig { returns(T::Array[OpenAI::Beta::AgentContent::Variants]) }
        attr_accessor :content

        # The ID of the agent receiving the input.
        sig { returns(String) }
        attr_accessor :recipient_agent_id

        # The ID of the agent sending the input.
        sig { returns(String) }
        attr_accessor :sender_agent_id

        # The status of the tool call.
        sig { returns(OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol) }
        attr_accessor :status

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `send_subagent_input_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A request to send input to another agent.
        sig do
          params(

            id: String,

            content: T::Array[
              T.any(OpenAI::Beta::OutputText::OrHash, OpenAI::Beta::AgentContent::EncryptedContent::OrHash)
            ],

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

          # The input sent to the receiving agent.
          content:,

          # The ID of the agent receiving the input.
          recipient_agent_id:,

          # The ID of the agent sending the input.
          sender_agent_id:,

          # The status of the tool call.
          status:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The item type. Always `send_subagent_input_call`.

          type: :send_subagent_input_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content: T::Array[OpenAI::Beta::AgentContent::Variants],
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
