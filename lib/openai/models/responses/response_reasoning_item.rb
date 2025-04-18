# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique identifier of the reasoning content.
        #
        #   @return [String]
        required :id, String

        # @!attribute summary
        #   Reasoning text contents.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseReasoningItem::Summary>]
        required :summary,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Responses::ResponseReasoningItem::Summary] }

        # @!attribute type
        #   The type of the object. Always `reasoning`.
        #
        #   @return [Symbol, :reasoning]
        required :type, const: :reasoning

        # @!attribute status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseReasoningItem::Status, nil]
        optional :status, enum: -> { OpenAI::Models::Responses::ResponseReasoningItem::Status }

        # @!method initialize(id:, summary:, status: nil, type: :reasoning)
        #   A description of the chain of thought used by a reasoning model while generating
        #   a response.
        #
        #   @param id [String]
        #   @param summary [Array<OpenAI::Models::Responses::ResponseReasoningItem::Summary>]
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseReasoningItem::Status]
        #   @param type [Symbol, :reasoning]

        class Summary < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   A short summary of the reasoning used by the model when generating the response.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the object. Always `summary_text`.
          #
          #   @return [Symbol, :summary_text]
          required :type, const: :summary_text

          # @!method initialize(text:, type: :summary_text)
          #   @param text [String]
          #   @param type [Symbol, :summary_text]
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Models::Responses::ResponseReasoningItem#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
