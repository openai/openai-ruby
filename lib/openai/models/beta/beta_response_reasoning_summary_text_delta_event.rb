# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseReasoningSummaryTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The text delta that was added to the summary.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The ID of the item this summary text delta is associated with.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item this summary text delta is associated with.
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

        # @!attribute type
        #   The type of the event. Always `response.reasoning_summary_text.delta`.
        #
        #   @return [Symbol, :"response.reasoning_summary_text.delta"]
        required :type, const: :"response.reasoning_summary_text.delta"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent }, nil?: true

        # @!method initialize(delta:, item_id:, output_index:, sequence_number:, summary_index:, agent: nil, type: :"response.reasoning_summary_text.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent} for more
        #   details.
        #
        #   Emitted when a delta is added to a reasoning summary text.
        #
        #   @param delta [String] The text delta that was added to the summary.
        #
        #   @param item_id [String] The ID of the item this summary text delta is associated with.
        #
        #   @param output_index [Integer] The index of the output item this summary text delta is associated with.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.reasoning_summary_text.delta"] The type of the event. Always `response.reasoning_summary_text.delta`.

        # @see OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent#agent
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

    BetaResponseReasoningSummaryTextDeltaEvent = Beta::BetaResponseReasoningSummaryTextDeltaEvent
  end
end
