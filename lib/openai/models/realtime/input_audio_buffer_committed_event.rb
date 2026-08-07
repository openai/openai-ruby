# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferCommittedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the user message item that will be created.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `input_audio_buffer.committed`.
        #
        #   @return [Symbol, :"input_audio_buffer.committed"]
        required :type, const: :"input_audio_buffer.committed"

        # @!attribute previous_item_id
        #   The ID of the preceding item after which the new item will be inserted. Can be
        #   `null` if the item has no predecessor.
        #
        #   @return [String, nil]
        optional :previous_item_id, String, nil?: true

        # @!method initialize(event_id:, item_id:, previous_item_id: nil, type: :"input_audio_buffer.committed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::InputAudioBufferCommittedEvent} for more details.
        #
        #   Returned when an input audio buffer is committed, either by the client or
        #   automatically in server VAD mode. The `item_id` property is the ID of the user
        #   message item that will be created, thus a `conversation.item.created` event will
        #   also be sent to the client.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the user message item that will be created.
        #
        #   @param previous_item_id [String, nil] The ID of the preceding item after which the new item will be inserted.
        #
        #   @param type [Symbol, :"input_audio_buffer.committed"] The event type, must be `input_audio_buffer.committed`.
      end
    end
  end
end
