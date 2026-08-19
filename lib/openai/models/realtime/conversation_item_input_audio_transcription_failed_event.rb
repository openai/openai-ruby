# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemInputAudioTranscriptionFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part containing the audio.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute error
        #   Details of the transcription error.
        #
        #   @return [OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionFailedEvent::Error]
        required :error, -> { OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent::Error }

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the user message item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `conversation.item.input_audio_transcription.failed`.
        #
        #   @return [Symbol, :"conversation.item.input_audio_transcription.failed"]
        required :type, const: :"conversation.item.input_audio_transcription.failed"

        # @!method initialize(content_index:, error:, event_id:, item_id:, type: :"conversation.item.input_audio_transcription.failed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionFailedEvent}
        #   for more details.
        #
        #   Returned when input audio transcription is configured, and a transcription
        #   request for a user message failed. These events are separate from other `error`
        #   events so that the client can identify the related Item.
        #
        #   @param content_index [Integer] The index of the content part containing the audio.
        #
        #   @param error [OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionFailedEvent::Error] Details of the transcription error.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the user message item.
        #
        #   @param type [Symbol, :"conversation.item.input_audio_transcription.failed"] The event type, must be

        # @see OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionFailedEvent#error
        class Error < OpenAI::Internal::Type::BaseModel
          # @!attribute code
          #   Error code, if any.
          #
          #   @return [String, nil]
          optional :code, String

          # @!attribute message
          #   A human-readable error message.
          #
          #   @return [String, nil]
          optional :message, String

          # @!attribute param
          #   Parameter related to the error, if any.
          #
          #   @return [String, nil]
          optional :param, String

          # @!attribute type
          #   The type of error.
          #
          #   @return [String, nil]
          optional :type, String

          # @!method initialize(code: nil, message: nil, param: nil, type: nil)
          #   Details of the transcription error.
          #
          #   @param code [String] Error code, if any.
          #
          #   @param message [String] A human-readable error message.
          #
          #   @param param [String] Parameter related to the error, if any.
          #
          #   @param type [String] The type of error.
        end
      end
    end
  end
end
