# typed: strong

module OpenAI
  module Models

    module Live

      # Client events accepted by an attached Live sideband WebSocket. The session has
      # already started. Send input audio over the primary connection.
      module SidebandClientEvent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Live::SessionUpdateEvent,
            OpenAI::Live::InputAudioMuteEvent,
            OpenAI::Live::InputAudioUnmuteEvent,
            OpenAI::Live::OutputAudioFixturePlayEvent,
            OpenAI::Live::InstructionsAppendEvent,
            OpenAI::Live::ThinkingAppendEvent,
            OpenAI::Live::CommentaryAppendEvent,
            OpenAI::Live::DecisionCreateEvent,
            OpenAI::Live::DecisionItemCreateEvent,
            OpenAI::Live::DecisionItemDeleteEvent,
            OpenAI::Live::ResponseItemCreateEvent,
            OpenAI::Live::ResponseCreateEvent,
            OpenAI::Live::SessionCloseEvent
          )
        end

        sig { override.returns(T::Array[OpenAI::Live::SidebandClientEvent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
