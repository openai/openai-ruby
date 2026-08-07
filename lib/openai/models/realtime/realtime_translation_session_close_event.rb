# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSessionCloseEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The event type, must be `session.close`.
        #
        #   @return [Symbol, :"session.close"]
        required :type, const: :"session.close"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(event_id: nil, type: :"session.close")
        #   Gracefully close the realtime translation session. The server flushes pending
        #   input audio and emits any remaining translated output before closing the
        #   session.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"session.close"] The event type, must be `session.close`.
      end
    end
  end
end
