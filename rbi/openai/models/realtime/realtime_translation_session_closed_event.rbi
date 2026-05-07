# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSessionClosedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranslationSessionClosedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event type, must be `session.closed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a realtime translation session is closed.
        sig { params(event_id: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # The event type, must be `session.closed`.
          type: :"session.closed"
        )
        end

        sig { override.returns({ event_id: String, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
