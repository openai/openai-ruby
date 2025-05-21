# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputTextAnnotationAddedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute annotation
        #   The annotation object being added. (See annotation schema for details.)
        #
        #   @return [Object]
        required :annotation, OpenAI::Internal::Type::Unknown

        # @!attribute annotation_index
        #   The index of the annotation within the content part.
        #
        #   @return [Integer]
        required :annotation_index, Integer

        # @!attribute content_index
        #   The index of the content part within the output item.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The unique identifier of the item to which the annotation is being added.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response's output array.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always 'response.output_text_annotation.added'.
        #
        #   @return [Symbol, :"response.output_text_annotation.added"]
        required :type, const: :"response.output_text_annotation.added"

        # @!method initialize(annotation:, annotation_index:, content_index:, item_id:, output_index:, type: :"response.output_text_annotation.added")
        #   Emitted when an annotation is added to output text content.
        #
        #   @param annotation [Object] The annotation object being added. (See annotation schema for details.)
        #
        #   @param annotation_index [Integer] The index of the annotation within the content part.
        #
        #   @param content_index [Integer] The index of the content part within the output item.
        #
        #   @param item_id [String] The unique identifier of the item to which the annotation is being added.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param type [Symbol, :"response.output_text_annotation.added"] The type of the event. Always 'response.output_text_annotation.added'.
      end
    end
  end
end
