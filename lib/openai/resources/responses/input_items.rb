# frozen_string_literal: true

module OpenAI
  module Resources
    class Responses
      class InputItems
        # Returns a list of input items for a given response.
        #
        # @overload list(response_id, after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {})
        #
        # @param response_id [String]
        # @param after [String]
        # @param before [String]
        # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>]
        # @param limit [Integer]
        # @param order [Symbol, OpenAI::Models::Responses::InputItemListParams::Order]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Responses::ResponseInputMessageItem, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem>]
        #
        # @see OpenAI::Models::Responses::InputItemListParams
        def list(response_id, params = {})
          parsed, options = OpenAI::Models::Responses::InputItemListParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["responses/%1$s/input_items", response_id],
            query: parsed,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Models::Responses::ResponseItem,
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
