# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseMcpCallCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the MCP tool call item that completed.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that completed.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_call.completed'.
        #
        #   @return [Symbol, :"response.mcp_call.completed"]
        required :type, const: :"response.mcp_call.completed"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseMcpCallCompletedEvent::Agent }, nil?: true

        # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, type: :"response.mcp_call.completed")
        #   Emitted when an MCP tool call has completed successfully.
        #
        #   @param item_id [String] The ID of the MCP tool call item that completed.
        #
        #   @param output_index [Integer] The index of the output item that completed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.mcp_call.completed"] The type of the event. Always 'response.mcp_call.completed'.

        # @see OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent#agent
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

    BetaResponseMcpCallCompletedEvent = Beta::BetaResponseMcpCallCompletedEvent
  end
end
