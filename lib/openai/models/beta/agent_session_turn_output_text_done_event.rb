# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnOutputTextDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part in the message.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the message item.
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

        # @!attribute text
        #   The complete output text.
        #
        #   @return [String]
        required :text, String

        # @!attribute turn_id
        #   The ID of the turn associated with the event, when applicable.
        #
        #   @return [String, nil]
        required :turn_id, String, nil?: true

        # @!attribute type
        #   The type of the object. Always `agent.session.turn.output_text.done`.
        #
        #   @return [Symbol, :"agent.session.turn.output_text.done"]
        required :type, const: :"agent.session.turn.output_text.done"

        # @!method initialize(content_index:, event_id:, item_id:, output_index:, session_id:, text:, turn_id:, type: :"agent.session.turn.output_text.done")
        #   Emitted when an output text content part is complete.
        #
        #   @param content_index [Integer]
        #     The index of the content part in the message.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param item_id [String]
        #     The ID of the message item.
        #
        #   @param output_index [Integer]
        #     The index of the item in the turn output.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param text [String]
        #     The complete output text.
        #
        #   @param turn_id [String, nil]
        #     The ID of the turn associated with the event, when applicable.
        #
        #   @param type [Symbol, :"agent.session.turn.output_text.done"]
        #     The type of the object. Always `agent.session.turn.output_text.done`.
      end
    end
  end
end
