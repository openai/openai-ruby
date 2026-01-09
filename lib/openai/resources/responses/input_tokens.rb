# frozen_string_literal: true

module OpenAI
  module Resources
    class Responses
      class InputTokens
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Responses::InputTokenCountParams} for more details.
        #
        # Get input token counts
        #
        # @overload count(conversation: nil, input: nil, instructions: nil, model: nil, parallel_tool_calls: nil, previous_response_id: nil, reasoning: nil, text: nil, tool_choice: nil, tools: nil, truncation: nil, request_options: {})
        #
        # @param conversation [String, OpenAI::Models::Responses::ResponseConversationParam, nil] The conversation that this response belongs to. Items from this conversation are
        #
        # @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItemParam, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ShellCall, OpenAI::Models::Responses::ResponseInputItem::ShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCall, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>, nil] Text, image, or file inputs to the model, used to generate a response
        #
        # @param instructions [String, nil] A system (or developer) message inserted into the model's context.
        #
        # @param model [String, nil] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a w
        #
        # @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
        #
        # @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to create multi-tu
        #
        # @param reasoning [OpenAI::Models::Reasoning, nil] **gpt-5 and o-series models only** Configuration options for [reasoning models](
        #
        # @param text [OpenAI::Models::Responses::InputTokenCountParams::Text, nil] Configuration options for a text response from the model. Can be plain
        #
        # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceAllowed, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, OpenAI::Models::Responses::ToolChoiceCustom, OpenAI::Models::Responses::ToolChoiceApplyPatch, OpenAI::Models::Responses::ToolChoiceShell, nil] Controls which tool the model should use, if any.
        #
        # @param tools [Array<OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::FunctionShellTool, OpenAI::Models::Responses::CustomTool, OpenAI::Models::Responses::ApplyPatchTool, OpenAI::Models::Responses::WebSearchTool, OpenAI::Models::Responses::WebSearchPreviewTool>, nil] An array of tools the model may call while generating a response. You can specif
        #
        # @param truncation [Symbol, OpenAI::Models::Responses::InputTokenCountParams::Truncation] The truncation strategy to use for the model response. - `auto`: If the input to
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Responses::InputTokenCountResponse]
        #
        # @see OpenAI::Models::Responses::InputTokenCountParams
        def count(params = {})
          parsed, options = OpenAI::Responses::InputTokenCountParams.dump_request(params)
          @client.request(
            method: :post,
            path: "responses/input_tokens",
            body: parsed,
            model: OpenAI::Models::Responses::InputTokenCountResponse,
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
