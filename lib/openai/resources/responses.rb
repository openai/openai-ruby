# frozen_string_literal: true

module OpenAI
  module Resources
    class Responses
      # @return [OpenAI::Resources::Responses::InputItems]
      attr_reader :input_items

      # See {OpenAI::Resources::Responses#stream_raw} for streaming counterpart.
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
      # @overload create(input:, model:, background: nil, include: nil, instructions: nil, max_output_tokens: nil, metadata: nil, parallel_tool_calls: nil, previous_response_id: nil, reasoning: nil, service_tier: nil, store: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
      #
      # @param input [String, Array<OpenAI::Responses::EasyInputMessage, OpenAI::Responses::ResponseInputItem::Message, OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseFunctionToolCall, OpenAI::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Responses::ResponseReasoningItem, OpenAI::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseInputItem::LocalShellCall, OpenAI::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Responses::ResponseInputItem::McpListTools, OpenAI::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Responses::ResponseInputItem::McpCall, OpenAI::Responses::ResponseInputItem::ItemReference>] Text, image, or file inputs to the model, used to generate a response.
      #
      # @param model [String, Symbol, OpenAI::ChatModel, OpenAI::ResponsesModel::ResponsesOnlyModel] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
      #
      # @param background [Boolean, nil] Whether to run the model response in the background.
      #
      # @param include [Array<Symbol, OpenAI::Responses::ResponseIncludable>, nil] Specify additional output data to include in the model response. Currently
      #
      # @param instructions [String, nil] Inserts a system (or developer) message as the first item in the model's context
      #
      # @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      # @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
      #
      # @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to
      #
      # @param reasoning [OpenAI::Reasoning, nil] **o-series models only**
      #
      # @param service_tier [Symbol, OpenAI::Responses::ResponseCreateParams::ServiceTier, nil] Specifies the latency tier to use for processing the request. This parameter is
      #
      # @param store [Boolean, nil] Whether to store the generated model response for later retrieval via
      #
      # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
      #
      # @param text [OpenAI::Responses::ResponseTextConfig] Configuration options for a text response from the model. Can be plain
      #
      # @param tool_choice [Symbol, OpenAI::Responses::ToolChoiceOptions, OpenAI::Responses::ToolChoiceTypes, OpenAI::Responses::ToolChoiceFunction] How the model should select which tool (or tools) to use when generating
      #
      # @param tools [Array<OpenAI::Responses::FunctionTool, OpenAI::Responses::FileSearchTool, OpenAI::Responses::ComputerTool, OpenAI::Responses::Tool::Mcp, OpenAI::Responses::Tool::CodeInterpreter, OpenAI::Responses::Tool::ImageGeneration, OpenAI::Responses::Tool::LocalShell, OpenAI::Responses::WebSearchTool>] An array of tools the model may call while generating a response. You
      #
      # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
      #
      # @param truncation [Symbol, OpenAI::Responses::ResponseCreateParams::Truncation, nil] The truncation strategy to use for the model response.
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Responses::Response]
      #
      # @see OpenAI::Models::Responses::ResponseCreateParams
      def create(params)
        parsed, options = OpenAI::Responses::ResponseCreateParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#stream_raw` for the streaming use case."
          raise ArgumentError.new(message)
        end
        @client.request(
          method: :post,
          path: "responses",
          body: parsed,
          model: OpenAI::Responses::Response,
          options: options
        )
      end

      def stream
        raise NotImplementedError.new("higher level helpers are coming soon!")
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
      # @overload stream_raw(input:, model:, background: nil, include: nil, instructions: nil, max_output_tokens: nil, metadata: nil, parallel_tool_calls: nil, previous_response_id: nil, reasoning: nil, service_tier: nil, store: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
      #
      # @param input [String, Array<OpenAI::Responses::EasyInputMessage, OpenAI::Responses::ResponseInputItem::Message, OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseFunctionToolCall, OpenAI::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Responses::ResponseReasoningItem, OpenAI::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseInputItem::LocalShellCall, OpenAI::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Responses::ResponseInputItem::McpListTools, OpenAI::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Responses::ResponseInputItem::McpCall, OpenAI::Responses::ResponseInputItem::ItemReference>] Text, image, or file inputs to the model, used to generate a response.
      #
      # @param model [String, Symbol, OpenAI::ChatModel, OpenAI::ResponsesModel::ResponsesOnlyModel] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
      #
      # @param background [Boolean, nil] Whether to run the model response in the background.
      #
      # @param include [Array<Symbol, OpenAI::Responses::ResponseIncludable>, nil] Specify additional output data to include in the model response. Currently
      #
      # @param instructions [String, nil] Inserts a system (or developer) message as the first item in the model's context
      #
      # @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      # @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
      #
      # @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to
      #
      # @param reasoning [OpenAI::Reasoning, nil] **o-series models only**
      #
      # @param service_tier [Symbol, OpenAI::Responses::ResponseCreateParams::ServiceTier, nil] Specifies the latency tier to use for processing the request. This parameter is
      #
      # @param store [Boolean, nil] Whether to store the generated model response for later retrieval via
      #
      # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
      #
      # @param text [OpenAI::Responses::ResponseTextConfig] Configuration options for a text response from the model. Can be plain
      #
      # @param tool_choice [Symbol, OpenAI::Responses::ToolChoiceOptions, OpenAI::Responses::ToolChoiceTypes, OpenAI::Responses::ToolChoiceFunction] How the model should select which tool (or tools) to use when generating
      #
      # @param tools [Array<OpenAI::Responses::FunctionTool, OpenAI::Responses::FileSearchTool, OpenAI::Responses::ComputerTool, OpenAI::Responses::Tool::Mcp, OpenAI::Responses::Tool::CodeInterpreter, OpenAI::Responses::Tool::ImageGeneration, OpenAI::Responses::Tool::LocalShell, OpenAI::Responses::WebSearchTool>] An array of tools the model may call while generating a response. You
      #
      # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
      #
      # @param truncation [Symbol, OpenAI::Responses::ResponseCreateParams::Truncation, nil] The truncation strategy to use for the model response.
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Responses::ResponseAudioDeltaEvent, OpenAI::Responses::ResponseAudioDoneEvent, OpenAI::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Responses::ResponseCompletedEvent, OpenAI::Responses::ResponseContentPartAddedEvent, OpenAI::Responses::ResponseContentPartDoneEvent, OpenAI::Responses::ResponseCreatedEvent, OpenAI::Responses::ResponseErrorEvent, OpenAI::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Responses::ResponseInProgressEvent, OpenAI::Responses::ResponseFailedEvent, OpenAI::Responses::ResponseIncompleteEvent, OpenAI::Responses::ResponseOutputItemAddedEvent, OpenAI::Responses::ResponseOutputItemDoneEvent, OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent, OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent, OpenAI::Responses::ResponseReasoningSummaryTextDeltaEvent, OpenAI::Responses::ResponseReasoningSummaryTextDoneEvent, OpenAI::Responses::ResponseRefusalDeltaEvent, OpenAI::Responses::ResponseRefusalDoneEvent, OpenAI::Responses::ResponseTextAnnotationDeltaEvent, OpenAI::Responses::ResponseTextDeltaEvent, OpenAI::Responses::ResponseTextDoneEvent, OpenAI::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Responses::ResponseWebSearchCallSearchingEvent, OpenAI::Responses::ResponseImageGenCallCompletedEvent, OpenAI::Responses::ResponseImageGenCallGeneratingEvent, OpenAI::Responses::ResponseImageGenCallInProgressEvent, OpenAI::Responses::ResponseImageGenCallPartialImageEvent, OpenAI::Responses::ResponseMcpCallArgumentsDeltaEvent, OpenAI::Responses::ResponseMcpCallArgumentsDoneEvent, OpenAI::Responses::ResponseMcpCallCompletedEvent, OpenAI::Responses::ResponseMcpCallFailedEvent, OpenAI::Responses::ResponseMcpCallInProgressEvent, OpenAI::Responses::ResponseMcpListToolsCompletedEvent, OpenAI::Responses::ResponseMcpListToolsFailedEvent, OpenAI::Responses::ResponseMcpListToolsInProgressEvent, OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent, OpenAI::Responses::ResponseQueuedEvent, OpenAI::Responses::ResponseReasoningDeltaEvent, OpenAI::Responses::ResponseReasoningDoneEvent, OpenAI::Responses::ResponseReasoningSummaryDeltaEvent, OpenAI::Responses::ResponseReasoningSummaryDoneEvent>]
      #
      # @see OpenAI::Models::Responses::ResponseCreateParams
      def stream_raw(params)
        parsed, options = OpenAI::Responses::ResponseCreateParams.dump_request(params)
        unless parsed.fetch(:stream, true)
          message = "Please use `#create` for the non-streaming use case."
          raise ArgumentError.new(message)
        end
        parsed.store(:stream, true)
        @client.request(
          method: :post,
          path: "responses",
          headers: {"accept" => "text/event-stream"},
          body: parsed,
          stream: OpenAI::Internal::Stream,
          model: OpenAI::Responses::ResponseStreamEvent,
          options: options
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::Responses::ResponseRetrieveParams} for more details.
      #
      # Retrieves a model response with the given ID.
      #
      # @overload retrieve(response_id, include: nil, request_options: {})
      #
      # @param response_id [String] The ID of the response to retrieve.
      #
      # @param include [Array<Symbol, OpenAI::Responses::ResponseIncludable>] Additional fields to include in the response. See the `include`
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Responses::Response]
      #
      # @see OpenAI::Models::Responses::ResponseRetrieveParams
      def retrieve(response_id, params = {})
        parsed, options = OpenAI::Responses::ResponseRetrieveParams.dump_request(params)
        @client.request(
          method: :get,
          path: ["responses/%1$s", response_id],
          query: parsed,
          model: OpenAI::Responses::Response,
          options: options
        )
      end

      # Deletes a model response with the given ID.
      #
      # @overload delete(response_id, request_options: {})
      #
      # @param response_id [String] The ID of the response to delete.
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
          options: params[:request_options]
        )
      end

      # Cancels a model response with the given ID. Only responses created with the
      # `background` parameter set to `true` can be cancelled.
      # [Learn more](https://platform.openai.com/docs/guides/background).
      #
      # @overload cancel(response_id, request_options: {})
      #
      # @param response_id [String] The ID of the response to cancel.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [nil]
      #
      # @see OpenAI::Models::Responses::ResponseCancelParams
      def cancel(response_id, params = {})
        @client.request(
          method: :post,
          path: ["responses/%1$s/cancel", response_id],
          model: NilClass,
          options: params[:request_options]
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @input_items = OpenAI::Resources::Responses::InputItems.new(client: client)
      end
    end
  end
end
