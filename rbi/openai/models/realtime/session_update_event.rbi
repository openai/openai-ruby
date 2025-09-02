# typed: strong

module OpenAI
  module Models
    module Realtime
      class SessionUpdateEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::SessionUpdateEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Realtime session object configuration.
        sig { returns(OpenAI::Realtime::RealtimeSessionCreateRequest) }
        attr_reader :session

        sig do
          params(
            session: OpenAI::Realtime::RealtimeSessionCreateRequest::OrHash
          ).void
        end
        attr_writer :session

        # The event type, must be `session.update`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event to update the session’s default configuration. The client may
        # send this event at any time to update any field, except for `voice`. However,
        # note that once a session has been initialized with a particular `model`, it
        # can’t be changed to another model using `session.update`.
        #
        # When the server receives a `session.update`, it will respond with a
        # `session.updated` event showing the full, effective configuration. Only the
        # fields that are present are updated. To clear a field like `instructions`, pass
        # an empty string.
        sig do
          params(
            session: OpenAI::Realtime::RealtimeSessionCreateRequest::OrHash,
            event_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Realtime session object configuration.
          session:,
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The event type, must be `session.update`.
          type: :"session.update"
        )
        end

        sig do
          override.returns(
            {
              session: OpenAI::Realtime::RealtimeSessionCreateRequest,
              type: Symbol,
              event_id: String
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
