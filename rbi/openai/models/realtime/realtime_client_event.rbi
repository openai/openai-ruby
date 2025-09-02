# typed: strong

module OpenAI
  module Models
    module Realtime
      # A realtime client event.
      module RealtimeClientEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemCreateEvent,
              OpenAI::Realtime::ConversationItemDeleteEvent,
              OpenAI::Realtime::ConversationItemRetrieveEvent,
              OpenAI::Realtime::ConversationItemTruncateEvent,
              OpenAI::Realtime::InputAudioBufferAppendEvent,
              OpenAI::Realtime::InputAudioBufferClearEvent,
              OpenAI::Realtime::OutputAudioBufferClearEvent,
              OpenAI::Realtime::InputAudioBufferCommitEvent,
              OpenAI::Realtime::ResponseCancelEvent,
              OpenAI::Realtime::ResponseCreateEvent,
              OpenAI::Realtime::SessionUpdateEvent,
              OpenAI::Realtime::TranscriptionSessionUpdate
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::RealtimeClientEvent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
