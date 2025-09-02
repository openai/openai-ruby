# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemInputAudioTranscriptionDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `conversation.item.input_audio_transcription.delta`.
        #
        #   @return [Symbol, :"conversation.item.input_audio_transcription.delta"]
        required :type, const: :"conversation.item.input_audio_transcription.delta"

        # @!attribute content_index
        #   The index of the content part in the item's content array.
        #
        #   @return [Integer, nil]
        optional :content_index, Integer

        # @!attribute delta
        #   The text delta.
        #
        #   @return [String, nil]
        optional :delta, String

        # @!attribute logprobs
        #   The log probabilities of the transcription.
        #
        #   @return [Array<OpenAI::Models::Realtime::LogProbProperties>, nil]
        optional :logprobs,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Realtime::LogProbProperties] },
                 nil?: true

        # @!method initialize(event_id:, item_id:, content_index: nil, delta: nil, logprobs: nil, type: :"conversation.item.input_audio_transcription.delta")
        #   Returned when the text value of an input audio transcription content part is
        #   updated.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the item.
        #
        #   @param content_index [Integer] The index of the content part in the item's content array.
        #
        #   @param delta [String] The text delta.
        #
        #   @param logprobs [Array<OpenAI::Models::Realtime::LogProbProperties>, nil] The log probabilities of the transcription.
        #
        #   @param type [Symbol, :"conversation.item.input_audio_transcription.delta"] The event type, must be `conversation.item.input_audio_transcription.delta`.
      end
    end
  end
end
