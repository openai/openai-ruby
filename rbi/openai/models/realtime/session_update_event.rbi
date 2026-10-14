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

        # Update the Realtime session. Choose either a realtime session or a transcription
        # session.
        sig do
          returns(
            T.any(
              OpenAI::Realtime::RealtimeSessionCreateRequest,
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest
            )
          )
        end
        attr_accessor :session

        # The event type, must be `session.update`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event. This is an arbitrary
        # string that a client may assign. It will be passed back if there is an error
        # with the event, but the corresponding `session.updated` event will not include
        # it.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event to update the session’s configuration. The client may send this
        # event at any time to update any field except for `voice` and `model`. `voice`
        # can be updated only if there have been no other audio outputs yet.
        #
        # When the server receives a `session.update`, it will respond with a
        # `session.updated` event showing the full, effective configuration. Only the
        # fields that are present in the `session.update` are updated. To clear a field
        # like `instructions`, pass an empty string. To clear a field like `tools`, pass
        # an empty array. To clear a field like `turn_detection`, pass `null`.
        sig do
          params(
            session:
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateRequest::OrHash,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::OrHash
              ),
            event_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Update the Realtime session. Choose either a realtime session or a transcription
          # session.
          session:,
          # Optional client-generated ID used to identify this event. This is an arbitrary
          # string that a client may assign. It will be passed back if there is an error
          # with the event, but the corresponding `session.updated` event will not include
          # it.
          event_id: nil,
          # The event type, must be `session.update`.
          type: :"session.update"
        )
        end

        sig do
          override.returns(
            {
              session:
                T.any(
                  OpenAI::Realtime::RealtimeSessionCreateRequest,
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest
                ),
              type: Symbol,
              event_id: String
            }
          )
        end
        def to_hash
        end

        # Update the Realtime session. Choose either a realtime session or a transcription
        # session.
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
              T::Array[OpenAI::Realtime::SessionUpdateEvent::Session::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
