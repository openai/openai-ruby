# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeErrorEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeErrorEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Details of the error.
        sig { returns(OpenAI::Realtime::RealtimeError) }
        attr_reader :error

        sig { params(error: OpenAI::Realtime::RealtimeError::OrHash).void }
        attr_writer :error

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event type, must be `error`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when an error occurs, which could be a client problem or a server
        # problem. Most errors are recoverable and the session will stay open, we
        # recommend to implementors to monitor and log error messages by default.
        sig do
          params(
            error: OpenAI::Realtime::RealtimeError::OrHash,
            event_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Details of the error.
          error:,
          # The unique ID of the server event.
          event_id:,
          # The event type, must be `error`.
          type: :error
        )
        end

        sig do
          override.returns(
            {
              error: OpenAI::Realtime::RealtimeError,
              event_id: String,
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
