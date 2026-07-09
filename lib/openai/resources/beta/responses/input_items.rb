# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Responses
        class InputItems
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Responses::InputItemListParams} for more details.
          #
          # Returns a list of input items for a given response.
          #
          # @overload list(response_id, after: nil, include: nil, limit: nil, order: nil, betas: nil, request_options: {})
          #
          # @param response_id [String] Path param: The ID of the response to retrieve input items for.
          #
          # @param after [String] Query param: An item ID to list items after, used in pagination.
          #
          # @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>] Query param: Additional fields to include in the response. See the `include`
          #
          # @param limit [Integer] Query param: A limit on the number of objects to be returned. Limit can range be
          #
          # @param order [Symbol, OpenAI::Models::Beta::Responses::InputItemListParams::Order] Query param: The order to return the input items in. Default is `desc`.
          #
          # @param betas [Array<Symbol, OpenAI::Models::Beta::Responses::InputItemListParams::Beta>] Header param: Optional beta features to enable for this request.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::BetaResponseInputMessageItem, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCallItem, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseItem::AgentMessage, OpenAI::Models::Beta::BetaResponseItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseItem::Program, OpenAI::Models::Beta::BetaResponseItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseItem::McpListTools, OpenAI::Models::Beta::BetaResponseItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallItem, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem>]
          #
          # @see OpenAI::Models::Beta::Responses::InputItemListParams
          def list(response_id, params = {})
            query_params = [:after, :include, :limit, :order]
            parsed, options = OpenAI::Beta::Responses::InputItemListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed.slice(*query_params))
            @client.request(
              method: :get,
              path: ["responses/%1$s/input_items?beta=true", response_id],
              query: query,
              headers: parsed.except(*query_params).transform_keys(betas: "openai-beta"),
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Beta::BetaResponseItem,
              security: {bearer_auth: true},
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
end
