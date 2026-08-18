# typed: strong

module OpenAI
  module Models
    module Realtime
      # A Realtime translation server event.
      module RealtimeTranslationServerEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeErrorEvent,
              OpenAI::Realtime::RealtimeTranslationSessionCreatedEvent,
              OpenAI::Realtime::RealtimeTranslationSessionUpdatedEvent,
              OpenAI::Realtime::RealtimeTranslationSessionClosedEvent,
              OpenAI::Realtime::RealtimeTranslationInputTranscriptDeltaEvent,
              OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent,
              OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::RealtimeTranslationServerEvent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
