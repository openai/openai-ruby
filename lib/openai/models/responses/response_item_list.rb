# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseItemList < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   A list of items used to generate this response.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseInputMessageItem, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem>]
        required :data, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Responses::ResponseItem] }

        # @!attribute first_id
        #   The ID of the first item in the list.
        #
        #   @return [String]
        required :first_id, String

        # @!attribute has_more
        #   Whether there are more items available.
        #
        #   @return [Boolean]
        required :has_more, OpenAI::Internal::Type::Boolean

        # @!attribute last_id
        #   The ID of the last item in the list.
        #
        #   @return [String]
        required :last_id, String

        # @!attribute object
        #   The type of object returned, must be `list`.
        #
        #   @return [Symbol, :list]
        required :object, const: :list

        # @!parse
        #   # A list of Response items.
        #   #
        #   # @param data [Array<OpenAI::Models::Responses::ResponseInputMessageItem, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem>]
        #   # @param first_id [String]
        #   # @param has_more [Boolean]
        #   # @param last_id [String]
        #   # @param object [Symbol, :list]
        #   #
        #   def initialize(data:, first_id:, has_more:, last_id:, object: :list, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end

    ResponseItemList = Responses::ResponseItemList
  end
end
