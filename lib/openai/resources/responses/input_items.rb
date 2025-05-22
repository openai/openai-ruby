# frozen_string_literal: true

module OpenAI
  module Resources
    class Responses
      class InputItems
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Responses::InputItemListParams} for more details.
        #
        # Returns a list of input items for a given response.
        #
        # @overload list(response_id, after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {})
        #
        # @param response_id [String] The ID of the response to retrieve input items for.
        #
        # @param after [String] An item ID to list items after, used in pagination.
        #
        # @param before [String] An item ID to list items before, used in pagination.
        #
        # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Additional fields to include in the response. See the `include`
        #
        # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between
        #
        # @param order [Symbol, OpenAI::Models::Responses::InputItemListParams::Order] The order to return the input items in. Default is `desc`.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Responses::ResponseInputMessageItem, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Models::Responses::ResponseItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseItem::LocalShellCall, OpenAI::Models::Responses::ResponseItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseItem::McpListTools, OpenAI::Models::Responses::ResponseItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseItem::McpCall>]
        #
        # @see OpenAI::Models::Responses::InputItemListParams
        def list(response_id, params = {})
          parsed, options = OpenAI::Responses::InputItemListParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["responses/%1$s/input_items", response_id],
            query: parsed,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Responses::ResponseItem,
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
