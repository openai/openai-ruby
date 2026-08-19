# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeErrorEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute error
        #   Details of the error.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeError]
        required :error, -> { OpenAI::Realtime::RealtimeError }

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #   The event type, must be `error`.
        #
        #   @return [Symbol, :error]
        required :type, const: :error

        # @!method initialize(error:, event_id:, type: :error)
        #   Returned when an error occurs, which could be a client problem or a server
        #   problem. Most errors are recoverable and the session will stay open, we
        #   recommend to implementors to monitor and log error messages by default.
        #
        #   @param error [OpenAI::Models::Realtime::RealtimeError] Details of the error.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param type [Symbol, :error] The event type, must be `error`.
      end
    end
  end
end
