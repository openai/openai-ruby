# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseContentPartAddedEvent < OpenAI::Internal::Type::BaseModel
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
        #   The ID of the item to which the content part was added.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute part
        #   The content part that was added.
        #
        #   @return [OpenAI::Models::Realtime::ResponseContentPartAddedEvent::Part]
        required :part, -> { OpenAI::Realtime::ResponseContentPartAddedEvent::Part }

        # @!attribute response_id
        #   The ID of the response.
        #
        #   @return [String]
        required :response_id, String

        # @!attribute type
        #   The event type, must be `response.content_part.added`.
        #
        #   @return [Symbol, :"response.content_part.added"]
        required :type, const: :"response.content_part.added"

        # @!method initialize(content_index:, event_id:, item_id:, output_index:, part:, response_id:, type: :"response.content_part.added")
        #   Returned when a new content part is added to an assistant message item during
        #   response generation.
        #
        #   @param content_index [Integer] The index of the content part in the item's content array.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the item to which the content part was added.
        #
        #   @param output_index [Integer] The index of the output item in the response.
        #
        #   @param part [OpenAI::Models::Realtime::ResponseContentPartAddedEvent::Part] The content part that was added.
        #
        #   @param response_id [String] The ID of the response.
        #
        #   @param type [Symbol, :"response.content_part.added"] The event type, must be `response.content_part.added`.

        # @see OpenAI::Models::Realtime::ResponseContentPartAddedEvent#part
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
          #   @return [Symbol, OpenAI::Models::Realtime::ResponseContentPartAddedEvent::Part::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::ResponseContentPartAddedEvent::Part::Type }

          # @!method initialize(audio: nil, text: nil, transcript: nil, type: nil)
          #   The content part that was added.
          #
          #   @param audio [String] Base64-encoded audio data (if type is "audio").
          #
          #   @param text [String] The text content (if type is "text").
          #
          #   @param transcript [String] The transcript of the audio (if type is "audio").
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::ResponseContentPartAddedEvent::Part::Type] The content type ("text", "audio").

          # The content type ("text", "audio").
          #
          # @see OpenAI::Models::Realtime::ResponseContentPartAddedEvent::Part#type
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
