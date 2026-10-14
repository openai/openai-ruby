# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionErrorEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionErrorEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The error that occurred.
        sig { returns(OpenAI::Beta::SessionError) }
        attr_reader :error

        sig { params(error: OpenAI::Beta::SessionError::OrHash).void }
        attr_writer :error

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the session associated with the event.
        sig { returns(String) }
        attr_accessor :session_id

        # The type of the object. Always `error`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a turn or session fails.
        sig do
          params(

            error: OpenAI::Beta::SessionError::OrHash,

            event_id: String,

            session_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The error that occurred.
          error:,

          # The unique ID of the event.
          event_id:,

          # The ID of the session associated with the event.
          session_id:,

          # The type of the object. Always `error`.

          type: :error
        )
        end

        sig do
          override.returns(
            {error: OpenAI::Beta::SessionError, event_id: String, session_id: String, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
