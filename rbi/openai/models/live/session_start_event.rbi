# typed: strong

module OpenAI
  module Models

    module Live

      class SessionStartEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionStartEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # Initial configuration for a primary WebSocket. Send session.start first and wait
        # for session.started before application commands. WebRTC creation already starts
        # the session; do not send this event again on its data channel.
        sig { returns(OpenAI::Live::SessionConfig) }
        attr_reader :session

        sig { params(session: OpenAI::Live::SessionConfig::OrHash).void }
        attr_writer :session

        # The Live client event type. Always `session.start`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Start a Live session on a primary WebSocket. Send this event before other
        # commands and wait for `session.started`.
        sig do
          params(

            session: OpenAI::Live::SessionConfig::OrHash,

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Initial configuration for a primary WebSocket. Send session.start first and wait
          # for session.started before application commands. WebRTC creation already starts
          # the session; do not send this event again on its data channel.
          session:,

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          # The Live client event type. Always `session.start`.

          type: :"session.start"
        )
        end

        sig do
          override.returns(
            {session: OpenAI::Live::SessionConfig, type: Symbol, event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
