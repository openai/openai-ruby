# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseContentPartDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part in the item's content array.
        #
        #   @return [Integer]
        required :content_index, Integer

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

        # @!attribute output_index
        #   The index of the output item in the response.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute part
        #   The content part that is done.
        #
        #   @return [OpenAI::Models::Realtime::ResponseContentPartDoneEvent::Part]
        required :part, -> { OpenAI::Realtime::ResponseContentPartDoneEvent::Part }

        # @!attribute response_id
        #   The ID of the response.
        #
        #   @return [String]
        required :response_id, String

        # @!attribute type
        #   The event type, must be `response.content_part.done`.
        #
        #   @return [Symbol, :"response.content_part.done"]
        required :type, const: :"response.content_part.done"

        # @!method initialize(content_index:, event_id:, item_id:, output_index:, part:, response_id:, type: :"response.content_part.done")
        #   Returned when a content part is done streaming in an assistant message item.
        #   Also emitted when a Response is interrupted, incomplete, or cancelled.
        #
        #   @param content_index [Integer] The index of the content part in the item's content array.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the item.
        #
        #   @param output_index [Integer] The index of the output item in the response.
        #
        #   @param part [OpenAI::Models::Realtime::ResponseContentPartDoneEvent::Part] The content part that is done.
        #
        #   @param response_id [String] The ID of the response.
        #
        #   @param type [Symbol, :"response.content_part.done"] The event type, must be `response.content_part.done`.

        # @see OpenAI::Models::Realtime::ResponseContentPartDoneEvent#part
        class Part < OpenAI::Internal::Type::BaseModel
          # @!attribute audio
          #   Base64-encoded audio data (if type is "audio").
          #
          #   @return [String, nil]
          optional :audio, String

          # @!attribute text
          #   The text content (if type is "text").
          #
          #   @return [String, nil]
          optional :text, String

          # @!attribute transcript
          #   The transcript of the audio (if type is "audio").
          #
          #   @return [String, nil]
          optional :transcript, String

          # @!attribute type
          #   The content type ("text", "audio").
          #
          #   @return [Symbol, OpenAI::Models::Realtime::ResponseContentPartDoneEvent::Part::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::ResponseContentPartDoneEvent::Part::Type }

          # @!method initialize(audio: nil, text: nil, transcript: nil, type: nil)
          #   The content part that is done.
          #
          #   @param audio [String] Base64-encoded audio data (if type is "audio").
          #
          #   @param text [String] The text content (if type is "text").
          #
          #   @param transcript [String] The transcript of the audio (if type is "audio").
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::ResponseContentPartDoneEvent::Part::Type] The content type ("text", "audio").

          # The content type ("text", "audio").
          #
          # @see OpenAI::Models::Realtime::ResponseContentPartDoneEvent::Part#type
          module Type
            extend OpenAI::Internal::Type::Enum

            TEXT = :text
            AUDIO = :audio

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
