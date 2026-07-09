# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Responses#create
      #
      # @see OpenAI::Resources::Beta::Responses#stream_raw
      class BetaResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for this Response.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   Unix timestamp (in seconds) of when this Response was created.
        #
        #   @return [Float]
        required :created_at, Float

        # @!attribute error
        #   An error object returned when the model fails to generate a Response.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseError, nil]
        required :error, -> { OpenAI::Beta::BetaResponseError }, nil?: true

        # @!attribute incomplete_details
        #   Details about why the response is incomplete.
        #
        #   @return [OpenAI::Models::Beta::BetaResponse::IncompleteDetails, nil]
        required :incomplete_details, -> { OpenAI::Beta::BetaResponse::IncompleteDetails }, nil?: true

        # @!attribute instructions
        #   A system (or developer) message inserted into the model's context.
        #
        #   When using along with `previous_response_id`, the instructions from a previous
        #   response will not be carried over to the next response. This makes it simple to
        #   swap out system (or developer) messages in new responses.
        #
        #   @return [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>, nil]
        required :instructions, union: -> { OpenAI::Beta::BetaResponse::Instructions }, nil?: true

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        required :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!attribute model
        #   Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        #
        #   @return [Symbol, String, OpenAI::Models::Beta::BetaResponse::Model]
        required :model, union: -> { OpenAI::Beta::BetaResponse::Model }

        # @!attribute object
        #   The object type of this resource - always set to `response`.
        #
        #   @return [Symbol, :response]
        required :object, const: :response

        # @!attribute output
        #   An array of content items generated by the model.
        #
        #   - The length and order of items in the `output` array is dependent on the
        #     model's response.
        #   - Rather than accessing the first item in the `output` array and assuming it's
        #     an `assistant` message with the content generated by the model, you might
        #     consider using the `output_text` property where supported in SDKs.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseOutputItem::Program, OpenAI::Models::Beta::BetaResponseOutputItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseOutputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseOutputItem::McpCall, OpenAI::Models::Beta::BetaResponseOutputItem::McpListTools, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem>]
        required :output, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseOutputItem] }

        # @!attribute parallel_tool_calls
        #   Whether to allow the model to run tool calls in parallel.
        #
        #   @return [Boolean]
        required :parallel_tool_calls, OpenAI::Internal::Type::Boolean

        # @!attribute temperature
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic. We generally recommend altering this or `top_p` but
        #   not both.
        #
        #   @return [Float, nil]
        required :temperature, Float, nil?: true

        # @!attribute tool_choice
        #   How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::BetaResponse::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell]
        required :tool_choice, union: -> { OpenAI::Beta::BetaResponse::ToolChoice }

        # @!attribute tools
        #   An array of tools the model may call while generating a response. You can
        #   specify which tool to use by setting the `tool_choice` parameter.
        #
        #   We support the following categories of tools:
        #
        #   - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #     capabilities, like
        #     [web search](https://platform.openai.com/docs/guides/tools-web-search) or
        #     [file search](https://platform.openai.com/docs/guides/tools-file-search).
        #     Learn more about
        #     [built-in tools](https://platform.openai.com/docs/guides/tools).
        #   - **MCP Tools**: Integrations with third-party systems via custom MCP servers or
        #     predefined connectors such as Google Drive and SharePoint. Learn more about
        #     [MCP Tools](https://platform.openai.com/docs/guides/tools-connectors-mcp).
        #   - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #     the model to call your own code with strongly typed arguments and outputs.
        #     Learn more about
        #     [function calling](https://platform.openai.com/docs/guides/function-calling).
        #     You can also use custom tools to call your own code.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>]
        required :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaTool] }

        # @!attribute top_p
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        #
        #   @return [Float, nil]
        required :top_p, Float, nil?: true

        # @!attribute background
        #   Whether to run the model response in the background.
        #   [Learn more](https://platform.openai.com/docs/guides/background).
        #
        #   @return [Boolean, nil]
        optional :background, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute completed_at
        #   Unix timestamp (in seconds) of when this Response was completed. Only present
        #   when the status is `completed`.
        #
        #   @return [Float, nil]
        optional :completed_at, Float, nil?: true

        # @!attribute conversation
        #   The conversation that this response belonged to. Input items and output items
        #   from this response were automatically added to this conversation.
        #
        #   @return [OpenAI::Models::Beta::BetaResponse::Conversation, nil]
        optional :conversation, -> { OpenAI::Beta::BetaResponse::Conversation }, nil?: true

        # @!attribute max_output_tokens
        #   An upper bound for the number of tokens that can be generated for a response,
        #   including visible output tokens and
        #   [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @return [Integer, nil]
        optional :max_output_tokens, Integer, nil?: true

        # @!attribute max_tool_calls
        #   The maximum number of total calls to built-in tools that can be processed in a
        #   response. This maximum number applies across all built-in tool calls, not per
        #   individual tool. Any further attempts to call a tool by the model will be
        #   ignored.
        #
        #   @return [Integer, nil]
        optional :max_tool_calls, Integer, nil?: true

        # @!attribute moderation
        #   Moderation results for the response input and output, if moderated completions
        #   were requested.
        #
        #   @return [OpenAI::Models::Beta::BetaResponse::Moderation, nil]
        optional :moderation, -> { OpenAI::Beta::BetaResponse::Moderation }, nil?: true

        # @!attribute previous_response_id
        #   The unique ID of the previous response to the model. Use this to create
        #   multi-turn conversations. Learn more about
        #   [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        #   Cannot be used in conjunction with `conversation`.
        #
        #   @return [String, nil]
        optional :previous_response_id, String, nil?: true

        # @!attribute prompt
        #   Reference to a prompt template and its variables.
        #   [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        #
        #   @return [OpenAI::Models::Beta::BetaResponsePrompt, nil]
        optional :prompt, -> { OpenAI::Beta::BetaResponsePrompt }, nil?: true

        # @!attribute prompt_cache_key
        #   Used by OpenAI to cache responses for similar requests to optimize your cache
        #   hit rates. Replaces the `user` field.
        #   [Learn more](https://platform.openai.com/docs/guides/prompt-caching).
        #
        #   @return [String, nil]
        optional :prompt_cache_key, String

        # @!attribute prompt_cache_options
        #   The prompt-caching options that were applied to the response. Supported for
        #   `gpt-5.6` and later models.
        #
        #   @return [OpenAI::Models::Beta::BetaResponse::PromptCacheOptions, nil]
        optional :prompt_cache_options, -> { OpenAI::Beta::BetaResponse::PromptCacheOptions }

        # @!attribute prompt_cache_retention
        #   @deprecated
        #
        #   Deprecated. Use `prompt_cache_options.ttl` instead.
        #
        #   The retention policy for the prompt cache. Set to `24h` to enable extended
        #   prompt caching, which keeps cached prefixes active for longer, up to a maximum
        #   of 24 hours.
        #   [Learn more](https://platform.openai.com/docs/guides/prompt-caching#prompt-cache-retention).
        #   This field expresses a maximum retention policy, while
        #   `prompt_cache_options.ttl` expresses a minimum cache lifetime. The two fields
        #   are independent and do not interact. For `gpt-5.5`, `gpt-5.5-pro`, and future
        #   models, only `24h` is supported.
        #
        #   For older models that support both `in_memory` and `24h`, the default depends on
        #   your organization's data retention policy:
        #
        #   - Organizations without ZDR enabled default to `24h`.
        #   - Organizations with ZDR enabled default to `in_memory` when
        #     `prompt_cache_retention` is not specified.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponse::PromptCacheRetention, nil]
        optional :prompt_cache_retention,
                 enum: -> { OpenAI::Beta::BetaResponse::PromptCacheRetention },
                 nil?: true

        # @!attribute reasoning
        #   **gpt-5 and o-series models only**
        #
        #   Configuration options for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @return [OpenAI::Models::Beta::BetaResponse::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Beta::BetaResponse::Reasoning }, nil?: true

        # @!attribute safety_identifier
        #   A stable identifier used to help detect users of your application that may be
        #   violating OpenAI's usage policies. The IDs should be a string that uniquely
        #   identifies each user, with a maximum length of 64 characters. We recommend
        #   hashing their username or email address, in order to avoid sending us any
        #   identifying information.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
        #
        #   @return [String, nil]
        optional :safety_identifier, String

        # @!attribute service_tier
        #   Specifies the processing type used for serving the request.
        #
        #   - If set to 'auto', then the request will be processed with the service tier
        #     configured in the Project settings. Unless otherwise configured, the Project
        #     will use 'default'.
        #   - If set to 'default', then the request will be processed with the standard
        #     pricing and performance for the selected model.
        #   - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #     '[priority](https://openai.com/api-priority-processing/)', then the request
        #     will be processed with the corresponding service tier.
        #   - When not set, the default behavior is 'auto'.
        #
        #   When the `service_tier` parameter is set, the response body will include the
        #   `service_tier` value based on the processing mode actually used to serve the
        #   request. This response value may be different from the value set in the
        #   parameter.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponse::ServiceTier, nil]
        optional :service_tier, enum: -> { OpenAI::Beta::BetaResponse::ServiceTier }, nil?: true

        # @!attribute status
        #   The status of the response generation. One of `completed`, `failed`,
        #   `in_progress`, `cancelled`, `queued`, or `incomplete`.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseStatus, nil]
        optional :status, enum: -> { OpenAI::Beta::BetaResponseStatus }

        # @!attribute text
        #   Configuration options for a text response from the model. Can be plain text or
        #   structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        #
        #   @return [OpenAI::Models::Beta::BetaResponseTextConfig, nil]
        optional :text, -> { OpenAI::Beta::BetaResponseTextConfig }

        # @!attribute top_logprobs
        #   An integer between 0 and 20 specifying the maximum number of most likely tokens
        #   to return at each token position, each with an associated log probability. In
        #   some cases, the number of returned tokens may be fewer than requested.
        #
        #   @return [Integer, nil]
        optional :top_logprobs, Integer, nil?: true

        # @!attribute truncation
        #   The truncation strategy to use for the model response.
        #
        #   - `auto`: If the input to this Response exceeds the model's context window size,
        #     the model will truncate the response to fit the context window by dropping
        #     items from the beginning of the conversation.
        #   - `disabled` (default): If the input size will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponse::Truncation, nil]
        optional :truncation, enum: -> { OpenAI::Beta::BetaResponse::Truncation }, nil?: true

        # @!attribute usage
        #   Represents token usage details including input tokens, output tokens, a
        #   breakdown of output tokens, and the total tokens used.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseUsage, nil]
        optional :usage, -> { OpenAI::Beta::BetaResponseUsage }

        # @!attribute user
        #   @deprecated
        #
        #   This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
        #   `prompt_cache_key` instead to maintain caching optimizations. A stable
        #   identifier for your end-users. Used to boost cache hit rates by better bucketing
        #   similar requests and to help OpenAI detect and prevent abuse.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
        #
        #   @return [String, nil]
        optional :user, String

        # @!method initialize(id:, created_at:, error:, incomplete_details:, instructions:, metadata:, model:, output:, parallel_tool_calls:, temperature:, tool_choice:, tools:, top_p:, background: nil, completed_at: nil, conversation: nil, max_output_tokens: nil, max_tool_calls: nil, moderation: nil, previous_response_id: nil, prompt: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning: nil, safety_identifier: nil, service_tier: nil, status: nil, text: nil, top_logprobs: nil, truncation: nil, usage: nil, user: nil, object: :response)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponse} for more details.
        #
        #   @param id [String] Unique identifier for this Response.
        #
        #   @param created_at [Float] Unix timestamp (in seconds) of when this Response was created.
        #
        #   @param error [OpenAI::Models::Beta::BetaResponseError, nil] An error object returned when the model fails to generate a Response.
        #
        #   @param incomplete_details [OpenAI::Models::Beta::BetaResponse::IncompleteDetails, nil] Details about why the response is incomplete.
        #
        #   @param instructions [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>, nil] A system (or developer) message inserted into the model's context.
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param model [Symbol, String, OpenAI::Models::Beta::BetaResponse::Model] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
        #
        #   @param output [Array<OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseOutputItem::Program, OpenAI::Models::Beta::BetaResponseOutputItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseOutputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseOutputItem::McpCall, OpenAI::Models::Beta::BetaResponseOutputItem::McpListTools, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem>] An array of content items generated by the model.
        #
        #   @param parallel_tool_calls [Boolean] Whether to allow the model to run tool calls in parallel.
        #
        #   @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
        #
        #   @param tool_choice [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::BetaResponse::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell] How the model should select which tool (or tools) to use when generating
        #
        #   @param tools [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>] An array of tools the model may call while generating a response. You
        #
        #   @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
        #
        #   @param background [Boolean, nil] Whether to run the model response in the background.
        #
        #   @param completed_at [Float, nil] Unix timestamp (in seconds) of when this Response was completed.
        #
        #   @param conversation [OpenAI::Models::Beta::BetaResponse::Conversation, nil] The conversation that this response belonged to. Input items and output items fr
        #
        #   @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
        #
        #   @param max_tool_calls [Integer, nil] The maximum number of total calls to built-in tools that can be processed in a r
        #
        #   @param moderation [OpenAI::Models::Beta::BetaResponse::Moderation, nil] Moderation results for the response input and output, if moderated completions w
        #
        #   @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to
        #
        #   @param prompt [OpenAI::Models::Beta::BetaResponsePrompt, nil] Reference to a prompt template and its variables.
        #
        #   @param prompt_cache_key [String] Used by OpenAI to cache responses for similar requests to optimize your cache hi
        #
        #   @param prompt_cache_options [OpenAI::Models::Beta::BetaResponse::PromptCacheOptions] The prompt-caching options that were applied to the response. Supported for `gpt
        #
        #   @param prompt_cache_retention [Symbol, OpenAI::Models::Beta::BetaResponse::PromptCacheRetention, nil] Deprecated. Use `prompt_cache_options.ttl` instead.
        #
        #   @param reasoning [OpenAI::Models::Beta::BetaResponse::Reasoning, nil] **gpt-5 and o-series models only**
        #
        #   @param safety_identifier [String] A stable identifier used to help detect users of your application that may be vi
        #
        #   @param service_tier [Symbol, OpenAI::Models::Beta::BetaResponse::ServiceTier, nil] Specifies the processing type used for serving the request.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseStatus] The status of the response generation. One of `completed`, `failed`,
        #
        #   @param text [OpenAI::Models::Beta::BetaResponseTextConfig] Configuration options for a text response from the model. Can be plain
        #
        #   @param top_logprobs [Integer, nil] An integer between 0 and 20 specifying the maximum number of most likely
        #
        #   @param truncation [Symbol, OpenAI::Models::Beta::BetaResponse::Truncation, nil] The truncation strategy to use for the model response.
        #
        #   @param usage [OpenAI::Models::Beta::BetaResponseUsage] Represents token usage details including input tokens, output tokens,
        #
        #   @param user [String] This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
        #
        #   @param object [Symbol, :response] The object type of this resource - always set to `response`.

        # @see OpenAI::Models::Beta::BetaResponse#incomplete_details
        class IncompleteDetails < OpenAI::Internal::Type::BaseModel
          # @!attribute reason
          #   The reason why the response is incomplete.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponse::IncompleteDetails::Reason, nil]
          optional :reason, enum: -> { OpenAI::Beta::BetaResponse::IncompleteDetails::Reason }

          # @!method initialize(reason: nil)
          #   Details about why the response is incomplete.
          #
          #   @param reason [Symbol, OpenAI::Models::Beta::BetaResponse::IncompleteDetails::Reason] The reason why the response is incomplete.

          # The reason why the response is incomplete.
          #
          # @see OpenAI::Models::Beta::BetaResponse::IncompleteDetails#reason
          module Reason
            extend OpenAI::Internal::Type::Enum

            MAX_OUTPUT_TOKENS = :max_output_tokens
            CONTENT_FILTER = :content_filter

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # A system (or developer) message inserted into the model's context.
        #
        # When using along with `previous_response_id`, the instructions from a previous
        # response will not be carried over to the next response. This makes it simple to
        # swap out system (or developer) messages in new responses.
        #
        # @see OpenAI::Models::Beta::BetaResponse#instructions
        module Instructions
          extend OpenAI::Internal::Type::Union

          # A text input to the model, equivalent to a text input with the
          # `developer` role.
          variant String

          # A list of one or many input items to the model, containing
          # different content types.
          variant -> { OpenAI::Models::Beta::BetaResponse::Instructions::BetaResponseInputItemArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>)]

          # @type [OpenAI::Internal::Type::Converter]
          BetaResponseInputItemArray =
            OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Beta::BetaResponseInputItem }]
        end

        # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
        # wide range of models with different capabilities, performance characteristics,
        # and price points. Refer to the
        # [model guide](https://platform.openai.com/docs/models) to browse and compare
        # available models.
        #
        # @see OpenAI::Models::Beta::BetaResponse#model
        module Model
          extend OpenAI::Internal::Type::Union

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_6_SOL }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_6_TERRA }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_6_LUNA }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_4 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_4_MINI }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_4_NANO }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_4_MINI_2026_03_17 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_4_NANO_2026_03_17 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_3_CHAT_LATEST }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_2 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_2_2025_12_11 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_2_CHAT_LATEST }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_2_PRO }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_2_PRO_2025_12_11 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_1 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_1_2025_11_13 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_1_CODEX }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_1_MINI }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_1_CHAT_LATEST }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_MINI }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_NANO }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_2025_08_07 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_MINI_2025_08_07 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_NANO_2025_08_07 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_CHAT_LATEST }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_1 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_1_MINI }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_1_NANO }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_1_2025_04_14 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_1_MINI_2025_04_14 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_1_NANO_2025_04_14 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O4_MINI }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O4_MINI_2025_04_16 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O3 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O3_2025_04_16 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O3_MINI }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O3_MINI_2025_01_31 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O1 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O1_2024_12_17 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O1_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O1_PREVIEW_2024_09_12 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O1_MINI }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O1_MINI_2024_09_12 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_2024_11_20 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_2024_08_06 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_2024_05_13 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_AUDIO_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_AUDIO_PREVIEW_2024_10_01 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_AUDIO_PREVIEW_2024_12_17 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_AUDIO_PREVIEW_2025_06_03 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_MINI_AUDIO_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_MINI_AUDIO_PREVIEW_2024_12_17 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_SEARCH_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_MINI_SEARCH_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_SEARCH_PREVIEW_2025_03_11 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_MINI_SEARCH_PREVIEW_2025_03_11 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::CHATGPT_4O_LATEST }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::CODEX_MINI_LATEST }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_MINI }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4O_MINI_2024_07_18 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_TURBO }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_TURBO_2024_04_09 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_0125_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_TURBO_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_1106_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_VISION_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_0314 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_0613 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_32K }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_32K_0314 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_4_32K_0613 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_3_5_TURBO }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_3_5_TURBO_16K }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_3_5_TURBO_0301 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_3_5_TURBO_0613 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_3_5_TURBO_1106 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_3_5_TURBO_0125 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_3_5_TURBO_16K_0613 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O1_PRO }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O1_PRO_2025_03_19 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O3_PRO }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O3_PRO_2025_06_10 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O3_DEEP_RESEARCH }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O3_DEEP_RESEARCH_2025_06_26 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O4_MINI_DEEP_RESEARCH }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::O4_MINI_DEEP_RESEARCH_2025_06_26 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::COMPUTER_USE_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::COMPUTER_USE_PREVIEW_2025_03_11 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_CODEX }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_PRO }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_PRO_2025_10_06 }

          variant const: -> { OpenAI::Models::Beta::BetaResponse::Model::GPT_5_1_CODEX_MAX }

          variant String

          # @!method self.variants
          #   @return [Array(Symbol, String)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(OpenAI::Beta::BetaResponse::Model::TaggedSymbol, String) }
          end

          # @!group

          GPT_5_6_SOL = :"gpt-5.6-sol"
          GPT_5_6_TERRA = :"gpt-5.6-terra"
          GPT_5_6_LUNA = :"gpt-5.6-luna"
          GPT_5_4 = :"gpt-5.4"
          GPT_5_4_MINI = :"gpt-5.4-mini"
          GPT_5_4_NANO = :"gpt-5.4-nano"
          GPT_5_4_MINI_2026_03_17 = :"gpt-5.4-mini-2026-03-17"
          GPT_5_4_NANO_2026_03_17 = :"gpt-5.4-nano-2026-03-17"
          GPT_5_3_CHAT_LATEST = :"gpt-5.3-chat-latest"
          GPT_5_2 = :"gpt-5.2"
          GPT_5_2_2025_12_11 = :"gpt-5.2-2025-12-11"
          GPT_5_2_CHAT_LATEST = :"gpt-5.2-chat-latest"
          GPT_5_2_PRO = :"gpt-5.2-pro"
          GPT_5_2_PRO_2025_12_11 = :"gpt-5.2-pro-2025-12-11"
          GPT_5_1 = :"gpt-5.1"
          GPT_5_1_2025_11_13 = :"gpt-5.1-2025-11-13"
          GPT_5_1_CODEX = :"gpt-5.1-codex"
          GPT_5_1_MINI = :"gpt-5.1-mini"
          GPT_5_1_CHAT_LATEST = :"gpt-5.1-chat-latest"
          GPT_5 = :"gpt-5"
          GPT_5_MINI = :"gpt-5-mini"
          GPT_5_NANO = :"gpt-5-nano"
          GPT_5_2025_08_07 = :"gpt-5-2025-08-07"
          GPT_5_MINI_2025_08_07 = :"gpt-5-mini-2025-08-07"
          GPT_5_NANO_2025_08_07 = :"gpt-5-nano-2025-08-07"
          GPT_5_CHAT_LATEST = :"gpt-5-chat-latest"
          GPT_4_1 = :"gpt-4.1"
          GPT_4_1_MINI = :"gpt-4.1-mini"
          GPT_4_1_NANO = :"gpt-4.1-nano"
          GPT_4_1_2025_04_14 = :"gpt-4.1-2025-04-14"
          GPT_4_1_MINI_2025_04_14 = :"gpt-4.1-mini-2025-04-14"
          GPT_4_1_NANO_2025_04_14 = :"gpt-4.1-nano-2025-04-14"
          O4_MINI = :"o4-mini"
          O4_MINI_2025_04_16 = :"o4-mini-2025-04-16"
          O3 = :o3
          O3_2025_04_16 = :"o3-2025-04-16"
          O3_MINI = :"o3-mini"
          O3_MINI_2025_01_31 = :"o3-mini-2025-01-31"
          O1 = :o1
          O1_2024_12_17 = :"o1-2024-12-17"
          O1_PREVIEW = :"o1-preview"
          O1_PREVIEW_2024_09_12 = :"o1-preview-2024-09-12"
          O1_MINI = :"o1-mini"
          O1_MINI_2024_09_12 = :"o1-mini-2024-09-12"
          GPT_4O = :"gpt-4o"
          GPT_4O_2024_11_20 = :"gpt-4o-2024-11-20"
          GPT_4O_2024_08_06 = :"gpt-4o-2024-08-06"
          GPT_4O_2024_05_13 = :"gpt-4o-2024-05-13"
          GPT_4O_AUDIO_PREVIEW = :"gpt-4o-audio-preview"
          GPT_4O_AUDIO_PREVIEW_2024_10_01 = :"gpt-4o-audio-preview-2024-10-01"
          GPT_4O_AUDIO_PREVIEW_2024_12_17 = :"gpt-4o-audio-preview-2024-12-17"
          GPT_4O_AUDIO_PREVIEW_2025_06_03 = :"gpt-4o-audio-preview-2025-06-03"
          GPT_4O_MINI_AUDIO_PREVIEW = :"gpt-4o-mini-audio-preview"
          GPT_4O_MINI_AUDIO_PREVIEW_2024_12_17 = :"gpt-4o-mini-audio-preview-2024-12-17"
          GPT_4O_SEARCH_PREVIEW = :"gpt-4o-search-preview"
          GPT_4O_MINI_SEARCH_PREVIEW = :"gpt-4o-mini-search-preview"
          GPT_4O_SEARCH_PREVIEW_2025_03_11 = :"gpt-4o-search-preview-2025-03-11"
          GPT_4O_MINI_SEARCH_PREVIEW_2025_03_11 = :"gpt-4o-mini-search-preview-2025-03-11"
          CHATGPT_4O_LATEST = :"chatgpt-4o-latest"
          CODEX_MINI_LATEST = :"codex-mini-latest"
          GPT_4O_MINI = :"gpt-4o-mini"
          GPT_4O_MINI_2024_07_18 = :"gpt-4o-mini-2024-07-18"
          GPT_4_TURBO = :"gpt-4-turbo"
          GPT_4_TURBO_2024_04_09 = :"gpt-4-turbo-2024-04-09"
          GPT_4_0125_PREVIEW = :"gpt-4-0125-preview"
          GPT_4_TURBO_PREVIEW = :"gpt-4-turbo-preview"
          GPT_4_1106_PREVIEW = :"gpt-4-1106-preview"
          GPT_4_VISION_PREVIEW = :"gpt-4-vision-preview"
          GPT_4 = :"gpt-4"
          GPT_4_0314 = :"gpt-4-0314"
          GPT_4_0613 = :"gpt-4-0613"
          GPT_4_32K = :"gpt-4-32k"
          GPT_4_32K_0314 = :"gpt-4-32k-0314"
          GPT_4_32K_0613 = :"gpt-4-32k-0613"
          GPT_3_5_TURBO = :"gpt-3.5-turbo"
          GPT_3_5_TURBO_16K = :"gpt-3.5-turbo-16k"
          GPT_3_5_TURBO_0301 = :"gpt-3.5-turbo-0301"
          GPT_3_5_TURBO_0613 = :"gpt-3.5-turbo-0613"
          GPT_3_5_TURBO_1106 = :"gpt-3.5-turbo-1106"
          GPT_3_5_TURBO_0125 = :"gpt-3.5-turbo-0125"
          GPT_3_5_TURBO_16K_0613 = :"gpt-3.5-turbo-16k-0613"
          O1_PRO = :"o1-pro"
          O1_PRO_2025_03_19 = :"o1-pro-2025-03-19"
          O3_PRO = :"o3-pro"
          O3_PRO_2025_06_10 = :"o3-pro-2025-06-10"
          O3_DEEP_RESEARCH = :"o3-deep-research"
          O3_DEEP_RESEARCH_2025_06_26 = :"o3-deep-research-2025-06-26"
          O4_MINI_DEEP_RESEARCH = :"o4-mini-deep-research"
          O4_MINI_DEEP_RESEARCH_2025_06_26 = :"o4-mini-deep-research-2025-06-26"
          COMPUTER_USE_PREVIEW = :"computer-use-preview"
          COMPUTER_USE_PREVIEW_2025_03_11 = :"computer-use-preview-2025-03-11"
          GPT_5_CODEX = :"gpt-5-codex"
          GPT_5_PRO = :"gpt-5-pro"
          GPT_5_PRO_2025_10_06 = :"gpt-5-pro-2025-10-06"
          GPT_5_1_CODEX_MAX = :"gpt-5.1-codex-max"

          # @!endgroup
        end

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        #
        # @see OpenAI::Models::Beta::BetaResponse#tool_choice
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          # Controls which (if any) tool is called by the model.
          #
          # `none` means the model will not call any tool and instead generates a message.
          #
          # `auto` means the model can pick between generating a message or calling one or
          # more tools.
          #
          # `required` means the model must call one or more tools.
          variant enum: -> { OpenAI::Beta::BetaToolChoiceOptions }

          # Constrains the tools available to the model to a pre-defined set.
          variant -> { OpenAI::Beta::BetaToolChoiceAllowed }

          # Indicates that the model should use a built-in tool to generate a response.
          # [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
          variant -> { OpenAI::Beta::BetaToolChoiceTypes }

          # Use this option to force the model to call a specific function.
          variant -> { OpenAI::Beta::BetaToolChoiceFunction }

          # Use this option to force the model to call a specific tool on a remote MCP server.
          variant -> { OpenAI::Beta::BetaToolChoiceMcp }

          # Use this option to force the model to call a specific custom tool.
          variant -> { OpenAI::Beta::BetaToolChoiceCustom }

          variant -> { OpenAI::Beta::BetaResponse::ToolChoice::BetaSpecificProgrammaticToolCallingParam }

          # Forces the model to call the apply_patch tool when executing a tool call.
          variant -> { OpenAI::Beta::BetaToolChoiceApplyPatch }

          # Forces the model to call the shell tool when a tool call is required.
          variant -> { OpenAI::Beta::BetaToolChoiceShell }

          class BetaSpecificProgrammaticToolCallingParam < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool to call. Always `programmatic_tool_calling`.
            #
            #   @return [Symbol, :programmatic_tool_calling]
            required :type, const: :programmatic_tool_calling

            # @!method initialize(type: :programmatic_tool_calling)
            #   @param type [Symbol, :programmatic_tool_calling] The tool to call. Always `programmatic_tool_calling`.
          end

          # @!method self.variants
          #   @return [Array(Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::BetaResponse::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell)]
        end

        # @see OpenAI::Models::Beta::BetaResponse#conversation
        class Conversation < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the conversation that this response was associated with.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   The conversation that this response belonged to. Input items and output items
          #   from this response were automatically added to this conversation.
          #
          #   @param id [String] The unique ID of the conversation that this response was associated with.
        end

        # @see OpenAI::Models::Beta::BetaResponse#moderation
        class Moderation < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #   Moderation for the response input.
          #
          #   @return [OpenAI::Models::Beta::BetaResponse::Moderation::Input::ModerationResult, OpenAI::Models::Beta::BetaResponse::Moderation::Input::Error]
          required :input, union: -> { OpenAI::Beta::BetaResponse::Moderation::Input }

          # @!attribute output
          #   Moderation for the response output.
          #
          #   @return [OpenAI::Models::Beta::BetaResponse::Moderation::Output::ModerationResult, OpenAI::Models::Beta::BetaResponse::Moderation::Output::Error]
          required :output, union: -> { OpenAI::Beta::BetaResponse::Moderation::Output }

          # @!method initialize(input:, output:)
          #   Moderation results for the response input and output, if moderated completions
          #   were requested.
          #
          #   @param input [OpenAI::Models::Beta::BetaResponse::Moderation::Input::ModerationResult, OpenAI::Models::Beta::BetaResponse::Moderation::Input::Error] Moderation for the response input.
          #
          #   @param output [OpenAI::Models::Beta::BetaResponse::Moderation::Output::ModerationResult, OpenAI::Models::Beta::BetaResponse::Moderation::Output::Error] Moderation for the response output.

          # Moderation for the response input.
          #
          # @see OpenAI::Models::Beta::BetaResponse::Moderation#input
          module Input
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # A moderation result produced for the response input or output.
            variant :moderation_result, -> { OpenAI::Beta::BetaResponse::Moderation::Input::ModerationResult }

            # An error produced while attempting moderation for the response input or output.
            variant :error, -> { OpenAI::Beta::BetaResponse::Moderation::Input::Error }

            class ModerationResult < OpenAI::Internal::Type::BaseModel
              # @!attribute categories
              #   A dictionary of moderation categories to booleans, True if the input is flagged
              #   under this category.
              #
              #   @return [Hash{Symbol=>Boolean}]
              required :categories, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Boolean]

              # @!attribute category_applied_input_types
              #   Which modalities of input are reflected by the score for each category.
              #
              #   @return [Hash{Symbol=>Array<Symbol, OpenAI::Models::Beta::BetaResponse::Moderation::Input::ModerationResult::CategoryAppliedInputType>}]
              required :category_applied_input_types,
                       -> do
                         OpenAI::Internal::Type::HashOf[
                           OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::BetaResponse::Moderation::Input::ModerationResult::CategoryAppliedInputType]
                         ]
                       end

              # @!attribute category_scores
              #   A dictionary of moderation categories to scores.
              #
              #   @return [Hash{Symbol=>Float}]
              required :category_scores, OpenAI::Internal::Type::HashOf[Float]

              # @!attribute flagged
              #   A boolean indicating whether the content was flagged by any category.
              #
              #   @return [Boolean]
              required :flagged, OpenAI::Internal::Type::Boolean

              # @!attribute model
              #   The moderation model that produced this result.
              #
              #   @return [String]
              required :model, String

              # @!attribute type
              #   The object type, which was always `moderation_result` for successful moderation
              #   results.
              #
              #   @return [Symbol, :moderation_result]
              required :type, const: :moderation_result

              # @!method initialize(categories:, category_applied_input_types:, category_scores:, flagged:, model:, type: :moderation_result)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Beta::BetaResponse::Moderation::Input::ModerationResult} for
              #   more details.
              #
              #   A moderation result produced for the response input or output.
              #
              #   @param categories [Hash{Symbol=>Boolean}] A dictionary of moderation categories to booleans, True if the input is flagged
              #
              #   @param category_applied_input_types [Hash{Symbol=>Array<Symbol, OpenAI::Models::Beta::BetaResponse::Moderation::Input::ModerationResult::CategoryAppliedInputType>}] Which modalities of input are reflected by the score for each category.
              #
              #   @param category_scores [Hash{Symbol=>Float}] A dictionary of moderation categories to scores.
              #
              #   @param flagged [Boolean] A boolean indicating whether the content was flagged by any category.
              #
              #   @param model [String] The moderation model that produced this result.
              #
              #   @param type [Symbol, :moderation_result] The object type, which was always `moderation_result` for successful moderation

              module CategoryAppliedInputType
                extend OpenAI::Internal::Type::Enum

                TEXT = :text
                IMAGE = :image

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            class Error < OpenAI::Internal::Type::BaseModel
              # @!attribute code
              #   The error code.
              #
              #   @return [String]
              required :code, String

              # @!attribute message
              #   The error message.
              #
              #   @return [String]
              required :message, String

              # @!attribute type
              #   The object type, which was always `error` for moderation failures.
              #
              #   @return [Symbol, :error]
              required :type, const: :error

              # @!method initialize(code:, message:, type: :error)
              #   An error produced while attempting moderation for the response input or output.
              #
              #   @param code [String] The error code.
              #
              #   @param message [String] The error message.
              #
              #   @param type [Symbol, :error] The object type, which was always `error` for moderation failures.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::BetaResponse::Moderation::Input::ModerationResult, OpenAI::Models::Beta::BetaResponse::Moderation::Input::Error)]
          end

          # Moderation for the response output.
          #
          # @see OpenAI::Models::Beta::BetaResponse::Moderation#output
          module Output
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # A moderation result produced for the response input or output.
            variant :moderation_result, -> { OpenAI::Beta::BetaResponse::Moderation::Output::ModerationResult }

            # An error produced while attempting moderation for the response input or output.
            variant :error, -> { OpenAI::Beta::BetaResponse::Moderation::Output::Error }

            class ModerationResult < OpenAI::Internal::Type::BaseModel
              # @!attribute categories
              #   A dictionary of moderation categories to booleans, True if the input is flagged
              #   under this category.
              #
              #   @return [Hash{Symbol=>Boolean}]
              required :categories, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Boolean]

              # @!attribute category_applied_input_types
              #   Which modalities of input are reflected by the score for each category.
              #
              #   @return [Hash{Symbol=>Array<Symbol, OpenAI::Models::Beta::BetaResponse::Moderation::Output::ModerationResult::CategoryAppliedInputType>}]
              required :category_applied_input_types,
                       -> do
                         OpenAI::Internal::Type::HashOf[
                           OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::BetaResponse::Moderation::Output::ModerationResult::CategoryAppliedInputType]
                         ]
                       end

              # @!attribute category_scores
              #   A dictionary of moderation categories to scores.
              #
              #   @return [Hash{Symbol=>Float}]
              required :category_scores, OpenAI::Internal::Type::HashOf[Float]

              # @!attribute flagged
              #   A boolean indicating whether the content was flagged by any category.
              #
              #   @return [Boolean]
              required :flagged, OpenAI::Internal::Type::Boolean

              # @!attribute model
              #   The moderation model that produced this result.
              #
              #   @return [String]
              required :model, String

              # @!attribute type
              #   The object type, which was always `moderation_result` for successful moderation
              #   results.
              #
              #   @return [Symbol, :moderation_result]
              required :type, const: :moderation_result

              # @!method initialize(categories:, category_applied_input_types:, category_scores:, flagged:, model:, type: :moderation_result)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Beta::BetaResponse::Moderation::Output::ModerationResult} for
              #   more details.
              #
              #   A moderation result produced for the response input or output.
              #
              #   @param categories [Hash{Symbol=>Boolean}] A dictionary of moderation categories to booleans, True if the input is flagged
              #
              #   @param category_applied_input_types [Hash{Symbol=>Array<Symbol, OpenAI::Models::Beta::BetaResponse::Moderation::Output::ModerationResult::CategoryAppliedInputType>}] Which modalities of input are reflected by the score for each category.
              #
              #   @param category_scores [Hash{Symbol=>Float}] A dictionary of moderation categories to scores.
              #
              #   @param flagged [Boolean] A boolean indicating whether the content was flagged by any category.
              #
              #   @param model [String] The moderation model that produced this result.
              #
              #   @param type [Symbol, :moderation_result] The object type, which was always `moderation_result` for successful moderation

              module CategoryAppliedInputType
                extend OpenAI::Internal::Type::Enum

                TEXT = :text
                IMAGE = :image

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            class Error < OpenAI::Internal::Type::BaseModel
              # @!attribute code
              #   The error code.
              #
              #   @return [String]
              required :code, String

              # @!attribute message
              #   The error message.
              #
              #   @return [String]
              required :message, String

              # @!attribute type
              #   The object type, which was always `error` for moderation failures.
              #
              #   @return [Symbol, :error]
              required :type, const: :error

              # @!method initialize(code:, message:, type: :error)
              #   An error produced while attempting moderation for the response input or output.
              #
              #   @param code [String] The error code.
              #
              #   @param message [String] The error message.
              #
              #   @param type [Symbol, :error] The object type, which was always `error` for moderation failures.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::BetaResponse::Moderation::Output::ModerationResult, OpenAI::Models::Beta::BetaResponse::Moderation::Output::Error)]
          end
        end

        # @see OpenAI::Models::Beta::BetaResponse#prompt_cache_options
        class PromptCacheOptions < OpenAI::Internal::Type::BaseModel
          # @!attribute mode
          #   Whether implicit prompt-cache breakpoints were enabled.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponse::PromptCacheOptions::Mode]
          required :mode, enum: -> { OpenAI::Beta::BetaResponse::PromptCacheOptions::Mode }

          # @!attribute ttl
          #   The minimum lifetime applied to each cache breakpoint.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponse::PromptCacheOptions::Ttl]
          required :ttl, enum: -> { OpenAI::Beta::BetaResponse::PromptCacheOptions::Ttl }

          # @!method initialize(mode:, ttl:)
          #   The prompt-caching options that were applied to the response. Supported for
          #   `gpt-5.6` and later models.
          #
          #   @param mode [Symbol, OpenAI::Models::Beta::BetaResponse::PromptCacheOptions::Mode] Whether implicit prompt-cache breakpoints were enabled.
          #
          #   @param ttl [Symbol, OpenAI::Models::Beta::BetaResponse::PromptCacheOptions::Ttl] The minimum lifetime applied to each cache breakpoint.

          # Whether implicit prompt-cache breakpoints were enabled.
          #
          # @see OpenAI::Models::Beta::BetaResponse::PromptCacheOptions#mode
          module Mode
            extend OpenAI::Internal::Type::Enum

            IMPLICIT = :implicit
            EXPLICIT = :explicit

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The minimum lifetime applied to each cache breakpoint.
          #
          # @see OpenAI::Models::Beta::BetaResponse::PromptCacheOptions#ttl
          module Ttl
            extend OpenAI::Internal::Type::Enum

            TTL_30M = :"30m"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @deprecated
        #
        # Deprecated. Use `prompt_cache_options.ttl` instead.
        #
        # The retention policy for the prompt cache. Set to `24h` to enable extended
        # prompt caching, which keeps cached prefixes active for longer, up to a maximum
        # of 24 hours.
        # [Learn more](https://platform.openai.com/docs/guides/prompt-caching#prompt-cache-retention).
        # This field expresses a maximum retention policy, while
        # `prompt_cache_options.ttl` expresses a minimum cache lifetime. The two fields
        # are independent and do not interact. For `gpt-5.5`, `gpt-5.5-pro`, and future
        # models, only `24h` is supported.
        #
        # For older models that support both `in_memory` and `24h`, the default depends on
        # your organization's data retention policy:
        #
        # - Organizations without ZDR enabled default to `24h`.
        # - Organizations with ZDR enabled default to `in_memory` when
        #   `prompt_cache_retention` is not specified.
        #
        # @see OpenAI::Models::Beta::BetaResponse#prompt_cache_retention
        module PromptCacheRetention
          extend OpenAI::Internal::Type::Enum

          IN_MEMORY = :in_memory
          PROMPT_CACHE_RETENTION_24H = :"24h"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaResponse#reasoning
        class Reasoning < OpenAI::Internal::Type::BaseModel
          # @!attribute context
          #   Controls which reasoning items are rendered back to the model on later turns.
          #   When returned on a response, this is the effective reasoning context mode used
          #   for the response.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponse::Reasoning::Context, nil]
          optional :context, enum: -> { OpenAI::Beta::BetaResponse::Reasoning::Context }, nil?: true

          # @!attribute effort
          #   Constrains effort on reasoning for reasoning models. Currently supported values
          #   are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
          #   reasoning effort can result in faster responses and fewer tokens used on
          #   reasoning in a response. Not all reasoning models support every value. See the
          #   [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
          #   model-specific support.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponse::Reasoning::Effort, nil]
          optional :effort, enum: -> { OpenAI::Beta::BetaResponse::Reasoning::Effort }, nil?: true

          # @!attribute generate_summary
          #   @deprecated
          #
          #   **Deprecated:** use `summary` instead.
          #
          #   A summary of the reasoning performed by the model. This can be useful for
          #   debugging and understanding the model's reasoning process. One of `auto`,
          #   `concise`, or `detailed`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponse::Reasoning::GenerateSummary, nil]
          optional :generate_summary,
                   enum: -> { OpenAI::Beta::BetaResponse::Reasoning::GenerateSummary },
                   nil?: true

          # @!attribute mode
          #   Controls the reasoning execution mode for the request.
          #
          #   When returned on a response, this is the effective execution mode.
          #
          #   @return [String, Symbol, OpenAI::Models::Beta::BetaResponse::Reasoning::Mode, nil]
          optional :mode, union: -> { OpenAI::Beta::BetaResponse::Reasoning::Mode }

          # @!attribute summary
          #   A summary of the reasoning performed by the model. This can be useful for
          #   debugging and understanding the model's reasoning process. One of `auto`,
          #   `concise`, or `detailed`.
          #
          #   `concise` is supported for `computer-use-preview` models and all reasoning
          #   models after `gpt-5`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponse::Reasoning::Summary, nil]
          optional :summary, enum: -> { OpenAI::Beta::BetaResponse::Reasoning::Summary }, nil?: true

          # @!method initialize(context: nil, effort: nil, generate_summary: nil, mode: nil, summary: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponse::Reasoning} for more details.
          #
          #   **gpt-5 and o-series models only**
          #
          #   Configuration options for
          #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
          #
          #   @param context [Symbol, OpenAI::Models::Beta::BetaResponse::Reasoning::Context, nil] Controls which reasoning items are rendered back to the model on later turns.
          #
          #   @param effort [Symbol, OpenAI::Models::Beta::BetaResponse::Reasoning::Effort, nil] Constrains effort on reasoning for reasoning models. Currently supported
          #
          #   @param generate_summary [Symbol, OpenAI::Models::Beta::BetaResponse::Reasoning::GenerateSummary, nil] **Deprecated:** use `summary` instead.
          #
          #   @param mode [String, Symbol, OpenAI::Models::Beta::BetaResponse::Reasoning::Mode] Controls the reasoning execution mode for the request.
          #
          #   @param summary [Symbol, OpenAI::Models::Beta::BetaResponse::Reasoning::Summary, nil] A summary of the reasoning performed by the model. This can be

          # Controls which reasoning items are rendered back to the model on later turns.
          # When returned on a response, this is the effective reasoning context mode used
          # for the response.
          #
          # @see OpenAI::Models::Beta::BetaResponse::Reasoning#context
          module Context
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            CURRENT_TURN = :current_turn
            ALL_TURNS = :all_turns

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # Constrains effort on reasoning for reasoning models. Currently supported values
          # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
          # reasoning effort can result in faster responses and fewer tokens used on
          # reasoning in a response. Not all reasoning models support every value. See the
          # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
          # model-specific support.
          #
          # @see OpenAI::Models::Beta::BetaResponse::Reasoning#effort
          module Effort
            extend OpenAI::Internal::Type::Enum

            NONE = :none
            MINIMAL = :minimal
            LOW = :low
            MEDIUM = :medium
            HIGH = :high
            XHIGH = :xhigh
            MAX = :max

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @deprecated
          #
          # **Deprecated:** use `summary` instead.
          #
          # A summary of the reasoning performed by the model. This can be useful for
          # debugging and understanding the model's reasoning process. One of `auto`,
          # `concise`, or `detailed`.
          #
          # @see OpenAI::Models::Beta::BetaResponse::Reasoning#generate_summary
          module GenerateSummary
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            CONCISE = :concise
            DETAILED = :detailed

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # Controls the reasoning execution mode for the request.
          #
          # When returned on a response, this is the effective execution mode.
          #
          # @see OpenAI::Models::Beta::BetaResponse::Reasoning#mode
          module Mode
            extend OpenAI::Internal::Type::Union

            variant String

            variant const: -> { OpenAI::Models::Beta::BetaResponse::Reasoning::Mode::STANDARD }

            variant const: -> { OpenAI::Models::Beta::BetaResponse::Reasoning::Mode::PRO }

            # @!method self.variants
            #   @return [Array(String, Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { T.any(String, OpenAI::Beta::BetaResponse::Reasoning::Mode::TaggedSymbol) }
            end

            # @!group

            STANDARD = :standard
            PRO = :pro

            # @!endgroup
          end

          # A summary of the reasoning performed by the model. This can be useful for
          # debugging and understanding the model's reasoning process. One of `auto`,
          # `concise`, or `detailed`.
          #
          # `concise` is supported for `computer-use-preview` models and all reasoning
          # models after `gpt-5`.
          #
          # @see OpenAI::Models::Beta::BetaResponse::Reasoning#summary
          module Summary
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            CONCISE = :concise
            DETAILED = :detailed

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # Specifies the processing type used for serving the request.
        #
        # - If set to 'auto', then the request will be processed with the service tier
        #   configured in the Project settings. Unless otherwise configured, the Project
        #   will use 'default'.
        # - If set to 'default', then the request will be processed with the standard
        #   pricing and performance for the selected model.
        # - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #   '[priority](https://openai.com/api-priority-processing/)', then the request
        #   will be processed with the corresponding service tier.
        # - When not set, the default behavior is 'auto'.
        #
        # When the `service_tier` parameter is set, the response body will include the
        # `service_tier` value based on the processing mode actually used to serve the
        # request. This response value may be different from the value set in the
        # parameter.
        #
        # @see OpenAI::Models::Beta::BetaResponse#service_tier
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DEFAULT = :default
          FLEX = :flex
          SCALE = :scale
          PRIORITY = :priority

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The truncation strategy to use for the model response.
        #
        # - `auto`: If the input to this Response exceeds the model's context window size,
        #   the model will truncate the response to fit the context window by dropping
        #   items from the beginning of the conversation.
        # - `disabled` (default): If the input size will exceed the context window size
        #   for a model, the request will fail with a 400 error.
        #
        # @see OpenAI::Models::Beta::BetaResponse#truncation
        module Truncation
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DISABLED = :disabled

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    BetaResponse = Beta::BetaResponse
  end
end
