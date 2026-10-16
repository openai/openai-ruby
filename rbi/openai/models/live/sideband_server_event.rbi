# typed: strong

module OpenAI
  module Models

    module Live

      # Server events received by an attached Live sideband WebSocket. Audio deltas are
      # delivered over the primary connection.
      module SidebandServerEvent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Live::SessionStartedEvent,
            OpenAI::Live::SessionUpdatedEvent,
            OpenAI::Live::InputAudioMutedEvent,
            OpenAI::Live::InputAudioUnmutedEvent,
            OpenAI::Live::OutputAudioFixturePlayingEvent,
            OpenAI::Live::OutputAudioFixturePlayedEvent,
            OpenAI::Live::InstructionsAppendedEvent,
            OpenAI::Live::ThinkingAppendedEvent,
            OpenAI::Live::CommentaryAppendedEvent,
            OpenAI::Live::InputTranscriptDeltaEvent,
            OpenAI::Live::OutputTranscriptDeltaEvent,
            OpenAI::Live::DelegationCreatedEvent,
            OpenAI::Live::DecisionEvent,
            OpenAI::Live::DecisionItemCreatedEvent,
            OpenAI::Live::DecisionItemDeletedEvent,
            OpenAI::Live::ResponseEvent,
            OpenAI::Live::SessionUsageUpdatedEvent,
            OpenAI::Live::SessionClosedEvent,
            OpenAI::Live::ErrorEvent,
            OpenAI::Live::InfoEvent
          )
        end

        sig { override.returns(T::Array[OpenAI::Live::SidebandServerEvent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
