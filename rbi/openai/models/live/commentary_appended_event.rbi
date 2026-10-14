# typed: strong

module OpenAI
  module Models

    module Live

      class CommentaryAppendedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::CommentaryAppendedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The end of this event on the Live session timeline, in milliseconds from the
        # beginning of the session. For appended context, this can equal start_ms.
        sig { returns(Integer) }
        attr_accessor :end_ms

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The start of this event on the Live session timeline, in milliseconds from the
        # beginning of the session.
        sig { returns(Integer) }
        attr_accessor :start_ms

        # The event type, always `session.commentary.appended`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # Returned when a session.commentary.append command is accepted into the Live
        # session timeline. Acknowledges the added commentary without guaranteeing exact
        # wording or completed audio playback.
        sig do
          params(

            end_ms: Integer,

            event_id: String,

            start_ms: Integer,

            client_event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The end of this event on the Live session timeline, in milliseconds from the
          # beginning of the session. For appended context, this can equal start_ms.
          end_ms:,

          # The unique ID of the Live server event.
          event_id:,

          # The start of this event on the Live session timeline, in milliseconds from the
          # beginning of the session.
          start_ms:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          # The event type, always `session.commentary.appended`.

          type: :"session.commentary.appended"
        )
        end

        sig do
          override.returns(
            {end_ms: Integer, event_id: String, start_ms: Integer, type: Symbol, client_event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
