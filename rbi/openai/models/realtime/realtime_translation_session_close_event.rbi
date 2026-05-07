# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSessionCloseEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranslationSessionCloseEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The event type, must be `session.close`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Gracefully close the realtime translation session. The server flushes pending
        # input audio and emits any remaining translated output before closing the
        # session.
        sig { params(event_id: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The event type, must be `session.close`.
          type: :"session.close"
        )
        end

        sig { override.returns({ type: Symbol, event_id: String }) }
        def to_hash
        end
      end
    end
  end
end
