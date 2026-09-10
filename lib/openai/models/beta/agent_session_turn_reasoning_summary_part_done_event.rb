# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnReasoningSummaryPartDoneEvent < OpenAI::Internal::Type::BaseModel
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

        # @!attribute part
        #   The completed summary part.
        #
        #   @return [OpenAI::Models::Beta::SummaryText]
        required :part, -> { OpenAI::Beta::SummaryText }

        # @!attribute session_id
        #   The ID of the session associated with the event.
        #
        #   @return [String]
        required :session_id, String

        # @!attribute status
        #   Present as `incomplete` when summary generation was interrupted.
        #
        #   @return [Symbol, :incomplete, nil]
        required :status, const: :incomplete, nil?: true

        # @!attribute summary_index
        #   The index of the summary part.
        #
        #   @return [Integer]
        required :summary_index, Integer

        # @!attribute turn_id
        #   The ID of the turn associated with the event, when applicable.
        #
        #   @return [String, nil]
        required :turn_id, String, nil?: true

        # @!attribute type
        #   The type of the object. Always `agent.session.turn.reasoning_summary_part.done`.
        #
        #   @return [Symbol, :"agent.session.turn.reasoning_summary_part.done"]
        required :type, const: :"agent.session.turn.reasoning_summary_part.done"

        # @!method initialize(event_id:, item_id:, output_index:, part:, session_id:, summary_index:, turn_id:, status: :incomplete, type: :"agent.session.turn.reasoning_summary_part.done")
        #   Emitted when a reasoning summary part is complete.
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
        #   @param part [OpenAI::Models::Beta::SummaryText]
        #     The completed summary part.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param summary_index [Integer]
        #     The index of the summary part.
        #
        #   @param turn_id [String, nil]
        #     The ID of the turn associated with the event, when applicable.
        #
        #   @param status [Symbol, :incomplete, nil]
        #     Present as `incomplete` when summary generation was interrupted.
        #
        #   @param type [Symbol, :"agent.session.turn.reasoning_summary_part.done"]
        #     The type of the object. Always `agent.session.turn.reasoning_summary_part.done`.
      end
    end
  end
end
