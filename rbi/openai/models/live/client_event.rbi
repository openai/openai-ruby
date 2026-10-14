# typed: strong

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

        Variants = T.type_alias do
          T.any(
            OpenAI::Live::SessionStartEvent,
            OpenAI::Live::SessionUpdateEvent,
            OpenAI::Live::InputAudioAppendEvent,
            OpenAI::Live::InputAudioMuteEvent,
            OpenAI::Live::InputAudioUnmuteEvent,
            OpenAI::Live::InstructionsAppendEvent,
            OpenAI::Live::ThinkingAppendEvent,
            OpenAI::Live::CommentaryAppendEvent,
            OpenAI::Live::ResponseItemCreateEvent,
            OpenAI::Live::ResponseCreateEvent,
            OpenAI::Live::SessionCloseEvent
          )
        end

        sig { override.returns(T::Array[OpenAI::Live::ClientEvent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
