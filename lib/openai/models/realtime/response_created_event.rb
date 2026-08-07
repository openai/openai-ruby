# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseCreatedEvent < OpenAI::Internal::Type::BaseModel
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
        #   The event type, must be `response.created`.
        #
        #   @return [Symbol, :"response.created"]
        required :type, const: :"response.created"

        # @!method initialize(event_id:, response:, type: :"response.created")
        #   Returned when a new Response is created. The first event of response creation,
        #   where the response is in an initial state of `in_progress`.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param response [OpenAI::Models::Realtime::RealtimeResponse] The response resource.
        #
        #   @param type [Symbol, :"response.created"] The event type, must be `response.created`.
      end
    end
  end
end
