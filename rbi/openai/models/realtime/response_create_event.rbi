# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseCreateEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseCreateEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The event type, must be `response.create`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Create a new Realtime response with these parameters
        sig do
          returns(T.nilable(OpenAI::Realtime::RealtimeResponseCreateParams))
        end
        attr_reader :response

        sig do
          params(
            response: OpenAI::Realtime::RealtimeResponseCreateParams::OrHash
          ).void
        end
        attr_writer :response

        # This event instructs the server to create a Response, which means triggering
        # model inference. When in Server VAD mode, the server will create Responses
        # automatically.
        #
        # A Response will include at least one Item, and may have two, in which case the
        # second will be a function call. These Items will be appended to the conversation
        # history by default.
        #
        # The server will respond with a `response.created` event, events for Items and
        # content created, and finally a `response.done` event to indicate the Response is
        # complete.
        #
        # The `response.create` event includes inference configuration like `instructions`
        # and `tools`. If these are set, they will override the Session's configuration
        # for this Response only.
        #
        # Responses can be created out-of-band of the default Conversation, meaning that
        # they can have arbitrary input, and it's possible to disable writing the output
        # to the Conversation. Only one Response can write to the default Conversation at
        # a time, but otherwise multiple Responses can be created in parallel. The
        # `metadata` field is a good way to disambiguate multiple simultaneous Responses.
        #
        # Clients can set `conversation` to `none` to create a Response that does not
        # write to the default Conversation. Arbitrary input can be provided with the
        # `input` field, which is an array accepting raw Items and references to existing
        # Items.
        sig do
          params(
            event_id: String,
            response: OpenAI::Realtime::RealtimeResponseCreateParams::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # Create a new Realtime response with these parameters
          response: nil,
          # The event type, must be `response.create`.
          type: :"response.create"
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              event_id: String,
              response: OpenAI::Realtime::RealtimeResponseCreateParams
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
