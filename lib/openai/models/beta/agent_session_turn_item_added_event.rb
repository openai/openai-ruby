# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnItemAddedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item
        #   The item that was added.
        #
        #   @return [OpenAI::Models::Beta::AgentSessionMessage, OpenAI::Models::Beta::AgentReasoningItem, OpenAI::Models::Beta::AgentFunctionCallItem, OpenAI::Models::Beta::AgentSessionItem::FunctionCallOutput, OpenAI::Models::Beta::AgentSessionItem::AgentMessage, OpenAI::Models::Beta::AgentMcpCallItem, OpenAI::Models::Beta::AgentWebSearchCallItem, OpenAI::Models::Beta::AgentCommandExecutionItem, OpenAI::Models::Beta::AgentCreateSubagentCallItem, OpenAI::Models::Beta::AgentSendSubagentInputCallItem, OpenAI::Models::Beta::AgentResumeSubagentCallItem, OpenAI::Models::Beta::AgentWaitForSubagentsCallItem, OpenAI::Models::Beta::AgentInterruptSubagentCallItem, OpenAI::Models::Beta::AgentCloseSubagentCallItem]
        required :item, union: -> { OpenAI::Beta::AgentSessionItem }

        # @!attribute output_index
        #   The index of the item in the turn output, when the item is agent output.
        #
        #   @return [Integer, nil]
        required :output_index, Integer, nil?: true

        # @!attribute session_id
        #   The ID of the session associated with the event.
        #
        #   @return [String]
        required :session_id, String

        # @!attribute turn_id
        #   The ID of the turn associated with the event, when applicable.
        #
        #   @return [String, nil]
        required :turn_id, String, nil?: true

        # @!attribute type
        #   The type of the object. Always `agent.session.turn.item.added`.
        #
        #   @return [Symbol, :"agent.session.turn.item.added"]
        required :type, const: :"agent.session.turn.item.added"

        # @!method initialize(event_id:, item:, output_index:, session_id:, turn_id:, type: :"agent.session.turn.item.added")
        #   Emitted when an item is added to a turn.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param item [OpenAI::Models::Beta::AgentSessionMessage, OpenAI::Models::Beta::AgentReasoningItem, OpenAI::Models::Beta::AgentFunctionCallItem, OpenAI::Models::Beta::AgentSessionItem::FunctionCallOutput, OpenAI::Models::Beta::AgentSessionItem::AgentMessage, OpenAI::Models::Beta::AgentMcpCallItem, OpenAI::Models::Beta::AgentWebSearchCallItem, OpenAI::Models::Beta::AgentCommandExecutionItem, OpenAI::Models::Beta::AgentCreateSubagentCallItem, OpenAI::Models::Beta::AgentSendSubagentInputCallItem, OpenAI::Models::Beta::AgentResumeSubagentCallItem, OpenAI::Models::Beta::AgentWaitForSubagentsCallItem, OpenAI::Models::Beta::AgentInterruptSubagentCallItem, OpenAI::Models::Beta::AgentCloseSubagentCallItem]
        #     The item that was added.
        #
        #   @param output_index [Integer, nil]
        #     The index of the item in the turn output, when the item is agent output.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param turn_id [String, nil]
        #     The ID of the turn associated with the event, when applicable.
        #
        #   @param type [Symbol, :"agent.session.turn.item.added"]
        #     The type of the object. Always `agent.session.turn.item.added`.
      end
    end
  end
end
