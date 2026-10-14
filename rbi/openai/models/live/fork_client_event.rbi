# typed: strong

module OpenAI
  module Models

    module Live

      # Client events for a Live fork WebSocket. First send session.start with an
      # overrides object (which may be empty), then wait for session.started before
      # sending other commands. The model and conversation are inherited from the stored
      # session.
      module ForkClientEvent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Live::ForkSessionStartEvent,
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

        sig { override.returns(T::Array[OpenAI::Live::ForkClientEvent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
