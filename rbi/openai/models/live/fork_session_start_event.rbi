# typed: strong

module OpenAI
  module Models

    module Live

      class ForkSessionStartEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ForkSessionStartEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # Overrides for a stored session after connecting to the fork WebSocket. An empty
        # object inherits the stored configuration; do not supply a new model.
        # audio.format applies only to the new WebSocket connection. client overrides are
        # only supported for WebRTC forks.
        sig { returns(OpenAI::Live::ForkSessionConfig) }
        attr_reader :session

        sig { params(session: OpenAI::Live::ForkSessionConfig::OrHash).void }
        attr_writer :session

        # The Live client event type. Always `session.start`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Start a Live session after connecting to a stored session’s fork WebSocket. Send
        # an empty `session` object to use the stored configuration.
        sig do
          params(

            session: OpenAI::Live::ForkSessionConfig::OrHash,

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Overrides for a stored session after connecting to the fork WebSocket. An empty
          # object inherits the stored configuration; do not supply a new model.
          # audio.format applies only to the new WebSocket connection. client overrides are
          # only supported for WebRTC forks.
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
            {session: OpenAI::Live::ForkSessionConfig, type: Symbol, event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
