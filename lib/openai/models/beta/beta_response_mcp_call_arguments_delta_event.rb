# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseMcpCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   A JSON string containing the partial update to the arguments for the MCP tool
        #   call.
        #
        #   @return [String]
        required :delta, String

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
        #   The type of the event. Always 'response.mcp_call_arguments.delta'.
        #
        #   @return [Symbol, :"response.mcp_call_arguments.delta"]
        required :type, const: :"response.mcp_call_arguments.delta"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent }, nil?: true

        # @!method initialize(delta:, item_id:, output_index:, sequence_number:, agent: nil, type: :"response.mcp_call_arguments.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent} for more details.
        #
        #   Emitted when there is a delta (partial update) to the arguments of an MCP tool
        #   call.
        #
        #   @param delta [String] A JSON string containing the partial update to the arguments for the MCP tool ca
        #
        #   @param item_id [String] The unique identifier of the MCP tool call item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.mcp_call_arguments.delta"] The type of the event. Always 'response.mcp_call_arguments.delta'.

        # @see OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent#agent
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

    BetaResponseMcpCallArgumentsDeltaEvent = Beta::BetaResponseMcpCallArgumentsDeltaEvent
  end
end
