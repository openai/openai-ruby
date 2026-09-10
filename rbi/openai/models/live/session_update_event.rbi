# typed: strong

module OpenAI
  module Models

    module Live

      class SessionUpdateEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionUpdateEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # Sparse delegation updates. Omitted settings retain their values. The delegation
        # type cannot change, including resetting Responses delegation to null or client.
        # Model, frontend instructions, audio, and startup input are immutable.
        sig { returns(OpenAI::Live::SessionUpdateConfig) }
        attr_reader :session

        sig { params(session: OpenAI::Live::SessionUpdateConfig::OrHash).void }
        attr_writer :session

        # The Live client event type. Always `session.update`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Update the delegation settings of an active Live session. The server
        # acknowledges accepted changes with `session.updated`.
        sig do
          params(

            session: OpenAI::Live::SessionUpdateConfig::OrHash,

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Sparse delegation updates. Omitted settings retain their values. The delegation
          # type cannot change, including resetting Responses delegation to null or client.
          # Model, frontend instructions, audio, and startup input are immutable.
          session:,

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          # The Live client event type. Always `session.update`.

          type: :"session.update"
        )
        end

        sig do
          override.returns(
            {session: OpenAI::Live::SessionUpdateConfig, type: Symbol, event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
