# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemTruncateEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemTruncateEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Inclusive duration up to which audio is truncated, in milliseconds. If the
        # audio_end_ms is greater than the actual audio duration, the server will respond
        # with an error.
        sig { returns(Integer) }
        attr_accessor :audio_end_ms

        # The index of the content part to truncate. Set this to `0`.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the assistant message item to truncate. Only assistant message items
        # can be truncated.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `conversation.item.truncate`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event to truncate a previous assistant message’s audio. The server
        # will produce audio faster than realtime, so this event is useful when the user
        # interrupts to truncate audio that has already been sent to the client but not
        # yet played. This will synchronize the server's understanding of the audio with
        # the client's playback.
        #
        # Truncating audio will delete the server-side text transcript to ensure there is
        # not text in the context that hasn't been heard by the user.
        #
        # If successful, the server will respond with a `conversation.item.truncated`
        # event.
        sig do
          params(
            audio_end_ms: Integer,
            content_index: Integer,
            item_id: String,
            event_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Inclusive duration up to which audio is truncated, in milliseconds. If the
          # audio_end_ms is greater than the actual audio duration, the server will respond
          # with an error.
          audio_end_ms:,
          # The index of the content part to truncate. Set this to `0`.
          content_index:,
          # The ID of the assistant message item to truncate. Only assistant message items
          # can be truncated.
          item_id:,
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The event type, must be `conversation.item.truncate`.
          type: :"conversation.item.truncate"
        )
        end

        sig do
          override.returns(
            {
              audio_end_ms: Integer,
              content_index: Integer,
              item_id: String,
              type: Symbol,
              event_id: String
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
