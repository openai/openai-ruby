# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseFunctionToolCallItem < OpenAI::Models::Beta::BetaResponseFunctionToolCall
        # @!attribute id
        #   The unique ID of the function tool call.
        #
        #   @return [String]
        required :id, String

        # @!attribute status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseFunctionToolCallItem::Status]
        required :status, enum: -> { OpenAI::Beta::BetaResponseFunctionToolCallItem::Status }

        # @!attribute created_by
        #   The identifier of the actor that created the item.
        #
        #   @return [String, nil]
        optional :created_by, String

        # @!method initialize(id:, status:, created_by: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseFunctionToolCallItem} for more details.
        #
        #   A tool call to run a function. See the
        #   [function calling guide](https://platform.openai.com/docs/guides/function-calling)
        #   for more information.
        #
        #   @param id [String] The unique ID of the function tool call.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseFunctionToolCallItem::Status] The status of the item. One of `in_progress`, `completed`, or
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

    BetaResponseFunctionToolCallItem = Beta::BetaResponseFunctionToolCallItem
  end
end
