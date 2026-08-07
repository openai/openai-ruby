# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseCreateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The event type, must be `response.create`.
        #
        #   @return [Symbol, :"response.create"]
        required :type, const: :"response.create"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!attribute response
        #   Create a new Realtime response with these parameters
        #
        #   @return [OpenAI::Models::Realtime::RealtimeResponseCreateParams, nil]
        optional :response, -> { OpenAI::Realtime::RealtimeResponseCreateParams }

        # @!method initialize(event_id: nil, response: nil, type: :"response.create")
        #   This event instructs the server to create a Response, which means triggering
        #   model inference. When in Server VAD mode, the server will create Responses
        #   automatically.
        #
        #   A Response will include at least one Item, and may have two, in which case the
        #   second will be a function call. These Items will be appended to the conversation
        #   history by default.
        #
        #   The server will respond with a `response.created` event, events for Items and
        #   content created, and finally a `response.done` event to indicate the Response is
        #   complete.
        #
        #   The `response.create` event includes inference configuration like `instructions`
        #   and `tools`. If these are set, they will override the Session's configuration
        #   for this Response only.
        #
        #   Responses can be created out-of-band of the default Conversation, meaning that
        #   they can have arbitrary input, and it's possible to disable writing the output
        #   to the Conversation. Only one Response can write to the default Conversation at
        #   a time, but otherwise multiple Responses can be created in parallel. The
        #   `metadata` field is a good way to disambiguate multiple simultaneous Responses.
        #
        #   Clients can set `conversation` to `none` to create a Response that does not
        #   write to the default Conversation. Arbitrary input can be provided with the
        #   `input` field, which is an array accepting raw Items and references to existing
        #   Items.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param response [OpenAI::Models::Realtime::RealtimeResponseCreateParams] Create a new Realtime response with these parameters
        #
        #   @param type [Symbol, :"response.create"] The event type, must be `response.create`.
      end
    end
  end
end
