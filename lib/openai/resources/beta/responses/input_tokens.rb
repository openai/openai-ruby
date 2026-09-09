# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Responses
        class InputTokens
          # Returns input token counts of the request.
          #
          # Returns an object with `object` set to `response.input_tokens` and an
          # `input_tokens` count.
          #
          # @overload count(conversation: nil, input: nil, instructions: nil, model: nil, parallel_tool_calls: nil, personality: nil, previous_response_id: nil, reasoning: nil, text: nil, tool_choice: nil, tools: nil, truncation: nil, betas: nil, request_options: {})
          #
          # @param conversation [String, OpenAI::Models::Beta::BetaResponseConversationParam, nil]
          #   Body param: The conversation that this response belongs to. Items from this
          #   conversation are prepended to `input_items` for this response request. Input
          #   items and output items from this response are automatically added to this
          #   conversation after this response completes.
          #
          # @param input [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>, nil]
          #   Body param: Text, image, or file inputs to the model, used to generate a
          #   response
          #
          # @param instructions [String, nil]
          #   Body param: A system (or developer) message inserted into the model's context.
          #   When used along with `previous_response_id`, the instructions from a previous
          #   response will not be carried over to the next response. This makes it simple to
          #   swap out system (or developer) messages in new responses.
          #
          # @param model [String, nil]
          #   Body param: Model ID used to generate the response, like `gpt-4o` or `o3`.
          #   OpenAI offers a wide range of models with different capabilities, performance
          #   characteristics, and price points. Refer to the
          #   [model guide](https://developers.openai.com/api/docs/models) to browse and
          #   compare available models.
          #
          # @param parallel_tool_calls [Boolean, nil]
          #   Body param: Whether to allow the model to run tool calls in parallel.
          #
          # @param personality [String, Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Personality]
          #   Body param: A model-owned style preset to apply to this request. Omit this
          #   parameter to use the model's default style. Supported values may expand over
          #   time. Values must be at most 64 characters.
          #
          # @param previous_response_id [String, nil]
          #   Body param: The unique ID of the previous response to the model. Use this to
          #   create multi-turn conversations. Learn more about
          #   [conversation state](https://developers.openai.com/api/docs/guides/conversation-state).
          #   Cannot be used in conjunction with `conversation`.
          #
          # @param reasoning [OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning, nil]
          #   Body param: **gpt-5 and o-series models only** Configuration options for
          #   [reasoning models](https://developers.openai.com/api/docs/guides/reasoning).
          #
          # @param text [OpenAI::Models::Beta::Responses::InputTokenCountParams::Text, nil]
          #   Body param: Configuration options for a text response from the model. Can be
          #   plain text or structured JSON data. Learn more:
          #
          #   - [Text inputs and outputs](https://developers.openai.com/api/docs/guides/text)
          #   - [Structured Outputs](https://developers.openai.com/api/docs/guides/structured-outputs)
          #
          # @param tool_choice [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell, nil]
          #   Body param: Controls which tool the model should use, if any.
          #
          # @param tools [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>, nil]
          #   Body param: An array of tools the model may call while generating a response.
          #   You can specify which tool to use by setting the `tool_choice` parameter.
          #
          # @param truncation [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Truncation]
          #   Body param: The truncation strategy to use for the model response. - `auto`: If
          #   the input to this Response exceeds the model's context window size, the model
          #   will truncate the response to fit the context window by dropping items from the
          #   beginning of the conversation. - `disabled` (default): If the input size will
          #   exceed the context window size for a model, the request will fail with a 400
          #   error.
          #
          # @param betas [Array<Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Beta>]
          #   Header param: Optional beta features to enable for this request.
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
