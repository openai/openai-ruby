# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseMcpListToolsCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the MCP tool call item that produced this output.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that was processed.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.mcp_list_tools.completed'.
        #
        #   @return [Symbol, :"response.mcp_list_tools.completed"]
        required :type, const: :"response.mcp_list_tools.completed"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseMcpListToolsCompletedEvent::Agent }, nil?: true

        # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, type: :"response.mcp_list_tools.completed")
        #   Emitted when the list of available MCP tools has been successfully retrieved.
        #
        #   @param item_id [String] The ID of the MCP tool call item that produced this output.
        #
        #   @param output_index [Integer] The index of the output item that was processed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.mcp_list_tools.completed"] The type of the event. Always 'response.mcp_list_tools.completed'.

        # @see OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent#agent
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

    BetaResponseMcpListToolsCompletedEvent = Beta::BetaResponseMcpListToolsCompletedEvent
  end
end
