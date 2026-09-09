# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Responses
        # @return [OpenAI::Resources::Beta::Responses::InputItems]
        attr_reader :input_items

        # @return [OpenAI::Resources::Beta::Responses::InputTokens]
        attr_reader :input_tokens

        # See {OpenAI::Resources::Beta::Responses#stream_raw} for streaming counterpart.
        #
        # Creates a model response. Provide
        # [text](https://developers.openai.com/api/docs/guides/text) or
        # [image](https://developers.openai.com/api/docs/guides/images-vision) inputs to
        # generate [text](https://developers.openai.com/api/docs/guides/text) or
        # [JSON](https://developers.openai.com/api/docs/guides/structured-outputs)
        # outputs. Have the model call your own
        # [custom code](https://developers.openai.com/api/docs/guides/function-calling) or
        # use built-in [tools](https://developers.openai.com/api/docs/guides/tools) like
        # [web search](https://developers.openai.com/api/docs/guides/tools-web-search) or
        # [file search](https://developers.openai.com/api/docs/guides/tools-file-search)
        # to use your own data as input for the model's response.
        #
        # @overload create(background: nil, context_management: nil, conversation: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, max_tool_calls: nil, metadata: nil, model: nil, moderation: nil, multi_agent: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning: nil, safety_identifier: nil, service_tier: nil, store: nil, stream_options: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, truncation: nil, user: nil, betas: nil, request_options: {})
        #
        # @param background [Boolean, nil]
        #   Body param: Whether to run the model response in the background.
        #   [Learn more](https://developers.openai.com/api/docs/guides/background).
        #
        # @param context_management [Array<OpenAI::Models::Beta::ResponseCreateParams::ContextManagement>, nil]
        #   Body param: Context management configuration for this request.
        #
        # @param conversation [String, OpenAI::Models::Beta::BetaResponseConversationParam, nil]
        #   Body param: The conversation that this response belongs to. Items from this
        #   conversation are prepended to `input_items` for this response request. Input
        #   items and output items from this response are automatically added to this
        #   conversation after this response completes.
        #
        # @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>, nil]
        #   Body param: Specify additional output data to include in the model response.
        #   Currently supported values are:
        #
        #   - `web_search_call.action.sources`: Include the sources of the web search tool
        #     call.
        #   - `code_interpreter_call.outputs`: Includes the outputs of python code execution
        #     in code interpreter tool call items.
        #   - `computer_call_output.output.image_url`: Include image urls from the computer
        #     call output.
        #   - `file_search_call.results`: Include the search results of the file search tool
        #     call.
        #   - `message.input_image.image_url`: Include image urls from the input message.
        #   - `message.output_text.logprobs`: Include logprobs with assistant messages.
        #   - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
        #     tokens in reasoning item outputs. This enables reasoning items to be used in
        #     multi-turn conversations when using the Responses API statelessly (like when
        #     the `store` parameter is set to `false`, or when an organization is enrolled
        #     in the zero data retention program).
        #
        # @param input [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>]
        #   Body param: Text, image, or file inputs to the model, used to generate a
        #   response.
        #
        #   Learn more:
        #
        #   - [Text inputs and outputs](https://developers.openai.com/api/docs/guides/text)
        #   - [Image inputs](https://developers.openai.com/api/docs/guides/images-vision)
        #   - [File inputs](https://developers.openai.com/api/docs/guides/file-inputs)
        #   - [Conversation state](https://developers.openai.com/api/docs/guides/conversation-state)
        #   - [Function calling](https://developers.openai.com/api/docs/guides/function-calling)
        #
        # @param instructions [String, nil]
        #   Body param: A system (or developer) message inserted into the model's context.
        #
        #   When using along with `previous_response_id`, the instructions from a previous
        #   response will not be carried over to the next response. This makes it simple to
        #   swap out system (or developer) messages in new responses.
        #
        # @param max_output_tokens [Integer, nil]
        #   Body param: An upper bound for the number of tokens that can be generated for a
        #   response, including visible output tokens and
        #   [reasoning tokens](https://developers.openai.com/api/docs/guides/reasoning).
        #
        # @param max_tool_calls [Integer, nil]
        #   Body param: The maximum number of total calls to built-in tools that can be
        #   processed in a response. This maximum number applies across all built-in tool
        #   calls, not per individual tool. Any further attempts to call a tool by the model
        #   will be ignored.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Body param: Set of 16 key-value pairs that can be attached to an object. This
        #   can be useful for storing additional information about the object in a
        #   structured format, and querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param model [Symbol, String, OpenAI::Models::Beta::ResponseCreateParams::Model]
        #   Body param: Model ID used to generate the response, like `gpt-6-astra`. OpenAI
        #   offers a wide range of models with different capabilities, performance
        #   characteristics, and price points. Refer to the
        #   [model guide](https://developers.openai.com/api/docs/models) to browse and
        #   compare available models.
        #
        # @param moderation [OpenAI::Models::Beta::ResponseCreateParams::Moderation, nil]
        #   Body param: Configuration for running moderation on the input and output of this
        #   response.
        #
        # @param multi_agent [OpenAI::Models::Beta::ResponseCreateParams::MultiAgent, nil]
        #   Body param: Configuration for server-hosted multi-agent execution.
        #
        # @param parallel_tool_calls [Boolean, nil]
        #   Body param: Whether to allow the model to run tool calls in parallel.
        #
        # @param previous_response_id [String, nil]
        #   Body param: The unique ID of the previous response to the model. Use this to
        #   create multi-turn conversations. Learn more about
        #   [conversation state](https://developers.openai.com/api/docs/guides/conversation-state).
        #   Cannot be used in conjunction with `conversation`.
        #
        # @param prompt [OpenAI::Models::Beta::BetaResponsePrompt, nil]
        #   Body param: Reference to a prompt template and its variables.
        #   [Learn more](https://developers.openai.com/api/docs/guides/text?api-mode=responses#version-prompts-in-code).
        #
        # @param prompt_cache_key [String, nil]
        #   Body param: Used by OpenAI to cache responses for similar requests to optimize
        #   your cache hit rates. Replaces the `user` field.
        #   [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching).
        #
        # @param prompt_cache_options [OpenAI::Models::Beta::ResponseCreateParams::PromptCacheOptions]
        #   Body param: Options for prompt caching. Supported for `gpt-5.6` and later
        #   models. By default, OpenAI automatically chooses one implicit cache breakpoint.
        #   You can add explicit breakpoints to content blocks with
        #   `prompt_cache_breakpoint`. Each request can write up to four breakpoints. For
        #   cache matching, OpenAI considers up to the latest 80 breakpoints in the
        #   conversation, without a content-block lookback limit. Set `mode` to `explicit`
        #   to disable the implicit breakpoint. The `ttl` defaults to `30m`, which is
        #   currently the only supported value. See the
        #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        #   for current details.
        #
        # @param prompt_cache_retention [Symbol, OpenAI::Models::Beta::ResponseCreateParams::PromptCacheRetention, nil]
        #   Body param: Deprecated. Use `prompt_cache_options.ttl` instead.
        #
        #   The retention policy for the prompt cache. Set to `24h` to enable extended
        #   prompt caching, which keeps cached prefixes active for longer, up to a maximum
        #   of 24 hours.
        #   [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching#prompt-cache-retention).
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
        # @param reasoning [OpenAI::Models::Beta::ResponseCreateParams::Reasoning, nil]
        #   Body param: Configuration options for
        #   [reasoning models](https://developers.openai.com/api/docs/guides/reasoning).
        #
        # @param safety_identifier [String, nil]
        #   Body param: A stable identifier used to help detect users of your application
        #   that may be violating OpenAI's usage policies. The IDs should be a string that
        #   uniquely identifies each user, with a maximum length of 64 characters. We
        #   recommend hashing their username or email address, in order to avoid sending us
        #   any identifying information.
        #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        #
        # @param service_tier [Symbol, OpenAI::Models::Beta::ResponseCreateParams::ServiceTier, nil]
        #   Body param: Specifies the processing type used for serving the request.
        #
        #   - If set to 'auto', then the request will be processed with the service tier
        #     configured in the Project settings. Unless otherwise configured, the Project
        #     will use 'default'.
        #   - If set to 'default', then the request will be processed with the standard
        #     pricing and performance for the selected model.
        #   - If set to
        #     '[flex](https://developers.openai.com/api/docs/guides/flex-processing)', then
        #     the request will be processed with the Flex Processing service tier.
        #   - To opt-in to
        #     [Fast mode](https://developers.openai.com/api/docs/guides/fast-mode) at the
        #     request level, include the `service_tier=fast` or `service_tier=priority`
        #     parameter for Responses or Chat Completions. The response will show
        #     `service_tier=priority` regardless of if you specify `service_tier=fast` or
        #     `priority` in your request.
        #   - If set to 'ultrafast', then the request will be processed with the
        #     access-controlled Ultrafast Processing service tier. This tier is currently
        #     available for `gpt-5.6-sol`; a response served through it will show
        #     `service_tier=ultrafast`.
        #   - When not set, the default behavior is 'auto'.
        #
        #   When the `service_tier` parameter is set, the response body will include the
        #   `service_tier` value based on the processing mode actually used to serve the
        #   request. This response value may be different from the value set in the
        #   parameter.
        #
        # @param store [Boolean, nil]
        #   Body param: Whether to store the generated model response for later retrieval
        #   via API. Defaults to true when omitted. If set to true, response data will be
        #   stored for at least 30 days, subject to the
        #   [data retention exceptions](https://developers.openai.com/api/docs/guides/your-data#v1responses).
        #
        # @param stream_options [OpenAI::Models::Beta::ResponseCreateParams::StreamOptions, nil]
        #   Body param: Options for streaming responses. Only set this when you set
        #   `stream: true`.
        #
        # @param temperature [Float, nil]
        #   Body param: What sampling temperature to use, between 0 and 2. Higher values
        #   like 0.8 will make the output more random, while lower values like 0.2 will make
        #   it more focused and deterministic. We generally recommend altering this or
        #   `top_p` but not both.
        #
        # @param text [OpenAI::Models::Beta::BetaResponseTextConfig]
        #   Body param: Configuration options for a text response from the model. Can be
        #   plain text or structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://developers.openai.com/api/docs/guides/text)
        #   - [Structured Outputs](https://developers.openai.com/api/docs/guides/structured-outputs)
        #
        # @param tool_choice [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::ResponseCreateParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell]
        #   Body param: How the model should select which tool (or tools) to use when
        #   generating a response. See the `tools` parameter to see how to specify which
        #   tools the model can call.
        #
        # @param tools [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>]
        #   Body param: An array of tools the model may call while generating a response.
        #   You can specify which tool to use by setting the `tool_choice` parameter.
        #
        #   We support the following categories of tools:
        #
        #   - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #     capabilities, like
        #     [web search](https://developers.openai.com/api/docs/guides/tools-web-search)
        #     or
        #     [file search](https://developers.openai.com/api/docs/guides/tools-file-search).
        #     Learn more about
        #     [built-in tools](https://developers.openai.com/api/docs/guides/tools).
        #   - **MCP Tools**: Integrations with third-party systems via custom MCP servers or
        #     predefined connectors such as Google Drive and SharePoint. Learn more about
        #     [MCP Tools](https://developers.openai.com/api/docs/guides/tools-connectors-mcp).
        #   - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #     the model to call your own code with strongly typed arguments and outputs.
        #     Learn more about
        #     [function calling](https://developers.openai.com/api/docs/guides/function-calling).
        #     You can also use custom tools to call your own code.
        #
        # @param top_logprobs [Integer, nil]
        #   Body param: An integer between 0 and 20 specifying the maximum number of most
        #   likely tokens to return at each token position, each with an associated log
        #   probability. In some cases, the number of returned tokens may be fewer than
        #   requested.
        #
        # @param top_p [Float, nil]
        #   Body param: An alternative to sampling with temperature, called nucleus
        #   sampling, where the model considers the results of the tokens with top_p
        #   probability mass. So 0.1 means only the tokens comprising the top 10%
        #   probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        #
        # @param truncation [Symbol, OpenAI::Models::Beta::ResponseCreateParams::Truncation, nil]
        #   Body param: The truncation strategy to use for the model response.
        #
        #   - `auto`: If the input to this Response exceeds the model's context window size,
        #     the model will truncate the response to fit the context window by dropping
        #     items from the beginning of the conversation.
        #   - `disabled` (default): If the input size will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        #
        # @param user [String]
        #   Body param: This field is being replaced by `safety_identifier` and
        #   `prompt_cache_key`. Use `prompt_cache_key` instead to maintain caching
        #   optimizations. A stable identifier for your end-users. Used to boost cache hit
        #   rates by better bucketing similar requests and to help OpenAI detect and prevent
        #   abuse.
        #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseCreateParams::Beta>]
        #   Header param: Optional beta features to enable for this request.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::BetaResponse]
        #
        # @see OpenAI::Models::Beta::ResponseCreateParams
        def create(params = {})
          parsed, options = OpenAI::Beta::ResponseCreateParams.dump_request(params)
          if parsed[:stream]
            message = "Please use `#stream_raw` for the streaming use case."
            raise ArgumentError.new(message)
          end

          header_params = {betas: "openai-beta"}
          @client.request(
            method: :post,
            path: "responses?beta=true",
            headers: parsed.slice(*header_params.keys).transform_keys(header_params),
            body: parsed.except(*header_params.keys),
            model: OpenAI::Beta::BetaResponse,
            security: {bearer_auth: true},
            options: options
          )
        end

        # See {OpenAI::Resources::Beta::Responses#create} for non-streaming counterpart.
        #
        # Creates a model response. Provide
        # [text](https://developers.openai.com/api/docs/guides/text) or
        # [image](https://developers.openai.com/api/docs/guides/images-vision) inputs to
        # generate [text](https://developers.openai.com/api/docs/guides/text) or
        # [JSON](https://developers.openai.com/api/docs/guides/structured-outputs)
        # outputs. Have the model call your own
        # [custom code](https://developers.openai.com/api/docs/guides/function-calling) or
        # use built-in [tools](https://developers.openai.com/api/docs/guides/tools) like
        # [web search](https://developers.openai.com/api/docs/guides/tools-web-search) or
        # [file search](https://developers.openai.com/api/docs/guides/tools-file-search)
        # to use your own data as input for the model's response.
        #
        # @overload stream_raw(background: nil, context_management: nil, conversation: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, max_tool_calls: nil, metadata: nil, model: nil, moderation: nil, multi_agent: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning: nil, safety_identifier: nil, service_tier: nil, store: nil, stream_options: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, truncation: nil, user: nil, betas: nil, request_options: {})
        #
        # @param background [Boolean, nil]
        #   Body param: Whether to run the model response in the background.
        #   [Learn more](https://developers.openai.com/api/docs/guides/background).
        #
        # @param context_management [Array<OpenAI::Models::Beta::ResponseCreateParams::ContextManagement>, nil]
        #   Body param: Context management configuration for this request.
        #
        # @param conversation [String, OpenAI::Models::Beta::BetaResponseConversationParam, nil]
        #   Body param: The conversation that this response belongs to. Items from this
        #   conversation are prepended to `input_items` for this response request. Input
        #   items and output items from this response are automatically added to this
        #   conversation after this response completes.
        #
        # @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>, nil]
        #   Body param: Specify additional output data to include in the model response.
        #   Currently supported values are:
        #
        #   - `web_search_call.action.sources`: Include the sources of the web search tool
        #     call.
        #   - `code_interpreter_call.outputs`: Includes the outputs of python code execution
        #     in code interpreter tool call items.
        #   - `computer_call_output.output.image_url`: Include image urls from the computer
        #     call output.
        #   - `file_search_call.results`: Include the search results of the file search tool
        #     call.
        #   - `message.input_image.image_url`: Include image urls from the input message.
        #   - `message.output_text.logprobs`: Include logprobs with assistant messages.
        #   - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
        #     tokens in reasoning item outputs. This enables reasoning items to be used in
        #     multi-turn conversations when using the Responses API statelessly (like when
        #     the `store` parameter is set to `false`, or when an organization is enrolled
        #     in the zero data retention program).
        #
        # @param input [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>]
        #   Body param: Text, image, or file inputs to the model, used to generate a
        #   response.
        #
        #   Learn more:
        #
        #   - [Text inputs and outputs](https://developers.openai.com/api/docs/guides/text)
        #   - [Image inputs](https://developers.openai.com/api/docs/guides/images-vision)
        #   - [File inputs](https://developers.openai.com/api/docs/guides/file-inputs)
        #   - [Conversation state](https://developers.openai.com/api/docs/guides/conversation-state)
        #   - [Function calling](https://developers.openai.com/api/docs/guides/function-calling)
        #
        # @param instructions [String, nil]
        #   Body param: A system (or developer) message inserted into the model's context.
        #
        #   When using along with `previous_response_id`, the instructions from a previous
        #   response will not be carried over to the next response. This makes it simple to
        #   swap out system (or developer) messages in new responses.
        #
        # @param max_output_tokens [Integer, nil]
        #   Body param: An upper bound for the number of tokens that can be generated for a
        #   response, including visible output tokens and
        #   [reasoning tokens](https://developers.openai.com/api/docs/guides/reasoning).
        #
        # @param max_tool_calls [Integer, nil]
        #   Body param: The maximum number of total calls to built-in tools that can be
        #   processed in a response. This maximum number applies across all built-in tool
        #   calls, not per individual tool. Any further attempts to call a tool by the model
        #   will be ignored.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Body param: Set of 16 key-value pairs that can be attached to an object. This
        #   can be useful for storing additional information about the object in a
        #   structured format, and querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param model [Symbol, String, OpenAI::Models::Beta::ResponseCreateParams::Model]
        #   Body param: Model ID used to generate the response, like `gpt-6-astra`. OpenAI
        #   offers a wide range of models with different capabilities, performance
        #   characteristics, and price points. Refer to the
        #   [model guide](https://developers.openai.com/api/docs/models) to browse and
        #   compare available models.
        #
        # @param moderation [OpenAI::Models::Beta::ResponseCreateParams::Moderation, nil]
        #   Body param: Configuration for running moderation on the input and output of this
        #   response.
        #
        # @param multi_agent [OpenAI::Models::Beta::ResponseCreateParams::MultiAgent, nil]
        #   Body param: Configuration for server-hosted multi-agent execution.
        #
        # @param parallel_tool_calls [Boolean, nil]
        #   Body param: Whether to allow the model to run tool calls in parallel.
        #
        # @param previous_response_id [String, nil]
        #   Body param: The unique ID of the previous response to the model. Use this to
        #   create multi-turn conversations. Learn more about
        #   [conversation state](https://developers.openai.com/api/docs/guides/conversation-state).
        #   Cannot be used in conjunction with `conversation`.
        #
        # @param prompt [OpenAI::Models::Beta::BetaResponsePrompt, nil]
        #   Body param: Reference to a prompt template and its variables.
        #   [Learn more](https://developers.openai.com/api/docs/guides/text?api-mode=responses#version-prompts-in-code).
        #
        # @param prompt_cache_key [String, nil]
        #   Body param: Used by OpenAI to cache responses for similar requests to optimize
        #   your cache hit rates. Replaces the `user` field.
        #   [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching).
        #
        # @param prompt_cache_options [OpenAI::Models::Beta::ResponseCreateParams::PromptCacheOptions]
        #   Body param: Options for prompt caching. Supported for `gpt-5.6` and later
        #   models. By default, OpenAI automatically chooses one implicit cache breakpoint.
        #   You can add explicit breakpoints to content blocks with
        #   `prompt_cache_breakpoint`. Each request can write up to four breakpoints. For
        #   cache matching, OpenAI considers up to the latest 80 breakpoints in the
        #   conversation, without a content-block lookback limit. Set `mode` to `explicit`
        #   to disable the implicit breakpoint. The `ttl` defaults to `30m`, which is
        #   currently the only supported value. See the
        #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        #   for current details.
        #
        # @param prompt_cache_retention [Symbol, OpenAI::Models::Beta::ResponseCreateParams::PromptCacheRetention, nil]
        #   Body param: Deprecated. Use `prompt_cache_options.ttl` instead.
        #
        #   The retention policy for the prompt cache. Set to `24h` to enable extended
        #   prompt caching, which keeps cached prefixes active for longer, up to a maximum
        #   of 24 hours.
        #   [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching#prompt-cache-retention).
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
        # @param reasoning [OpenAI::Models::Beta::ResponseCreateParams::Reasoning, nil]
        #   Body param: Configuration options for
        #   [reasoning models](https://developers.openai.com/api/docs/guides/reasoning).
        #
        # @param safety_identifier [String, nil]
        #   Body param: A stable identifier used to help detect users of your application
        #   that may be violating OpenAI's usage policies. The IDs should be a string that
        #   uniquely identifies each user, with a maximum length of 64 characters. We
        #   recommend hashing their username or email address, in order to avoid sending us
        #   any identifying information.
        #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        #
        # @param service_tier [Symbol, OpenAI::Models::Beta::ResponseCreateParams::ServiceTier, nil]
        #   Body param: Specifies the processing type used for serving the request.
        #
        #   - If set to 'auto', then the request will be processed with the service tier
        #     configured in the Project settings. Unless otherwise configured, the Project
        #     will use 'default'.
        #   - If set to 'default', then the request will be processed with the standard
        #     pricing and performance for the selected model.
        #   - If set to
        #     '[flex](https://developers.openai.com/api/docs/guides/flex-processing)', then
        #     the request will be processed with the Flex Processing service tier.
        #   - To opt-in to
        #     [Fast mode](https://developers.openai.com/api/docs/guides/fast-mode) at the
        #     request level, include the `service_tier=fast` or `service_tier=priority`
        #     parameter for Responses or Chat Completions. The response will show
        #     `service_tier=priority` regardless of if you specify `service_tier=fast` or
        #     `priority` in your request.
        #   - If set to 'ultrafast', then the request will be processed with the
        #     access-controlled Ultrafast Processing service tier. This tier is currently
        #     available for `gpt-5.6-sol`; a response served through it will show
        #     `service_tier=ultrafast`.
        #   - When not set, the default behavior is 'auto'.
        #
        #   When the `service_tier` parameter is set, the response body will include the
        #   `service_tier` value based on the processing mode actually used to serve the
        #   request. This response value may be different from the value set in the
        #   parameter.
        #
        # @param store [Boolean, nil]
        #   Body param: Whether to store the generated model response for later retrieval
        #   via API. Defaults to true when omitted. If set to true, response data will be
        #   stored for at least 30 days, subject to the
        #   [data retention exceptions](https://developers.openai.com/api/docs/guides/your-data#v1responses).
        #
        # @param stream_options [OpenAI::Models::Beta::ResponseCreateParams::StreamOptions, nil]
        #   Body param: Options for streaming responses. Only set this when you set
        #   `stream: true`.
        #
        # @param temperature [Float, nil]
        #   Body param: What sampling temperature to use, between 0 and 2. Higher values
        #   like 0.8 will make the output more random, while lower values like 0.2 will make
        #   it more focused and deterministic. We generally recommend altering this or
        #   `top_p` but not both.
        #
        # @param text [OpenAI::Models::Beta::BetaResponseTextConfig]
        #   Body param: Configuration options for a text response from the model. Can be
        #   plain text or structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://developers.openai.com/api/docs/guides/text)
        #   - [Structured Outputs](https://developers.openai.com/api/docs/guides/structured-outputs)
        #
        # @param tool_choice [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::ResponseCreateParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell]
        #   Body param: How the model should select which tool (or tools) to use when
        #   generating a response. See the `tools` parameter to see how to specify which
        #   tools the model can call.
        #
        # @param tools [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>]
        #   Body param: An array of tools the model may call while generating a response.
        #   You can specify which tool to use by setting the `tool_choice` parameter.
        #
        #   We support the following categories of tools:
        #
        #   - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #     capabilities, like
        #     [web search](https://developers.openai.com/api/docs/guides/tools-web-search)
        #     or
        #     [file search](https://developers.openai.com/api/docs/guides/tools-file-search).
        #     Learn more about
        #     [built-in tools](https://developers.openai.com/api/docs/guides/tools).
        #   - **MCP Tools**: Integrations with third-party systems via custom MCP servers or
        #     predefined connectors such as Google Drive and SharePoint. Learn more about
        #     [MCP Tools](https://developers.openai.com/api/docs/guides/tools-connectors-mcp).
        #   - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #     the model to call your own code with strongly typed arguments and outputs.
        #     Learn more about
        #     [function calling](https://developers.openai.com/api/docs/guides/function-calling).
        #     You can also use custom tools to call your own code.
        #
        # @param top_logprobs [Integer, nil]
        #   Body param: An integer between 0 and 20 specifying the maximum number of most
        #   likely tokens to return at each token position, each with an associated log
        #   probability. In some cases, the number of returned tokens may be fewer than
        #   requested.
        #
        # @param top_p [Float, nil]
        #   Body param: An alternative to sampling with temperature, called nucleus
        #   sampling, where the model considers the results of the tokens with top_p
        #   probability mass. So 0.1 means only the tokens comprising the top 10%
        #   probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        #
        # @param truncation [Symbol, OpenAI::Models::Beta::ResponseCreateParams::Truncation, nil]
        #   Body param: The truncation strategy to use for the model response.
        #
        #   - `auto`: If the input to this Response exceeds the model's context window size,
        #     the model will truncate the response to fit the context window by dropping
        #     items from the beginning of the conversation.
        #   - `disabled` (default): If the input size will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        #
        # @param user [String]
        #   Body param: This field is being replaced by `safety_identifier` and
        #   `prompt_cache_key`. Use `prompt_cache_key` instead to maintain caching
        #   optimizations. A stable identifier for your end-users. Used to boost cache hit
        #   rates by better bucketing similar requests and to help OpenAI detect and prevent
        #   abuse.
        #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseCreateParams::Beta>]
        #   Header param: Optional beta features to enable for this request.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::BetaResponseAudioDeltaEvent, OpenAI::Models::Beta::BetaResponseAudioDoneEvent, OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent, OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Beta::BetaResponseCompletedEvent, OpenAI::Models::Beta::BetaResponseContentPartAddedEvent, OpenAI::Models::Beta::BetaResponseContentPartDoneEvent, OpenAI::Models::Beta::BetaResponseCreatedEvent, OpenAI::Models::Beta::BetaResponseErrorEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallCompletedEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallSearchingEvent, OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Beta::BetaResponseShellCallCommandAddedEvent, OpenAI::Models::Beta::BetaResponseShellCallCommandDeltaEvent, OpenAI::Models::Beta::BetaResponseShellCallCommandDoneEvent, OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent, OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent, OpenAI::Models::Beta::BetaResponseInProgressEvent, OpenAI::Models::Beta::BetaResponseFailedEvent, OpenAI::Models::Beta::BetaResponseIncompleteEvent, OpenAI::Models::Beta::BetaResponseOutputItemAddedEvent, OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent, OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent, OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent, OpenAI::Models::Beta::BetaResponseRefusalDoneEvent, OpenAI::Models::Beta::BetaResponseTextDeltaEvent, OpenAI::Models::Beta::BetaResponseTextDoneEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallCompletedEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallSearchingEvent, OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent, OpenAI::Models::Beta::BetaResponseImageGenCallGeneratingEvent, OpenAI::Models::Beta::BetaResponseImageGenCallInProgressEvent, OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent, OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent, OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent, OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent, OpenAI::Models::Beta::BetaResponseMcpCallFailedEvent, OpenAI::Models::Beta::BetaResponseMcpCallInProgressEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsInProgressEvent, OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent, OpenAI::Models::Beta::BetaResponseQueuedEvent, OpenAI::Models::Beta::BetaResponseCustomToolCallInputDeltaEvent, OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent, OpenAI::Streaming::UnknownStreamEvent>]
        #
        # @see OpenAI::Models::Beta::ResponseCreateParams
        def stream_raw(params = {})
          parsed, options = OpenAI::Beta::ResponseCreateParams.dump_request(params)
          unless parsed.fetch(:stream, true)
            message = "Please use `#create` for the non-streaming use case."
            raise ArgumentError.new(message)
          end

          parsed.store(:stream, true)
          header_params = {betas: "openai-beta"}
          @client.request(
            method: :post,
            path: "responses?beta=true",
            headers: {
              "accept" => "text/event-stream",
              "accept-encoding" => "identity",
              **parsed.slice(*header_params.keys)
            }.transform_keys(
              header_params
            ),
            body: parsed.except(*header_params.keys),
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Beta::BetaResponseStreamEvent,
            security: {bearer_auth: true},
            options: options
          )
        end

        # See {OpenAI::Resources::Beta::Responses#retrieve_streaming} for streaming
        # counterpart.
        #
        # Retrieves a model response with the given ID.
        #
        # @overload retrieve(response_id, include: nil, include_obfuscation: nil, starting_after: nil, betas: nil, request_options: {})
        #
        # @param response_id [String]
        #   Path param: The ID of the response to retrieve.
        #
        # @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>]
        #   Query param: Additional fields to include in the response. See the `include`
        #   parameter for Response creation above for more information.
        #
        # @param include_obfuscation [Boolean]
        #   Query param: When true, stream obfuscation will be enabled. Stream obfuscation
        #   adds random characters to an `obfuscation` field on streaming delta events to
        #   normalize payload sizes as a mitigation to certain side-channel attacks. These
        #   obfuscation fields are included by default, but add a small amount of overhead
        #   to the data stream. You can set `include_obfuscation` to false to optimize for
        #   bandwidth if you trust the network links between your application and the OpenAI
        #   API.
        #
        # @param starting_after [Integer]
        #   Query param: The sequence number of the event after which to start streaming.
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseRetrieveParams::Beta>]
        #   Header param: Optional beta features to enable for this request.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::BetaResponse]
        #
        # @see OpenAI::Models::Beta::ResponseRetrieveParams
        def retrieve(response_id, params = {})
          query_params = [:include, :include_obfuscation, :starting_after, :stream]
          parsed, options = OpenAI::Beta::ResponseRetrieveParams.dump_request(params)
          query = OpenAI::Internal::Util.encode_query_params(parsed.slice(*query_params))
          if parsed[:stream]
            message = "Please use `#retrieve_streaming` for the streaming use case."
            raise ArgumentError.new(message)
          end

          @client.request(
            method: :get,
            path: ["responses/%1$s?beta=true", response_id],
            query: query,
            headers: parsed.except(*query_params).transform_keys(betas: "openai-beta"),
            model: OpenAI::Beta::BetaResponse,
            security: {bearer_auth: true},
            options: options
          )
        end

        # See {OpenAI::Resources::Beta::Responses#retrieve} for non-streaming counterpart.
        #
        # Retrieves a model response with the given ID.
        #
        # @overload retrieve_streaming(response_id, include: nil, include_obfuscation: nil, starting_after: nil, betas: nil, request_options: {})
        #
        # @param response_id [String]
        #   Path param: The ID of the response to retrieve.
        #
        # @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>]
        #   Query param: Additional fields to include in the response. See the `include`
        #   parameter for Response creation above for more information.
        #
        # @param include_obfuscation [Boolean]
        #   Query param: When true, stream obfuscation will be enabled. Stream obfuscation
        #   adds random characters to an `obfuscation` field on streaming delta events to
        #   normalize payload sizes as a mitigation to certain side-channel attacks. These
        #   obfuscation fields are included by default, but add a small amount of overhead
        #   to the data stream. You can set `include_obfuscation` to false to optimize for
        #   bandwidth if you trust the network links between your application and the OpenAI
        #   API.
        #
        # @param starting_after [Integer]
        #   Query param: The sequence number of the event after which to start streaming.
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseRetrieveParams::Beta>]
        #   Header param: Optional beta features to enable for this request.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::BetaResponseAudioDeltaEvent, OpenAI::Models::Beta::BetaResponseAudioDoneEvent, OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent, OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Beta::BetaResponseCompletedEvent, OpenAI::Models::Beta::BetaResponseContentPartAddedEvent, OpenAI::Models::Beta::BetaResponseContentPartDoneEvent, OpenAI::Models::Beta::BetaResponseCreatedEvent, OpenAI::Models::Beta::BetaResponseErrorEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallCompletedEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallSearchingEvent, OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Beta::BetaResponseShellCallCommandAddedEvent, OpenAI::Models::Beta::BetaResponseShellCallCommandDeltaEvent, OpenAI::Models::Beta::BetaResponseShellCallCommandDoneEvent, OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent, OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent, OpenAI::Models::Beta::BetaResponseInProgressEvent, OpenAI::Models::Beta::BetaResponseFailedEvent, OpenAI::Models::Beta::BetaResponseIncompleteEvent, OpenAI::Models::Beta::BetaResponseOutputItemAddedEvent, OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent, OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent, OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent, OpenAI::Models::Beta::BetaResponseRefusalDoneEvent, OpenAI::Models::Beta::BetaResponseTextDeltaEvent, OpenAI::Models::Beta::BetaResponseTextDoneEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallCompletedEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallSearchingEvent, OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent, OpenAI::Models::Beta::BetaResponseImageGenCallGeneratingEvent, OpenAI::Models::Beta::BetaResponseImageGenCallInProgressEvent, OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent, OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent, OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent, OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent, OpenAI::Models::Beta::BetaResponseMcpCallFailedEvent, OpenAI::Models::Beta::BetaResponseMcpCallInProgressEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsInProgressEvent, OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent, OpenAI::Models::Beta::BetaResponseQueuedEvent, OpenAI::Models::Beta::BetaResponseCustomToolCallInputDeltaEvent, OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent, OpenAI::Streaming::UnknownStreamEvent>]
        #
        # @see OpenAI::Models::Beta::ResponseRetrieveParams
        def retrieve_streaming(response_id, params = {})
          query_params = [:include, :include_obfuscation, :starting_after, :stream]
          parsed, options = OpenAI::Beta::ResponseRetrieveParams.dump_request(params)
          unless parsed.fetch(:stream, true)
            message = "Please use `#retrieve` for the non-streaming use case."
            raise ArgumentError.new(message)
          end

          parsed.store(:stream, true)
          query = OpenAI::Internal::Util.encode_query_params(parsed.slice(*query_params))
          @client.request(
            method: :get,
            path: ["responses/%1$s?beta=true", response_id],
            query: query,
            headers: {
              "accept" => "text/event-stream",
              "accept-encoding" => "identity",
              **parsed.except(*query_params)
            }.transform_keys(
              betas: "openai-beta"
            ),
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Beta::BetaResponseStreamEvent,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Deletes a model response with the given ID.
        #
        # @overload delete(response_id, betas: nil, request_options: {})
        #
        # @param response_id [String]
        #   The ID of the response to delete.
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseDeleteParams::Beta>]
        #   Optional beta features to enable for this request.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [nil]
        #
        # @see OpenAI::Models::Beta::ResponseDeleteParams
        def delete(response_id, params = {})
          parsed, options = OpenAI::Beta::ResponseDeleteParams.dump_request(params)
          @client.request(
            method: :delete,
            path: ["responses/%1$s?beta=true", response_id],
            headers: parsed.transform_keys(betas: "openai-beta"),
            model: NilClass,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Cancels a model response with the given ID. Only responses created with the
        # `background` parameter set to `true` can be cancelled.
        # [Learn more](https://developers.openai.com/api/docs/guides/background).
        #
        # @overload cancel(response_id, betas: nil, request_options: {})
        #
        # @param response_id [String]
        #   The ID of the response to cancel.
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseCancelParams::Beta>]
        #   Optional beta features to enable for this request.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::BetaResponse]
        #
        # @see OpenAI::Models::Beta::ResponseCancelParams
        def cancel(response_id, params = {})
          parsed, options = OpenAI::Beta::ResponseCancelParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["responses/%1$s/cancel?beta=true", response_id],
            headers: parsed.transform_keys(betas: "openai-beta"),
            model: OpenAI::Beta::BetaResponse,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Compact a conversation. Returns a compacted response object.
        #
        # Learn when and how to compact long-running conversations in the
        # [conversation state guide](https://developers.openai.com/api/docs/guides/conversation-state#managing-the-context-window).
        # For ZDR-compatible compaction details, see
        # [Compaction (advanced)](https://developers.openai.com/api/docs/guides/conversation-state#compaction-advanced).
        #
        # @overload compact(model:, input: nil, instructions: nil, previous_response_id: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, service_tier: nil, betas: nil, request_options: {})
        #
        # @param model [Symbol, String, OpenAI::Models::Beta::ResponseCompactParams::Model, nil]
        #   Body param: Model ID used to generate the response, like `gpt-6-astra`. OpenAI
        #   offers a wide range of models with different capabilities, performance
        #   characteristics, and price points. Refer to the
        #   [model guide](https://developers.openai.com/api/docs/models) to browse and
        #   compare available models.
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
        # @param previous_response_id [String, nil]
        #   Body param: The unique ID of the previous response to the model. Use this to
        #   create multi-turn conversations. Learn more about
        #   [conversation state](https://developers.openai.com/api/docs/guides/conversation-state).
        #   Cannot be used in conjunction with `conversation`.
        #
        # @param prompt_cache_key [String, nil]
        #   Body param: A key to use when reading from or writing to the prompt cache.
        #
        # @param prompt_cache_options [OpenAI::Models::Beta::ResponseCompactParams::PromptCacheOptions, nil]
        #   Body param: Options for prompt caching. Supported for `gpt-5.6` and later
        #   models. By default, OpenAI automatically chooses one implicit cache breakpoint.
        #   You can add explicit breakpoints to content blocks with
        #   `prompt_cache_breakpoint`. Each request can write up to four breakpoints. For
        #   cache matching, OpenAI considers up to the latest 80 breakpoints in the
        #   conversation, without a content-block lookback limit. Set `mode` to `explicit`
        #   to disable the implicit breakpoint. The `ttl` defaults to `30m`, which is
        #   currently the only supported value. See the
        #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        #   for current details.
        #
        # @param prompt_cache_retention [Symbol, OpenAI::Models::Beta::ResponseCompactParams::PromptCacheRetention, nil]
        #   Body param: How long to retain a prompt cache entry created by this request.
        #
        # @param service_tier [Symbol, OpenAI::Models::Beta::ResponseCompactParams::ServiceTier, nil]
        #   Body param: Specifies the processing type used for serving the request. - If set
        #   to 'auto', then the request will be processed with the service tier configured
        #   in the Project settings. Unless otherwise configured, the Project will use
        #   'default'. - If set to 'default', then the request will be processed with the
        #   standard pricing and performance for the selected model. - If set to
        #   '[flex](https://developers.openai.com/api/docs/guides/flex-processing)', then
        #   the request will be processed with the Flex Processing service tier. - To opt-in
        #   to [Fast mode](https://developers.openai.com/api/docs/guides/fast-mode) at the
        #   request level, include the `service_tier=fast` or `service_tier=priority`
        #   parameter for Responses or Chat Completions. For models with a dedicated Fast
        #   tier, either value resolves to `service_tier=fast`; for other models, either
        #   value resolves to `service_tier=priority`. - When not set, the default behavior
        #   is 'auto'. When the `service_tier` parameter is set, the response body will
        #   include the `service_tier` value based on the processing mode actually used to
        #   serve the request. This response value may be different from the value set in
        #   the parameter.
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseCompactParams::Beta>]
        #   Header param: Optional beta features to enable for this request.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::BetaCompactedResponse]
        #
        # @see OpenAI::Models::Beta::ResponseCompactParams
        def compact(params)
          parsed, options = OpenAI::Beta::ResponseCompactParams.dump_request(params)
          header_params = {betas: "openai-beta"}
          @client.request(
            method: :post,
            path: "responses/compact?beta=true",
            headers: parsed.slice(*header_params.keys).transform_keys(header_params),
            body: parsed.except(*header_params.keys),
            model: OpenAI::Beta::BetaCompactedResponse,
            security: {bearer_auth: true},
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @input_items = OpenAI::Resources::Beta::Responses::InputItems.new(client: client)
          @input_tokens = OpenAI::Resources::Beta::Responses::InputTokens.new(client: client)
        end
      end
    end
  end
end
