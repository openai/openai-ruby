# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemTruncateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute audio_end_ms
        #   Inclusive duration up to which audio is truncated, in milliseconds. If the
        #   audio_end_ms is greater than the actual audio duration, the server will respond
        #   with an error.
        #
        #   @return [Integer]
        required :audio_end_ms, Integer

        # @!attribute content_index
        #   The index of the content part to truncate. Set this to 0.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The ID of the assistant message item to truncate. Only assistant message items
        #   can be truncated.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `conversation.item.truncate`.
        #
        #   @return [Symbol, :"conversation.item.truncate"]
        required :type, const: :"conversation.item.truncate"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(audio_end_ms:, content_index:, item_id:, event_id: nil, type: :"conversation.item.truncate")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ConversationItemTruncateEvent} for more details.
        #
        #   Send this event to truncate a previous assistant message’s audio. The server
        #   will produce audio faster than realtime, so this event is useful when the user
        #   interrupts to truncate audio that has already been sent to the client but not
        #   yet played. This will synchronize the server's understanding of the audio with
        #   the client's playback.
        #
        #   Truncating audio will delete the server-side text transcript to ensure there is
        #   not text in the context that hasn't been heard by the user.
        #
        #   If successful, the server will respond with a `conversation.item.truncated`
        #   event.
        #
        #   @param audio_end_ms [Integer] Inclusive duration up to which audio is truncated, in milliseconds. If
        #
        #   @param content_index [Integer] The index of the content part to truncate. Set this to 0.
        #
        #   @param item_id [String] The ID of the assistant message item to truncate. Only assistant message
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"conversation.item.truncate"] The event type, must be `conversation.item.truncate`.
      end
    end
  end
end
