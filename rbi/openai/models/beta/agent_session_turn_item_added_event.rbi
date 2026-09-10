# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionTurnItemAddedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionTurnItemAddedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The item that was added.
        sig { returns(OpenAI::Beta::AgentSessionItem::Variants) }
        attr_accessor :item

        # The index of the item in the turn output, when the item is agent output.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :output_index

        # The ID of the session associated with the event.
        sig { returns(String) }
        attr_accessor :session_id

        # The ID of the turn associated with the event, when applicable.
        sig { returns(T.nilable(String)) }
        attr_accessor :turn_id

        # The type of the object. Always `agent.session.turn.item.added`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when an item is added to a turn.
        sig do
          params(

            event_id: String,

            item: T.any(
              OpenAI::Beta::AgentSessionMessage::OrHash,
              OpenAI::Beta::AgentReasoningItem::OrHash,
              OpenAI::Beta::AgentFunctionCallItem::OrHash,
              OpenAI::Beta::AgentSessionItem::FunctionCallOutput::OrHash,
              OpenAI::Beta::AgentSessionItem::AgentMessage::OrHash,
              OpenAI::Beta::AgentMcpCallItem::OrHash,
              OpenAI::Beta::AgentWebSearchCallItem::OrHash,
              OpenAI::Beta::AgentCommandExecutionItem::OrHash,
              OpenAI::Beta::AgentCreateSubagentCallItem::OrHash,
              OpenAI::Beta::AgentSendSubagentInputCallItem::OrHash,
              OpenAI::Beta::AgentResumeSubagentCallItem::OrHash,
              OpenAI::Beta::AgentWaitForSubagentsCallItem::OrHash,
              OpenAI::Beta::AgentInterruptSubagentCallItem::OrHash,
              OpenAI::Beta::AgentCloseSubagentCallItem::OrHash
            ),

            output_index: T.nilable(Integer),

            session_id: String,

            turn_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          event_id:,

          # The item that was added.
          item:,

          # The index of the item in the turn output, when the item is agent output.
          output_index:,

          # The ID of the session associated with the event.
          session_id:,

          # The ID of the turn associated with the event, when applicable.
          turn_id:,

          # The type of the object. Always `agent.session.turn.item.added`.

          type: :"agent.session.turn.item.added"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              item: OpenAI::Beta::AgentSessionItem::Variants,
              output_index: T.nilable(Integer),
              session_id: String,
              turn_id: T.nilable(String),
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
