# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSessionUpdateEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranslationSessionUpdateEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Translation session fields to update. The session `type` and `model` are set at
        # creation and cannot be changed with `session.update`.
        sig do
          returns(OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest)
        end
        attr_reader :session

        sig do
          params(
            session:
              OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest::OrHash
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

        # Send this event to update the translation session configuration. Translation
        # sessions support updates to `audio.output.language`,
        # `audio.input.transcription`, and `audio.input.noise_reduction`.
        sig do
          params(
            session:
              OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest::OrHash,
            event_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Translation session fields to update. The session `type` and `model` are set at
          # creation and cannot be changed with `session.update`.
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
              session:
                OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest,
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
