# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Client events accepted by the Responses WebSocket server.
      module BetaResponsesClientEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Client event for creating a response over a persistent WebSocket connection.
        # This payload uses the same top-level fields as `POST /v1/responses`.
        #
        # Notes:
        # - `stream` is implicit over WebSocket and should not be sent.
        # - `background` is not supported over WebSocket.
        variant :"response.create", -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate }

        # Injects input items into an active response over a WebSocket connection.
        # The items are validated and committed atomically. Currently, the server
        # accepts client-owned tool outputs that resume a waiting agent.
        variant :"response.inject", -> { OpenAI::Beta::BetaResponseInjectEvent }

        class ResponseCreate < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the client event. Always `response.create`.
          #
          #   @return [Symbol, :"response.create"]
          required :type, const: :"response.create"

          # @!attribute background
          #   Whether to run the model response in the background.
          #   [Learn more](https://platform.openai.com/docs/guides/background).
          #
          #   @return [Boolean, nil]
          optional :background, OpenAI::Internal::Type::Boolean, nil?: true

          # @!attribute context_management
          #   Context management configuration for this request.
          #
          #   @return [Array<OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::ContextManagement>, nil]
          optional :context_management,
                   -> {
                     OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::ContextManagement]
                   },
                   nil?: true

          # @!attribute conversation
          #   The conversation that this response belongs to. Items from this conversation are
          #   prepended to `input_items` for this response request. Input items and output
          #   items from this response are automatically added to this conversation after this
          #   response completes.
          #
          #   @return [String, OpenAI::Models::Beta::BetaResponseConversationParam, nil]
          optional :conversation,
                   union: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Conversation },
                   nil?: true

          # @!attribute include
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
          #   @return [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>, nil]
          optional :include,
                   -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::BetaResponseIncludable] },
                   nil?: true

          # @!attribute input
          #   Text, image, or file inputs to the model, used to generate a response.
          #
          #   Learn more:
          #
          #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
          #   - [Image inputs](https://platform.openai.com/docs/guides/images)
          #   - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
          #   - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
          #   - [Function calling](https://platform.openai.com/docs/guides/function-calling)
          #
          #   @return [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>, nil]
          optional :input, union: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Input }

          # @!attribute instructions
          #   A system (or developer) message inserted into the model's context.
          #
          #   When using along with `previous_response_id`, the instructions from a previous
          #   response will not be carried over to the next response. This makes it simple to
          #   swap out system (or developer) messages in new responses.
          #
          #   @return [String, nil]
          optional :instructions, String, nil?: true

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

          # @!attribute metadata
          #   Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!attribute model
          #   Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
          #   wide range of models with different capabilities, performance characteristics,
          #   and price points. Refer to the
          #   [model guide](https://platform.openai.com/docs/models) to browse and compare
          #   available models.
          #
          #   @return [Symbol, String, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model, nil]
          optional :model, union: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Model }

          # @!attribute moderation
          #   Configuration for running moderation on the input and output of this response.
          #
          #   @return [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation, nil]
          optional :moderation,
                   -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation },
                   nil?: true

          # @!attribute multi_agent
          #   Configuration for server-hosted multi-agent execution.
          #
          #   @return [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::MultiAgent, nil]
          optional :multi_agent,
                   -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::MultiAgent },
                   nil?: true

          # @!attribute parallel_tool_calls
          #   Whether to allow the model to run tool calls in parallel.
          #
          #   @return [Boolean, nil]
          optional :parallel_tool_calls, OpenAI::Internal::Type::Boolean, nil?: true

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
          #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
          #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
          #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
          #   request can write up to four breakpoints. For cache matching, OpenAI considers
          #   up to the latest 80 breakpoints in the conversation, without a content-block
          #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
          #   `ttl` defaults to `30m`, which is currently the only supported value. See the
          #   [prompt caching guide](https://platform.openai.com/docs/guides/prompt-caching)
          #   for current details.
          #
          #   @return [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions, nil]
          optional :prompt_cache_options,
                   -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions }

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
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheRetention, nil]
          optional :prompt_cache_retention,
                   enum: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheRetention },
                   nil?: true

          # @!attribute reasoning
          #   **gpt-5 and o-series models only**
          #
          #   Configuration options for
          #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
          #
          #   @return [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning, nil]
          optional :reasoning,
                   -> {
                     OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning
                   },
                   nil?: true

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
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::ServiceTier, nil]
          optional :service_tier,
                   enum: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::ServiceTier },
                   nil?: true

          # @!attribute store
          #   Whether to store the generated model response for later retrieval via API.
          #
          #   @return [Boolean, nil]
          optional :store, OpenAI::Internal::Type::Boolean, nil?: true

          # @!attribute stream
          #   If set to true, the model response data will be streamed to the client as it is
          #   generated using
          #   [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format).
          #   See the
          #   [Streaming section below](https://platform.openai.com/docs/api-reference/responses-streaming)
          #   for more information.
          #
          #   @return [Boolean, nil]
          optional :stream, OpenAI::Internal::Type::Boolean, nil?: true

          # @!attribute stream_options
          #   Options for streaming responses. Only set this when you set `stream: true`.
          #
          #   @return [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::StreamOptions, nil]
          optional :stream_options,
                   -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::StreamOptions },
                   nil?: true

          # @!attribute temperature
          #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          #   make the output more random, while lower values like 0.2 will make it more
          #   focused and deterministic. We generally recommend altering this or `top_p` but
          #   not both.
          #
          #   @return [Float, nil]
          optional :temperature, Float, nil?: true

          # @!attribute text
          #   Configuration options for a text response from the model. Can be plain text or
          #   structured JSON data. Learn more:
          #
          #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
          #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
          #
          #   @return [OpenAI::Models::Beta::BetaResponseTextConfig, nil]
          optional :text, -> { OpenAI::Beta::BetaResponseTextConfig }

          # @!attribute tool_choice
          #   How the model should select which tool (or tools) to use when generating a
          #   response. See the `tools` parameter to see how to specify which tools the model
          #   can call.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell, nil]
          optional :tool_choice, union: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::ToolChoice }

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
          #   @return [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>, nil]
          optional :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaTool] }

          # @!attribute top_logprobs
          #   An integer between 0 and 20 specifying the maximum number of most likely tokens
          #   to return at each token position, each with an associated log probability. In
          #   some cases, the number of returned tokens may be fewer than requested.
          #
          #   @return [Integer, nil]
          optional :top_logprobs, Integer, nil?: true

          # @!attribute top_p
          #   An alternative to sampling with temperature, called nucleus sampling, where the
          #   model considers the results of the tokens with top_p probability mass. So 0.1
          #   means only the tokens comprising the top 10% probability mass are considered.
          #
          #   We generally recommend altering this or `temperature` but not both.
          #
          #   @return [Float, nil]
          optional :top_p, Float, nil?: true

          # @!attribute truncation
          #   @deprecated
          #
          #   The truncation strategy to use for the model response.
          #
          #   - `auto`: If the input to this Response exceeds the model's context window size,
          #     the model will truncate the response to fit the context window by dropping
          #     items from the beginning of the conversation.
          #   - `disabled` (default): If the input size will exceed the context window size
          #     for a model, the request will fail with a 400 error.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Truncation, nil]
          optional :truncation,
                   enum: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Truncation },
                   nil?: true

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

          # @!method initialize(background: nil, context_management: nil, conversation: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, max_tool_calls: nil, metadata: nil, model: nil, moderation: nil, multi_agent: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning: nil, safety_identifier: nil, service_tier: nil, store: nil, stream: nil, stream_options: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, truncation: nil, user: nil, type: :"response.create")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate} for more
          #   details.
          #
          #   Client event for creating a response over a persistent WebSocket connection.
          #   This payload uses the same top-level fields as `POST /v1/responses`.
          #
          #   Notes:
          #
          #   - `stream` is implicit over WebSocket and should not be sent.
          #   - `background` is not supported over WebSocket.
          #
          #   @param background [Boolean, nil] Whether to run the model response in the background.
          #
          #   @param context_management [Array<OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::ContextManagement>, nil] Context management configuration for this request.
          #
          #   @param conversation [String, OpenAI::Models::Beta::BetaResponseConversationParam, nil] The conversation that this response belongs to. Items from this conversation are
          #
          #   @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>, nil] Specify additional output data to include in the model response. Currently suppo
          #
          #   @param input [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>] Text, image, or file inputs to the model, used to generate a response.
          #
          #   @param instructions [String, nil] A system (or developer) message inserted into the model's context.
          #
          #   @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
          #
          #   @param max_tool_calls [Integer, nil] The maximum number of total calls to built-in tools that can be processed in a r
          #
          #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
          #
          #   @param model [Symbol, String, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
          #
          #   @param moderation [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation, nil] Configuration for running moderation on the input and output of this response.
          #
          #   @param multi_agent [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::MultiAgent, nil] Configuration for server-hosted multi-agent execution.
          #
          #   @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
          #
          #   @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to
          #
          #   @param prompt [OpenAI::Models::Beta::BetaResponsePrompt, nil] Reference to a prompt template and its variables.
          #
          #   @param prompt_cache_key [String] Used by OpenAI to cache responses for similar requests to optimize your cache hi
          #
          #   @param prompt_cache_options [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions] Options for prompt caching. Supported for `gpt-5.6` and later models. By default
          #
          #   @param prompt_cache_retention [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheRetention, nil] Deprecated. Use `prompt_cache_options.ttl` instead.
          #
          #   @param reasoning [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning, nil] **gpt-5 and o-series models only**
          #
          #   @param safety_identifier [String] A stable identifier used to help detect users of your application that may be vi
          #
          #   @param service_tier [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::ServiceTier, nil] Specifies the processing type used for serving the request.
          #
          #   @param store [Boolean, nil] Whether to store the generated model response for later retrieval via
          #
          #   @param stream [Boolean, nil] If set to true, the model response data will be streamed to the client
          #
          #   @param stream_options [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::StreamOptions, nil] Options for streaming responses. Only set this when you set `stream: true`.
          #
          #   @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
          #
          #   @param text [OpenAI::Models::Beta::BetaResponseTextConfig] Configuration options for a text response from the model. Can be plain
          #
          #   @param tool_choice [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell] How the model should select which tool (or tools) to use when generating
          #
          #   @param tools [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>] An array of tools the model may call while generating a response. You
          #
          #   @param top_logprobs [Integer, nil] An integer between 0 and 20 specifying the maximum number of most likely
          #
          #   @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
          #
          #   @param truncation [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Truncation, nil] The truncation strategy to use for the model response.
          #
          #   @param user [String] This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
          #
          #   @param type [Symbol, :"response.create"] The type of the client event. Always `response.create`.

          class ContextManagement < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The context management entry type. Currently only 'compaction' is supported.
            #
            #   @return [String]
            required :type, String

            # @!attribute compact_threshold
            #   Token threshold at which compaction should be triggered for this entry.
            #
            #   @return [Integer, nil]
            optional :compact_threshold, Integer, nil?: true

            # @!method initialize(type:, compact_threshold: nil)
            #   @param type [String] The context management entry type. Currently only 'compaction' is supported.
            #
            #   @param compact_threshold [Integer, nil] Token threshold at which compaction should be triggered for this entry.
          end

          # The conversation that this response belongs to. Items from this conversation are
          # prepended to `input_items` for this response request. Input items and output
          # items from this response are automatically added to this conversation after this
          # response completes.
          #
          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#conversation
          module Conversation
            extend OpenAI::Internal::Type::Union

            # The unique ID of the conversation.
            variant String

            # The conversation that this response belongs to.
            variant -> { OpenAI::Beta::BetaResponseConversationParam }

            # @!method self.variants
            #   @return [Array(String, OpenAI::Models::Beta::BetaResponseConversationParam)]
          end

          # Text, image, or file inputs to the model, used to generate a response.
          #
          # Learn more:
          #
          # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
          # - [Image inputs](https://platform.openai.com/docs/guides/images)
          # - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
          # - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
          # - [Function calling](https://platform.openai.com/docs/guides/function-calling)
          #
          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#input
          module Input
            extend OpenAI::Internal::Type::Union

            # A text input to the model, equivalent to a text input with the
            # `user` role.
            variant String

            # A list of one or many input items to the model, containing
            # different content types.
            variant -> { OpenAI::Beta::BetaResponseInput }

            # @!method self.variants
            #   @return [Array(String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>)]
          end

          # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
          # wide range of models with different capabilities, performance characteristics,
          # and price points. Refer to the
          # [model guide](https://platform.openai.com/docs/models) to browse and compare
          # available models.
          #
          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#model
          module Model
            extend OpenAI::Internal::Type::Union

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_6_SOL }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_6_TERRA }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_6_LUNA }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_4 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_4_MINI }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_4_NANO }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_4_MINI_2026_03_17 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_4_NANO_2026_03_17 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_3_CHAT_LATEST }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_2 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_2_2025_12_11 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_2_CHAT_LATEST }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_2_PRO }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_2_PRO_2025_12_11 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_1 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_1_2025_11_13 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_1_CODEX }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_1_MINI }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_1_CHAT_LATEST }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_MINI }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_NANO }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_2025_08_07 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_MINI_2025_08_07 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_NANO_2025_08_07 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_CHAT_LATEST }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_1 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_1_MINI }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_1_NANO }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_1_2025_04_14 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_1_MINI_2025_04_14 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_1_NANO_2025_04_14 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O4_MINI }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O4_MINI_2025_04_16 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O3 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O3_2025_04_16 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O3_MINI }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O3_MINI_2025_01_31 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O1 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O1_2024_12_17 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O1_PREVIEW }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O1_PREVIEW_2024_09_12 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O1_MINI }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O1_MINI_2024_09_12 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_2024_11_20 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_2024_08_06 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_2024_05_13 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_AUDIO_PREVIEW }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_AUDIO_PREVIEW_2024_10_01 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_AUDIO_PREVIEW_2024_12_17 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_AUDIO_PREVIEW_2025_06_03 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_MINI_AUDIO_PREVIEW }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_MINI_AUDIO_PREVIEW_2024_12_17 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_SEARCH_PREVIEW }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_MINI_SEARCH_PREVIEW }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_SEARCH_PREVIEW_2025_03_11 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_MINI_SEARCH_PREVIEW_2025_03_11 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::CHATGPT_4O_LATEST }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::CODEX_MINI_LATEST }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_MINI }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4O_MINI_2024_07_18 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_TURBO }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_TURBO_2024_04_09 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_0125_PREVIEW }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_TURBO_PREVIEW }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_1106_PREVIEW }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_VISION_PREVIEW }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_0314 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_0613 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_32K }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_32K_0314 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_4_32K_0613 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_3_5_TURBO }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_3_5_TURBO_16K }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_3_5_TURBO_0301 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_3_5_TURBO_0613 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_3_5_TURBO_1106 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_3_5_TURBO_0125 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_3_5_TURBO_16K_0613 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O1_PRO }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O1_PRO_2025_03_19 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O3_PRO }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O3_PRO_2025_06_10 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O3_DEEP_RESEARCH }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O3_DEEP_RESEARCH_2025_06_26 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O4_MINI_DEEP_RESEARCH }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::O4_MINI_DEEP_RESEARCH_2025_06_26 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::COMPUTER_USE_PREVIEW }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::COMPUTER_USE_PREVIEW_2025_03_11 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_CODEX }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_PRO }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_PRO_2025_10_06 }

            variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Model::GPT_5_1_CODEX_MAX }

            variant String

            # @!method self.variants
            #   @return [Array(Symbol, String)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { T.any(OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Model::TaggedSymbol, String) }
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

          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#moderation
          class Moderation < OpenAI::Internal::Type::BaseModel
            # @!attribute model
            #   The moderation model to use for moderated completions, e.g.
            #   'omni-moderation-latest'.
            #
            #   @return [String]
            required :model, String

            # @!attribute policy
            #   The policy to apply to moderated response input and output.
            #
            #   @return [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy, nil]
            optional :policy,
                     -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy },
                     nil?: true

            # @!method initialize(model:, policy: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation} for
            #   more details.
            #
            #   Configuration for running moderation on the input and output of this response.
            #
            #   @param model [String] The moderation model to use for moderated completions, e.g. 'omni-moderation-lat
            #
            #   @param policy [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy, nil] The policy to apply to moderated response input and output.

            # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation#policy
            class Policy < OpenAI::Internal::Type::BaseModel
              # @!attribute input
              #   The moderation policy for the response input.
              #
              #   @return [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Input, nil]
              optional :input,
                       -> {
                         OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Input
                       },
                       nil?: true

              # @!attribute output
              #   The moderation policy for the response output.
              #
              #   @return [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Output, nil]
              optional :output,
                       -> {
                         OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Output
                       },
                       nil?: true

              # @!method initialize(input: nil, output: nil)
              #   The policy to apply to moderated response input and output.
              #
              #   @param input [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Input, nil] The moderation policy for the response input.
              #
              #   @param output [OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Output, nil] The moderation policy for the response output.

              # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy#input
              class Input < OpenAI::Internal::Type::BaseModel
                # @!attribute mode
                #
                #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Input::Mode]
                required :mode,
                         enum: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Input::Mode }

                # @!method initialize(mode:)
                #   The moderation policy for the response input.
                #
                #   @param mode [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Input::Mode]

                # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Input#mode
                module Mode
                  extend OpenAI::Internal::Type::Enum

                  SCORE = :score
                  BLOCK = :block

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end

              # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy#output
              class Output < OpenAI::Internal::Type::BaseModel
                # @!attribute mode
                #
                #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Output::Mode]
                required :mode,
                         enum: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Output::Mode }

                # @!method initialize(mode:)
                #   The moderation policy for the response output.
                #
                #   @param mode [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Output::Mode]

                # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Moderation::Policy::Output#mode
                module Mode
                  extend OpenAI::Internal::Type::Enum

                  SCORE = :score
                  BLOCK = :block

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end
            end
          end

          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#multi_agent
          class MultiAgent < OpenAI::Internal::Type::BaseModel
            # @!attribute enabled
            #   Whether to enable server-hosted multi-agent execution for this response.
            #
            #   @return [Boolean]
            required :enabled, OpenAI::Internal::Type::Boolean

            # @!attribute max_concurrent_subagents
            #   `max_concurrent_subagents` sets the maximum number of subagents that can be
            #   active simultaneously across the entire agent tree. It includes all
            #   descendants—children, grandchildren, and deeper subagents—but excludes the root
            #   agent. The API does not impose a fixed upper bound on this setting. The default
            #   is `3`, which is recommended for most workloads. Multi-agent runs also have no
            #   fixed limit on tree depth or the total number of subagents created during a run.
            #
            #   @return [Integer, nil]
            optional :max_concurrent_subagents, Integer

            # @!method initialize(enabled:, max_concurrent_subagents: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::MultiAgent} for
            #   more details.
            #
            #   Configuration for server-hosted multi-agent execution.
            #
            #   @param enabled [Boolean] Whether to enable server-hosted multi-agent execution for this response.
            #
            #   @param max_concurrent_subagents [Integer] `max_concurrent_subagents` sets the maximum number of subagents that can be acti
          end

          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#prompt_cache_options
          class PromptCacheOptions < OpenAI::Internal::Type::BaseModel
            # @!attribute mode
            #   Controls whether OpenAI automatically creates an implicit cache breakpoint.
            #   Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
            #   and writes up to the latest three explicit breakpoints in the request. With
            #   `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
            #   latest four explicit breakpoints. If there are no explicit breakpoints, the
            #   request does not use prompt caching.
            #
            #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions::Mode, nil]
            optional :mode,
                     enum: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions::Mode }

            # @!attribute ttl
            #   The minimum lifetime applied to every implicit and explicit cache breakpoint
            #   written by the request. Defaults to `30m`, which is currently the only supported
            #   value. The backend may retain cache entries for longer.
            #
            #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions::Ttl, nil]
            optional :ttl,
                     enum: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions::Ttl }

            # @!method initialize(mode: nil, ttl: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions}
            #   for more details.
            #
            #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
            #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
            #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
            #   request can write up to four breakpoints. For cache matching, OpenAI considers
            #   up to the latest 80 breakpoints in the conversation, without a content-block
            #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
            #   `ttl` defaults to `30m`, which is currently the only supported value. See the
            #   [prompt caching guide](https://platform.openai.com/docs/guides/prompt-caching)
            #   for current details.
            #
            #   @param mode [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions::Mode] Controls whether OpenAI automatically creates an implicit cache breakpoint. Defa
            #
            #   @param ttl [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions::Ttl] The minimum lifetime applied to every implicit and explicit cache breakpoint wri

            # Controls whether OpenAI automatically creates an implicit cache breakpoint.
            # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
            # and writes up to the latest three explicit breakpoints in the request. With
            # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
            # latest four explicit breakpoints. If there are no explicit breakpoints, the
            # request does not use prompt caching.
            #
            # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions#mode
            module Mode
              extend OpenAI::Internal::Type::Enum

              IMPLICIT = :implicit
              EXPLICIT = :explicit

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # The minimum lifetime applied to every implicit and explicit cache breakpoint
            # written by the request. Defaults to `30m`, which is currently the only supported
            # value. The backend may retain cache entries for longer.
            #
            # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::PromptCacheOptions#ttl
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
          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#prompt_cache_retention
          module PromptCacheRetention
            extend OpenAI::Internal::Type::Enum

            IN_MEMORY = :in_memory
            PROMPT_CACHE_RETENTION_24H = :"24h"

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#reasoning
          class Reasoning < OpenAI::Internal::Type::BaseModel
            # @!attribute context
            #   Controls which reasoning items are rendered back to the model on later turns.
            #   When returned on a response, this is the effective reasoning context mode used
            #   for the response.
            #
            #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Context, nil]
            optional :context,
                     enum: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Context },
                     nil?: true

            # @!attribute effort
            #   Constrains effort on reasoning for reasoning models. Currently supported values
            #   are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
            #   reasoning effort can result in faster responses and fewer tokens used on
            #   reasoning in a response. Not all reasoning models support every value. See the
            #   [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
            #   model-specific support.
            #
            #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Effort, nil]
            optional :effort,
                     enum: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Effort },
                     nil?: true

            # @!attribute generate_summary
            #   @deprecated
            #
            #   **Deprecated:** use `summary` instead.
            #
            #   A summary of the reasoning performed by the model. This can be useful for
            #   debugging and understanding the model's reasoning process. One of `auto`,
            #   `concise`, or `detailed`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::GenerateSummary, nil]
            optional :generate_summary,
                     enum: -> {
                       OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::GenerateSummary
                     },
                     nil?: true

            # @!attribute mode
            #   Controls the reasoning execution mode for the request.
            #
            #   When returned on a response, this is the effective execution mode.
            #
            #   @return [String, Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Mode, nil]
            optional :mode, union: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Mode }

            # @!attribute summary
            #   A summary of the reasoning performed by the model. This can be useful for
            #   debugging and understanding the model's reasoning process. One of `auto`,
            #   `concise`, or `detailed`.
            #
            #   `concise` is supported for `computer-use-preview` models and all reasoning
            #   models after `gpt-5`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Summary, nil]
            optional :summary,
                     enum: -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Summary },
                     nil?: true

            # @!method initialize(context: nil, effort: nil, generate_summary: nil, mode: nil, summary: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning} for
            #   more details.
            #
            #   **gpt-5 and o-series models only**
            #
            #   Configuration options for
            #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
            #
            #   @param context [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Context, nil] Controls which reasoning items are rendered back to the model on later turns.
            #
            #   @param effort [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Effort, nil] Constrains effort on reasoning for reasoning models. Currently supported
            #
            #   @param generate_summary [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::GenerateSummary, nil] **Deprecated:** use `summary` instead.
            #
            #   @param mode [String, Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Mode] Controls the reasoning execution mode for the request.
            #
            #   @param summary [Symbol, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Summary, nil] A summary of the reasoning performed by the model. This can be

            # Controls which reasoning items are rendered back to the model on later turns.
            # When returned on a response, this is the effective reasoning context mode used
            # for the response.
            #
            # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning#context
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
            # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning#effort
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
            # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning#generate_summary
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
            # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning#mode
            module Mode
              extend OpenAI::Internal::Type::Union

              variant String

              variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Mode::STANDARD }

              variant const: -> { OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Mode::PRO }

              # @!method self.variants
              #   @return [Array(String, Symbol)]

              define_sorbet_constant!(:Variants) do
                T.type_alias { T.any(String, OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning::Mode::TaggedSymbol) }
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
            # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::Reasoning#summary
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
          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#service_tier
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

          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#stream_options
          class StreamOptions < OpenAI::Internal::Type::BaseModel
            # @!attribute include_obfuscation
            #   When true, stream obfuscation will be enabled. Stream obfuscation adds random
            #   characters to an `obfuscation` field on streaming delta events to normalize
            #   payload sizes as a mitigation to certain side-channel attacks. These obfuscation
            #   fields are included by default, but add a small amount of overhead to the data
            #   stream. You can set `include_obfuscation` to false to optimize for bandwidth if
            #   you trust the network links between your application and the OpenAI API.
            #
            #   @return [Boolean, nil]
            optional :include_obfuscation, OpenAI::Internal::Type::Boolean

            # @!method initialize(include_obfuscation: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::StreamOptions}
            #   for more details.
            #
            #   Options for streaming responses. Only set this when you set `stream: true`.
            #
            #   @param include_obfuscation [Boolean] When true, stream obfuscation will be enabled. Stream obfuscation adds
          end

          # How the model should select which tool (or tools) to use when generating a
          # response. See the `tools` parameter to see how to specify which tools the model
          # can call.
          #
          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#tool_choice
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

            variant -> { OpenAI::Beta::BetaResponsesClientEvent::ResponseCreate::ToolChoice::BetaSpecificProgrammaticToolCallingParam }

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
            #   @return [Array(Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell)]
          end

          # @deprecated
          #
          # The truncation strategy to use for the model response.
          #
          # - `auto`: If the input to this Response exceeds the model's context window size,
          #   the model will truncate the response to fit the context window by dropping
          #   items from the beginning of the conversation.
          # - `disabled` (default): If the input size will exceed the context window size
          #   for a model, the request will fail with a 400 error.
          #
          # @see OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate#truncation
          module Truncation
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            DISABLED = :disabled

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::BetaResponsesClientEvent::ResponseCreate, OpenAI::Models::Beta::BetaResponseInjectEvent)]
      end
    end

    BetaResponsesClientEvent = Beta::BetaResponsesClientEvent
  end
end
