# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseReasoningTextDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the reasoning content part.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The ID of the item this reasoning text is associated with.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item this reasoning text is associated with.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute text
        #   The full text of the completed reasoning content.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the event. Always `response.reasoning_text.done`.
        #
        #   @return [Symbol, :"response.reasoning_text.done"]
        required :type, const: :"response.reasoning_text.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseReasoningTextDoneEvent::Agent }, nil?: true

        # @!method initialize(content_index:, item_id:, output_index:, sequence_number:, text:, agent: nil, type: :"response.reasoning_text.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent} for more details.
        #
        #   Emitted when a reasoning text is completed.
        #
        #   @param content_index [Integer] The index of the reasoning content part.
        #
        #   @param item_id [String] The ID of the item this reasoning text is associated with.
        #
        #   @param output_index [Integer] The index of the output item this reasoning text is associated with.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param text [String] The full text of the completed reasoning content.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.reasoning_text.done"] The type of the event. Always `response.reasoning_text.done`.

        # @see OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent#agent
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

    BetaResponseReasoningTextDoneEvent = Beta::BetaResponseReasoningTextDoneEvent
  end
end
