# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseCancelEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The event type, must be `response.cancel`.
        #
        #   @return [Symbol, :"response.cancel"]
        required :type, const: :"response.cancel"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!attribute response_id
        #   A specific response ID to cancel - if not provided, will cancel an in-progress
        #   response in the default conversation.
        #
        #   @return [String, nil]
        optional :response_id, String

        # @!method initialize(event_id: nil, response_id: nil, type: :"response.cancel")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ResponseCancelEvent} for more details.
        #
        #   Send this event to cancel an in-progress response. The server will respond with
        #   a `response.done` event with a status of `response.status=cancelled`. If there
        #   is no response to cancel, the server will respond with an error. It's safe to
        #   call `response.cancel` even if no response is in progress, an error will be
        #   returned the session will remain unaffected.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param response_id [String] A specific response ID to cancel - if not provided, will cancel an
        #
        #   @param type [Symbol, :"response.cancel"] The event type, must be `response.cancel`.
      end
    end
  end
end
