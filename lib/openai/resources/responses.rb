# frozen_string_literal: true

module OpenAI
  module Resources
    class Responses
      # @return [OpenAI::Resources::Responses::InputItems]
      attr_reader :input_items

      # Creates a model response. Provide
      #   [text](https://platform.openai.com/docs/guides/text) or
      #   [image](https://platform.openai.com/docs/guides/images) inputs to generate
      #   [text](https://platform.openai.com/docs/guides/text) or
      #   [JSON](https://platform.openai.com/docs/guides/structured-outputs) outputs. Have
      #   the model call your own
      #   [custom code](https://platform.openai.com/docs/guides/function-calling) or use
      #   built-in [tools](https://platform.openai.com/docs/guides/tools) like
      #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
      #   [file search](https://platform.openai.com/docs/guides/tools-file-search) to use
      #   your own data as input for the model's response.
      #
      # @param params [OpenAI::Models::Responses::ResponseCreateParams, Hash{Symbol=>Object}] .
      #
      #   @option params [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ItemReference>] :input Text, image, or file inputs to the model, used to generate a response.
      #
      #     Learn more:
      #
      #     - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
      #     - [Image inputs](https://platform.openai.com/docs/guides/images)
      #     - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
      #     - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
      #     - [Function calling](https://platform.openai.com/docs/guides/function-calling)
      #
      #   @option params [String, Symbol, OpenAI::Models::ChatModel] :model Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
      #     wide range of models with different capabilities, performance characteristics,
      #     and price points. Refer to the
      #     [model guide](https://platform.openai.com/docs/models) to browse and compare
      #     available models.
      #
      #   @option params [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil] :include Specify additional output data to include in the model response. Currently
      #     supported values are:
      #
      #     - `file_search_call.results`: Include the search results of the file search tool
      #       call.
      #     - `message.input_image.image_url`: Include image urls from the input message.
      #     - `computer_call_output.output.image_url`: Include image urls from the computer
      #       call output.
      #
      #   @option params [String, nil] :instructions Inserts a system (or developer) message as the first item in the model's
      #     context.
      #
      #     When using along with `previous_response_id`, the instructions from a previous
      #     response will not be carried over to the next response. This makes it simple to
      #     swap out system (or developer) messages in new responses.
      #
      #   @option params [Integer, nil] :max_output_tokens An upper bound for the number of tokens that can be generated for a response,
      #     including visible output tokens and
      #     [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
      #
      #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
      #     for storing additional information about the object in a structured format, and
      #     querying for objects via API or the dashboard.
      #
      #     Keys are strings with a maximum length of 64 characters. Values are strings with
      #     a maximum length of 512 characters.
      #
      #   @option params [Boolean, nil] :parallel_tool_calls Whether to allow the model to run tool calls in parallel.
      #
      #   @option params [String, nil] :previous_response_id The unique ID of the previous response to the model. Use this to create
      #     multi-turn conversations. Learn more about
      #     [conversation state](https://platform.openai.com/docs/guides/conversation-state).
      #
      #   @option params [OpenAI::Models::Reasoning, nil] :reasoning **o-series models only**
      #
      #     Configuration options for
      #     [reasoning models](https://platform.openai.com/docs/guides/reasoning).
      #
      #   @option params [Boolean, nil] :store Whether to store the generated model response for later retrieval via API.
      #
      #   @option params [Float, nil] :temperature What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
      #     make the output more random, while lower values like 0.2 will make it more
      #     focused and deterministic. We generally recommend altering this or `top_p` but
      #     not both.
      #
      #   @option params [OpenAI::Models::Responses::ResponseTextConfig] :text Configuration options for a text response from the model. Can be plain text or
      #     structured JSON data. Learn more:
      #
      #     - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
      #     - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
      #
      #   @option params [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction] :tool_choice How the model should select which tool (or tools) to use when generating a
      #     response. See the `tools` parameter to see how to specify which tools the model
      #     can call.
      #
      #   @option params [Array<OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool>] :tools An array of tools the model may call while generating a response. You can
      #     specify which tool to use by setting the `tool_choice` parameter.
      #
      #     The two categories of tools you can provide the model are:
      #
      #     - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
      #       capabilities, like
      #       [web search](https://platform.openai.com/docs/guides/tools-web-search) or
      #       [file search](https://platform.openai.com/docs/guides/tools-file-search).
      #       Learn more about
      #       [built-in tools](https://platform.openai.com/docs/guides/tools).
      #     - **Function calls (custom tools)**: Functions that are defined by you, enabling
      #       the model to call your own code. Learn more about
      #       [function calling](https://platform.openai.com/docs/guides/function-calling).
      #
      #   @option params [Float, nil] :top_p An alternative to sampling with temperature, called nucleus sampling, where the
      #     model considers the results of the tokens with top_p probability mass. So 0.1
      #     means only the tokens comprising the top 10% probability mass are considered.
      #
      #     We generally recommend altering this or `temperature` but not both.
      #
      #   @option params [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil] :truncation The truncation strategy to use for the model response.
      #
      #     - `auto`: If the context of this response and previous ones exceeds the model's
      #       context window size, the model will truncate the response to fit the context
      #       window by dropping input items in the middle of the conversation.
      #     - `disabled` (default): If a model response will exceed the context window size
      #       for a model, the request will fail with a 400 error.
      #
      #   @option params [String] :user A unique identifier representing your end-user, which can help OpenAI to monitor
      #     and detect abuse.
      #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::Responses::Response]
      def create(params)
        parsed, options = OpenAI::Models::Responses::ResponseCreateParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#create_streaming` for the streaming use case."
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

      # Creates a model response. Provide
      #   [text](https://platform.openai.com/docs/guides/text) or
      #   [image](https://platform.openai.com/docs/guides/images) inputs to generate
      #   [text](https://platform.openai.com/docs/guides/text) or
      #   [JSON](https://platform.openai.com/docs/guides/structured-outputs) outputs. Have
      #   the model call your own
      #   [custom code](https://platform.openai.com/docs/guides/function-calling) or use
      #   built-in [tools](https://platform.openai.com/docs/guides/tools) like
      #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
      #   [file search](https://platform.openai.com/docs/guides/tools-file-search) to use
      #   your own data as input for the model's response.
      #
      # @param params [OpenAI::Models::Responses::ResponseCreateParams, Hash{Symbol=>Object}] .
      #
      #   @option params [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ItemReference>] :input Text, image, or file inputs to the model, used to generate a response.
      #
      #     Learn more:
      #
      #     - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
      #     - [Image inputs](https://platform.openai.com/docs/guides/images)
      #     - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
      #     - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
      #     - [Function calling](https://platform.openai.com/docs/guides/function-calling)
      #
      #   @option params [String, Symbol, OpenAI::Models::ChatModel] :model Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
      #     wide range of models with different capabilities, performance characteristics,
      #     and price points. Refer to the
      #     [model guide](https://platform.openai.com/docs/models) to browse and compare
      #     available models.
      #
      #   @option params [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil] :include Specify additional output data to include in the model response. Currently
      #     supported values are:
      #
      #     - `file_search_call.results`: Include the search results of the file search tool
      #       call.
      #     - `message.input_image.image_url`: Include image urls from the input message.
      #     - `computer_call_output.output.image_url`: Include image urls from the computer
      #       call output.
      #
      #   @option params [String, nil] :instructions Inserts a system (or developer) message as the first item in the model's
      #     context.
      #
      #     When using along with `previous_response_id`, the instructions from a previous
      #     response will not be carried over to the next response. This makes it simple to
      #     swap out system (or developer) messages in new responses.
      #
      #   @option params [Integer, nil] :max_output_tokens An upper bound for the number of tokens that can be generated for a response,
      #     including visible output tokens and
      #     [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
      #
      #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
      #     for storing additional information about the object in a structured format, and
      #     querying for objects via API or the dashboard.
      #
      #     Keys are strings with a maximum length of 64 characters. Values are strings with
      #     a maximum length of 512 characters.
      #
      #   @option params [Boolean, nil] :parallel_tool_calls Whether to allow the model to run tool calls in parallel.
      #
      #   @option params [String, nil] :previous_response_id The unique ID of the previous response to the model. Use this to create
      #     multi-turn conversations. Learn more about
      #     [conversation state](https://platform.openai.com/docs/guides/conversation-state).
      #
      #   @option params [OpenAI::Models::Reasoning, nil] :reasoning **o-series models only**
      #
      #     Configuration options for
      #     [reasoning models](https://platform.openai.com/docs/guides/reasoning).
      #
      #   @option params [Boolean, nil] :store Whether to store the generated model response for later retrieval via API.
      #
      #   @option params [Float, nil] :temperature What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
      #     make the output more random, while lower values like 0.2 will make it more
      #     focused and deterministic. We generally recommend altering this or `top_p` but
      #     not both.
      #
      #   @option params [OpenAI::Models::Responses::ResponseTextConfig] :text Configuration options for a text response from the model. Can be plain text or
      #     structured JSON data. Learn more:
      #
      #     - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
      #     - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
      #
      #   @option params [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction] :tool_choice How the model should select which tool (or tools) to use when generating a
      #     response. See the `tools` parameter to see how to specify which tools the model
      #     can call.
      #
      #   @option params [Array<OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool>] :tools An array of tools the model may call while generating a response. You can
      #     specify which tool to use by setting the `tool_choice` parameter.
      #
      #     The two categories of tools you can provide the model are:
      #
      #     - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
      #       capabilities, like
      #       [web search](https://platform.openai.com/docs/guides/tools-web-search) or
      #       [file search](https://platform.openai.com/docs/guides/tools-file-search).
      #       Learn more about
      #       [built-in tools](https://platform.openai.com/docs/guides/tools).
      #     - **Function calls (custom tools)**: Functions that are defined by you, enabling
      #       the model to call your own code. Learn more about
      #       [function calling](https://platform.openai.com/docs/guides/function-calling).
      #
      #   @option params [Float, nil] :top_p An alternative to sampling with temperature, called nucleus sampling, where the
      #     model considers the results of the tokens with top_p probability mass. So 0.1
      #     means only the tokens comprising the top 10% probability mass are considered.
      #
      #     We generally recommend altering this or `temperature` but not both.
      #
      #   @option params [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil] :truncation The truncation strategy to use for the model response.
      #
      #     - `auto`: If the context of this response and previous ones exceeds the model's
      #       context window size, the model will truncate the response to fit the context
      #       window by dropping input items in the middle of the conversation.
      #     - `disabled` (default): If a model response will exceed the context window size
      #       for a model, the request will fail with a 400 error.
      #
      #   @option params [String] :user A unique identifier representing your end-user, which can help OpenAI to monitor
      #     and detect abuse.
      #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Stream<OpenAI::Models::Responses::ResponseAudioDeltaEvent, OpenAI::Models::Responses::ResponseAudioDoneEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Responses::ResponseCompletedEvent, OpenAI::Models::Responses::ResponseContentPartAddedEvent, OpenAI::Models::Responses::ResponseContentPartDoneEvent, OpenAI::Models::Responses::ResponseCreatedEvent, OpenAI::Models::Responses::ResponseErrorEvent, OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseInProgressEvent, OpenAI::Models::Responses::ResponseFailedEvent, OpenAI::Models::Responses::ResponseIncompleteEvent, OpenAI::Models::Responses::ResponseOutputItemAddedEvent, OpenAI::Models::Responses::ResponseOutputItemDoneEvent, OpenAI::Models::Responses::ResponseRefusalDeltaEvent, OpenAI::Models::Responses::ResponseRefusalDoneEvent, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent, OpenAI::Models::Responses::ResponseTextDeltaEvent, OpenAI::Models::Responses::ResponseTextDoneEvent, OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent>]
      def create_streaming(params)
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
          stream: OpenAI::Stream,
          model: OpenAI::Models::Responses::ResponseStreamEvent,
          options: options
        )
      end

      # Retrieves a model response with the given ID.
      #
      # @param response_id [String] The ID of the response to retrieve.
      #
      # @param params [OpenAI::Models::Responses::ResponseRetrieveParams, Hash{Symbol=>Object}] .
      #
      #   @option params [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] :include Additional fields to include in the response. See the `include` parameter for
      #     Response creation above for more information.
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::Responses::Response]
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
      # @param response_id [String] The ID of the response to delete.
      #
      # @param params [OpenAI::Models::Responses::ResponseDeleteParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [nil]
      def delete(response_id, params = {})
        @client.request(
          method: :delete,
          path: ["responses/%1$s", response_id],
          model: NilClass,
          options: params[:request_options]
        )
      end

      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @input_items = OpenAI::Resources::Responses::InputItems.new(client: client)
      end
    end
  end
end
