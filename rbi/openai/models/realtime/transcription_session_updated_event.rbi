# typed: strong

module OpenAI
  module Models
    module Realtime
      class TranscriptionSessionUpdatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::TranscriptionSessionUpdatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # A new Realtime transcription session configuration.
        #
        # When a session is created on the server via REST API, the session object also
        # contains an ephemeral key. Default TTL for keys is 10 minutes. This property is
        # not present when a session is updated via the WebSocket API.
        sig do
          returns(OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse)
        end
        attr_reader :session

        sig do
          params(
            session:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::OrHash
          ).void
        end
        attr_writer :session

        # The event type, must be `transcription_session.updated`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a transcription session is updated with a
        # `transcription_session.update` event, unless there is an error.
        sig do
          params(
            event_id: String,
            session:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # A new Realtime transcription session configuration.
          #
          # When a session is created on the server via REST API, the session object also
          # contains an ephemeral key. Default TTL for keys is 10 minutes. This property is
          # not present when a session is updated via the WebSocket API.
          session:,
          # The event type, must be `transcription_session.updated`.
          type: :"transcription_session.updated"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              session:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
