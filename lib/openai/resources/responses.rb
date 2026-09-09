# frozen_string_literal: true

require_relative "../helpers/structured_output/response_parser"

module OpenAI
  module Resources
    class Responses
      # @return [OpenAI::Resources::Responses::InputItems]
      attr_reader :input_items

      # @return [OpenAI::Resources::Responses::InputTokens]
      attr_reader :input_tokens

      # See {OpenAI::Resources::Responses#stream_raw} for streaming counterpart.
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
      # @overload create(background: nil, context_management: nil, conversation: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, max_tool_calls: nil, metadata: nil, model: nil, moderation: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning: nil, safety_identifier: nil, service_tier: nil, store: nil, stream_options: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
      #
      # @param background [Boolean, nil]
      #   Whether to run the model response in the background.
      #   [Learn more](https://developers.openai.com/api/docs/guides/background).
      #
      # @param context_management [Array<OpenAI::Models::Responses::ResponseCreateParams::ContextManagement>, nil]
      #   Context management configuration for this request.
      #
      # @param conversation [String, OpenAI::Models::Responses::ResponseConversationParam, nil]
      #   The conversation that this response belongs to. Items from this conversation are
      #   prepended to `input_items` for this response request. Input items and output
      #   items from this response are automatically added to this conversation after this
      #   response completes.
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
      #   Specify additional output data to include in the model response. Currently
      #   supported values are:
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
      # @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseInputItem::ToolSearchCall, OpenAI::Models::Responses::ResponseToolSearchOutputItemParam, OpenAI::Models::Responses::ResponseInputItem::AdditionalTools, OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItemParam, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ShellCall, OpenAI::Models::Responses::ResponseInputItem::ShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCall, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::CompactionTrigger, OpenAI::Models::Responses::ResponseInputItem::ItemReference, OpenAI::Models::Responses::ResponseInputItem::Program, OpenAI::Models::Responses::ResponseInputItem::ProgramOutput>]
      #   Text, image, or file inputs to the model, used to generate a response.
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
      #   A system (or developer) message inserted into the model's context.
      #
      #   When using along with `previous_response_id`, the instructions from a previous
      #   response will not be carried over to the next response. This makes it simple to
      #   swap out system (or developer) messages in new responses.
      #
      # @param max_output_tokens [Integer, nil]
      #   An upper bound for the number of tokens that can be generated for a response,
      #   including visible output tokens and
      #   [reasoning tokens](https://developers.openai.com/api/docs/guides/reasoning).
      #
      # @param max_tool_calls [Integer, nil]
      #   The maximum number of total calls to built-in tools that can be processed in a
      #   response. This maximum number applies across all built-in tool calls, not per
      #   individual tool. Any further attempts to call a tool by the model will be
      #   ignored.
      #
      # @param metadata [Hash{Symbol=>String}, nil]
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      #
      # @param model [String, Symbol, OpenAI::Models::ChatModel, OpenAI::Models::ResponsesModel::ResponsesOnlyModel]
      #   Model ID used to generate the response, like `gpt-6-astra`. OpenAI offers a wide
      #   range of models with different capabilities, performance characteristics, and
      #   price points. Refer to the
      #   [model guide](https://developers.openai.com/api/docs/models) to browse and
      #   compare available models.
      #
      # @param moderation [OpenAI::Models::Responses::ResponseCreateParams::Moderation, nil]
      #   Configuration for running moderation on the input and output of this response.
      #
      # @param parallel_tool_calls [Boolean, nil]
      #   Whether to allow the model to run tool calls in parallel.
      #
      # @param previous_response_id [String, nil]
      #   The unique ID of the previous response to the model. Use this to create
      #   multi-turn conversations. Learn more about
      #   [conversation state](https://developers.openai.com/api/docs/guides/conversation-state).
      #   Cannot be used in conjunction with `conversation`.
      #
      # @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil]
      #   Reference to a prompt template and its variables.
      #   [Learn more](https://developers.openai.com/api/docs/guides/text?api-mode=responses#version-prompts-in-code).
      #
      # @param prompt_cache_key [String, nil]
      #   Used by OpenAI to cache responses for similar requests to optimize your cache
      #   hit rates. Replaces the `user` field.
      #   [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching).
      #
      # @param prompt_cache_options [OpenAI::Models::Responses::ResponseCreateParams::PromptCacheOptions]
      #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
      #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
      #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
      #   request can write up to four breakpoints. For cache matching, OpenAI considers
      #   up to the latest 80 breakpoints in the conversation, without a content-block
      #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
      #   `ttl` defaults to `30m`, which is currently the only supported value. See the
      #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
      #   for current details.
      #
      # @param prompt_cache_retention [Symbol, OpenAI::Models::Responses::ResponseCreateParams::PromptCacheRetention, nil]
      #   Deprecated. Use `prompt_cache_options.ttl` instead.
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
      # @param reasoning [OpenAI::Models::Reasoning, nil]
      #   Configuration options for
      #   [reasoning models](https://developers.openai.com/api/docs/guides/reasoning).
      #
      # @param safety_identifier [String, nil]
      #   A stable identifier used to help detect users of your application that may be
      #   violating OpenAI's usage policies. The IDs should be a string that uniquely
      #   identifies each user, with a maximum length of 64 characters. We recommend
      #   hashing their username or email address, in order to avoid sending us any
      #   identifying information.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      # @param service_tier [Symbol, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier, nil]
      #   Specifies the processing type used for serving the request.
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
      #   Whether to store the generated model response for later retrieval via API.
      #   Defaults to true when omitted. If set to true, response data will be stored for
      #   at least 30 days, subject to the
      #   [data retention exceptions](https://developers.openai.com/api/docs/guides/your-data#v1responses).
      #
      # @param stream_options [OpenAI::Models::Responses::ResponseCreateParams::StreamOptions, nil]
      #   Options for streaming responses. Only set this when you set `stream: true`.
      #
      # @param temperature [Float, nil]
      #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
      #   make the output more random, while lower values like 0.2 will make it more
      #   focused and deterministic. We generally recommend altering this or `top_p` but
      #   not both.
      #
      # @param text [OpenAI::Models::Responses::ResponseTextConfig]
      #   Configuration options for a text response from the model. Can be plain text or
      #   structured JSON data. Learn more:
      #
      #   - [Text inputs and outputs](https://developers.openai.com/api/docs/guides/text)
      #   - [Structured Outputs](https://developers.openai.com/api/docs/guides/structured-outputs)
      #
      # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceAllowed, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, OpenAI::Models::Responses::ToolChoiceCustom, OpenAI::Models::Responses::ResponseCreateParams::ToolChoice::SpecificProgrammaticToolCallingParam, OpenAI::Models::Responses::ToolChoiceApplyPatch, OpenAI::Models::Responses::ToolChoiceShell]
      #   How the model should select which tool (or tools) to use when generating a
      #   response. See the `tools` parameter to see how to specify which tools the model
      #   can call.
      #
      # @param tools [Array<OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::ComputerUsePreviewTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ProgrammaticToolCalling, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::FunctionShellTool, OpenAI::Models::Responses::CustomTool, OpenAI::Models::Responses::NamespaceTool, OpenAI::Models::Responses::ToolSearchTool, OpenAI::Models::Responses::ApplyPatchTool, OpenAI::Models::Responses::WebSearchTool, OpenAI::Models::Responses::WebSearchPreviewTool>]
      #   An array of tools the model may call while generating a response. You can
      #   specify which tool to use by setting the `tool_choice` parameter.
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
      #   An integer between 0 and 20 specifying the maximum number of most likely tokens
      #   to return at each token position, each with an associated log probability. In
      #   some cases, the number of returned tokens may be fewer than requested.
      #
      # @param top_p [Float, nil]
      #   An alternative to sampling with temperature, called nucleus sampling, where the
      #   model considers the results of the tokens with top_p probability mass. So 0.1
      #   means only the tokens comprising the top 10% probability mass are considered.
      #
      #   We generally recommend altering this or `temperature` but not both.
      #
      # @param truncation [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil]
      #   The truncation strategy to use for the model response.
      #
      #   - `auto`: If the input to this Response exceeds the model's context window size,
      #     the model will truncate the response to fit the context window by dropping
      #     items from the beginning of the conversation.
      #   - `disabled` (default): If the input size will exceed the context window size
      #     for a model, the request will fail with a 400 error.
      #
      # @param user [String]
      #   This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
      #   `prompt_cache_key` instead to maintain caching optimizations. A stable
      #   identifier for your end-users. Used to boost cache hit rates by better bucketing
      #   similar requests and to help OpenAI detect and prevent abuse.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Responses::Response]
      #
      # @see OpenAI::Models::Responses::ResponseCreateParams
      def create(params = {})
        parsed, options = OpenAI::Responses::ResponseCreateParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#stream` for the streaming use case."
          raise ArgumentError.new(message)
        end

        model, tool_models = get_structured_output_models(parsed)

        unwrap = -> (raw) do
          parse_structured_outputs!(raw, model, tool_models)
        end

        @client.request(
          method: :post,
          path: "responses",
          body: parsed,
          unwrap: unwrap,
          model: OpenAI::Responses::Response,
          security: {bearer_auth: true},
          options: options
        )
      end

      # See {OpenAI::Resources::Responses#create} for non-streaming counterpart.
      #
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::Responses::ResponseCreateParams} for more details.
      #
      # Creates a model response. Provide
      # [text](https://platform.openai.com/docs/guides/text) or
      # [image](https://platform.openai.com/docs/guides/images) inputs to generate
      # [text](https://platform.openai.com/docs/guides/text) or
      # [JSON](https://platform.openai.com/docs/guides/structured-outputs) outputs. Have
      # the model call your own
      # [custom code](https://platform.openai.com/docs/guides/function-calling) or use
      # built-in [tools](https://platform.openai.com/docs/guides/tools) like
      # [web search](https://platform.openai.com/docs/guides/tools-web-search) or
      # [file search](https://platform.openai.com/docs/guides/tools-file-search) to use
      # your own data as input for the model's response.
      #
      # @overload stream(background: nil, context_management: nil, conversation: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, max_tool_calls: nil, metadata: nil, model: nil, moderation: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning: nil, response_id: nil, safety_identifier: nil, service_tier: nil, starting_after: nil, store: nil, stream_options: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
      #
      # @param background [Boolean, nil] Whether to run the model response in the background.
      #
      # @param context_management [Array<OpenAI::Models::Responses::ResponseCreateParams::ContextManagement>, nil] Context management configuration for this request.
      #
      # @param conversation [String, OpenAI::Models::Responses::ResponseConversationParam, nil] The conversation that this response belongs to. Items from this conversation are
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil] Specify additional output data to include in the model response. Currently suppo
      #
      # @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseInputItem::ToolSearchCall, OpenAI::Models::Responses::ResponseToolSearchOutputItemParam, OpenAI::Models::Responses::ResponseInputItem::AdditionalTools, OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItemParam, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ShellCall, OpenAI::Models::Responses::ResponseInputItem::ShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCall, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::CompactionTrigger, OpenAI::Models::Responses::ResponseInputItem::ItemReference, OpenAI::Models::Responses::ResponseInputItem::Program, OpenAI::Models::Responses::ResponseInputItem::ProgramOutput>]
      #
      # @param instructions [String, nil] A system (or developer) message inserted into the model's context.
      #
      # @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
      #
      # @param max_tool_calls [Integer, nil] The maximum number of total calls to built-in tools that can be processed in a r
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      # @param model [String, Symbol, OpenAI::Models::ChatModel, OpenAI::Models::ResponsesModel::ResponsesOnlyModel] Model ID used to generate the response, like `gpt-6-astra`. OpenAI
      #
      # @param moderation [OpenAI::Models::Responses::ResponseCreateParams::Moderation, nil] Configuration for running moderation on the input and output of this response.
      #
      # @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
      #
      # @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to create multi-turn conversations.
      #
      # @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
      #
      # @param prompt_cache_key [String] Used by OpenAI to cache responses for similar requests to optimize your cache hi
      #
      # @param prompt_cache_options [OpenAI::Models::Responses::ResponseCreateParams::PromptCacheOptions] Options for prompt caching. Supported for `gpt-5.6` and later models. By default
      #
      # @param prompt_cache_retention [Symbol, OpenAI::Models::Responses::ResponseCreateParams::PromptCacheRetention, nil] Deprecated. Use `prompt_cache_options.ttl` instead.
      #
      # @param reasoning [OpenAI::Models::Reasoning, nil] **o-series models only**
      #
      # @param response_id [String, nil] The ID of the response whose stream to resume.
      #
      # @param safety_identifier [String] A stable identifier used to help detect users of your application that may be vi
      #
      # @param service_tier [Symbol, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier, nil] Specifies the processing type used for serving the request.
      #
      # @param starting_after [Integer, nil] The sequence number of the event after which to resume streaming. Can only be used with `response_id`.
      #
      # @param store [Boolean, nil] Whether to store the generated model response for later retrieval via
      #
      # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
      #
      # @param text [OpenAI::Models::Responses::ResponseTextConfig] Configuration options for a text response from the model. Can be plain
      #
      # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceAllowed, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp] How the model should select which tool (or tools) to use when generating
      #
      # @param tools [Array<OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::Tool::Custom, OpenAI::Models::Responses::WebSearchTool>] An array of tools the model may call while generating a response. You
      #
      # @param top_logprobs [Integer, nil] An integer between 0 and 20 specifying the number of most likely tokens to
      #
      # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
      #
      # @param truncation [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil] The truncation strategy to use for the model response.
      #
      # @param user [String] This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Models::Responses::ResponseAudioDeltaEvent, OpenAI::Models::Responses::ResponseAudioDoneEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Responses::ResponseCompletedEvent, OpenAI::Models::Responses::ResponseContentPartAddedEvent, OpenAI::Models::Responses::ResponseContentPartDoneEvent, OpenAI::Models::Responses::ResponseCreatedEvent, OpenAI::Models::Responses::ResponseErrorEvent, OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseInProgressEvent, OpenAI::Models::Responses::ResponseFailedEvent, OpenAI::Models::Responses::ResponseIncompleteEvent, OpenAI::Models::Responses::ResponseOutputItemAddedEvent, OpenAI::Models::Responses::ResponseOutputItemDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Responses::ResponseRefusalDeltaEvent, OpenAI::Models::Responses::ResponseRefusalDoneEvent, OpenAI::Models::Responses::ResponseTextDeltaEvent, OpenAI::Models::Responses::ResponseTextDoneEvent, OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseImageGenCallCompletedEvent, OpenAI::Models::Responses::ResponseImageGenCallGeneratingEvent, OpenAI::Models::Responses::ResponseImageGenCallInProgressEvent, OpenAI::Models::Responses::ResponseImageGenCallPartialImageEvent, OpenAI::Models::Responses::ResponseMcpCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseMcpCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseMcpCallCompletedEvent, OpenAI::Models::Responses::ResponseMcpCallFailedEvent, OpenAI::Models::Responses::ResponseMcpCallInProgressEvent, OpenAI::Models::Responses::ResponseMcpListToolsCompletedEvent, OpenAI::Models::Responses::ResponseMcpListToolsFailedEvent, OpenAI::Models::Responses::ResponseMcpListToolsInProgressEvent, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent, OpenAI::Models::Responses::ResponseQueuedEvent, OpenAI::Models::Responses::ResponseCustomToolCallInputDeltaEvent, OpenAI::Models::Responses::ResponseCustomToolCallInputDoneEvent, OpenAI::Streaming::UnknownStreamEvent>]
      #
      # @see OpenAI::Models::Responses::ResponseCreateParams
      def stream(params)
        parsed, options = OpenAI::Responses::ResponseCreateParams.dump_request(params)
        starting_after, response_id = parsed.values_at(:starting_after, :response_id)

        if starting_after && !response_id
          raise ArgumentError, "starting_after can only be used with response_id"
        end

        model, tool_models = get_structured_output_models(parsed)

        unwrap = -> (raw) do
          if raw[:type] == "response.completed" && raw[:response]
            parse_structured_outputs!(raw[:response], model, tool_models)
          end

          raw
        end

        if response_id
          retrieve_params = parsed.slice(:include, :starting_after)
          retrieve_params[:request_options] = options

          raw_stream = retrieve_streaming_internal(
            response_id,
            params: retrieve_params,
            unwrap: unwrap
          )
        else
          parsed[:stream] = true

          raw_stream = @client.request(
            method: :post,
            path: "responses",
            headers: {"accept" => "text/event-stream"},
            body: parsed,
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Models::Responses::ResponseStreamEvent,
            unwrap: unwrap,
            security: {bearer_auth: true},
            options: options
          )
        end

        OpenAI::Streaming::ResponseStream.new(
          raw_stream: raw_stream,
          text_format: model,
          starting_after: starting_after
        )
      end

      # See {OpenAI::Resources::Responses#create} for non-streaming counterpart.
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
      # @overload stream_raw(background: nil, context_management: nil, conversation: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, max_tool_calls: nil, metadata: nil, model: nil, moderation: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning: nil, safety_identifier: nil, service_tier: nil, store: nil, stream_options: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
      #
      # @param background [Boolean, nil]
      #   Whether to run the model response in the background.
      #   [Learn more](https://developers.openai.com/api/docs/guides/background).
      #
      # @param context_management [Array<OpenAI::Models::Responses::ResponseCreateParams::ContextManagement>, nil]
      #   Context management configuration for this request.
      #
      # @param conversation [String, OpenAI::Models::Responses::ResponseConversationParam, nil]
      #   The conversation that this response belongs to. Items from this conversation are
      #   prepended to `input_items` for this response request. Input items and output
      #   items from this response are automatically added to this conversation after this
      #   response completes.
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
      #   Specify additional output data to include in the model response. Currently
      #   supported values are:
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
      # @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseInputItem::ToolSearchCall, OpenAI::Models::Responses::ResponseToolSearchOutputItemParam, OpenAI::Models::Responses::ResponseInputItem::AdditionalTools, OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItemParam, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ShellCall, OpenAI::Models::Responses::ResponseInputItem::ShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCall, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::CompactionTrigger, OpenAI::Models::Responses::ResponseInputItem::ItemReference, OpenAI::Models::Responses::ResponseInputItem::Program, OpenAI::Models::Responses::ResponseInputItem::ProgramOutput>]
      #   Text, image, or file inputs to the model, used to generate a response.
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
      #   A system (or developer) message inserted into the model's context.
      #
      #   When using along with `previous_response_id`, the instructions from a previous
      #   response will not be carried over to the next response. This makes it simple to
      #   swap out system (or developer) messages in new responses.
      #
      # @param max_output_tokens [Integer, nil]
      #   An upper bound for the number of tokens that can be generated for a response,
      #   including visible output tokens and
      #   [reasoning tokens](https://developers.openai.com/api/docs/guides/reasoning).
      #
      # @param max_tool_calls [Integer, nil]
      #   The maximum number of total calls to built-in tools that can be processed in a
      #   response. This maximum number applies across all built-in tool calls, not per
      #   individual tool. Any further attempts to call a tool by the model will be
      #   ignored.
      #
      # @param metadata [Hash{Symbol=>String}, nil]
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      #
      # @param model [String, Symbol, OpenAI::Models::ChatModel, OpenAI::Models::ResponsesModel::ResponsesOnlyModel]
      #   Model ID used to generate the response, like `gpt-6-astra`. OpenAI offers a wide
      #   range of models with different capabilities, performance characteristics, and
      #   price points. Refer to the
      #   [model guide](https://developers.openai.com/api/docs/models) to browse and
      #   compare available models.
      #
      # @param moderation [OpenAI::Models::Responses::ResponseCreateParams::Moderation, nil]
      #   Configuration for running moderation on the input and output of this response.
      #
      # @param parallel_tool_calls [Boolean, nil]
      #   Whether to allow the model to run tool calls in parallel.
      #
      # @param previous_response_id [String, nil]
      #   The unique ID of the previous response to the model. Use this to create
      #   multi-turn conversations. Learn more about
      #   [conversation state](https://developers.openai.com/api/docs/guides/conversation-state).
      #   Cannot be used in conjunction with `conversation`.
      #
      # @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil]
      #   Reference to a prompt template and its variables.
      #   [Learn more](https://developers.openai.com/api/docs/guides/text?api-mode=responses#version-prompts-in-code).
      #
      # @param prompt_cache_key [String, nil]
      #   Used by OpenAI to cache responses for similar requests to optimize your cache
      #   hit rates. Replaces the `user` field.
      #   [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching).
      #
      # @param prompt_cache_options [OpenAI::Models::Responses::ResponseCreateParams::PromptCacheOptions]
      #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
      #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
      #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
      #   request can write up to four breakpoints. For cache matching, OpenAI considers
      #   up to the latest 80 breakpoints in the conversation, without a content-block
      #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
      #   `ttl` defaults to `30m`, which is currently the only supported value. See the
      #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
      #   for current details.
      #
      # @param prompt_cache_retention [Symbol, OpenAI::Models::Responses::ResponseCreateParams::PromptCacheRetention, nil]
      #   Deprecated. Use `prompt_cache_options.ttl` instead.
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
      # @param reasoning [OpenAI::Models::Reasoning, nil]
      #   Configuration options for
      #   [reasoning models](https://developers.openai.com/api/docs/guides/reasoning).
      #
      # @param safety_identifier [String, nil]
      #   A stable identifier used to help detect users of your application that may be
      #   violating OpenAI's usage policies. The IDs should be a string that uniquely
      #   identifies each user, with a maximum length of 64 characters. We recommend
      #   hashing their username or email address, in order to avoid sending us any
      #   identifying information.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      # @param service_tier [Symbol, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier, nil]
      #   Specifies the processing type used for serving the request.
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
      #   Whether to store the generated model response for later retrieval via API.
      #   Defaults to true when omitted. If set to true, response data will be stored for
      #   at least 30 days, subject to the
      #   [data retention exceptions](https://developers.openai.com/api/docs/guides/your-data#v1responses).
      #
      # @param stream_options [OpenAI::Models::Responses::ResponseCreateParams::StreamOptions, nil]
      #   Options for streaming responses. Only set this when you set `stream: true`.
      #
      # @param temperature [Float, nil]
      #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
      #   make the output more random, while lower values like 0.2 will make it more
      #   focused and deterministic. We generally recommend altering this or `top_p` but
      #   not both.
      #
      # @param text [OpenAI::Models::Responses::ResponseTextConfig]
      #   Configuration options for a text response from the model. Can be plain text or
      #   structured JSON data. Learn more:
      #
      #   - [Text inputs and outputs](https://developers.openai.com/api/docs/guides/text)
      #   - [Structured Outputs](https://developers.openai.com/api/docs/guides/structured-outputs)
      #
      # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceAllowed, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, OpenAI::Models::Responses::ToolChoiceCustom, OpenAI::Models::Responses::ResponseCreateParams::ToolChoice::SpecificProgrammaticToolCallingParam, OpenAI::Models::Responses::ToolChoiceApplyPatch, OpenAI::Models::Responses::ToolChoiceShell]
      #   How the model should select which tool (or tools) to use when generating a
      #   response. See the `tools` parameter to see how to specify which tools the model
      #   can call.
      #
      # @param tools [Array<OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::ComputerUsePreviewTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ProgrammaticToolCalling, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::FunctionShellTool, OpenAI::Models::Responses::CustomTool, OpenAI::Models::Responses::NamespaceTool, OpenAI::Models::Responses::ToolSearchTool, OpenAI::Models::Responses::ApplyPatchTool, OpenAI::Models::Responses::WebSearchTool, OpenAI::Models::Responses::WebSearchPreviewTool>]
      #   An array of tools the model may call while generating a response. You can
      #   specify which tool to use by setting the `tool_choice` parameter.
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
      #   An integer between 0 and 20 specifying the maximum number of most likely tokens
      #   to return at each token position, each with an associated log probability. In
      #   some cases, the number of returned tokens may be fewer than requested.
      #
      # @param top_p [Float, nil]
      #   An alternative to sampling with temperature, called nucleus sampling, where the
      #   model considers the results of the tokens with top_p probability mass. So 0.1
      #   means only the tokens comprising the top 10% probability mass are considered.
      #
      #   We generally recommend altering this or `temperature` but not both.
      #
      # @param truncation [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil]
      #   The truncation strategy to use for the model response.
      #
      #   - `auto`: If the input to this Response exceeds the model's context window size,
      #     the model will truncate the response to fit the context window by dropping
      #     items from the beginning of the conversation.
      #   - `disabled` (default): If the input size will exceed the context window size
      #     for a model, the request will fail with a 400 error.
      #
      # @param user [String]
      #   This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
      #   `prompt_cache_key` instead to maintain caching optimizations. A stable
      #   identifier for your end-users. Used to boost cache hit rates by better bucketing
      #   similar requests and to help OpenAI detect and prevent abuse.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Models::Responses::ResponseAudioDeltaEvent, OpenAI::Models::Responses::ResponseAudioDoneEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Responses::ResponseCompletedEvent, OpenAI::Models::Responses::ResponseContentPartAddedEvent, OpenAI::Models::Responses::ResponseContentPartDoneEvent, OpenAI::Models::Responses::ResponseCreatedEvent, OpenAI::Models::Responses::ResponseErrorEvent, OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseShellCallCommandAddedEvent, OpenAI::Models::Responses::ResponseShellCallCommandDeltaEvent, OpenAI::Models::Responses::ResponseShellCallCommandDoneEvent, OpenAI::Models::Responses::ResponseShellCallOutputContentDeltaEvent, OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent, OpenAI::Models::Responses::ResponseInProgressEvent, OpenAI::Models::Responses::ResponseFailedEvent, OpenAI::Models::Responses::ResponseIncompleteEvent, OpenAI::Models::Responses::ResponseOutputItemAddedEvent, OpenAI::Models::Responses::ResponseOutputItemDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Responses::ResponseReasoningTextDeltaEvent, OpenAI::Models::Responses::ResponseReasoningTextDoneEvent, OpenAI::Models::Responses::ResponseRefusalDeltaEvent, OpenAI::Models::Responses::ResponseRefusalDoneEvent, OpenAI::Models::Responses::ResponseTextDeltaEvent, OpenAI::Models::Responses::ResponseTextDoneEvent, OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseImageGenCallCompletedEvent, OpenAI::Models::Responses::ResponseImageGenCallGeneratingEvent, OpenAI::Models::Responses::ResponseImageGenCallInProgressEvent, OpenAI::Models::Responses::ResponseImageGenCallPartialImageEvent, OpenAI::Models::Responses::ResponseMcpCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseMcpCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseMcpCallCompletedEvent, OpenAI::Models::Responses::ResponseMcpCallFailedEvent, OpenAI::Models::Responses::ResponseMcpCallInProgressEvent, OpenAI::Models::Responses::ResponseMcpListToolsCompletedEvent, OpenAI::Models::Responses::ResponseMcpListToolsFailedEvent, OpenAI::Models::Responses::ResponseMcpListToolsInProgressEvent, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent, OpenAI::Models::Responses::ResponseQueuedEvent, OpenAI::Models::Responses::ResponseCustomToolCallInputDeltaEvent, OpenAI::Models::Responses::ResponseCustomToolCallInputDoneEvent, OpenAI::Streaming::UnknownStreamEvent>]
      #
      # @see OpenAI::Models::Responses::ResponseCreateParams
      def stream_raw(params = {})
        parsed, options = OpenAI::Responses::ResponseCreateParams.dump_request(params)
        unless parsed.fetch(:stream, true)
          message = "Please use `#create` for the non-streaming use case."
          raise ArgumentError.new(message)
        end

        parsed.store(:stream, true)
        @client.request(
          method: :post,
          path: "responses",
          headers: {"accept" => "text/event-stream", "accept-encoding" => "identity"},
          body: parsed,
          stream: OpenAI::Internal::Stream,
          model: OpenAI::Responses::ResponseStreamEvent,
          security: {bearer_auth: true},
          options: options
        )
      end

      # See {OpenAI::Resources::Responses#retrieve_streaming} for streaming counterpart.
      #
      # Retrieves a model response with the given ID.
      #
      # @overload retrieve(response_id, include: nil, include_obfuscation: nil, starting_after: nil, text: nil, tools: nil, request_options: {})
      #
      # @param response_id [String]
      #   The ID of the response to retrieve.
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>]
      #   Additional fields to include in the response. See the `include` parameter for
      #   Response creation above for more information.
      #
      # @param include_obfuscation [Boolean]
      #   When true, stream obfuscation will be enabled. Stream obfuscation adds random
      #   characters to an `obfuscation` field on streaming delta events to normalize
      #   payload sizes as a mitigation to certain side-channel attacks. These obfuscation
      #   fields are included by default, but add a small amount of overhead to the data
      #   stream. You can set `include_obfuscation` to false to optimize for bandwidth if
      #   you trust the network links between your application and the OpenAI API.
      #
      # @param starting_after [Integer]
      #   The sequence number of the event after which to start streaming.
      #
      # @param text [OpenAI::Responses::ResponseTextConfig, OpenAI::StructuredOutput::JsonSchemaConverter, Hash, nil] The structured-output model,
      #   or the same typed/hash text configuration accepted by creation, used to parse retrieved text output. This is a local parsing hint and is not
      #   sent to the API.
      #
      # @param tools [Array<OpenAI::Responses::FunctionTool, OpenAI::StructuredOutput::JsonSchemaConverter, Hash>, nil] Structured-output models, or
      #   the same typed/hash function-tool definitions accepted by creation, used to parse retrieved function tool calls. These are local parsing hints
      #   and are not sent to the API.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Responses::Response]
      #
      # @see OpenAI::Models::Responses::ResponseRetrieveParams
      def retrieve(response_id, params = {})
        parsed, options = OpenAI::Responses::ResponseRetrieveParams.dump_request(params)
        structured_output_params = parsed.slice(:text, :tools)
        parsed.delete(:text)
        parsed.delete(:tools)
        query = OpenAI::Internal::Util.encode_query_params(parsed)
        if parsed[:stream]
          message = "Please use `#retrieve_streaming` for the streaming use case."
          raise ArgumentError.new(message)
        end

        model, tool_models = get_retrieval_structured_output_models(structured_output_params)

        unwrap = if model || !tool_models.empty?
          -> (raw) do
            parse_retrieved_structured_outputs!(raw, model, tool_models)
          end
        end

        @client.request(
          method: :get,
          path: ["responses/%1$s", response_id],
          query: query,
          unwrap: unwrap,
          model: OpenAI::Responses::Response,
          security: {bearer_auth: true},
          options: options
        )
      end

      # See {OpenAI::Resources::Responses#retrieve} for non-streaming counterpart.
      #
      # Retrieves a model response with the given ID.
      #
      # @overload retrieve_streaming(response_id, include: nil, include_obfuscation: nil, starting_after: nil, request_options: {})
      #
      # @param response_id [String]
      #   The ID of the response to retrieve.
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>]
      #   Additional fields to include in the response. See the `include` parameter for
      #   Response creation above for more information.
      #
      # @param include_obfuscation [Boolean]
      #   When true, stream obfuscation will be enabled. Stream obfuscation adds random
      #   characters to an `obfuscation` field on streaming delta events to normalize
      #   payload sizes as a mitigation to certain side-channel attacks. These obfuscation
      #   fields are included by default, but add a small amount of overhead to the data
      #   stream. You can set `include_obfuscation` to false to optimize for bandwidth if
      #   you trust the network links between your application and the OpenAI API.
      #
      # @param starting_after [Integer]
      #   The sequence number of the event after which to start streaming.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Models::Responses::ResponseAudioDeltaEvent, OpenAI::Models::Responses::ResponseAudioDoneEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Responses::ResponseCompletedEvent, OpenAI::Models::Responses::ResponseContentPartAddedEvent, OpenAI::Models::Responses::ResponseContentPartDoneEvent, OpenAI::Models::Responses::ResponseCreatedEvent, OpenAI::Models::Responses::ResponseErrorEvent, OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseShellCallCommandAddedEvent, OpenAI::Models::Responses::ResponseShellCallCommandDeltaEvent, OpenAI::Models::Responses::ResponseShellCallCommandDoneEvent, OpenAI::Models::Responses::ResponseShellCallOutputContentDeltaEvent, OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent, OpenAI::Models::Responses::ResponseInProgressEvent, OpenAI::Models::Responses::ResponseFailedEvent, OpenAI::Models::Responses::ResponseIncompleteEvent, OpenAI::Models::Responses::ResponseOutputItemAddedEvent, OpenAI::Models::Responses::ResponseOutputItemDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Responses::ResponseReasoningTextDeltaEvent, OpenAI::Models::Responses::ResponseReasoningTextDoneEvent, OpenAI::Models::Responses::ResponseRefusalDeltaEvent, OpenAI::Models::Responses::ResponseRefusalDoneEvent, OpenAI::Models::Responses::ResponseTextDeltaEvent, OpenAI::Models::Responses::ResponseTextDoneEvent, OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseImageGenCallCompletedEvent, OpenAI::Models::Responses::ResponseImageGenCallGeneratingEvent, OpenAI::Models::Responses::ResponseImageGenCallInProgressEvent, OpenAI::Models::Responses::ResponseImageGenCallPartialImageEvent, OpenAI::Models::Responses::ResponseMcpCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseMcpCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseMcpCallCompletedEvent, OpenAI::Models::Responses::ResponseMcpCallFailedEvent, OpenAI::Models::Responses::ResponseMcpCallInProgressEvent, OpenAI::Models::Responses::ResponseMcpListToolsCompletedEvent, OpenAI::Models::Responses::ResponseMcpListToolsFailedEvent, OpenAI::Models::Responses::ResponseMcpListToolsInProgressEvent, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent, OpenAI::Models::Responses::ResponseQueuedEvent, OpenAI::Models::Responses::ResponseCustomToolCallInputDeltaEvent, OpenAI::Models::Responses::ResponseCustomToolCallInputDoneEvent, OpenAI::Streaming::UnknownStreamEvent>]
      #
      # @see OpenAI::Models::Responses::ResponseRetrieveParams
      def retrieve_streaming(response_id, params = {})
        parsed, options = OpenAI::Responses::ResponseRetrieveParams.dump_request(params)
        unless parsed.fetch(:stream, true)
          message = "Please use `#retrieve` for the non-streaming use case."
          raise ArgumentError.new(message)
        end

        parsed.store(:stream, true)
        query = OpenAI::Internal::Util.encode_query_params(parsed)
        @client.request(
          method: :get,
          path: ["responses/%1$s", response_id],
          query: query,
          headers: {"accept" => "text/event-stream", "accept-encoding" => "identity"},
          stream: OpenAI::Internal::Stream,
          model: OpenAI::Responses::ResponseStreamEvent,
          security: {bearer_auth: true},
          options: options
        )
      end

      private def retrieve_streaming_internal(response_id, params:, unwrap:)
        parsed, options = OpenAI::Responses::ResponseRetrieveParams.dump_request(params)
        parsed.store(:stream, true)
        @client.request(
          method: :get,
          path: ["responses/%1$s", response_id],
          query: parsed,
          headers: {"accept" => "text/event-stream"},
          stream: OpenAI::Internal::Stream,
          model: OpenAI::Responses::ResponseStreamEvent,
          security: {bearer_auth: true},
          options: options,
          unwrap: unwrap
        )
      end

      # Deletes a model response with the given ID.
      #
      # @overload delete(response_id, request_options: {})
      #
      # @param response_id [String]
      #   The ID of the response to delete.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [nil]
      #
      # @see OpenAI::Models::Responses::ResponseDeleteParams
      def delete(response_id, params = {})
        @client.request(
          method: :delete,
          path: ["responses/%1$s", response_id],
          model: NilClass,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # Cancels a model response with the given ID. Only responses created with the
      # `background` parameter set to `true` can be cancelled.
      # [Learn more](https://developers.openai.com/api/docs/guides/background).
      #
      # @overload cancel(response_id, request_options: {})
      #
      # @param response_id [String]
      #   The ID of the response to cancel.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Responses::Response]
      #
      # @see OpenAI::Models::Responses::ResponseCancelParams
      def cancel(response_id, params = {})
        @client.request(
          method: :post,
          path: ["responses/%1$s/cancel", response_id],
          model: OpenAI::Responses::Response,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # Compact a conversation. Returns a compacted response object.
      #
      # Learn when and how to compact long-running conversations in the
      # [conversation state guide](https://developers.openai.com/api/docs/guides/conversation-state#managing-the-context-window).
      # For ZDR-compatible compaction details, see
      # [Compaction (advanced)](https://developers.openai.com/api/docs/guides/conversation-state#compaction-advanced).
      #
      # @overload compact(model:, input: nil, instructions: nil, previous_response_id: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, service_tier: nil, request_options: {})
      #
      # @param model [Symbol, String, OpenAI::Models::Responses::ResponseCompactParams::Model, nil]
      #   Model ID used to generate the response, like `gpt-6-astra`. OpenAI offers a wide
      #   range of models with different capabilities, performance characteristics, and
      #   price points. Refer to the
      #   [model guide](https://developers.openai.com/api/docs/models) to browse and
      #   compare available models.
      #
      # @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseInputItem::ToolSearchCall, OpenAI::Models::Responses::ResponseToolSearchOutputItemParam, OpenAI::Models::Responses::ResponseInputItem::AdditionalTools, OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItemParam, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ShellCall, OpenAI::Models::Responses::ResponseInputItem::ShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCall, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::CompactionTrigger, OpenAI::Models::Responses::ResponseInputItem::ItemReference, OpenAI::Models::Responses::ResponseInputItem::Program, OpenAI::Models::Responses::ResponseInputItem::ProgramOutput>, nil]
      #   Text, image, or file inputs to the model, used to generate a response
      #
      # @param instructions [String, nil]
      #   A system (or developer) message inserted into the model's context. When used
      #   along with `previous_response_id`, the instructions from a previous response
      #   will not be carried over to the next response. This makes it simple to swap out
      #   system (or developer) messages in new responses.
      #
      # @param previous_response_id [String, nil]
      #   The unique ID of the previous response to the model. Use this to create
      #   multi-turn conversations. Learn more about
      #   [conversation state](https://developers.openai.com/api/docs/guides/conversation-state).
      #   Cannot be used in conjunction with `conversation`.
      #
      # @param prompt_cache_key [String, nil]
      #   A key to use when reading from or writing to the prompt cache.
      #
      # @param prompt_cache_options [OpenAI::Models::Responses::ResponseCompactParams::PromptCacheOptions, nil]
      #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
      #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
      #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
      #   request can write up to four breakpoints. For cache matching, OpenAI considers
      #   up to the latest 80 breakpoints in the conversation, without a content-block
      #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
      #   `ttl` defaults to `30m`, which is currently the only supported value. See the
      #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
      #   for current details.
      #
      # @param prompt_cache_retention [Symbol, OpenAI::Models::Responses::ResponseCompactParams::PromptCacheRetention, nil]
      #   How long to retain a prompt cache entry created by this request.
      #
      # @param service_tier [Symbol, OpenAI::Models::Responses::ResponseCompactParams::ServiceTier, nil]
      #   Specifies the processing type used for serving the request. - If set to 'auto',
      #   then the request will be processed with the service tier configured in the
      #   Project settings. Unless otherwise configured, the Project will use 'default'. -
      #   If set to 'default', then the request will be processed with the standard
      #   pricing and performance for the selected model. - If set to
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
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Responses::CompactedResponse]
      #
      # @see OpenAI::Models::Responses::ResponseCompactParams
      def compact(params)
        parsed, options = OpenAI::Responses::ResponseCompactParams.dump_request(params)
        @client.request(
          method: :post,
          path: "responses/compact",
          body: parsed,
          model: OpenAI::Responses::CompactedResponse,
          security: {bearer_auth: true},
          options: options
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @input_items = OpenAI::Resources::Responses::InputItems.new(client: client)
        @input_tokens = OpenAI::Resources::Responses::InputTokens.new(client: client)
      end

      private

      def parse_structured_outputs!(raw, model, tool_models)
        OpenAI::Helpers::StructuredOutput::ResponseParser.parse!(raw, model, tool_models)
      end

      def parse_retrieved_structured_outputs!(raw, model, tool_models)
        OpenAI::Helpers::StructuredOutput::ResponseParser.parse_retrieved!(raw, model, tool_models)
      end

      def get_structured_output_models(parsed)
        OpenAI::Helpers::StructuredOutput::ResponseParser.get_models(parsed)
      end

      def get_retrieval_structured_output_models(parsed)
        OpenAI::Helpers::StructuredOutput::ResponseParser.get_retrieval_models(parsed)
      end
    end
  end
end
