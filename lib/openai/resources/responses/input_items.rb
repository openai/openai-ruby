# frozen_string_literal: true

module OpenAI
  module Resources
    class Responses
      class InputItems
        # Returns a list of input items for a given response.
        #
        # @param response_id [String] The ID of the response to retrieve input items for.
        #
        # @param params [OpenAI::Models::Responses::InputItemListParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :after An item ID to list items after, used in pagination.
        #
        #   @option params [String] :before An item ID to list items before, used in pagination.
        #
        #   @option params [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] :include Additional fields to include in the response. See the `include` parameter for
        #     Response creation above for more information.
        #
        #   @option params [Integer] :limit A limit on the number of objects to be returned. Limit can range between 1 and
        #     100, and the default is 20.
        #
        #   @option params [Symbol, OpenAI::Models::Responses::InputItemListParams::Order] :order The order to return the input items in. Default is `asc`.
        #
        #     - `asc`: Return the input items in ascending order.
        #     - `desc`: Return the input items in descending order.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::CursorPage<OpenAI::Models::Responses::ResponseInputMessageItem, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem>]
        def list(response_id, params = {})
          parsed, options = OpenAI::Models::Responses::InputItemListParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["responses/%0s/input_items", response_id],
            query: parsed,
            page: OpenAI::CursorPage,
            model: OpenAI::Models::Responses::ResponseItem,
            options: options
          )
        end

        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
