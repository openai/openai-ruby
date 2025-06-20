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
      # @overload create(background: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, reasoning: nil, service_tier: nil, store: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
      #
      # @param background [Boolean, nil] Whether to run the model response in the background.
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil] Specify additional output data to include in the model response. Currently
      #
      # @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>] Text, image, or file inputs to the model, used to generate a response.
      #
      # @param instructions [String, nil] A system (or developer) message inserted into the model's context.
      #
      # @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      # @param model [String, Symbol, OpenAI::Models::ChatModel, OpenAI::Models::ResponsesModel::ResponsesOnlyModel] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
      #
      # @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
      #
      # @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to
      #
      # @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
      #
      # @param reasoning [OpenAI::Models::Reasoning, nil] **o-series models only**
      #
      # @param service_tier [Symbol, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier, nil] Specifies the latency tier to use for processing the request. This parameter is
      #
      # @param store [Boolean, nil] Whether to store the generated model response for later retrieval via
      #
      # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
      #
      # @param text [OpenAI::Models::Responses::ResponseTextConfig] Configuration options for a text response from the model. Can be plain
      #
      # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction] How the model should select which tool (or tools) to use when generating
      #
      # @param tools [Array<OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::WebSearchTool>] An array of tools the model may call while generating a response. You
      #
      # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
      #
      # @param truncation [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil] The truncation strategy to use for the model response.
      #
      # @param user [String] A stable identifier for your end-users.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Responses::Response]
      #
      # @see OpenAI::Models::Responses::ResponseCreateParams
      def create(params = {})
        parsed, options = OpenAI::Responses::ResponseCreateParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#stream_raw` for the streaming use case."
          raise ArgumentError.new(message)
        end

        model = nil
        tool_models = {}
        case parsed
        in {text: OpenAI::StructuredOutput::JsonSchemaConverter => model}
          parsed.update(
            text: {
              format: {
                type: :json_schema,
                strict: true,
                name: model.name.split("::").last,
                schema: model.to_json_schema
              }
            }
          )
        in {text: {format: OpenAI::StructuredOutput::JsonSchemaConverter => model}}
          parsed.fetch(:text).update(
            format: {
              type: :json_schema,
              strict: true,
              name: model.name.split("::").last,
              schema: model.to_json_schema
            }
          )
        in {text: {format: {type: :json_schema, schema: OpenAI::StructuredOutput::JsonSchemaConverter => model}}}
          parsed.dig(:text, :format).store(:schema, model.to_json_schema)
        in {tools: Array => tools}
          mapped = tools.map do |tool|
            case tool
            in OpenAI::StructuredOutput::JsonSchemaConverter
              name = tool.name.split("::").last
              tool_models.store(name, tool)
              {
                type: :function,
                strict: true,
                name: name,
                parameters: tool.to_json_schema
              }
            in {type: :function, parameters: OpenAI::StructuredOutput::JsonSchemaConverter => params}
              func = tool.fetch(:function)
              name = func[:name] ||= params.name.split("::").last
              tool_models.store(name, params)
              func.update(parameters: params.to_json_schema)
              tool
            else
              tool
            end
          end
          tools.replace(mapped)
        else
        end

        unwrap = ->(raw) do
          if model.is_a?(OpenAI::StructuredOutput::JsonSchemaConverter)
            raw[:output]
              &.flat_map do |output|
                next [] unless output[:type] == "message"
                output[:content].to_a
              end
              &.each do |content|
                next unless content[:type] == "output_text"
                parsed = JSON.parse(content.fetch(:text), symbolize_names: true)
                coerced = OpenAI::Internal::Type::Converter.coerce(model, parsed)
                content.store(:parsed, coerced)
              end
          end
          raw[:output]&.each do |output|
            next unless output[:type] == "function_call"
            next if (model = tool_models[output.fetch(:name)]).nil?
            parsed = JSON.parse(output.fetch(:arguments), symbolize_names: true)
            coerced = OpenAI::Internal::Type::Converter.coerce(model, parsed)
            output.store(:parsed, coerced)
          end

          raw
        end
        @client.request(
          method: :post,
          path: "responses",
          body: parsed,
          unwrap: unwrap,
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
      # @overload stream_raw(background: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, reasoning: nil, service_tier: nil, store: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
      #
      # @param background [Boolean, nil] Whether to run the model response in the background.
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil] Specify additional output data to include in the model response. Currently
      #
      # @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>] Text, image, or file inputs to the model, used to generate a response.
      #
      # @param instructions [String, nil] A system (or developer) message inserted into the model's context.
      #
      # @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      # @param model [String, Symbol, OpenAI::Models::ChatModel, OpenAI::Models::ResponsesModel::ResponsesOnlyModel] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
      #
      # @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
      #
      # @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to
      #
      # @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
      #
      # @param reasoning [OpenAI::Models::Reasoning, nil] **o-series models only**
      #
      # @param service_tier [Symbol, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier, nil] Specifies the latency tier to use for processing the request. This parameter is
      #
      # @param store [Boolean, nil] Whether to store the generated model response for later retrieval via
      #
      # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
      #
      # @param text [OpenAI::Models::Responses::ResponseTextConfig] Configuration options for a text response from the model. Can be plain
      #
      # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction] How the model should select which tool (or tools) to use when generating
      #
      # @param tools [Array<OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::WebSearchTool>] An array of tools the model may call while generating a response. You
      #
      # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
      #
      # @param truncation [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil] The truncation strategy to use for the model response.
      #
      # @param user [String] A stable identifier for your end-users.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Models::Responses::ResponseAudioDeltaEvent, OpenAI::Models::Responses::ResponseAudioDoneEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Responses::ResponseCompletedEvent, OpenAI::Models::Responses::ResponseContentPartAddedEvent, OpenAI::Models::Responses::ResponseContentPartDoneEvent, OpenAI::Models::Responses::ResponseCreatedEvent, OpenAI::Models::Responses::ResponseErrorEvent, OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseInProgressEvent, OpenAI::Models::Responses::ResponseFailedEvent, OpenAI::Models::Responses::ResponseIncompleteEvent, OpenAI::Models::Responses::ResponseOutputItemAddedEvent, OpenAI::Models::Responses::ResponseOutputItemDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Responses::ResponseRefusalDeltaEvent, OpenAI::Models::Responses::ResponseRefusalDoneEvent, OpenAI::Models::Responses::ResponseTextDeltaEvent, OpenAI::Models::Responses::ResponseTextDoneEvent, OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseImageGenCallCompletedEvent, OpenAI::Models::Responses::ResponseImageGenCallGeneratingEvent, OpenAI::Models::Responses::ResponseImageGenCallInProgressEvent, OpenAI::Models::Responses::ResponseImageGenCallPartialImageEvent, OpenAI::Models::Responses::ResponseMcpCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseMcpCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseMcpCallCompletedEvent, OpenAI::Models::Responses::ResponseMcpCallFailedEvent, OpenAI::Models::Responses::ResponseMcpCallInProgressEvent, OpenAI::Models::Responses::ResponseMcpListToolsCompletedEvent, OpenAI::Models::Responses::ResponseMcpListToolsFailedEvent, OpenAI::Models::Responses::ResponseMcpListToolsInProgressEvent, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent, OpenAI::Models::Responses::ResponseQueuedEvent, OpenAI::Models::Responses::ResponseReasoningDeltaEvent, OpenAI::Models::Responses::ResponseReasoningDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryDeltaEvent, OpenAI::Models::Responses::ResponseReasoningSummaryDoneEvent>]
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
          headers: {"accept" => "text/event-stream"},
          body: parsed,
          stream: OpenAI::Internal::Stream,
          model: OpenAI::Responses::ResponseStreamEvent,
          options: options
        )
      end

      # See {OpenAI::Resources::Responses#retrieve_streaming} for streaming counterpart.
      #
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::Responses::ResponseRetrieveParams} for more details.
      #
      # Retrieves a model response with the given ID.
      #
      # @overload retrieve(response_id, include: nil, starting_after: nil, request_options: {})
      #
      # @param response_id [String] The ID of the response to retrieve.
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Additional fields to include in the response. See the `include`
      #
      # @param starting_after [Integer] The sequence number of the event after which to start streaming.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Responses::Response]
      #
      # @see OpenAI::Models::Responses::ResponseRetrieveParams
      def retrieve(response_id, params = {})
        parsed, options = OpenAI::Responses::ResponseRetrieveParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#retrieve_streaming` for the streaming use case."
          raise ArgumentError.new(message)
        end
        @client.request(
          method: :get,
          path: ["responses/%1$s", response_id],
          query: parsed,
          model: OpenAI::Responses::Response,
          options: options
        )
      end

      # See {OpenAI::Resources::Responses#retrieve} for non-streaming counterpart.
      #
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::Responses::ResponseRetrieveParams} for more details.
      #
      # Retrieves a model response with the given ID.
      #
      # @overload retrieve_streaming(response_id, include: nil, starting_after: nil, request_options: {})
      #
      # @param response_id [String] The ID of the response to retrieve.
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Additional fields to include in the response. See the `include`
      #
      # @param starting_after [Integer] The sequence number of the event after which to start streaming.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Models::Responses::ResponseAudioDeltaEvent, OpenAI::Models::Responses::ResponseAudioDoneEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Responses::ResponseCompletedEvent, OpenAI::Models::Responses::ResponseContentPartAddedEvent, OpenAI::Models::Responses::ResponseContentPartDoneEvent, OpenAI::Models::Responses::ResponseCreatedEvent, OpenAI::Models::Responses::ResponseErrorEvent, OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseInProgressEvent, OpenAI::Models::Responses::ResponseFailedEvent, OpenAI::Models::Responses::ResponseIncompleteEvent, OpenAI::Models::Responses::ResponseOutputItemAddedEvent, OpenAI::Models::Responses::ResponseOutputItemDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Responses::ResponseRefusalDeltaEvent, OpenAI::Models::Responses::ResponseRefusalDoneEvent, OpenAI::Models::Responses::ResponseTextDeltaEvent, OpenAI::Models::Responses::ResponseTextDoneEvent, OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseImageGenCallCompletedEvent, OpenAI::Models::Responses::ResponseImageGenCallGeneratingEvent, OpenAI::Models::Responses::ResponseImageGenCallInProgressEvent, OpenAI::Models::Responses::ResponseImageGenCallPartialImageEvent, OpenAI::Models::Responses::ResponseMcpCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseMcpCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseMcpCallCompletedEvent, OpenAI::Models::Responses::ResponseMcpCallFailedEvent, OpenAI::Models::Responses::ResponseMcpCallInProgressEvent, OpenAI::Models::Responses::ResponseMcpListToolsCompletedEvent, OpenAI::Models::Responses::ResponseMcpListToolsFailedEvent, OpenAI::Models::Responses::ResponseMcpListToolsInProgressEvent, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent, OpenAI::Models::Responses::ResponseQueuedEvent, OpenAI::Models::Responses::ResponseReasoningDeltaEvent, OpenAI::Models::Responses::ResponseReasoningDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryDeltaEvent, OpenAI::Models::Responses::ResponseReasoningSummaryDoneEvent>]
      #
      # @see OpenAI::Models::Responses::ResponseRetrieveParams
      def retrieve_streaming(response_id, params = {})
        parsed, options = OpenAI::Responses::ResponseRetrieveParams.dump_request(params)
        unless parsed.fetch(:stream, true)
          message = "Please use `#retrieve` for the non-streaming use case."
          raise ArgumentError.new(message)
        end
        parsed.store(:stream, true)
        @client.request(
          method: :get,
          path: ["responses/%1$s", response_id],
          query: parsed,
          headers: {"accept" => "text/event-stream"},
          stream: OpenAI::Internal::Stream,
          model: OpenAI::Responses::ResponseStreamEvent,
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
      # @return [OpenAI::Models::Responses::Response]
      #
      # @see OpenAI::Models::Responses::ResponseCancelParams
      def cancel(response_id, params = {})
        @client.request(
          method: :post,
          path: ["responses/%1$s/cancel", response_id],
          model: OpenAI::Responses::Response,
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
