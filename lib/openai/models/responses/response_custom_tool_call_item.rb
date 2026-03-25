# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCustomToolCallItem < OpenAI::Models::Responses::ResponseCustomToolCall
        # @!attribute id
        #   The unique ID of the custom tool call item.
        #
        #   @return [String]
        required :id, String

        # @!attribute status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseCustomToolCallItem::Status]
        required :status, enum: -> { OpenAI::Responses::ResponseCustomToolCallItem::Status }

        # @!attribute created_by
        #   The identifier of the actor that created the item.
        #
        #   @return [String, nil]
        optional :created_by, String

        # @!method initialize(id:, status:, created_by: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCustomToolCallItem} for more details.
        #
        #   A call to a custom tool created by the model.
        #
        #   @param id [String] The unique ID of the custom tool call item.
        #
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseCustomToolCallItem::Status] The status of the item. One of `in_progress`, `completed`, or
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
