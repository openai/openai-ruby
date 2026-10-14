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

        # Update the delegation settings of an active Live session. The server acknowledges accepted changes with `session.updated`.
        variant :"session.update", -> { OpenAI::Live::SessionUpdateEvent }

        # Send audio to a Live session over its primary WebSocket. WebRTC and SIP sessions send audio over their media transport.
        variant :"session.input_audio.append", -> { OpenAI::Live::InputAudioAppendEvent }

        # Mute audio input to the Live model without closing the session. The server acknowledges with `session.input_audio.muted`.
        variant :"session.input_audio.mute", -> { OpenAI::Live::InputAudioMuteEvent }

        # Resume audio input to a Live model after muting it. The server acknowledges with `session.input_audio.unmuted`.
        variant :"session.input_audio.unmute", -> { OpenAI::Live::InputAudioUnmuteEvent }

        # Append instructions to the Live conversation while it is running, optionally associating them with an existing client delegation.
        variant :"session.instructions.append", -> { OpenAI::Live::InstructionsAppendEvent }

        # Provide silent reasoning or progress context to the Live model, optionally for an existing client delegation.
        variant :"session.thinking.append", -> { OpenAI::Live::ThinkingAppendEvent }

        # Provide context the Live model can communicate to the user, optionally for an existing client delegation.
        variant :"session.commentary.append", -> { OpenAI::Live::CommentaryAppendEvent }

        # Add an input item to the Live session’s Responses backend. Requires Responses delegation; use `response.create` to request a response.
        variant :"response.item.create", -> { OpenAI::Live::ResponseItemCreateEvent }

        # Request a response from the Live session’s Responses backend, or continue a delegated response waiting for tool results. Requires Responses delegation.
        variant :"response.create", -> { OpenAI::Live::ResponseCreateEvent }

        # Request that the Live session close. The terminal `session.closed` event contains the close reason and final usage.
        variant :"session.close", -> { OpenAI::Live::SessionCloseEvent }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Live::SessionStartEvent, OpenAI::Models::Live::SessionUpdateEvent, OpenAI::Models::Live::InputAudioAppendEvent, OpenAI::Models::Live::InputAudioMuteEvent, OpenAI::Models::Live::InputAudioUnmuteEvent, OpenAI::Models::Live::InstructionsAppendEvent, OpenAI::Models::Live::ThinkingAppendEvent, OpenAI::Models::Live::CommentaryAppendEvent, OpenAI::Models::Live::ResponseItemCreateEvent, OpenAI::Models::Live::ResponseCreateEvent, OpenAI::Models::Live::SessionCloseEvent)]
      end
    end
  end
end
