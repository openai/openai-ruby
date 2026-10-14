# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseOutputItemDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item
        #   The output item that was marked done.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseOutputItem::Program, OpenAI::Models::Beta::BetaResponseOutputItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseOutputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseOutputItem::McpCall, OpenAI::Models::Beta::BetaResponseOutputItem::McpListTools, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem]
        required :item, union: -> { OpenAI::Beta::BetaResponseOutputItem }

        # @!attribute output_index
        #   The index of the output item that was marked done.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.output_item.done`.
        #
        #   @return [Symbol, :"response.output_item.done"]
        required :type, const: :"response.output_item.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseOutputItemDoneEvent::Agent }, nil?: true

        # @!method initialize(item:, output_index:, sequence_number:, agent: nil, type: :"response.output_item.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent} for more details.
        #
        #   Emitted when an output item is marked done.
        #
        #   @param item [OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseOutputItem::Program, OpenAI::Models::Beta::BetaResponseOutputItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseOutputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseOutputItem::McpCall, OpenAI::Models::Beta::BetaResponseOutputItem::McpListTools, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem] The output item that was marked done.
        #
        #   @param output_index [Integer] The index of the output item that was marked done.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.output_item.done"] The type of the event. Always `response.output_item.done`.

        # @see OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that owns this multi-agent streaming event.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
        end
      end
    end

    BetaResponseOutputItemDoneEvent = Beta::BetaResponseOutputItemDoneEvent
  end
end
