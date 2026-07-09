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
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::ResponseCreateParams} for more details.
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
        # @overload create(background: nil, context_management: nil, conversation: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, max_tool_calls: nil, metadata: nil, model: nil, moderation: nil, multi_agent: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning: nil, safety_identifier: nil, service_tier: nil, store: nil, stream_options: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, truncation: nil, user: nil, betas: nil, request_options: {})
        #
        # @param background [Boolean, nil] Body param: Whether to run the model response in the background.
        #
        # @param context_management [Array<OpenAI::Models::Beta::ResponseCreateParams::ContextManagement>, nil] Body param: Context management configuration for this request.
        #
        # @param conversation [String, OpenAI::Models::Beta::BetaResponseConversationParam, nil] Body param: The conversation that this response belongs to. Items from this conv
        #
        # @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>, nil] Body param: Specify additional output data to include in the model response. Cur
        #
        # @param input [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>] Body param: Text, image, or file inputs to the model, used to generate a respons
        #
        # @param instructions [String, nil] Body param: A system (or developer) message inserted into the model's context.
        #
        # @param max_output_tokens [Integer, nil] Body param: An upper bound for the number of tokens that can be generated for a
        #
        # @param max_tool_calls [Integer, nil] Body param: The maximum number of total calls to built-in tools that can be proc
        #
        # @param metadata [Hash{Symbol=>String}, nil] Body param: Set of 16 key-value pairs that can be attached to an object. This ca
        #
        # @param model [Symbol, String, OpenAI::Models::Beta::ResponseCreateParams::Model] Body param: Model ID used to generate the response, like `gpt-4o` or `o3`. OpenA
        #
        # @param moderation [OpenAI::Models::Beta::ResponseCreateParams::Moderation, nil] Body param: Configuration for running moderation on the input and output of this
        #
        # @param multi_agent [OpenAI::Models::Beta::ResponseCreateParams::MultiAgent, nil] Body param: Configuration for server-hosted multi-agent execution.
        #
        # @param parallel_tool_calls [Boolean, nil] Body param: Whether to allow the model to run tool calls in parallel.
        #
        # @param previous_response_id [String, nil] Body param: The unique ID of the previous response to the model. Use this to
        #
        # @param prompt [OpenAI::Models::Beta::BetaResponsePrompt, nil] Body param: Reference to a prompt template and its variables.
        #
        # @param prompt_cache_key [String] Body param: Used by OpenAI to cache responses for similar requests to optimize y
        #
        # @param prompt_cache_options [OpenAI::Models::Beta::ResponseCreateParams::PromptCacheOptions] Body param: Options for prompt caching. Supported for `gpt-5.6` and later models
        #
        # @param prompt_cache_retention [Symbol, OpenAI::Models::Beta::ResponseCreateParams::PromptCacheRetention, nil] Body param: Deprecated. Use `prompt_cache_options.ttl` instead.
        #
        # @param reasoning [OpenAI::Models::Beta::ResponseCreateParams::Reasoning, nil] Body param: **gpt-5 and o-series models only**
        #
        # @param safety_identifier [String] Body param: A stable identifier used to help detect users of your application th
        #
        # @param service_tier [Symbol, OpenAI::Models::Beta::ResponseCreateParams::ServiceTier, nil] Body param: Specifies the processing type used for serving the request.
        #
        # @param store [Boolean, nil] Body param: Whether to store the generated model response for later retrieval vi
        #
        # @param stream_options [OpenAI::Models::Beta::ResponseCreateParams::StreamOptions, nil] Body param: Options for streaming responses. Only set this when you set `stream:
        #
        # @param temperature [Float, nil] Body param: What sampling temperature to use, between 0 and 2. Higher values lik
        #
        # @param text [OpenAI::Models::Beta::BetaResponseTextConfig] Body param: Configuration options for a text response from the model. Can be pla
        #
        # @param tool_choice [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::ResponseCreateParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell] Body param: How the model should select which tool (or tools) to use when genera
        #
        # @param tools [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>] Body param: An array of tools the model may call while generating a response. Yo
        #
        # @param top_logprobs [Integer, nil] Body param: An integer between 0 and 20 specifying the maximum number of most li
        #
        # @param top_p [Float, nil] Body param: An alternative to sampling with temperature, called nucleus sampling
        #
        # @param truncation [Symbol, OpenAI::Models::Beta::ResponseCreateParams::Truncation, nil] Body param: The truncation strategy to use for the model response.
        #
        # @param user [String] Body param: This field is being replaced by `safety_identifier` and `prompt_cach
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseCreateParams::Beta>] Header param: Optional beta features to enable for this request.
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
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::ResponseCreateParams} for more details.
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
        # @overload stream_raw(background: nil, context_management: nil, conversation: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, max_tool_calls: nil, metadata: nil, model: nil, moderation: nil, multi_agent: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning: nil, safety_identifier: nil, service_tier: nil, store: nil, stream_options: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, truncation: nil, user: nil, betas: nil, request_options: {})
        #
        # @param background [Boolean, nil] Body param: Whether to run the model response in the background.
        #
        # @param context_management [Array<OpenAI::Models::Beta::ResponseCreateParams::ContextManagement>, nil] Body param: Context management configuration for this request.
        #
        # @param conversation [String, OpenAI::Models::Beta::BetaResponseConversationParam, nil] Body param: The conversation that this response belongs to. Items from this conv
        #
        # @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>, nil] Body param: Specify additional output data to include in the model response. Cur
        #
        # @param input [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>] Body param: Text, image, or file inputs to the model, used to generate a respons
        #
        # @param instructions [String, nil] Body param: A system (or developer) message inserted into the model's context.
        #
        # @param max_output_tokens [Integer, nil] Body param: An upper bound for the number of tokens that can be generated for a
        #
        # @param max_tool_calls [Integer, nil] Body param: The maximum number of total calls to built-in tools that can be proc
        #
        # @param metadata [Hash{Symbol=>String}, nil] Body param: Set of 16 key-value pairs that can be attached to an object. This ca
        #
        # @param model [Symbol, String, OpenAI::Models::Beta::ResponseCreateParams::Model] Body param: Model ID used to generate the response, like `gpt-4o` or `o3`. OpenA
        #
        # @param moderation [OpenAI::Models::Beta::ResponseCreateParams::Moderation, nil] Body param: Configuration for running moderation on the input and output of this
        #
        # @param multi_agent [OpenAI::Models::Beta::ResponseCreateParams::MultiAgent, nil] Body param: Configuration for server-hosted multi-agent execution.
        #
        # @param parallel_tool_calls [Boolean, nil] Body param: Whether to allow the model to run tool calls in parallel.
        #
        # @param previous_response_id [String, nil] Body param: The unique ID of the previous response to the model. Use this to
        #
        # @param prompt [OpenAI::Models::Beta::BetaResponsePrompt, nil] Body param: Reference to a prompt template and its variables.
        #
        # @param prompt_cache_key [String] Body param: Used by OpenAI to cache responses for similar requests to optimize y
        #
        # @param prompt_cache_options [OpenAI::Models::Beta::ResponseCreateParams::PromptCacheOptions] Body param: Options for prompt caching. Supported for `gpt-5.6` and later models
        #
        # @param prompt_cache_retention [Symbol, OpenAI::Models::Beta::ResponseCreateParams::PromptCacheRetention, nil] Body param: Deprecated. Use `prompt_cache_options.ttl` instead.
        #
        # @param reasoning [OpenAI::Models::Beta::ResponseCreateParams::Reasoning, nil] Body param: **gpt-5 and o-series models only**
        #
        # @param safety_identifier [String] Body param: A stable identifier used to help detect users of your application th
        #
        # @param service_tier [Symbol, OpenAI::Models::Beta::ResponseCreateParams::ServiceTier, nil] Body param: Specifies the processing type used for serving the request.
        #
        # @param store [Boolean, nil] Body param: Whether to store the generated model response for later retrieval vi
        #
        # @param stream_options [OpenAI::Models::Beta::ResponseCreateParams::StreamOptions, nil] Body param: Options for streaming responses. Only set this when you set `stream:
        #
        # @param temperature [Float, nil] Body param: What sampling temperature to use, between 0 and 2. Higher values lik
        #
        # @param text [OpenAI::Models::Beta::BetaResponseTextConfig] Body param: Configuration options for a text response from the model. Can be pla
        #
        # @param tool_choice [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::ResponseCreateParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell] Body param: How the model should select which tool (or tools) to use when genera
        #
        # @param tools [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>] Body param: An array of tools the model may call while generating a response. Yo
        #
        # @param top_logprobs [Integer, nil] Body param: An integer between 0 and 20 specifying the maximum number of most li
        #
        # @param top_p [Float, nil] Body param: An alternative to sampling with temperature, called nucleus sampling
        #
        # @param truncation [Symbol, OpenAI::Models::Beta::ResponseCreateParams::Truncation, nil] Body param: The truncation strategy to use for the model response.
        #
        # @param user [String] Body param: This field is being replaced by `safety_identifier` and `prompt_cach
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseCreateParams::Beta>] Header param: Optional beta features to enable for this request.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::BetaResponseAudioDeltaEvent, OpenAI::Models::Beta::BetaResponseAudioDoneEvent, OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent, OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Beta::BetaResponseCompletedEvent, OpenAI::Models::Beta::BetaResponseContentPartAddedEvent, OpenAI::Models::Beta::BetaResponseContentPartDoneEvent, OpenAI::Models::Beta::BetaResponseCreatedEvent, OpenAI::Models::Beta::BetaResponseErrorEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallCompletedEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallSearchingEvent, OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Beta::BetaResponseInProgressEvent, OpenAI::Models::Beta::BetaResponseFailedEvent, OpenAI::Models::Beta::BetaResponseIncompleteEvent, OpenAI::Models::Beta::BetaResponseOutputItemAddedEvent, OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent, OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent, OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent, OpenAI::Models::Beta::BetaResponseRefusalDoneEvent, OpenAI::Models::Beta::BetaResponseTextDeltaEvent, OpenAI::Models::Beta::BetaResponseTextDoneEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallCompletedEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallSearchingEvent, OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent, OpenAI::Models::Beta::BetaResponseImageGenCallGeneratingEvent, OpenAI::Models::Beta::BetaResponseImageGenCallInProgressEvent, OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent, OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent, OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent, OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent, OpenAI::Models::Beta::BetaResponseMcpCallFailedEvent, OpenAI::Models::Beta::BetaResponseMcpCallInProgressEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsInProgressEvent, OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent, OpenAI::Models::Beta::BetaResponseQueuedEvent, OpenAI::Models::Beta::BetaResponseCustomToolCallInputDeltaEvent, OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent>]
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
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::ResponseRetrieveParams} for more details.
        #
        # Retrieves a model response with the given ID.
        #
        # @overload retrieve(response_id, include: nil, include_obfuscation: nil, starting_after: nil, betas: nil, request_options: {})
        #
        # @param response_id [String] Path param: The ID of the response to retrieve.
        #
        # @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>] Query param: Additional fields to include in the response. See the `include`
        #
        # @param include_obfuscation [Boolean] Query param: When true, stream obfuscation will be enabled. Stream obfuscation a
        #
        # @param starting_after [Integer] Query param: The sequence number of the event after which to start streaming.
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseRetrieveParams::Beta>] Header param: Optional beta features to enable for this request.
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
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::ResponseRetrieveParams} for more details.
        #
        # Retrieves a model response with the given ID.
        #
        # @overload retrieve_streaming(response_id, include: nil, include_obfuscation: nil, starting_after: nil, betas: nil, request_options: {})
        #
        # @param response_id [String] Path param: The ID of the response to retrieve.
        #
        # @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>] Query param: Additional fields to include in the response. See the `include`
        #
        # @param include_obfuscation [Boolean] Query param: When true, stream obfuscation will be enabled. Stream obfuscation a
        #
        # @param starting_after [Integer] Query param: The sequence number of the event after which to start streaming.
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseRetrieveParams::Beta>] Header param: Optional beta features to enable for this request.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::BetaResponseAudioDeltaEvent, OpenAI::Models::Beta::BetaResponseAudioDoneEvent, OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent, OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Beta::BetaResponseCompletedEvent, OpenAI::Models::Beta::BetaResponseContentPartAddedEvent, OpenAI::Models::Beta::BetaResponseContentPartDoneEvent, OpenAI::Models::Beta::BetaResponseCreatedEvent, OpenAI::Models::Beta::BetaResponseErrorEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallCompletedEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallSearchingEvent, OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Beta::BetaResponseInProgressEvent, OpenAI::Models::Beta::BetaResponseFailedEvent, OpenAI::Models::Beta::BetaResponseIncompleteEvent, OpenAI::Models::Beta::BetaResponseOutputItemAddedEvent, OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent, OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent, OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent, OpenAI::Models::Beta::BetaResponseRefusalDoneEvent, OpenAI::Models::Beta::BetaResponseTextDeltaEvent, OpenAI::Models::Beta::BetaResponseTextDoneEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallCompletedEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallSearchingEvent, OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent, OpenAI::Models::Beta::BetaResponseImageGenCallGeneratingEvent, OpenAI::Models::Beta::BetaResponseImageGenCallInProgressEvent, OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent, OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent, OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent, OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent, OpenAI::Models::Beta::BetaResponseMcpCallFailedEvent, OpenAI::Models::Beta::BetaResponseMcpCallInProgressEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsInProgressEvent, OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent, OpenAI::Models::Beta::BetaResponseQueuedEvent, OpenAI::Models::Beta::BetaResponseCustomToolCallInputDeltaEvent, OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent>]
        #
        # @see OpenAI::Models::Beta::ResponseRetrieveParams
        def retrieve_streaming(response_id, params = {})
          query_params = [:include, :include_obfuscation, :starting_after, :stream]
          parsed, options = OpenAI::Beta::ResponseRetrieveParams.dump_request(params)
          query = OpenAI::Internal::Util.encode_query_params(parsed.slice(*query_params))
          unless parsed.fetch(:stream, true)
            message = "Please use `#retrieve` for the non-streaming use case."
            raise ArgumentError.new(message)
          end
          parsed.store(:stream, true)
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
        # @param response_id [String] The ID of the response to delete.
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseDeleteParams::Beta>] Optional beta features to enable for this request.
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
        # [Learn more](https://platform.openai.com/docs/guides/background).
        #
        # @overload cancel(response_id, betas: nil, request_options: {})
        #
        # @param response_id [String] The ID of the response to cancel.
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseCancelParams::Beta>] Optional beta features to enable for this request.
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

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::ResponseCompactParams} for more details.
        #
        # Compact a conversation. Returns a compacted response object.
        #
        # Learn when and how to compact long-running conversations in the
        # [conversation state guide](https://platform.openai.com/docs/guides/conversation-state#managing-the-context-window).
        # For ZDR-compatible compaction details, see
        # [Compaction (advanced)](https://platform.openai.com/docs/guides/conversation-state#compaction-advanced).
        #
        # @overload compact(model:, input: nil, instructions: nil, previous_response_id: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, service_tier: nil, betas: nil, request_options: {})
        #
        # @param model [Symbol, String, OpenAI::Models::Beta::ResponseCompactParams::Model, nil] Body param: Model ID used to generate the response, like `gpt-5` or `o3`. OpenAI
        #
        # @param input [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>, nil] Body param: Text, image, or file inputs to the model, used to generate a respons
        #
        # @param instructions [String, nil] Body param: A system (or developer) message inserted into the model's context.
        #
        # @param previous_response_id [String, nil] Body param: The unique ID of the previous response to the model. Use this to cre
        #
        # @param prompt_cache_key [String, nil] Body param: A key to use when reading from or writing to the prompt cache.
        #
        # @param prompt_cache_options [OpenAI::Models::Beta::ResponseCompactParams::PromptCacheOptions, nil] Body param: Options for prompt caching. Supported for `gpt-5.6` and later models
        #
        # @param prompt_cache_retention [Symbol, OpenAI::Models::Beta::ResponseCompactParams::PromptCacheRetention, nil] Body param: How long to retain a prompt cache entry created by this request.
        #
        # @param service_tier [Symbol, OpenAI::Models::Beta::ResponseCompactParams::ServiceTier, nil] Body param: The service tier to use for this request.
        #
        # @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseCompactParams::Beta>] Header param: Optional beta features to enable for this request.
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
