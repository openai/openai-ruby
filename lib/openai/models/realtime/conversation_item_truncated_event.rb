# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemTruncatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute audio_end_ms
        #   The duration up to which the audio was truncated, in milliseconds.
        #
        #   @return [Integer]
        required :audio_end_ms, Integer

        # @!attribute content_index
        #   The index of the content part that was truncated.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the assistant message item that was truncated.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `conversation.item.truncated`.
        #
        #   @return [Symbol, :"conversation.item.truncated"]
        required :type, const: :"conversation.item.truncated"

        # @!method initialize(audio_end_ms:, content_index:, event_id:, item_id:, type: :"conversation.item.truncated")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ConversationItemTruncatedEvent} for more details.
        #
        #   Returned when an earlier assistant audio message item is truncated by the client
        #   with a `conversation.item.truncate` event. This event is used to synchronize the
        #   server's understanding of the audio with the client's playback.
        #
        #   This action will truncate the audio and remove the server-side text transcript
        #   to ensure there is no text in the context that hasn't been heard by the user.
        #
        #   @param audio_end_ms [Integer] The duration up to which the audio was truncated, in milliseconds.
        #
        #   @param content_index [Integer] The index of the content part that was truncated.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the assistant message item that was truncated.
        #
        #   @param type [Symbol, :"conversation.item.truncated"] The event type, must be `conversation.item.truncated`.
      end
    end
  end
end
