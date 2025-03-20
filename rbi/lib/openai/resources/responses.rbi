# typed: strong

module OpenAI
  module Resources
    class Responses
      sig { returns(OpenAI::Resources::Responses::InputItems) }
      def input_items
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
      sig do
        params(
          input: T.any(
            String,
            T::Array[
            T.any(
              OpenAI::Models::Responses::EasyInputMessage,
              OpenAI::Models::Responses::ResponseInputItem::Message,
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput,
              OpenAI::Models::Responses::ResponseReasoningItem,
              OpenAI::Models::Responses::ResponseInputItem::ItemReference
            )
            ]
          ),
          model: T.any(String, OpenAI::Models::ChatModel::OrSymbol, OpenAI::Models::ResponsesModel::UnionMember2::OrSymbol),
          include: T.nilable(T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol]),
          instructions: T.nilable(String),
          max_output_tokens: T.nilable(Integer),
          metadata: T.nilable(T::Hash[Symbol, String]),
          parallel_tool_calls: T.nilable(T::Boolean),
          previous_response_id: T.nilable(String),
          reasoning: T.nilable(OpenAI::Models::Reasoning),
          store: T.nilable(T::Boolean),
          temperature: T.nilable(Float),
          text: OpenAI::Models::Responses::ResponseTextConfig,
          tool_choice: T.any(
            OpenAI::Models::Responses::ToolChoiceOptions::OrSymbol,
            OpenAI::Models::Responses::ToolChoiceTypes,
            OpenAI::Models::Responses::ToolChoiceFunction
          ),
          tools: T::Array[
          T.any(
            OpenAI::Models::Responses::FileSearchTool,
            OpenAI::Models::Responses::FunctionTool,
            OpenAI::Models::Responses::ComputerTool,
            OpenAI::Models::Responses::WebSearchTool
          )
          ],
          top_p: T.nilable(Float),
          truncation: T.nilable(OpenAI::Models::Responses::ResponseCreateParams::Truncation::OrSymbol),
          user: String,
          stream: T.noreturn,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Responses::Response)
      end
      def create(
        # Text, image, or file inputs to the model, used to generate a response.
        #
        #   Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Image inputs](https://platform.openai.com/docs/guides/images)
        #   - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        #   - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        #   - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        input:,
        # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        model:,
        # Specify additional output data to include in the model response. Currently
        #   supported values are:
        #
        #   - `file_search_call.results`: Include the search results of the file search tool
        #     call.
        #   - `message.input_image.image_url`: Include image urls from the input message.
        #   - `computer_call_output.output.image_url`: Include image urls from the computer
        #     call output.
        include: nil,
        # Inserts a system (or developer) message as the first item in the model's
        #   context.
        #
        #   When using along with `previous_response_id`, the instructions from a previous
        #   response will be not be carried over to the next response. This makes it simple
        #   to swap out system (or developer) messages in new responses.
        instructions: nil,
        # An upper bound for the number of tokens that can be generated for a response,
        #   including visible output tokens and
        #   [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        max_output_tokens: nil,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        metadata: nil,
        # Whether to allow the model to run tool calls in parallel.
        parallel_tool_calls: nil,
        # The unique ID of the previous response to the model. Use this to create
        #   multi-turn conversations. Learn more about
        #   [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        previous_response_id: nil,
        # **o-series models only**
        #
        #   Configuration options for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        reasoning: nil,
        # Whether to store the generated model response for later retrieval via API.
        store: nil,
        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic. We generally recommend altering this or `top_p` but
        #   not both.
        temperature: nil,
        # Configuration options for a text response from the model. Can be plain text or
        #   structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        text: nil,
        # How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        tool_choice: nil,
        # An array of tools the model may call while generating a response. You can
        #   specify which tool to use by setting the `tool_choice` parameter.
        #
        #   The two categories of tools you can provide the model are:
        #
        #   - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #     capabilities, like
        #     [web search](https://platform.openai.com/docs/guides/tools-web-search) or
        #     [file search](https://platform.openai.com/docs/guides/tools-file-search).
        #     Learn more about
        #     [built-in tools](https://platform.openai.com/docs/guides/tools).
        #   - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #     the model to call your own code. Learn more about
        #     [function calling](https://platform.openai.com/docs/guides/function-calling).
        tools: nil,
        # An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        top_p: nil,
        # The truncation strategy to use for the model response.
        #
        #   - `auto`: If the context of this response and previous ones exceeds the model's
        #     context window size, the model will truncate the response to fit the context
        #     window by dropping input items in the middle of the conversation.
        #   - `disabled` (default): If a model response will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        truncation: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        #   and detect abuse.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        # There is no need to provide `stream:`. Instead, use `#create_streaming` or
        #   `#create` for streaming and non-streaming use cases, respectively.
        stream: false,
        request_options: {}
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
      sig do
        params(
          input: T.any(
            String,
            T::Array[
            T.any(
              OpenAI::Models::Responses::EasyInputMessage,
              OpenAI::Models::Responses::ResponseInputItem::Message,
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput,
              OpenAI::Models::Responses::ResponseReasoningItem,
              OpenAI::Models::Responses::ResponseInputItem::ItemReference
            )
            ]
          ),
          model: T.any(String, OpenAI::Models::ChatModel::OrSymbol, OpenAI::Models::ResponsesModel::UnionMember2::OrSymbol),
          include: T.nilable(T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol]),
          instructions: T.nilable(String),
          max_output_tokens: T.nilable(Integer),
          metadata: T.nilable(T::Hash[Symbol, String]),
          parallel_tool_calls: T.nilable(T::Boolean),
          previous_response_id: T.nilable(String),
          reasoning: T.nilable(OpenAI::Models::Reasoning),
          store: T.nilable(T::Boolean),
          temperature: T.nilable(Float),
          text: OpenAI::Models::Responses::ResponseTextConfig,
          tool_choice: T.any(
            OpenAI::Models::Responses::ToolChoiceOptions::OrSymbol,
            OpenAI::Models::Responses::ToolChoiceTypes,
            OpenAI::Models::Responses::ToolChoiceFunction
          ),
          tools: T::Array[
          T.any(
            OpenAI::Models::Responses::FileSearchTool,
            OpenAI::Models::Responses::FunctionTool,
            OpenAI::Models::Responses::ComputerTool,
            OpenAI::Models::Responses::WebSearchTool
          )
          ],
          top_p: T.nilable(Float),
          truncation: T.nilable(OpenAI::Models::Responses::ResponseCreateParams::Truncation::OrSymbol),
          user: String,
          stream: T.noreturn,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(
            OpenAI::Stream[
            T.any(
              OpenAI::Models::Responses::ResponseAudioDeltaEvent,
              OpenAI::Models::Responses::ResponseAudioDoneEvent,
              OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent,
              OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent,
              OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent,
              OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent,
              OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent,
              OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent,
              OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent,
              OpenAI::Models::Responses::ResponseCompletedEvent,
              OpenAI::Models::Responses::ResponseContentPartAddedEvent,
              OpenAI::Models::Responses::ResponseContentPartDoneEvent,
              OpenAI::Models::Responses::ResponseCreatedEvent,
              OpenAI::Models::Responses::ResponseErrorEvent,
              OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent,
              OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent,
              OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent,
              OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent,
              OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent,
              OpenAI::Models::Responses::ResponseInProgressEvent,
              OpenAI::Models::Responses::ResponseFailedEvent,
              OpenAI::Models::Responses::ResponseIncompleteEvent,
              OpenAI::Models::Responses::ResponseOutputItemAddedEvent,
              OpenAI::Models::Responses::ResponseOutputItemDoneEvent,
              OpenAI::Models::Responses::ResponseRefusalDeltaEvent,
              OpenAI::Models::Responses::ResponseRefusalDoneEvent,
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent,
              OpenAI::Models::Responses::ResponseTextDeltaEvent,
              OpenAI::Models::Responses::ResponseTextDoneEvent,
              OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent,
              OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent,
              OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent
            )
            ]
          )
      end
      def create_streaming(
        # Text, image, or file inputs to the model, used to generate a response.
        #
        #   Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Image inputs](https://platform.openai.com/docs/guides/images)
        #   - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        #   - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        #   - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        input:,
        # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        model:,
        # Specify additional output data to include in the model response. Currently
        #   supported values are:
        #
        #   - `file_search_call.results`: Include the search results of the file search tool
        #     call.
        #   - `message.input_image.image_url`: Include image urls from the input message.
        #   - `computer_call_output.output.image_url`: Include image urls from the computer
        #     call output.
        include: nil,
        # Inserts a system (or developer) message as the first item in the model's
        #   context.
        #
        #   When using along with `previous_response_id`, the instructions from a previous
        #   response will be not be carried over to the next response. This makes it simple
        #   to swap out system (or developer) messages in new responses.
        instructions: nil,
        # An upper bound for the number of tokens that can be generated for a response,
        #   including visible output tokens and
        #   [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        max_output_tokens: nil,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        metadata: nil,
        # Whether to allow the model to run tool calls in parallel.
        parallel_tool_calls: nil,
        # The unique ID of the previous response to the model. Use this to create
        #   multi-turn conversations. Learn more about
        #   [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        previous_response_id: nil,
        # **o-series models only**
        #
        #   Configuration options for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        reasoning: nil,
        # Whether to store the generated model response for later retrieval via API.
        store: nil,
        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic. We generally recommend altering this or `top_p` but
        #   not both.
        temperature: nil,
        # Configuration options for a text response from the model. Can be plain text or
        #   structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        text: nil,
        # How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        tool_choice: nil,
        # An array of tools the model may call while generating a response. You can
        #   specify which tool to use by setting the `tool_choice` parameter.
        #
        #   The two categories of tools you can provide the model are:
        #
        #   - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #     capabilities, like
        #     [web search](https://platform.openai.com/docs/guides/tools-web-search) or
        #     [file search](https://platform.openai.com/docs/guides/tools-file-search).
        #     Learn more about
        #     [built-in tools](https://platform.openai.com/docs/guides/tools).
        #   - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #     the model to call your own code. Learn more about
        #     [function calling](https://platform.openai.com/docs/guides/function-calling).
        tools: nil,
        # An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        top_p: nil,
        # The truncation strategy to use for the model response.
        #
        #   - `auto`: If the context of this response and previous ones exceeds the model's
        #     context window size, the model will truncate the response to fit the context
        #     window by dropping input items in the middle of the conversation.
        #   - `disabled` (default): If a model response will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        truncation: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        #   and detect abuse.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        # There is no need to provide `stream:`. Instead, use `#create_streaming` or
        #   `#create` for streaming and non-streaming use cases, respectively.
        stream: true,
        request_options: {}
      )
      end

      # Retrieves a model response with the given ID.
      sig do
        params(
          response_id: String,
          include: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol],
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Responses::Response)
      end
      def retrieve(
        # The ID of the response to retrieve.
        response_id,
        # Additional fields to include in the response. See the `include` parameter for
        #   Response creation above for more information.
        include: nil,
        request_options: {}
      )
      end

      # Deletes a model response with the given ID.
      sig do
        params(
          response_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .void
      end
      def delete(
        # The ID of the response to delete.
        response_id,
        request_options: {}
      )
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
