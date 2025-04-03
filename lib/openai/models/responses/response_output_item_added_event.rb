# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputItemAddedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item
        #   The output item that was added.
        #
        #   @return [OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem]
        required :item, union: -> { OpenAI::Models::Responses::ResponseOutputItem }

        # @!attribute output_index
        #   The index of the output item that was added.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.output_item.added`.
        #
        #   @return [Symbol, :"response.output_item.added"]
        required :type, const: :"response.output_item.added"

        # @!parse
        #   # Emitted when a new output item is added.
        #   #
        #   # @param item [OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.output_item.added"]
        #   #
        #   def initialize(item:, output_index:, type: :"response.output_item.added", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
