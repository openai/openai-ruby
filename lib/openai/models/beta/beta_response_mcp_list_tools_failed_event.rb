# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseMcpListToolsFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the MCP tool call item that failed.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that failed.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_list_tools.failed'.
        #
        #   @return [Symbol, :"response.mcp_list_tools.failed"]
        required :type, const: :"response.mcp_list_tools.failed"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseMcpListToolsFailedEvent::Agent }, nil?: true

        # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, type: :"response.mcp_list_tools.failed")
        #   Emitted when the attempt to list available MCP tools has failed.
        #
        #   @param item_id [String] The ID of the MCP tool call item that failed.
        #
        #   @param output_index [Integer] The index of the output item that failed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.mcp_list_tools.failed"] The type of the event. Always 'response.mcp_list_tools.failed'.

        # @see OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent#agent
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

    BetaResponseMcpListToolsFailedEvent = Beta::BetaResponseMcpListToolsFailedEvent
  end
end
