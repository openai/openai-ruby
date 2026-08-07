# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemInputAudioTranscriptionSegment < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The segment identifier.
        #
        #   @return [String]
        required :id, String

        # @!attribute content_index
        #   The index of the input audio content part within the item.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute end_
        #   End time of the segment in seconds.
        #
        #   @return [Float]
        required :end_, Float, api_name: :end

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the item containing the input audio content.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute speaker
        #   The detected speaker label for this segment.
        #
        #   @return [String]
        required :speaker, String

        # @!attribute start
        #   Start time of the segment in seconds.
        #
        #   @return [Float]
        required :start, Float

        # @!attribute text
        #   The text for this segment.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The event type, must be `conversation.item.input_audio_transcription.segment`.
        #
        #   @return [Symbol, :"conversation.item.input_audio_transcription.segment"]
        required :type, const: :"conversation.item.input_audio_transcription.segment"

        # @!method initialize(id:, content_index:, end_:, event_id:, item_id:, speaker:, start:, text:, type: :"conversation.item.input_audio_transcription.segment")
        #   Returned when an input audio transcription segment is identified for an item.
        #
        #   @param id [String] The segment identifier.
        #
        #   @param content_index [Integer] The index of the input audio content part within the item.
        #
        #   @param end_ [Float] End time of the segment in seconds.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the item containing the input audio content.
        #
        #   @param speaker [String] The detected speaker label for this segment.
        #
        #   @param start [Float] Start time of the segment in seconds.
        #
        #   @param text [String] The text for this segment.
        #
        #   @param type [Symbol, :"conversation.item.input_audio_transcription.segment"] The event type, must be `conversation.item.input_audio_transcription.segment`.
      end
    end
  end
end
