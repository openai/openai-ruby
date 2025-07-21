# typed: strong

module OpenAI
  module Resources
    class Responses
      sig { returns(OpenAI::Resources::Responses::InputItems) }
      attr_reader :input_items

      # See {OpenAI::Resources::Responses#stream_raw} for streaming counterpart.
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
      sig do
        params(
          background: T.nilable(T::Boolean),
          include:
            T.nilable(
              T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
            ),
          input: OpenAI::Responses::ResponseCreateParams::Input::Variants,
          instructions: T.nilable(String),
          max_output_tokens: T.nilable(Integer),
          max_tool_calls: T.nilable(Integer),
          metadata: T.nilable(T::Hash[Symbol, String]),
          model:
            T.any(
              String,
              OpenAI::ChatModel::OrSymbol,
              OpenAI::ResponsesModel::ResponsesOnlyModel::OrSymbol
            ),
          parallel_tool_calls: T.nilable(T::Boolean),
          previous_response_id: T.nilable(String),
          prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
          reasoning: T.nilable(OpenAI::Reasoning::OrHash),
          service_tier:
            T.nilable(
              OpenAI::Responses::ResponseCreateParams::ServiceTier::OrSymbol
            ),
          store: T.nilable(T::Boolean),
          temperature: T.nilable(Float),
          text:
            T.any(
              OpenAI::Responses::ResponseTextConfig::OrHash,
              OpenAI::StructuredOutput::JsonSchemaConverter
            ),
          tool_choice:
            T.any(
              OpenAI::Responses::ToolChoiceOptions::OrSymbol,
              OpenAI::Responses::ToolChoiceTypes::OrHash,
              OpenAI::Responses::ToolChoiceFunction::OrHash,
              OpenAI::Responses::ToolChoiceMcp::OrHash
            ),
          tools:
            T::Array[
              T.any(
                OpenAI::Responses::FunctionTool::OrHash,
                OpenAI::Responses::FileSearchTool::OrHash,
                OpenAI::Responses::ComputerTool::OrHash,
                OpenAI::Responses::Tool::Mcp::OrHash,
                OpenAI::Responses::Tool::CodeInterpreter::OrHash,
                OpenAI::Responses::Tool::ImageGeneration::OrHash,
                OpenAI::Responses::Tool::LocalShell::OrHash,
                OpenAI::Responses::WebSearchTool::OrHash
              )
            ],
          top_logprobs: T.nilable(Integer),
          top_p: T.nilable(Float),
          truncation:
            T.nilable(
              OpenAI::Responses::ResponseCreateParams::Truncation::OrSymbol
            ),
          user: String,
          stream: T.noreturn,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Responses::Response)
      end
      def create(
        # Whether to run the model response in the background.
        # [Learn more](https://platform.openai.com/docs/guides/background).
        background: nil,
        # Specify additional output data to include in the model response. Currently
        # supported values are:
        #
        # - `code_interpreter_call.outputs`: Includes the outputs of python code execution
        #   in code interpreter tool call items.
        # - `computer_call_output.output.image_url`: Include image urls from the computer
        #   call output.
        # - `file_search_call.results`: Include the search results of the file search tool
        #   call.
        # - `message.input_image.image_url`: Include image urls from the input message.
        # - `message.output_text.logprobs`: Include logprobs with assistant messages.
        # - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
        #   tokens in reasoning item outputs. This enables reasoning items to be used in
        #   multi-turn conversations when using the Responses API statelessly (like when
        #   the `store` parameter is set to `false`, or when an organization is enrolled
        #   in the zero data retention program).
        include: nil,
        # Text, image, or file inputs to the model, used to generate a response.
        #
        # Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Image inputs](https://platform.openai.com/docs/guides/images)
        # - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        # - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        # - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        input: nil,
        # A system (or developer) message inserted into the model's context.
        #
        # When using along with `previous_response_id`, the instructions from a previous
        # response will not be carried over to the next response. This makes it simple to
        # swap out system (or developer) messages in new responses.
        instructions: nil,
        # An upper bound for the number of tokens that can be generated for a response,
        # including visible output tokens and
        # [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        max_output_tokens: nil,
        # The maximum number of total calls to built-in tools that can be processed in a
        # response. This maximum number applies across all built-in tool calls, not per
        # individual tool. Any further attempts to call a tool by the model will be
        # ignored.
        max_tool_calls: nil,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata: nil,
        # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
        # wide range of models with different capabilities, performance characteristics,
        # and price points. Refer to the
        # [model guide](https://platform.openai.com/docs/models) to browse and compare
        # available models.
        model: nil,
        # Whether to allow the model to run tool calls in parallel.
        parallel_tool_calls: nil,
        # The unique ID of the previous response to the model. Use this to create
        # multi-turn conversations. Learn more about
        # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        previous_response_id: nil,
        # Reference to a prompt template and its variables.
        # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        prompt: nil,
        # **o-series models only**
        #
        # Configuration options for
        # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        reasoning: nil,
        # Specifies the processing type used for serving the request.
        #
        # - If set to 'auto', then the request will be processed with the service tier
        #   configured in the Project settings. Unless otherwise configured, the Project
        #   will use 'default'.
        # - If set to 'default', then the request will be processed with the standard
        #   pricing and performance for the selected model.
        # - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #   'priority', then the request will be processed with the corresponding service
        #   tier. [Contact sales](https://openai.com/contact-sales) to learn more about
        #   Priority processing.
        # - When not set, the default behavior is 'auto'.
        #
        # When the `service_tier` parameter is set, the response body will include the
        # `service_tier` value based on the processing mode actually used to serve the
        # request. This response value may be different from the value set in the
        # parameter.
        service_tier: nil,
        # Whether to store the generated model response for later retrieval via API.
        store: nil,
        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        # make the output more random, while lower values like 0.2 will make it more
        # focused and deterministic. We generally recommend altering this or `top_p` but
        # not both.
        temperature: nil,
        # Configuration options for a text response from the model. Can be plain text or
        # structured JSON data. Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        text: nil,
        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        tool_choice: nil,
        # An array of tools the model may call while generating a response. You can
        # specify which tool to use by setting the `tool_choice` parameter.
        #
        # The two categories of tools you can provide the model are:
        #
        # - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #   capabilities, like
        #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
        #   [file search](https://platform.openai.com/docs/guides/tools-file-search).
        #   Learn more about
        #   [built-in tools](https://platform.openai.com/docs/guides/tools).
        # - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #   the model to call your own code. Learn more about
        #   [function calling](https://platform.openai.com/docs/guides/function-calling).
        tools: nil,
        # An integer between 0 and 20 specifying the number of most likely tokens to
        # return at each token position, each with an associated log probability.
        top_logprobs: nil,
        # An alternative to sampling with temperature, called nucleus sampling, where the
        # model considers the results of the tokens with top_p probability mass. So 0.1
        # means only the tokens comprising the top 10% probability mass are considered.
        #
        # We generally recommend altering this or `temperature` but not both.
        top_p: nil,
        # The truncation strategy to use for the model response.
        #
        # - `auto`: If the context of this response and previous ones exceeds the model's
        #   context window size, the model will truncate the response to fit the context
        #   window by dropping input items in the middle of the conversation.
        # - `disabled` (default): If a model response will exceed the context window size
        #   for a model, the request will fail with a 400 error.
        truncation: nil,
        # A stable identifier for your end-users. Used to boost cache hit rates by better
        # bucketing similar requests and to help OpenAI detect and prevent abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        # There is no need to provide `stream:`. Instead, use `#stream_raw` or `#create`
        # for streaming and non-streaming use cases, respectively.
        stream: false,
        request_options: {}
      )
      end

      # See {OpenAI::Resources::Responses#create} for non-streaming counterpart.
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
      sig do
        params(
          background: T.nilable(T::Boolean),
          include:
            T.nilable(
              T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
            ),
          input: OpenAI::Responses::ResponseCreateParams::Input::Variants,
          instructions: T.nilable(String),
          max_output_tokens: T.nilable(Integer),
          max_tool_calls: T.nilable(Integer),
          metadata: T.nilable(T::Hash[Symbol, String]),
          model:
            T.any(
              String,
              OpenAI::ChatModel::OrSymbol,
              OpenAI::ResponsesModel::ResponsesOnlyModel::OrSymbol
            ),
          parallel_tool_calls: T.nilable(T::Boolean),
          previous_response_id: T.nilable(String),
          prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
          reasoning: T.nilable(OpenAI::Reasoning::OrHash),
          service_tier:
            T.nilable(
              OpenAI::Responses::ResponseCreateParams::ServiceTier::OrSymbol
            ),
          store: T.nilable(T::Boolean),
          temperature: T.nilable(Float),
          text:
            T.nilable(
              T.any(
                OpenAI::Responses::ResponseTextConfig::OrHash,
                OpenAI::StructuredOutput::JsonSchemaConverter
              )
            ),
          tool_choice:
            T.any(
              OpenAI::Responses::ToolChoiceOptions::OrSymbol,
              OpenAI::Responses::ToolChoiceTypes::OrHash,
              OpenAI::Responses::ToolChoiceFunction::OrHash,
              OpenAI::Responses::ToolChoiceMcp::OrHash
            ),
          tools:
            T::Array[
              T.any(
                OpenAI::Responses::FunctionTool::OrHash,
                OpenAI::Responses::FileSearchTool::OrHash,
                OpenAI::Responses::ComputerTool::OrHash,
                OpenAI::Responses::Tool::Mcp::OrHash,
                OpenAI::Responses::Tool::CodeInterpreter::OrHash,
                OpenAI::Responses::Tool::ImageGeneration::OrHash,
                OpenAI::Responses::Tool::LocalShell::OrHash,
                OpenAI::Responses::WebSearchTool::OrHash
              )
            ],
          top_logprobs: T.nilable(Integer),
          top_p: T.nilable(Float),
          truncation:
            T.nilable(
              OpenAI::Responses::ResponseCreateParams::Truncation::OrSymbol
            ),
          user: String,
          stream: T.noreturn,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(
          OpenAI::Internal::Stream[
            OpenAI::Responses::ResponseStreamEvent::Variants
          ]
        )
      end
      def stream_raw(
        # Whether to run the model response in the background.
        # [Learn more](https://platform.openai.com/docs/guides/background).
        background: nil,
        # Specify additional output data to include in the model response. Currently
        # supported values are:
        #
        # - `code_interpreter_call.outputs`: Includes the outputs of python code execution
        #   in code interpreter tool call items.
        # - `computer_call_output.output.image_url`: Include image urls from the computer
        #   call output.
        # - `file_search_call.results`: Include the search results of the file search tool
        #   call.
        # - `message.input_image.image_url`: Include image urls from the input message.
        # - `message.output_text.logprobs`: Include logprobs with assistant messages.
        # - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
        #   tokens in reasoning item outputs. This enables reasoning items to be used in
        #   multi-turn conversations when using the Responses API statelessly (like when
        #   the `store` parameter is set to `false`, or when an organization is enrolled
        #   in the zero data retention program).
        include: nil,
        # Text, image, or file inputs to the model, used to generate a response.
        #
        # Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Image inputs](https://platform.openai.com/docs/guides/images)
        # - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        # - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        # - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        input: nil,
        # A system (or developer) message inserted into the model's context.
        #
        # When using along with `previous_response_id`, the instructions from a previous
        # response will not be carried over to the next response. This makes it simple to
        # swap out system (or developer) messages in new responses.
        instructions: nil,
        # An upper bound for the number of tokens that can be generated for a response,
        # including visible output tokens and
        # [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        max_output_tokens: nil,
        # The maximum number of total calls to built-in tools that can be processed in a
        # response. This maximum number applies across all built-in tool calls, not per
        # individual tool. Any further attempts to call a tool by the model will be
        # ignored.
        max_tool_calls: nil,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata: nil,
        # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
        # wide range of models with different capabilities, performance characteristics,
        # and price points. Refer to the
        # [model guide](https://platform.openai.com/docs/models) to browse and compare
        # available models.
        model: nil,
        # Whether to allow the model to run tool calls in parallel.
        parallel_tool_calls: nil,
        # The unique ID of the previous response to the model. Use this to create
        # multi-turn conversations. Learn more about
        # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        previous_response_id: nil,
        # Reference to a prompt template and its variables.
        # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        prompt: nil,
        # **o-series models only**
        #
        # Configuration options for
        # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        reasoning: nil,
        # Specifies the processing type used for serving the request.
        #
        # - If set to 'auto', then the request will be processed with the service tier
        #   configured in the Project settings. Unless otherwise configured, the Project
        #   will use 'default'.
        # - If set to 'default', then the request will be processed with the standard
        #   pricing and performance for the selected model.
        # - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #   'priority', then the request will be processed with the corresponding service
        #   tier. [Contact sales](https://openai.com/contact-sales) to learn more about
        #   Priority processing.
        # - When not set, the default behavior is 'auto'.
        #
        # When the `service_tier` parameter is set, the response body will include the
        # `service_tier` value based on the processing mode actually used to serve the
        # request. This response value may be different from the value set in the
        # parameter.
        service_tier: nil,
        # Whether to store the generated model response for later retrieval via API.
        store: nil,
        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        # make the output more random, while lower values like 0.2 will make it more
        # focused and deterministic. We generally recommend altering this or `top_p` but
        # not both.
        temperature: nil,
        # Configuration options for a text response from the model. Can be plain text or
        # structured JSON data. Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        text: nil,
        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        tool_choice: nil,
        # An array of tools the model may call while generating a response. You can
        # specify which tool to use by setting the `tool_choice` parameter.
        #
        # The two categories of tools you can provide the model are:
        #
        # - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #   capabilities, like
        #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
        #   [file search](https://platform.openai.com/docs/guides/tools-file-search).
        #   Learn more about
        #   [built-in tools](https://platform.openai.com/docs/guides/tools).
        # - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #   the model to call your own code. Learn more about
        #   [function calling](https://platform.openai.com/docs/guides/function-calling).
        tools: nil,
        # An integer between 0 and 20 specifying the number of most likely tokens to
        # return at each token position, each with an associated log probability.
        top_logprobs: nil,
        # An alternative to sampling with temperature, called nucleus sampling, where the
        # model considers the results of the tokens with top_p probability mass. So 0.1
        # means only the tokens comprising the top 10% probability mass are considered.
        #
        # We generally recommend altering this or `temperature` but not both.
        top_p: nil,
        # The truncation strategy to use for the model response.
        #
        # - `auto`: If the context of this response and previous ones exceeds the model's
        #   context window size, the model will truncate the response to fit the context
        #   window by dropping input items in the middle of the conversation.
        # - `disabled` (default): If a model response will exceed the context window size
        #   for a model, the request will fail with a 400 error.
        truncation: nil,
        # A stable identifier for your end-users. Used to boost cache hit rates by better
        # bucketing similar requests and to help OpenAI detect and prevent abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        # There is no need to provide `stream:`. Instead, use `#stream_raw` or `#create`
        # for streaming and non-streaming use cases, respectively.
        stream: true,
        request_options: {}
      )
      end

      # See {OpenAI::Resources::Responses#create} for non-streaming counterpart.
      #
      # Creates a model response with a higher-level streaming interface that provides
      # helper methods for processing events and aggregating stream outputs.
      sig do
        params(
          input:
            T.nilable(OpenAI::Responses::ResponseCreateParams::Input::Variants),
          model:
            T.nilable(
              T.any(
                String,
                OpenAI::ChatModel::OrSymbol,
                OpenAI::ResponsesModel::ResponsesOnlyModel::OrSymbol
              )
            ),
          background: T.nilable(T::Boolean),
          include:
            T.nilable(
              T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
            ),
          instructions: T.nilable(String),
          max_output_tokens: T.nilable(Integer),
          metadata: T.nilable(T::Hash[Symbol, String]),
          parallel_tool_calls: T.nilable(T::Boolean),
          previous_response_id: T.nilable(String),
          prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
          reasoning: T.nilable(OpenAI::Reasoning::OrHash),
          service_tier:
            T.nilable(
              OpenAI::Responses::ResponseCreateParams::ServiceTier::OrSymbol
            ),
          store: T.nilable(T::Boolean),
          temperature: T.nilable(Float),
          text:
            T.any(
              OpenAI::Responses::ResponseTextConfig::OrHash,
              OpenAI::StructuredOutput::JsonSchemaConverter
            ),
          tool_choice:
            T.any(
              OpenAI::Responses::ToolChoiceOptions::OrSymbol,
              OpenAI::Responses::ToolChoiceTypes::OrHash,
              OpenAI::Responses::ToolChoiceFunction::OrHash
            ),
          tools:
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Responses::FunctionTool::OrHash,
                  OpenAI::Responses::FileSearchTool::OrHash,
                  OpenAI::Responses::ComputerTool::OrHash,
                  OpenAI::Responses::Tool::Mcp::OrHash,
                  OpenAI::Responses::Tool::CodeInterpreter::OrHash,
                  OpenAI::Responses::Tool::ImageGeneration::OrHash,
                  OpenAI::Responses::Tool::LocalShell::OrHash,
                  OpenAI::Responses::WebSearchTool::OrHash,
                  OpenAI::StructuredOutput::JsonSchemaConverter
                )
              ]
            ),
          top_p: T.nilable(Float),
          truncation:
            T.nilable(
              OpenAI::Responses::ResponseCreateParams::Truncation::OrSymbol
            ),
          user: T.nilable(String),
          starting_after: T.nilable(Integer),
          request_options: T.nilable(OpenAI::RequestOptions::OrHash)
        ).returns(OpenAI::Streaming::ResponseStream)
      end
      def stream(
        # Text, image, or file inputs to the model, used to generate a response.
        input: nil,
        # Model ID used to generate the response, like `gpt-4o` or `o3`.
        model: nil,
        # Whether to run the model response in the background.
        background: nil,
        # Specify additional output data to include in the model response.
        include: nil,
        # A system (or developer) message inserted into the model's context.
        instructions: nil,
        # An upper bound for the number of tokens that can be generated for a response.
        max_output_tokens: nil,
        # Set of 16 key-value pairs that can be attached to an object.
        metadata: nil,
        # Whether to allow the model to run tool calls in parallel.
        parallel_tool_calls: nil,
        # The unique ID of the previous response to the model. Use this to create
        # multi-turn conversations.
        previous_response_id: nil,
        # Reference to a prompt template and its variables.
        prompt: nil,
        # Configuration options for reasoning models.
        reasoning: nil,
        # Specifies the latency tier to use for processing the request.
        service_tier: nil,
        # Whether to store the generated model response for later retrieval via API.
        store: nil,
        # What sampling temperature to use, between 0 and 2.
        temperature: nil,
        # Configuration options for a text response from the model.
        text: nil,
        # How the model should select which tool (or tools) to use when generating a response.
        tool_choice: nil,
        # An array of tools the model may call while generating a response.
        tools: nil,
        # An alternative to sampling with temperature, called nucleus sampling.
        top_p: nil,
        # The truncation strategy to use for the model response.
        truncation: nil,
        # A stable identifier for your end-users.
        user: nil,
        # The sequence number of the event after which to start streaming (for resuming streams).
        starting_after: nil,
        request_options: {}
      )
      end

      # See {OpenAI::Resources::Responses#retrieve_streaming} for streaming counterpart.
      #
      # Retrieves a model response with the given ID.
      sig do
        params(
          response_id: String,
          include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
          starting_after: Integer,
          stream: T.noreturn,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Responses::Response)
      end
      def retrieve(
        # The ID of the response to retrieve.
        response_id,
        # Additional fields to include in the response. See the `include` parameter for
        # Response creation above for more information.
        include: nil,
        # The sequence number of the event after which to start streaming.
        starting_after: nil,
        # There is no need to provide `stream:`. Instead, use `#retrieve_streaming` or
        # `#retrieve` for streaming and non-streaming use cases, respectively.
        stream: false,
        request_options: {}
      )
      end

      # See {OpenAI::Resources::Responses#retrieve} for non-streaming counterpart.
      #
      # Retrieves a model response with the given ID.
      sig do
        params(
          response_id: String,
          include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
          starting_after: Integer,
          stream: T.noreturn,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(
          OpenAI::Internal::Stream[
            OpenAI::Responses::ResponseStreamEvent::Variants
          ]
        )
      end
      def retrieve_streaming(
        # The ID of the response to retrieve.
        response_id,
        # Additional fields to include in the response. See the `include` parameter for
        # Response creation above for more information.
        include: nil,
        # The sequence number of the event after which to start streaming.
        starting_after: nil,
        # There is no need to provide `stream:`. Instead, use `#retrieve_streaming` or
        # `#retrieve` for streaming and non-streaming use cases, respectively.
        stream: true,
        request_options: {}
      )
      end

      # Deletes a model response with the given ID.
      sig do
        params(
          response_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).void
      end
      def delete(
        # The ID of the response to delete.
        response_id,
        request_options: {}
      )
      end

      # Cancels a model response with the given ID. Only responses created with the
      # `background` parameter set to `true` can be cancelled.
      # [Learn more](https://platform.openai.com/docs/guides/background).
      sig do
        params(
          response_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Responses::Response)
      end
      def cancel(
        # The ID of the response to cancel.
        response_id,
        request_options: {}
      )
      end

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
