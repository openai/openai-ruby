# typed: strong

module OpenAI
  module Models

    module Realtime

      # A Realtime translation client event.
      module RealtimeTranslationClientEvent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Realtime::RealtimeTranslationSessionUpdateEvent,
            OpenAI::Realtime::RealtimeTranslationInputAudioBufferAppendEvent,
            OpenAI::Realtime::RealtimeTranslationSessionCloseEvent
          )
        end

        sig { override.returns(T::Array[OpenAI::Realtime::RealtimeTranslationClientEvent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
