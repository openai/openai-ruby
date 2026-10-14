# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemTruncatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemTruncatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The duration up to which the audio was truncated, in milliseconds.
        sig { returns(Integer) }
        attr_accessor :audio_end_ms

        # The index of the content part that was truncated.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the assistant message item that was truncated.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `conversation.item.truncated`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when an earlier assistant audio message item is truncated by the client
        # with a `conversation.item.truncate` event. This event is used to synchronize the
        # server's understanding of the audio with the client's playback.
        #
        # This action will truncate the audio and remove the server-side text transcript
        # to ensure there is no text in the context that hasn't been heard by the user.
        sig do
          params(
            audio_end_ms: Integer,
            content_index: Integer,
            event_id: String,
            item_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The duration up to which the audio was truncated, in milliseconds.
          audio_end_ms:,
          # The index of the content part that was truncated.
          content_index:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the assistant message item that was truncated.
          item_id:,
          # The event type, must be `conversation.item.truncated`.
          type: :"conversation.item.truncated"
        )
        end

        sig do
          override.returns(
            {
              audio_end_ms: Integer,
              content_index: Integer,
              event_id: String,
              item_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
