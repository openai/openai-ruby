# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses#create
      #
      # @see OpenAI::Resources::Responses#stream_raw
      class ResponseCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute background
        #   Whether to run the model response in the background.
        #   [Learn more](https://platform.openai.com/docs/guides/background).
        #
        #   @return [Boolean, nil]
        optional :background, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute include
        #   Specify additional output data to include in the model response. Currently
        #   supported values are:
        #
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
        #   @return [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Responses::ResponseIncludable] },
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
        #   @return [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>, nil]
        optional :input, union: -> { OpenAI::Responses::ResponseCreateParams::Input }

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
        #   @return [String, Symbol, OpenAI::Models::ChatModel, OpenAI::Models::ResponsesModel::ResponsesOnlyModel, nil]
        optional :model, union: -> { OpenAI::ResponsesModel }

        # @!attribute parallel_tool_calls
        #   Whether to allow the model to run tool calls in parallel.
        #
        #   @return [Boolean, nil]
        optional :parallel_tool_calls, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute previous_response_id
        #   The unique ID of the previous response to the model. Use this to create
        #   multi-turn conversations. Learn more about
        #   [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        #
        #   @return [String, nil]
        optional :previous_response_id, String, nil?: true

        # @!attribute prompt
        #   Reference to a prompt template and its variables.
        #   [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        #
        #   @return [OpenAI::Models::Responses::ResponsePrompt, nil]
        optional :prompt, -> { OpenAI::Responses::ResponsePrompt }, nil?: true

        # @!attribute prompt_cache_key
        #   Used by OpenAI to cache responses for similar requests to optimize your cache
        #   hit rates. Replaces the `user` field.
        #   [Learn more](https://platform.openai.com/docs/guides/prompt-caching).
        #
        #   @return [String, nil]
        optional :prompt_cache_key, String

        # @!attribute reasoning
        #   **gpt-5 and o-series models only**
        #
        #   Configuration options for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @return [OpenAI::Models::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Reasoning }, nil?: true

        # @!attribute safety_identifier
        #   A stable identifier used to help detect users of your application that may be
        #   violating OpenAI's usage policies. The IDs should be a string that uniquely
        #   identifies each user. We recommend hashing their username or email address, in
        #   order to avoid sending us any identifying information.
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
        #   @return [Symbol, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier, nil]
        optional :service_tier, enum: -> { OpenAI::Responses::ResponseCreateParams::ServiceTier }, nil?: true

        # @!attribute store
        #   Whether to store the generated model response for later retrieval via API.
        #
        #   @return [Boolean, nil]
        optional :store, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute stream_options
        #   Options for streaming responses. Only set this when you set `stream: true`.
        #
        #   @return [OpenAI::Models::Responses::ResponseCreateParams::StreamOptions, nil]
        optional :stream_options, -> { OpenAI::Responses::ResponseCreateParams::StreamOptions }, nil?: true

        # @!attribute temperature
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic. We generally recommend altering this or `top_p` but
        #   not both.
        #
        #   @return [Float, nil]
        optional :temperature, Float, nil?: true

        # @!attribute text
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        #
        #   @return [OpenAI::Models::Responses::ResponseTextConfig, nil]
        optional :text,
                 union: -> {
                   OpenAI::UnionOf[
                     OpenAI::Responses::ResponseTextConfig,
                     OpenAI::StructuredOutput::JsonSchemaConverter
                   ]
                 }

        # @!attribute tool_choice
        #   How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceAllowed, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, OpenAI::Models::Responses::ToolChoiceCustom, nil]
        optional :tool_choice, union: -> { OpenAI::Responses::ResponseCreateParams::ToolChoice }

        # @!attribute tools
        #   An array of tools the model may call while generating a response. You can
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
        #     the model to call your own code with strongly typed arguments and outputs.
        #     Learn more about
        #     [function calling](https://platform.openai.com/docs/guides/function-calling).
        #     You can also use custom tools to call your own code.
        #
        #   @return [Array<OpenAI::StructuredOutput::JsonSchemaConverter, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::CustomTool, OpenAI::Models::Responses::WebSearchTool>, nil]
        optional :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::Tool] }

        # @!attribute top_logprobs
        #   An integer between 0 and 20 specifying the number of most likely tokens to
        #   return at each token position, each with an associated log probability.
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
        #   The truncation strategy to use for the model response.
        #
        #   - `auto`: If the context of this response and previous ones exceeds the model's
        #     context window size, the model will truncate the response to fit the context
        #     window by dropping input items in the middle of the conversation.
        #   - `disabled` (default): If a model response will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil]
        optional :truncation, enum: -> { OpenAI::Responses::ResponseCreateParams::Truncation }, nil?: true

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

        # @!method initialize(background: nil, include: nil, input: nil, instructions: nil, max_output_tokens: nil, max_tool_calls: nil, metadata: nil, model: nil, parallel_tool_calls: nil, previous_response_id: nil, prompt: nil, prompt_cache_key: nil, reasoning: nil, safety_identifier: nil, service_tier: nil, store: nil, stream_options: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCreateParams} for more details.
        #
        #   @param background [Boolean, nil] Whether to run the model response in the background.
        #
        #   @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil] Specify additional output data to include in the model response. Currently
        #
        #   @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>] Text, image, or file inputs to the model, used to generate a response.
        #
        #   @param instructions [String, nil] A system (or developer) message inserted into the model's context.
        #
        #   @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
        #
        #   @param max_tool_calls [Integer, nil] The maximum number of total calls to built-in tools that can be processed in a r
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param model [String, Symbol, OpenAI::Models::ChatModel, OpenAI::Models::ResponsesModel::ResponsesOnlyModel] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
        #
        #   @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
        #
        #   @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to
        #
        #   @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
        #
        #   @param prompt_cache_key [String] Used by OpenAI to cache responses for similar requests to optimize your cache hi
        #
        #   @param reasoning [OpenAI::Models::Reasoning, nil] **gpt-5 and o-series models only**
        #
        #   @param safety_identifier [String] A stable identifier used to help detect users of your application that may be vi
        #
        #   @param service_tier [Symbol, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier, nil] Specifies the processing type used for serving the request.
        #
        #   @param store [Boolean, nil] Whether to store the generated model response for later retrieval via
        #
        #   @param stream_options [OpenAI::Models::Responses::ResponseCreateParams::StreamOptions, nil] Options for streaming responses. Only set this when you set `stream: true`.
        #
        #   @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
        #
        #   @param text [OpenAI::Models::Responses::ResponseCreateParams::Text]
        #
        #   @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceAllowed, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, OpenAI::Models::Responses::ToolChoiceCustom] How the model should select which tool (or tools) to use when generating
        #
        #   @param tools [Array<OpenAI::StructuredOutput::JsonSchemaConverter, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::CustomTool, OpenAI::Models::Responses::WebSearchTool>] An array of tools the model may call while generating a response. You
        #
        #   @param top_logprobs [Integer, nil] An integer between 0 and 20 specifying the number of most likely tokens to
        #
        #   @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
        #
        #   @param truncation [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil] The truncation strategy to use for the model response.
        #
        #   @param user [String] This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Text, image, or file inputs to the model, used to generate a response.
        #
        # Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Image inputs](https://platform.openai.com/docs/guides/images)
        # - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        # - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        # - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        module Input
          extend OpenAI::Internal::Type::Union

          # A text input to the model, equivalent to a text input with the
          # `user` role.
          variant String

          # A list of one or many input items to the model, containing
          # different content types.
          variant -> { OpenAI::Responses::ResponseInput }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>)]
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
          #   {OpenAI::Models::Responses::ResponseCreateParams::StreamOptions} for more
          #   details.
          #
          #   Options for streaming responses. Only set this when you set `stream: true`.
          #
          #   @param include_obfuscation [Boolean] When true, stream obfuscation will be enabled. Stream obfuscation adds
        end

        class Text < OpenAI::Internal::Type::BaseModel
          # @!attribute format_
          #   An object specifying the format that the model must output.
          #
          #   Configuring `{ "type": "json_schema" }` enables Structured Outputs, which
          #   ensures the model will match your supplied JSON schema. Learn more in the
          #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #   The default format is `{ "type": "text" }` with no additional options.
          #
          #   **Not recommended for gpt-4o and newer models:**
          #
          #   Setting to `{ "type": "json_object" }` enables the older JSON mode, which
          #   ensures the message the model generates is valid JSON. Using `json_schema` is
          #   preferred for models that support it.
          #
          #   @return [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::Models::ResponseFormatJSONObject, nil]
          optional :format_, union: -> { OpenAI::Responses::ResponseFormatTextConfig }, api_name: :format

          # @!attribute verbosity
          #   Constrains the verbosity of the model's response. Lower values will result in
          #   more concise responses, while higher values will result in more verbose
          #   responses. Currently supported values are `low`, `medium`, and `high`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Text::Verbosity, nil]
          optional :verbosity,
                   enum: -> {
                     OpenAI::Responses::ResponseCreateParams::Text::Verbosity
                   },
                   nil?: true

          # @!method initialize(format_: nil, verbosity: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseCreateParams::Text} for more details.
          #
          #   @param format_ [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::Models::ResponseFormatJSONObject] An object specifying the format that the model must output.
          #
          #   @param verbosity [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Text::Verbosity, nil] Constrains the verbosity of the model's response. Lower values will result in

          # Constrains the verbosity of the model's response. Lower values will result in
          # more concise responses, while higher values will result in more verbose
          # responses. Currently supported values are `low`, `medium`, and `high`.
          #
          # @see OpenAI::Models::Responses::ResponseCreateParams::Text#verbosity
          module Verbosity
            extend OpenAI::Internal::Type::Enum

            LOW = :low
            MEDIUM = :medium
            HIGH = :high

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
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
          variant enum: -> { OpenAI::Responses::ToolChoiceOptions }

          # Constrains the tools available to the model to a pre-defined set.
          variant -> { OpenAI::Responses::ToolChoiceAllowed }

          # Indicates that the model should use a built-in tool to generate a response.
          # [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
          variant -> { OpenAI::Responses::ToolChoiceTypes }

          # Use this option to force the model to call a specific function.
          variant -> { OpenAI::Responses::ToolChoiceFunction }

          # Use this option to force the model to call a specific tool on a remote MCP server.
          variant -> { OpenAI::Responses::ToolChoiceMcp }

          # Use this option to force the model to call a specific custom tool.
          variant -> { OpenAI::Responses::ToolChoiceCustom }

          # @!method self.variants
          #   @return [Array(Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceAllowed, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, OpenAI::Models::Responses::ToolChoiceCustom)]
        end

        # The truncation strategy to use for the model response.
        #
        # - `auto`: If the context of this response and previous ones exceeds the model's
        #   context window size, the model will truncate the response to fit the context
        #   window by dropping input items in the middle of the conversation.
        # - `disabled` (default): If a model response will exceed the context window size
        #   for a model, the request will fail with a 400 error.
        module Truncation
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DISABLED = :disabled

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
