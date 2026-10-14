# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseMcpCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute arguments
        #   A JSON string containing the finalized arguments for the MCP tool call.
        #
        #   @return [String]
        required :arguments, String

        # @!attribute item_id
        #   The unique identifier of the MCP tool call item being processed.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response's output array.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_call_arguments.done'.
        #
        #   @return [Symbol, :"response.mcp_call_arguments.done"]
        required :type, const: :"response.mcp_call_arguments.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseMcpCallArgumentsDoneEvent::Agent }, nil?: true

        # @!method initialize(arguments:, item_id:, output_index:, sequence_number:, agent: nil, type: :"response.mcp_call_arguments.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent} for more details.
        #
        #   Emitted when the arguments for an MCP tool call are finalized.
        #
        #   @param arguments [String] A JSON string containing the finalized arguments for the MCP tool call.
        #
        #   @param item_id [String] The unique identifier of the MCP tool call item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.mcp_call_arguments.done"] The type of the event. Always 'response.mcp_call_arguments.done'.

        # @see OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent#agent
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

    BetaResponseMcpCallArgumentsDoneEvent = Beta::BetaResponseMcpCallArgumentsDoneEvent
  end
end
