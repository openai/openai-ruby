# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      # @see OpenAI::Resources::Conversations::Items#create
      class ConversationItemList < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   A list of conversation items.
        #
        #   @return [Array<OpenAI::Models::Conversations::Message, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Conversations::ConversationItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Conversations::ConversationItem::LocalShellCall, OpenAI::Models::Conversations::ConversationItem::LocalShellCallOutput, OpenAI::Models::Conversations::ConversationItem::McpListTools, OpenAI::Models::Conversations::ConversationItem::McpApprovalRequest, OpenAI::Models::Conversations::ConversationItem::McpApprovalResponse, OpenAI::Models::Conversations::ConversationItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput>]
        required :data, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Conversations::ConversationItem] }

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
        #   A list of Conversation items.
        #
        #   @param data [Array<OpenAI::Models::Conversations::Message, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Conversations::ConversationItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Conversations::ConversationItem::LocalShellCall, OpenAI::Models::Conversations::ConversationItem::LocalShellCallOutput, OpenAI::Models::Conversations::ConversationItem::McpListTools, OpenAI::Models::Conversations::ConversationItem::McpApprovalRequest, OpenAI::Models::Conversations::ConversationItem::McpApprovalResponse, OpenAI::Models::Conversations::ConversationItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput>] A list of conversation items.
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

    ConversationItemList = Conversations::ConversationItemList
  end
end
