# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentCreateSubagentCallItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentCreateSubagentCallItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the tool call item.
        sig { returns(String) }
        attr_accessor :id

        # The ID of the agent that requested the subagent.
        sig { returns(String) }
        attr_accessor :agent_id

        # The task given to the spawned agent.
        sig { returns(T::Array[OpenAI::Beta::AgentContent::Variants]) }
        attr_accessor :content

        # The model requested for the spawned agent.
        sig { returns(T.nilable(String)) }
        attr_accessor :model

        # The reasoning effort requested for the spawned agent.
        sig { returns(T.nilable(String)) }
        attr_accessor :reasoning_effort

        # The status of the tool call.
        sig { returns(OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol) }
        attr_accessor :status

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `create_subagent_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A request to spawn a subagent.
        sig do
          params(

            id: String,

            agent_id: String,

            content: T::Array[
              T.any(OpenAI::Beta::OutputText::OrHash, OpenAI::Beta::AgentContent::EncryptedContent::OrHash)
            ],

            model: T.nilable(String),

            reasoning_effort: T.nilable(String),

            status: OpenAI::Beta::AgentFunctionCallStatus::OrSymbol,

            turn_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the tool call item.
          id:,

          # The ID of the agent that requested the subagent.
          agent_id:,

          # The task given to the spawned agent.
          content:,

          # The model requested for the spawned agent.
          model:,

          # The reasoning effort requested for the spawned agent.
          reasoning_effort:,

          # The status of the tool call.
          status:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The item type. Always `create_subagent_call`.

          type: :create_subagent_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              agent_id: String,
              content: T::Array[OpenAI::Beta::AgentContent::Variants],
              model: T.nilable(String),
              reasoning_effort: T.nilable(String),
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
