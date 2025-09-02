# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # Whether to run the model response in the background.
        # [Learn more](https://platform.openai.com/docs/guides/background).
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :background

        # The conversation that this response belongs to. Items from this conversation are
        # prepended to `input_items` for this response request. Input items and output
        # items from this response are automatically added to this conversation after this
        # response completes.
        sig do
          returns(
            T.nilable(
              T.any(String, OpenAI::Responses::ResponseConversationParam)
            )
          )
        end
        attr_accessor :conversation

        # Specify additional output data to include in the model response. Currently
        # supported values are:
        #
        # - `web_search_call.action.sources`: Include the sources of the web search tool
        #   call.
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
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol])
          )
        end
        attr_accessor :include

        # Text, image, or file inputs to the model, used to generate a response.
        #
        # Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Image inputs](https://platform.openai.com/docs/guides/images)
        # - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        # - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        # - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        sig do
          returns(
            T.nilable(OpenAI::Responses::ResponseCreateParams::Input::Variants)
          )
        end
        attr_reader :input

        sig do
          params(
            input: OpenAI::Responses::ResponseCreateParams::Input::Variants
          ).void
        end
        attr_writer :input

        # A system (or developer) message inserted into the model's context.
        #
        # When using along with `previous_response_id`, the instructions from a previous
        # response will not be carried over to the next response. This makes it simple to
        # swap out system (or developer) messages in new responses.
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # An upper bound for the number of tokens that can be generated for a response,
        # including visible output tokens and
        # [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(Integer)) }
        attr_accessor :max_output_tokens

        # The maximum number of total calls to built-in tools that can be processed in a
        # response. This maximum number applies across all built-in tool calls, not per
        # individual tool. Any further attempts to call a tool by the model will be
        # ignored.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :max_tool_calls

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
        # wide range of models with different capabilities, performance characteristics,
        # and price points. Refer to the
        # [model guide](https://platform.openai.com/docs/models) to browse and compare
        # available models.
        sig do
          returns(
            T.nilable(
              T.any(
                String,
                OpenAI::ChatModel::OrSymbol,
                OpenAI::ResponsesModel::ResponsesOnlyModel::OrSymbol
              )
            )
          )
        end
        attr_reader :model

        sig do
          params(
            model:
              T.any(
                String,
                OpenAI::ChatModel::OrSymbol,
                OpenAI::ResponsesModel::ResponsesOnlyModel::OrSymbol
              )
          ).void
        end
        attr_writer :model

        # Whether to allow the model to run tool calls in parallel.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :parallel_tool_calls

        # The unique ID of the previous response to the model. Use this to create
        # multi-turn conversations. Learn more about
        # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        # Cannot be used in conjunction with `conversation`.
        sig { returns(T.nilable(String)) }
        attr_accessor :previous_response_id

        # Reference to a prompt template and its variables.
        # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        sig { returns(T.nilable(OpenAI::Responses::ResponsePrompt)) }
        attr_reader :prompt

        sig do
          params(
            prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash)
          ).void
        end
        attr_writer :prompt

        # Used by OpenAI to cache responses for similar requests to optimize your cache
        # hit rates. Replaces the `user` field.
        # [Learn more](https://platform.openai.com/docs/guides/prompt-caching).
        sig { returns(T.nilable(String)) }
        attr_reader :prompt_cache_key

        sig { params(prompt_cache_key: String).void }
        attr_writer :prompt_cache_key

        # **gpt-5 and o-series models only**
        #
        # Configuration options for
        # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(OpenAI::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: T.nilable(OpenAI::Reasoning::OrHash)).void }
        attr_writer :reasoning

        # A stable identifier used to help detect users of your application that may be
        # violating OpenAI's usage policies. The IDs should be a string that uniquely
        # identifies each user. We recommend hashing their username or email address, in
        # order to avoid sending us any identifying information.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
        sig { returns(T.nilable(String)) }
        attr_reader :safety_identifier

        sig { params(safety_identifier: String).void }
        attr_writer :safety_identifier

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
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseCreateParams::ServiceTier::OrSymbol
            )
          )
        end
        attr_accessor :service_tier

        # Whether to store the generated model response for later retrieval via API.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :store

        # Options for streaming responses. Only set this when you set `stream: true`.
        sig do
          returns(
            T.nilable(OpenAI::Responses::ResponseCreateParams::StreamOptions)
          )
        end
        attr_reader :stream_options

        sig do
          params(
            stream_options:
              T.nilable(
                OpenAI::Responses::ResponseCreateParams::StreamOptions::OrHash
              )
          ).void
        end
        attr_writer :stream_options

        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        # make the output more random, while lower values like 0.2 will make it more
        # focused and deterministic. We generally recommend altering this or `top_p` but
        # not both.
        sig { returns(T.nilable(Float)) }
        attr_accessor :temperature

        # Configuration options for a text response from the model. Can be plain text or
        # structured JSON data. Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        sig { returns(T.nilable(OpenAI::Responses::ResponseTextConfig)) }
        attr_reader :text

        sig do
          params(
            text:
              T.any(
                OpenAI::Responses::ResponseTextConfig::OrHash,
                OpenAI::StructuredOutput::JsonSchemaConverter
              )
          ).void
        end
        attr_writer :text

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceAllowed,
                OpenAI::Responses::ToolChoiceTypes,
                OpenAI::Responses::ToolChoiceFunction,
                OpenAI::Responses::ToolChoiceMcp,
                OpenAI::Responses::ToolChoiceCustom
              )
            )
          )
        end
        attr_reader :tool_choice

        sig do
          params(
            tool_choice:
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceAllowed::OrHash,
                OpenAI::Responses::ToolChoiceTypes::OrHash,
                OpenAI::Responses::ToolChoiceFunction::OrHash,
                OpenAI::Responses::ToolChoiceMcp::OrHash,
                OpenAI::Responses::ToolChoiceCustom::OrHash
              )
          ).void
        end
        attr_writer :tool_choice

        # An array of tools the model may call while generating a response. You can
        # specify which tool to use by setting the `tool_choice` parameter.
        #
        # We support the following categories of tools:
        #
        # - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #   capabilities, like
        #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
        #   [file search](https://platform.openai.com/docs/guides/tools-file-search).
        #   Learn more about
        #   [built-in tools](https://platform.openai.com/docs/guides/tools).
        # - **MCP Tools**: Integrations with third-party systems via custom MCP servers or
        #   predefined connectors such as Google Drive and Notion. Learn more about
        #   [MCP Tools](https://platform.openai.com/docs/guides/tools-connectors-mcp).
        # - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #   the model to call your own code with strongly typed arguments and outputs.
        #   Learn more about
        #   [function calling](https://platform.openai.com/docs/guides/function-calling).
        #   You can also use custom tools to call your own code.
        sig do
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Responses::FunctionTool,
                  OpenAI::Responses::FileSearchTool,
                  OpenAI::Responses::ComputerTool,
                  OpenAI::Responses::Tool::Mcp,
                  OpenAI::Responses::Tool::CodeInterpreter,
                  OpenAI::Responses::Tool::ImageGeneration,
                  OpenAI::Responses::Tool::LocalShell,
                  OpenAI::Responses::CustomTool,
                  OpenAI::Responses::WebSearchTool,
                  OpenAI::Responses::WebSearchPreviewTool
                )
              ]
            )
          )
        end
        attr_reader :tools

        sig do
          params(
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
                  OpenAI::Responses::CustomTool::OrHash,
                  OpenAI::Responses::WebSearchTool::OrHash,
                  OpenAI::Responses::WebSearchPreviewTool::OrHash
                )
              ]
          ).void
        end
        attr_writer :tools

        # An integer between 0 and 20 specifying the number of most likely tokens to
        # return at each token position, each with an associated log probability.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :top_logprobs

        # An alternative to sampling with temperature, called nucleus sampling, where the
        # model considers the results of the tokens with top_p probability mass. So 0.1
        # means only the tokens comprising the top 10% probability mass are considered.
        #
        # We generally recommend altering this or `temperature` but not both.
        sig { returns(T.nilable(Float)) }
        attr_accessor :top_p

        # The truncation strategy to use for the model response.
        #
        # - `auto`: If the context of this response and previous ones exceeds the model's
        #   context window size, the model will truncate the response to fit the context
        #   window by dropping input items in the middle of the conversation.
        # - `disabled` (default): If a model response will exceed the context window size
        #   for a model, the request will fail with a 400 error.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseCreateParams::Truncation::OrSymbol
            )
          )
        end
        attr_accessor :truncation

        # This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
        # `prompt_cache_key` instead to maintain caching optimizations. A stable
        # identifier for your end-users. Used to boost cache hit rates by better bucketing
        # similar requests and to help OpenAI detect and prevent abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
        sig { returns(T.nilable(String)) }
        attr_reader :user

        sig { params(user: String).void }
        attr_writer :user

        sig do
          params(
            background: T.nilable(T::Boolean),
            conversation:
              T.nilable(
                T.any(
                  String,
                  OpenAI::Responses::ResponseConversationParam::OrHash
                )
              ),
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
            prompt_cache_key: String,
            reasoning: T.nilable(OpenAI::Reasoning::OrHash),
            safety_identifier: String,
            service_tier:
              T.nilable(
                OpenAI::Responses::ResponseCreateParams::ServiceTier::OrSymbol
              ),
            store: T.nilable(T::Boolean),
            stream_options:
              T.nilable(
                OpenAI::Responses::ResponseCreateParams::StreamOptions::OrHash
              ),
            temperature: T.nilable(Float),
            text: OpenAI::Responses::ResponseTextConfig::OrHash,
            tool_choice:
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceAllowed::OrHash,
                OpenAI::Responses::ToolChoiceTypes::OrHash,
                OpenAI::Responses::ToolChoiceFunction::OrHash,
                OpenAI::Responses::ToolChoiceMcp::OrHash,
                OpenAI::Responses::ToolChoiceCustom::OrHash
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
                  OpenAI::Responses::CustomTool::OrHash,
                  OpenAI::Responses::WebSearchTool::OrHash,
                  OpenAI::Responses::WebSearchPreviewTool::OrHash
                )
              ],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            truncation:
              T.nilable(
                OpenAI::Responses::ResponseCreateParams::Truncation::OrSymbol
              ),
            user: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Whether to run the model response in the background.
          # [Learn more](https://platform.openai.com/docs/guides/background).
          background: nil,
          # The conversation that this response belongs to. Items from this conversation are
          # prepended to `input_items` for this response request. Input items and output
          # items from this response are automatically added to this conversation after this
          # response completes.
          conversation: nil,
          # Specify additional output data to include in the model response. Currently
          # supported values are:
          #
          # - `web_search_call.action.sources`: Include the sources of the web search tool
          #   call.
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
          # Cannot be used in conjunction with `conversation`.
          previous_response_id: nil,
          # Reference to a prompt template and its variables.
          # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
          prompt: nil,
          # Used by OpenAI to cache responses for similar requests to optimize your cache
          # hit rates. Replaces the `user` field.
          # [Learn more](https://platform.openai.com/docs/guides/prompt-caching).
          prompt_cache_key: nil,
          # **gpt-5 and o-series models only**
          #
          # Configuration options for
          # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
          reasoning: nil,
          # A stable identifier used to help detect users of your application that may be
          # violating OpenAI's usage policies. The IDs should be a string that uniquely
          # identifies each user. We recommend hashing their username or email address, in
          # order to avoid sending us any identifying information.
          # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
          safety_identifier: nil,
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
          service_tier: nil,
          # Whether to store the generated model response for later retrieval via API.
          store: nil,
          # Options for streaming responses. Only set this when you set `stream: true`.
          stream_options: nil,
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
          # We support the following categories of tools:
          #
          # - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
          #   capabilities, like
          #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
          #   [file search](https://platform.openai.com/docs/guides/tools-file-search).
          #   Learn more about
          #   [built-in tools](https://platform.openai.com/docs/guides/tools).
          # - **MCP Tools**: Integrations with third-party systems via custom MCP servers or
          #   predefined connectors such as Google Drive and Notion. Learn more about
          #   [MCP Tools](https://platform.openai.com/docs/guides/tools-connectors-mcp).
          # - **Function calls (custom tools)**: Functions that are defined by you, enabling
          #   the model to call your own code with strongly typed arguments and outputs.
          #   Learn more about
          #   [function calling](https://platform.openai.com/docs/guides/function-calling).
          #   You can also use custom tools to call your own code.
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
          # This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
          # `prompt_cache_key` instead to maintain caching optimizations. A stable
          # identifier for your end-users. Used to boost cache hit rates by better bucketing
          # similar requests and to help OpenAI detect and prevent abuse.
          # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
          user: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              background: T.nilable(T::Boolean),
              conversation:
                T.nilable(
                  T.any(String, OpenAI::Responses::ResponseConversationParam)
                ),
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
              prompt: T.nilable(OpenAI::Responses::ResponsePrompt),
              prompt_cache_key: String,
              reasoning: T.nilable(OpenAI::Reasoning),
              safety_identifier: String,
              service_tier:
                T.nilable(
                  OpenAI::Responses::ResponseCreateParams::ServiceTier::OrSymbol
                ),
              store: T.nilable(T::Boolean),
              stream_options:
                T.nilable(
                  OpenAI::Responses::ResponseCreateParams::StreamOptions
                ),
              temperature: T.nilable(Float),
              text: OpenAI::Responses::ResponseTextConfig,
              tool_choice:
                T.any(
                  OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                  OpenAI::Responses::ToolChoiceAllowed,
                  OpenAI::Responses::ToolChoiceTypes,
                  OpenAI::Responses::ToolChoiceFunction,
                  OpenAI::Responses::ToolChoiceMcp,
                  OpenAI::Responses::ToolChoiceCustom
                ),
              tools:
                T::Array[
                  T.any(
                    OpenAI::Responses::FunctionTool,
                    OpenAI::Responses::FileSearchTool,
                    OpenAI::Responses::ComputerTool,
                    OpenAI::Responses::Tool::Mcp,
                    OpenAI::Responses::Tool::CodeInterpreter,
                    OpenAI::Responses::Tool::ImageGeneration,
                    OpenAI::Responses::Tool::LocalShell,
                    OpenAI::Responses::CustomTool,
                    OpenAI::Responses::WebSearchTool,
                    OpenAI::Responses::WebSearchPreviewTool
                  )
                ],
              top_logprobs: T.nilable(Integer),
              top_p: T.nilable(Float),
              truncation:
                T.nilable(
                  OpenAI::Responses::ResponseCreateParams::Truncation::OrSymbol
                ),
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # The conversation that this response belongs to. Items from this conversation are
        # prepended to `input_items` for this response request. Input items and output
        # items from this response are automatically added to this conversation after this
        # response completes.
        module Conversation
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(String, OpenAI::Responses::ResponseConversationParam)
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCreateParams::Conversation::Variants
              ]
            )
          end
          def self.variants
          end
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
        module Input
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                T::Array[OpenAI::Responses::ResponseInputItem::Variants]
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Responses::ResponseCreateParams::Input::Variants]
            )
          end
          def self.variants
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
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Responses::ResponseCreateParams::ServiceTier
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol
            )
          DEFAULT =
            T.let(
              :default,
              OpenAI::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol
            )
          FLEX =
            T.let(
              :flex,
              OpenAI::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol
            )
          SCALE =
            T.let(
              :scale,
              OpenAI::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol
            )
          PRIORITY =
            T.let(
              :priority,
              OpenAI::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class StreamOptions < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseCreateParams::StreamOptions,
                OpenAI::Internal::AnyHash
              )
            end

          # When true, stream obfuscation will be enabled. Stream obfuscation adds random
          # characters to an `obfuscation` field on streaming delta events to normalize
          # payload sizes as a mitigation to certain side-channel attacks. These obfuscation
          # fields are included by default, but add a small amount of overhead to the data
          # stream. You can set `include_obfuscation` to false to optimize for bandwidth if
          # you trust the network links between your application and the OpenAI API.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :include_obfuscation

          sig { params(include_obfuscation: T::Boolean).void }
          attr_writer :include_obfuscation

          # Options for streaming responses. Only set this when you set `stream: true`.
          sig do
            params(include_obfuscation: T::Boolean).returns(T.attached_class)
          end
          def self.new(
            # When true, stream obfuscation will be enabled. Stream obfuscation adds random
            # characters to an `obfuscation` field on streaming delta events to normalize
            # payload sizes as a mitigation to certain side-channel attacks. These obfuscation
            # fields are included by default, but add a small amount of overhead to the data
            # stream. You can set `include_obfuscation` to false to optimize for bandwidth if
            # you trust the network links between your application and the OpenAI API.
            include_obfuscation: nil
          )
          end

          sig { override.returns({ include_obfuscation: T::Boolean }) }
          def to_hash
          end
        end

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ToolChoiceOptions::TaggedSymbol,
                OpenAI::Responses::ToolChoiceAllowed,
                OpenAI::Responses::ToolChoiceTypes,
                OpenAI::Responses::ToolChoiceFunction,
                OpenAI::Responses::ToolChoiceMcp,
                OpenAI::Responses::ToolChoiceCustom
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCreateParams::ToolChoice::Variants
              ]
            )
          end
          def self.variants
          end
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

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseCreateParams::Truncation)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Responses::ResponseCreateParams::Truncation::TaggedSymbol
            )
          DISABLED =
            T.let(
              :disabled,
              OpenAI::Responses::ResponseCreateParams::Truncation::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCreateParams::Truncation::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
