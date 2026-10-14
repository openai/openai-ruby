# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnReasoningSummaryTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The summary text that was appended.
        #
        #   @return [String]
        required :delta, String

        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the reasoning item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the item in the turn output.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute session_id
        #   The ID of the session associated with the event.
        #
        #   @return [String]
        required :session_id, String

        # @!attribute summary_index
        #   The index of the summary content part.
        #
        #   @return [Integer]
        required :summary_index, Integer

        # @!attribute turn_id
        #   The ID of the turn associated with the event, when applicable.
        #
        #   @return [String, nil]
        required :turn_id, String, nil?: true

        # @!attribute type
        #   The type of the object. Always
        #   `agent.session.turn.reasoning_summary_text.delta`.
        #
        #   @return [Symbol, :"agent.session.turn.reasoning_summary_text.delta"]
        required :type, const: :"agent.session.turn.reasoning_summary_text.delta"

        # @!method initialize(delta:, event_id:, item_id:, output_index:, session_id:, summary_index:, turn_id:, type: :"agent.session.turn.reasoning_summary_text.delta")
        #   Emitted when text is appended to a reasoning summary.
        #
        #   @param delta [String]
        #     The summary text that was appended.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param item_id [String]
        #     The ID of the reasoning item.
        #
        #   @param output_index [Integer]
        #     The index of the item in the turn output.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param summary_index [Integer]
        #     The index of the summary content part.
        #
        #   @param turn_id [String, nil]
        #     The ID of the turn associated with the event, when applicable.
        #
        #   @param type [Symbol, :"agent.session.turn.reasoning_summary_text.delta"]
        #     The type of the object. Always
        #     `agent.session.turn.reasoning_summary_text.delta`.
      end
    end
  end
end
