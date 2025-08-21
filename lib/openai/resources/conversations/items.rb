# frozen_string_literal: true

module OpenAI
  module Resources
    class Conversations
      class Items
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Conversations::ItemCreateParams} for more details.
        #
        # Create items in a conversation with the given ID.
        #
        # @overload create(conversation_id, items:, include: nil, request_options: {})
        #
        # @param conversation_id [String] Path param: The ID of the conversation to add the item to.
        #
        # @param items [Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>] Body param: The items to add to the conversation. You may add up to 20 items at
        #
        # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Query param: Additional fields to include in the response. See the `include`
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Conversations::ConversationItemList]
        #
        # @see OpenAI::Models::Conversations::ItemCreateParams
        def create(conversation_id, params)
          parsed, options = OpenAI::Conversations::ItemCreateParams.dump_request(params)
          query_params = [:include]
          @client.request(
            method: :post,
            path: ["conversations/%1$s/items", conversation_id],
            query: parsed.slice(*query_params),
            body: parsed.except(*query_params),
            model: OpenAI::Conversations::ConversationItemList,
            options: options
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Conversations::ItemRetrieveParams} for more details.
        #
        # Get a single item from a conversation with the given IDs.
        #
        # @overload retrieve(item_id, conversation_id:, include: nil, request_options: {})
        #
        # @param item_id [String] Path param: The ID of the item to retrieve.
        #
        # @param conversation_id [String] Path param: The ID of the conversation that contains the item.
        #
        # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Query param: Additional fields to include in the response. See the `include`
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Conversations::Message, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Conversations::ConversationItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Conversations::ConversationItem::LocalShellCall, OpenAI::Models::Conversations::ConversationItem::LocalShellCallOutput, OpenAI::Models::Conversations::ConversationItem::McpListTools, OpenAI::Models::Conversations::ConversationItem::McpApprovalRequest, OpenAI::Models::Conversations::ConversationItem::McpApprovalResponse, OpenAI::Models::Conversations::ConversationItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput]
        #
        # @see OpenAI::Models::Conversations::ItemRetrieveParams
        def retrieve(item_id, params)
          parsed, options = OpenAI::Conversations::ItemRetrieveParams.dump_request(params)
          conversation_id =
            parsed.delete(:conversation_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["conversations/%1$s/items/%2$s", conversation_id, item_id],
            query: parsed,
            model: OpenAI::Conversations::ConversationItem,
            options: options
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Conversations::ItemListParams} for more details.
        #
        # List all items for a conversation with the given ID.
        #
        # @overload list(conversation_id, after: nil, include: nil, limit: nil, order: nil, request_options: {})
        #
        # @param conversation_id [String] The ID of the conversation to list items for.
        #
        # @param after [String] An item ID to list items after, used in pagination.
        #
        # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Specify additional output data to include in the model response. Currently
        #
        # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between
        #
        # @param order [Symbol, OpenAI::Models::Conversations::ItemListParams::Order] The order to return the input items in. Default is `desc`.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Conversations::Message, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Conversations::ConversationItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Conversations::ConversationItem::LocalShellCall, OpenAI::Models::Conversations::ConversationItem::LocalShellCallOutput, OpenAI::Models::Conversations::ConversationItem::McpListTools, OpenAI::Models::Conversations::ConversationItem::McpApprovalRequest, OpenAI::Models::Conversations::ConversationItem::McpApprovalResponse, OpenAI::Models::Conversations::ConversationItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput>]
        #
        # @see OpenAI::Models::Conversations::ItemListParams
        def list(conversation_id, params = {})
          parsed, options = OpenAI::Conversations::ItemListParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["conversations/%1$s/items", conversation_id],
            query: parsed,
            page: OpenAI::Internal::ConversationCursorPage,
            model: OpenAI::Conversations::ConversationItem,
            options: options
          )
        end

        # Delete an item from a conversation with the given IDs.
        #
        # @overload delete(item_id, conversation_id:, request_options: {})
        #
        # @param item_id [String] The ID of the item to delete.
        #
        # @param conversation_id [String] The ID of the conversation that contains the item.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Conversations::Conversation]
        #
        # @see OpenAI::Models::Conversations::ItemDeleteParams
        def delete(item_id, params)
          parsed, options = OpenAI::Conversations::ItemDeleteParams.dump_request(params)
          conversation_id =
            parsed.delete(:conversation_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :delete,
            path: ["conversations/%1$s/items/%2$s", conversation_id, item_id],
            model: OpenAI::Conversations::Conversation,
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
