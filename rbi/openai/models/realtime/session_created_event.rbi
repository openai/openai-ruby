# typed: strong

module OpenAI
  module Models
    module Realtime
      class SessionCreatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::SessionCreatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The session configuration.
        sig do
          returns(
            T.any(
              OpenAI::Realtime::RealtimeSessionCreateRequest,
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest
            )
          )
        end
        attr_accessor :session

        # The event type, must be `session.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a Session is created. Emitted automatically when a new connection
        # is established as the first server event. This event will contain the default
        # Session configuration.
        sig do
          params(
            event_id: String,
            session:
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateRequest::OrHash,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # The session configuration.
          session:,
          # The event type, must be `session.created`.
          type: :"session.created"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              session:
                T.any(
                  OpenAI::Realtime::RealtimeSessionCreateRequest,
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest
                ),
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # The session configuration.
        module Session
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateRequest,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Realtime::SessionCreatedEvent::Session::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
