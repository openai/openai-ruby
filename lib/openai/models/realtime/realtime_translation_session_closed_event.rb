# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSessionClosedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #   The event type, must be `session.closed`.
        #
        #   @return [Symbol, :"session.closed"]
        required :type, const: :"session.closed"

        # @!method initialize(event_id:, type: :"session.closed")
        #   Returned when a realtime translation session is closed.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param type [Symbol, :"session.closed"] The event type, must be `session.closed`.
      end
    end
  end
end
