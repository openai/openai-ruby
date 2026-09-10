# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnReasoningSummaryTextDoneEvent < OpenAI::Internal::Type::BaseModel
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

        # @!attribute text
        #   The complete reasoning summary text.
        #
        #   @return [String]
        required :text, String

        # @!attribute turn_id
        #   The ID of the turn associated with the event, when applicable.
        #
        #   @return [String, nil]
        required :turn_id, String, nil?: true

        # @!attribute type
        #   The type of the object. Always `agent.session.turn.reasoning_summary_text.done`.
        #
        #   @return [Symbol, :"agent.session.turn.reasoning_summary_text.done"]
        required :type, const: :"agent.session.turn.reasoning_summary_text.done"

        # @!method initialize(event_id:, item_id:, output_index:, session_id:, summary_index:, text:, turn_id:, type: :"agent.session.turn.reasoning_summary_text.done")
        #   Emitted when a reasoning summary content part is complete.
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
        #   @param text [String]
        #     The complete reasoning summary text.
        #
        #   @param turn_id [String, nil]
        #     The ID of the turn associated with the event, when applicable.
        #
        #   @param type [Symbol, :"agent.session.turn.reasoning_summary_text.done"]
        #     The type of the object. Always `agent.session.turn.reasoning_summary_text.done`.
      end
    end
  end
end
