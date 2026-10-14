# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseReasoningSummaryTextDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the item this summary text is associated with.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item this summary text is associated with.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute summary_index
        #   The index of the summary part within the reasoning summary.
        #
        #   @return [Integer]
        required :summary_index, Integer

        # @!attribute text
        #   The full text of the completed reasoning summary.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the event. Always `response.reasoning_summary_text.done`.
        #
        #   @return [Symbol, :"response.reasoning_summary_text.done"]
        required :type, const: :"response.reasoning_summary_text.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent }, nil?: true

        # @!method initialize(item_id:, output_index:, sequence_number:, summary_index:, text:, agent: nil, type: :"response.reasoning_summary_text.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent} for more
        #   details.
        #
        #   Emitted when a reasoning summary text is completed.
        #
        #   @param item_id [String] The ID of the item this summary text is associated with.
        #
        #   @param output_index [Integer] The index of the output item this summary text is associated with.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
        #
        #   @param text [String] The full text of the completed reasoning summary.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.reasoning_summary_text.done"] The type of the event. Always `response.reasoning_summary_text.done`.

        # @see OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent#agent
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

    BetaResponseReasoningSummaryTextDoneEvent = Beta::BetaResponseReasoningSummaryTextDoneEvent
  end
end
