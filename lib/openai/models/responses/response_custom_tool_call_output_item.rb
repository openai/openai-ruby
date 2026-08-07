# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCustomToolCallOutputItem < OpenAI::Models::Responses::ResponseCustomToolCallOutput
        # @!attribute id
        #   The unique ID of the custom tool call output item.
        #
        #   @return [String]
        required :id, String

        # @!attribute status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseCustomToolCallOutputItem::Status]
        required :status, enum: -> { OpenAI::Responses::ResponseCustomToolCallOutputItem::Status }

        # @!attribute created_by
        #   The identifier of the actor that created the item.
        #
        #   @return [String, nil]
        optional :created_by, String

        # @!method initialize(id:, status:, created_by: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCustomToolCallOutputItem} for more details.
        #
        #   The output of a custom tool call from your code, being sent back to the model.
        #
        #   @param id [String] The unique ID of the custom tool call output item.
        #
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseCustomToolCallOutputItem::Status] The status of the item. One of `in_progress`, `completed`, or
        #
        #   @param created_by [String] The identifier of the actor that created the item.

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
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
