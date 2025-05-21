# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseItemList < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   A list of items used to generate this response.
        #
        #   @return [Array<OpenAI::Responses::ResponseInputMessageItem, OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseComputerToolCallOutputItem, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseFunctionToolCallItem, OpenAI::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Responses::ResponseItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseItem::LocalShellCall, OpenAI::Responses::ResponseItem::LocalShellCallOutput, OpenAI::Responses::ResponseItem::McpListTools, OpenAI::Responses::ResponseItem::McpApprovalRequest, OpenAI::Responses::ResponseItem::McpApprovalResponse, OpenAI::Responses::ResponseItem::McpCall>]
        required :data, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseItem] }

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

        # @!method initialize(data:, first_id:, has_more:, last_id:, object: :list)
        #   A list of Response items.
        #
        #   @param data [Array<OpenAI::Responses::ResponseInputMessageItem, OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseComputerToolCallOutputItem, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseFunctionToolCallItem, OpenAI::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Responses::ResponseItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseItem::LocalShellCall, OpenAI::Responses::ResponseItem::LocalShellCallOutput, OpenAI::Responses::ResponseItem::McpListTools, OpenAI::Responses::ResponseItem::McpApprovalRequest, OpenAI::Responses::ResponseItem::McpApprovalResponse, OpenAI::Responses::ResponseItem::McpCall>] A list of items used to generate this response.
        #
        #   @param first_id [String] The ID of the first item in the list.
        #
        #   @param has_more [Boolean] Whether there are more items available.
        #
        #   @param last_id [String] The ID of the last item in the list.
        #
        #   @param object [Symbol, :list] The type of object returned, must be `list`.
      end
    end

    ResponseItemList = Responses::ResponseItemList
  end
end
