# typed: strong

module OpenAI
  module Models

    module Live

      class ErrorEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ErrorEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # Details of the Live error and the client command that caused it, when known.
        sig { returns(OpenAI::Live::Error) }
        attr_reader :error

        sig { params(error: OpenAI::Live::Error::OrHash).void }
        attr_writer :error

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event type, always `error`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # Reports an error in the Live session, such as an invalid client command. Use
        # error.client_event_id, when present, to identify the command that caused the
        # error.
        sig do
          params(

            error: OpenAI::Live::Error::OrHash,

            event_id: String,

            client_event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Details of the Live error and the client command that caused it, when known.
          error:,

          # The unique ID of the Live server event.
          event_id:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          # The event type, always `error`.

          type: :error
        )
        end

        sig do
          override.returns(
            {error: OpenAI::Live::Error, event_id: String, type: Symbol, client_event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
