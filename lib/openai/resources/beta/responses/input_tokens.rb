# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Responses
        class InputTokens
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Responses::InputTokenCountParams} for more details.
          #
          # Returns input token counts of the request.
          #
          # Returns an object with `object` set to `response.input_tokens` and an
          # `input_tokens` count.
          #
          # @overload count(conversation: nil, input: nil, instructions: nil, model: nil, parallel_tool_calls: nil, personality: nil, previous_response_id: nil, reasoning: nil, text: nil, tool_choice: nil, tools: nil, truncation: nil, betas: nil, request_options: {})
          #
          # @param conversation [String, OpenAI::Models::Beta::BetaResponseConversationParam, nil] Body param: The conversation that this response belongs to. Items from this conv
          #
          # @param input [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>, nil] Body param: Text, image, or file inputs to the model, used to generate a respons
          #
          # @param instructions [String, nil] Body param: A system (or developer) message inserted into the model's context.
          #
          # @param model [String, nil] Body param: Model ID used to generate the response, like `gpt-4o` or `o3`. OpenA
          #
          # @param parallel_tool_calls [Boolean, nil] Body param: Whether to allow the model to run tool calls in parallel.
          #
          # @param personality [String, Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Personality] Body param: A model-owned style preset to apply to this request. Omit this param
          #
          # @param previous_response_id [String, nil] Body param: The unique ID of the previous response to the model. Use this to cre
          #
          # @param reasoning [OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning, nil] Body param: **gpt-5 and o-series models only** Configuration options for [reason
          #
          # @param text [OpenAI::Models::Beta::Responses::InputTokenCountParams::Text, nil] Body param: Configuration options for a text response from the model. Can be pla
          #
          # @param tool_choice [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell, nil] Body param: Controls which tool the model should use, if any.
          #
          # @param tools [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>, nil] Body param: An array of tools the model may call while generating a response. Yo
          #
          # @param truncation [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Truncation] Body param: The truncation strategy to use for the model response. - `auto`: If
          #
          # @param betas [Array<Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Beta>] Header param: Optional beta features to enable for this request.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Responses::InputTokenCountResponse]
          #
          # @see OpenAI::Models::Beta::Responses::InputTokenCountParams
          def count(params = {})
            parsed, options = OpenAI::Beta::Responses::InputTokenCountParams.dump_request(params)
            header_params = {betas: "openai-beta"}
            @client.request(
              method: :post,
              path: "responses/input_tokens?beta=true",
              headers: parsed.slice(*header_params.keys).transform_keys(header_params),
              body: parsed.except(*header_params.keys),
              model: OpenAI::Models::Beta::Responses::InputTokenCountResponse,
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
