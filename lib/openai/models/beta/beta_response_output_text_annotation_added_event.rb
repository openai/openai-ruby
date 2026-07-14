# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseOutputTextAnnotationAddedEvent < OpenAI::Internal::Type::BaseModel
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

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.output_text.annotation.added'.
        #
        #   @return [Symbol, :"response.output_text.annotation.added"]
        required :type, const: :"response.output_text.annotation.added"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent }, nil?: true

        # @!method initialize(annotation:, annotation_index:, content_index:, item_id:, output_index:, sequence_number:, agent: nil, type: :"response.output_text.annotation.added")
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
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.output_text.annotation.added"] The type of the event. Always 'response.output_text.annotation.added'.

        # @see OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that owns this multi-agent streaming event.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
        end
      end
    end

    BetaResponseOutputTextAnnotationAddedEvent = Beta::BetaResponseOutputTextAnnotationAddedEvent
  end
end
