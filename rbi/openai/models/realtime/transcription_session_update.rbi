# typed: strong

module OpenAI
  module Models
    module Realtime
      class TranscriptionSessionUpdate < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::TranscriptionSessionUpdate,
              OpenAI::Internal::AnyHash
            )
          end

        # Realtime transcription session object configuration.
        sig do
          returns(OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest)
        end
        attr_reader :session

        sig do
          params(
            session:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::OrHash
          ).void
        end
        attr_writer :session

        # The event type, must be `transcription_session.update`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event to update a transcription session.
        sig do
          params(
            session:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::OrHash,
            event_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Realtime transcription session object configuration.
          session:,
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The event type, must be `transcription_session.update`.
          type: :"transcription_session.update"
        )
        end

        sig do
          override.returns(
            {
              session:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest,
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
