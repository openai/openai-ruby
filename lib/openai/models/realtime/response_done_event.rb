# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute response
        #   The response resource.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeResponse]
        required :response, -> { OpenAI::Realtime::RealtimeResponse }

        # @!attribute type
        #   The event type, must be `response.done`.
        #
        #   @return [Symbol, :"response.done"]
        required :type, const: :"response.done"

        # @!method initialize(event_id:, response:, type: :"response.done")
        #   Returned when a Response is done streaming. Always emitted, no matter the final
        #   state. The Response object included in the `response.done` event will include
        #   all output Items in the Response but will omit the raw audio data.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param response [OpenAI::Models::Realtime::RealtimeResponse] The response resource.
        #
        #   @param type [Symbol, :"response.done"] The event type, must be `response.done`.
      end
    end
  end
end
