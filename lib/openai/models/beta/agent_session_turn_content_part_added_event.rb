# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnContentPartAddedEvent < OpenAI::Internal::Type::BaseModel
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

        # @!attribute part
        #   The initial content part.
        #
        #   @return [OpenAI::Models::Beta::OutputText]
        required :part, -> { OpenAI::Beta::OutputText }

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
        #   The type of the object. Always `agent.session.turn.content_part.added`.
        #
        #   @return [Symbol, :"agent.session.turn.content_part.added"]
        required :type, const: :"agent.session.turn.content_part.added"

        # @!method initialize(content_index:, event_id:, item_id:, output_index:, part:, session_id:, turn_id:, type: :"agent.session.turn.content_part.added")
        #   Emitted when an output text content part is added.
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
        #   @param part [OpenAI::Models::Beta::OutputText]
        #     The initial content part.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param turn_id [String, nil]
        #     The ID of the turn associated with the event, when applicable.
        #
        #   @param type [Symbol, :"agent.session.turn.content_part.added"]
        #     The type of the object. Always `agent.session.turn.content_part.added`.
      end
    end
  end
end
