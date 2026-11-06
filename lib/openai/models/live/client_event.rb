# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # Client events for Live. Initialize a primary WebSocket with session.start and
      # wait for session.started. WebRTC creation already starts the session. Audio
      # append is primary WebSocket-only. See the
      # [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting)
      # before writing frontend instructions and delegation policies.
      module ClientEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Start a Live session on a primary WebSocket. Send this event before other commands and wait for `session.started`.
        variant :"session.start", -> { OpenAI::Live::SessionStartEvent }

        # Update the delegation settings or transcript triggers of an active Live session. The server acknowledges accepted changes with `session.updated`.
        variant :"session.update", -> { OpenAI::Live::SessionUpdateEvent }

        # Send audio to a Live session over its primary WebSocket. WebRTC and SIP sessions send audio over their media transport.
        variant :"session.input_audio.append", -> { OpenAI::Live::InputAudioAppendEvent }

        # Mute audio input to the Live model without closing the session. The server acknowledges with `session.input_audio.muted`.
        variant :"session.input_audio.mute", -> { OpenAI::Live::InputAudioMuteEvent }

        # Resume audio input to a Live model after muting it. The server acknowledges with `session.input_audio.unmuted`. An active audio fixture still pauses inference until playback finishes.
        variant :"session.input_audio.unmute", -> { OpenAI::Live::InputAudioUnmuteEvent }

        # Play one complete audio fixture through the session output. Send this event over the primary WebSocket or a server sideband. Audio must be raw mono PCM16 little-endian at 24 kHz, regardless of the session audio format, and at most 30 seconds. The entire payload is validated before model speech is interrupted and input is muted. Only one fixture can be active. fixture.playing acknowledges acceptance and fixture.played reports server mixer drain. These notifications are not exact transport-media boundaries. Input arriving during playback is dropped and not replayed.
        variant :"session.output_audio.fixture.play", -> { OpenAI::Live::OutputAudioFixturePlayEvent }

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

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Live::SessionStartEvent, OpenAI::Models::Live::SessionUpdateEvent, OpenAI::Models::Live::InputAudioAppendEvent, OpenAI::Models::Live::InputAudioMuteEvent, OpenAI::Models::Live::InputAudioUnmuteEvent, OpenAI::Models::Live::OutputAudioFixturePlayEvent, OpenAI::Models::Live::InstructionsAppendEvent, OpenAI::Models::Live::ThinkingAppendEvent, OpenAI::Models::Live::CommentaryAppendEvent, OpenAI::Models::Live::DecisionCreateEvent, OpenAI::Models::Live::DecisionItemCreateEvent, OpenAI::Models::Live::DecisionItemDeleteEvent, OpenAI::Models::Live::ResponseItemCreateEvent, OpenAI::Models::Live::ResponseCreateEvent, OpenAI::Models::Live::SessionCloseEvent)]
      end
    end
  end
end
