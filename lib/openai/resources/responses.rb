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
      # @overload create(input:, model:, include: nil, instructions: nil, max_output_tokens: nil, metadata: nil, parallel_tool_calls: nil, previous_response_id: nil, reasoning: nil, service_tier: nil, store: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
      #
      # @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ItemReference>] Text, image, or file inputs to the model, used to generate a response. ...
      #
      # @param model [String, Symbol, OpenAI::Models::ChatModel, OpenAI::Models::ResponsesModel::ResponsesOnlyModel] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI ...
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil] Specify additional output data to include in the model response. Currently ...
      #
      # @param instructions [String, nil] Inserts a system (or developer) message as the first item in the model's context
      # ...
      #
      # @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
      # ...
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
      #
      # @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel. ...
      #
      # @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to ...
      #
      # @param reasoning [OpenAI::Models::Reasoning, nil] **o-series models only** ...
      #
      # @param service_tier [Symbol, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier, nil] Specifies the latency tier to use for processing the request. This parameter is
      # ...
      #
      # @param store [Boolean, nil] Whether to store the generated model response for later retrieval via ...
      #
      # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
      # ...
      #
      # @param text [OpenAI::Models::Responses::ResponseTextConfig] Configuration options for a text response from the model. Can be plain ...
      #
      # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction] How the model should select which tool (or tools) to use when generating ...
      #
      # @param tools [Array<OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool>] An array of tools the model may call while generating a response. You ...
      #
      # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling, ...
      #
      # @param truncation [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil] The truncation strategy to use for the model response. ...
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      # ...
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Responses::Response]
      #
      # @see OpenAI::Models::Responses::ResponseCreateParams
      def create(params)
        parsed, options = OpenAI::Models::Responses::ResponseCreateParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#stream_raw` for the streaming use case."
          raise ArgumentError.new(message)
        end
        @client.request(
          method: :post,
          path: "responses",
          body: parsed,
          model: OpenAI::Models::Responses::Response,
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
      # @overload stream_raw(input:, model:, include: nil, instructions: nil, max_output_tokens: nil, metadata: nil, parallel_tool_calls: nil, previous_response_id: nil, reasoning: nil, service_tier: nil, store: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
      #
      # @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ItemReference>] Text, image, or file inputs to the model, used to generate a response. ...
      #
      # @param model [String, Symbol, OpenAI::Models::ChatModel, OpenAI::Models::ResponsesModel::ResponsesOnlyModel] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI ...
      #
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil] Specify additional output data to include in the model response. Currently ...
      #
      # @param instructions [String, nil] Inserts a system (or developer) message as the first item in the model's context
      # ...
      #
      # @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
      # ...
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
      #
      # @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel. ...
      #
      # @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to ...
      #
      # @param reasoning [OpenAI::Models::Reasoning, nil] **o-series models only** ...
      #
      # @param service_tier [Symbol, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier, nil] Specifies the latency tier to use for processing the request. This parameter is
      # ...
      #
      # @param store [Boolean, nil] Whether to store the generated model response for later retrieval via ...
      #
      # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
      # ...
      #
      # @param text [OpenAI::Models::Responses::ResponseTextConfig] Configuration options for a text response from the model. Can be plain ...
      #
      # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction] How the model should select which tool (or tools) to use when generating ...
      #
      # @param tools [Array<OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool>] An array of tools the model may call while generating a response. You ...
      #
      # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling, ...
      #
      # @param truncation [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil] The truncation strategy to use for the model response. ...
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      # ...
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Models::Responses::ResponseAudioDeltaEvent, OpenAI::Models::Responses::ResponseAudioDoneEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Responses::ResponseCompletedEvent, OpenAI::Models::Responses::ResponseContentPartAddedEvent, OpenAI::Models::Responses::ResponseContentPartDoneEvent, OpenAI::Models::Responses::ResponseCreatedEvent, OpenAI::Models::Responses::ResponseErrorEvent, OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseInProgressEvent, OpenAI::Models::Responses::ResponseFailedEvent, OpenAI::Models::Responses::ResponseIncompleteEvent, OpenAI::Models::Responses::ResponseOutputItemAddedEvent, OpenAI::Models::Responses::ResponseOutputItemDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Responses::ResponseRefusalDeltaEvent, OpenAI::Models::Responses::ResponseRefusalDoneEvent, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent, OpenAI::Models::Responses::ResponseTextDeltaEvent, OpenAI::Models::Responses::ResponseTextDoneEvent, OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent>]
      #
      # @see OpenAI::Models::Responses::ResponseCreateParams
      def stream_raw(params)
        parsed, options = OpenAI::Models::Responses::ResponseCreateParams.dump_request(params)
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
          model: OpenAI::Models::Responses::ResponseStreamEvent,
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
      # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Additional fields to include in the response. See the `include` ...
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Responses::Response]
      #
      # @see OpenAI::Models::Responses::ResponseRetrieveParams
      def retrieve(response_id, params = {})
        parsed, options = OpenAI::Models::Responses::ResponseRetrieveParams.dump_request(params)
        @client.request(
          method: :get,
          path: ["responses/%1$s", response_id],
          query: parsed,
          model: OpenAI::Models::Responses::Response,
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
