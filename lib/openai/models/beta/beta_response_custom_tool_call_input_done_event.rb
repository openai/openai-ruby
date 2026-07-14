# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseCustomToolCallInputDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute input
        #   The complete input data for the custom tool call.
        #
        #   @return [String]
        required :input, String

        # @!attribute item_id
        #   Unique identifier for the API item associated with this event.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output this event applies to.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The event type identifier.
        #
        #   @return [Symbol, :"response.custom_tool_call_input.done"]
        required :type, const: :"response.custom_tool_call_input.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent }, nil?: true

        # @!method initialize(input:, item_id:, output_index:, sequence_number:, agent: nil, type: :"response.custom_tool_call_input.done")
        #   Event indicating that input for a custom tool call is complete.
        #
        #   @param input [String] The complete input data for the custom tool call.
        #
        #   @param item_id [String] Unique identifier for the API item associated with this event.
        #
        #   @param output_index [Integer] The index of the output this event applies to.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.custom_tool_call_input.done"] The event type identifier.

        # @see OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent#agent
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

    BetaResponseCustomToolCallInputDoneEvent = Beta::BetaResponseCustomToolCallInputDoneEvent
  end
end
