# typed: strong

module OpenAI
  module Models

    module Live

      class OutputAudioFixturePlayedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::OutputAudioFixturePlayedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        sig { returns(Symbol) }
        attr_accessor :type

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # The complete audio fixture has drained from the server mixer and normal
        # inference has resumed. Transport buffers may still contain audio; this event
        # does not prove listener-side completion. The optional client_event_id echoes the
        # play command. This event is not emitted for canceled or failed playback.
        sig do
          params(

            event_id: String,

            client_event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the Live server event.
          event_id:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          type: :"session.output_audio.fixture.played"
        )
        end

        sig do
          override.returns(
            {event_id: String, type: Symbol, client_event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
