# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnOutputTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part in the message.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute delta
        #   The text that was appended.
        #
        #   @return [String]
        required :delta, String

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

        # @!attribute turn_id
        #   The ID of the turn associated with the event, when applicable.
        #
        #   @return [String, nil]
        required :turn_id, String, nil?: true

        # @!attribute type
        #   The type of the object. Always `agent.session.turn.output_text.delta`.
        #
        #   @return [Symbol, :"agent.session.turn.output_text.delta"]
        required :type, const: :"agent.session.turn.output_text.delta"

        # @!method initialize(content_index:, delta:, event_id:, item_id:, output_index:, session_id:, turn_id:, type: :"agent.session.turn.output_text.delta")
        #   Emitted when text is appended to an output text content part.
        #
        #   @param content_index [Integer]
        #     The index of the content part in the message.
        #
        #   @param delta [String]
        #     The text that was appended.
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
        #   @param turn_id [String, nil]
        #     The ID of the turn associated with the event, when applicable.
        #
        #   @param type [Symbol, :"agent.session.turn.output_text.delta"]
        #     The type of the object. Always `agent.session.turn.output_text.delta`.
      end
    end
  end
end
