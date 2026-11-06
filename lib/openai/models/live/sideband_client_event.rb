# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # Client events accepted by an attached Live sideband WebSocket. The session has
      # already started. Send input audio over the primary connection.
      module SidebandClientEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Update the delegation settings or transcript triggers of an active Live session. The server acknowledges accepted changes with `session.updated`.
        variant :"session.update", -> { OpenAI::Live::SessionUpdateEvent }

        # Mute audio input to the Live model without closing the session. The server acknowledges with `session.input_audio.muted`.
        variant :"session.input_audio.mute", -> { OpenAI::Live::InputAudioMuteEvent }

        # Resume audio input to a Live model after muting it. The server acknowledges with `session.input_audio.unmuted`. An active audio fixture still pauses inference until playback finishes.
        variant :"session.input_audio.unmute", -> { OpenAI::Live::InputAudioUnmuteEvent }

        # Play one complete audio fixture through the session output. Send this event over the primary WebSocket or a server sideband. Audio must be raw mono PCM16 little-endian at 24 kHz, regardless of the session audio format, and at most 30 seconds. The entire payload is validated before model speech is interrupted and input is muted. Only one fixture can be active. fixture.playing acknowledges acceptance and fixture.played reports server mixer drain. These notifications are not exact transport-media boundaries. Input arriving during playback is dropped and not replayed.
        variant :"session.output_audio.fixture.play", -> { OpenAI::Live::OutputAudioFixturePlayEvent }

        # Send one DTMF keypress to the SIP trunk through a Live sideband connection. This command is supported only for SIP calls. A successful send emits `transport.dtmf.sent` on sideband. If you provide `event_id`, the success notification includes it as `client_event_id`; a failure includes it as `error.client_event_id`. Send separate events for multiple keypresses.
        variant :"transport.dtmf.send", -> { OpenAI::Live::SidebandClientEvent::TransportDtmfSend }

        # Append developer instructions to the Live conversation while it is running, optionally associating them with an existing client delegation. Rejected while an audio fixture is active. These instructions remain in conversation history through compaction and are included in future backend delegations. For external audio, describe content already delivered so the assistant does not repeat it.
        variant :"session.instructions.append", -> { OpenAI::Live::InstructionsAppendEvent }

        # Provide silent reasoning or progress context to the Live model, optionally for an existing client delegation. Rejected while an audio fixture is active.
        variant :"session.thinking.append", -> { OpenAI::Live::ThinkingAppendEvent }

        # Provide context the Live model can communicate to the user, optionally for an existing client delegation. Rejected while an audio fixture is active.
        variant :"session.commentary.append", -> { OpenAI::Live::CommentaryAppendEvent }

        # Evaluate the configured questions using the current conversation and Decision inputs. Reusing an event_id is rejected for the lifetime of the session.
        variant :"decision.create", -> { OpenAI::Live::DecisionCreateEvent }

        # Append an input item for future decisions without starting an evaluation or changing Live voice context.
        variant :"decision.item.create", -> { OpenAI::Live::DecisionItemCreateEvent }

        # Delete an input item from future decisions without starting an evaluation or changing Live voice context.
        variant :"decision.item.delete", -> { OpenAI::Live::DecisionItemDeleteEvent }

        # Add an input item to the Live session’s Responses backend. Requires Responses delegation; use `response.create` to request a response.
        variant :"response.item.create", -> { OpenAI::Live::ResponseItemCreateEvent }

        # Request a response from the Live session’s Responses backend, or continue a delegated response waiting for tool results. Requires Responses delegation.
        variant :"response.create", -> { OpenAI::Live::ResponseCreateEvent }

        # Request that the Live session close. The terminal `session.closed` event contains the close reason and final usage.
        variant :"session.close", -> { OpenAI::Live::SessionCloseEvent }

        class TransportDtmfSend < OpenAI::Internal::Type::BaseModel
          # @!attribute event
          #   The DTMF key to send: one of `0`–`9`, `A`–`D`, `*`, or `#`.
          #
          #   @return [String]
          required :event, String

          # @!attribute type
          #
          #   @return [Symbol, :"transport.dtmf.send"]
          required :type, const: :"transport.dtmf.send"

          # @!attribute event_id
          #   Optional client identifier for correlating this command with a server event's
          #   client_event_id or error.client_event_id.
          #
          #   @return [String, nil]
          optional :event_id, String, nil?: true

          # @!method initialize(event:, event_id: nil, type: :"transport.dtmf.send")
          #   Send one DTMF keypress to the SIP trunk through a Live sideband connection. This
          #   command is supported only for SIP calls. A successful send emits
          #   `transport.dtmf.sent` on sideband. If you provide `event_id`, the success
          #   notification includes it as `client_event_id`; a failure includes it as
          #   `error.client_event_id`. Send separate events for multiple keypresses.
          #
          #   @param event [String]
          #     The DTMF key to send: one of `0`–`9`, `A`–`D`, `*`, or `#`.
          #
          #   @param event_id [String, nil]
          #     Optional client identifier for correlating this command with a server event's
          #     client_event_id or error.client_event_id.
          #
          #   @param type [Symbol, :"transport.dtmf.send"]
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Live::SessionUpdateEvent, OpenAI::Models::Live::InputAudioMuteEvent, OpenAI::Models::Live::InputAudioUnmuteEvent, OpenAI::Models::Live::OutputAudioFixturePlayEvent, OpenAI::Models::Live::SidebandClientEvent::TransportDtmfSend, OpenAI::Models::Live::InstructionsAppendEvent, OpenAI::Models::Live::ThinkingAppendEvent, OpenAI::Models::Live::CommentaryAppendEvent, OpenAI::Models::Live::DecisionCreateEvent, OpenAI::Models::Live::DecisionItemCreateEvent, OpenAI::Models::Live::DecisionItemDeleteEvent, OpenAI::Models::Live::ResponseItemCreateEvent, OpenAI::Models::Live::ResponseCreateEvent, OpenAI::Models::Live::SessionCloseEvent)]
      end
    end
  end
end
