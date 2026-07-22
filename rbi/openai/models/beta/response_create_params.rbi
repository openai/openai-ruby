# typed: strong

module OpenAI
  module Models
    module Beta
      class ResponseCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::ResponseCreateParams, OpenAI::Internal::AnyHash)
          end

        # Whether to run the model response in the background.
        # [Learn more](https://platform.openai.com/docs/guides/background).
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :background

        # Context management configuration for this request.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Beta::ResponseCreateParams::ContextManagement]
            )
          )
        end
        attr_accessor :context_management

        # The conversation that this response belongs to. Items from this conversation are
        # prepended to `input_items` for this response request. Input items and output
        # items from this response are automatically added to this conversation after this
        # response completes.
        sig do
          returns(
            T.nilable(
              T.any(String, OpenAI::Beta::BetaResponseConversationParam)
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
            T.nilable(T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol])
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
            T.nilable(OpenAI::Beta::ResponseCreateParams::Input::Variants)
          )
        end
        attr_reader :input

        sig do
          params(
            input: OpenAI::Beta::ResponseCreateParams::Input::Variants
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
              T.any(OpenAI::Beta::ResponseCreateParams::Model::OrSymbol, String)
            )
          )
        end
        attr_reader :model

        sig do
          params(
            model:
              T.any(OpenAI::Beta::ResponseCreateParams::Model::OrSymbol, String)
          ).void
        end
        attr_writer :model

        # Configuration for running moderation on the input and output of this response.
        sig do
          returns(T.nilable(OpenAI::Beta::ResponseCreateParams::Moderation))
        end
        attr_reader :moderation

        sig do
          params(
            moderation:
              T.nilable(OpenAI::Beta::ResponseCreateParams::Moderation::OrHash)
          ).void
        end
        attr_writer :moderation

        # Configuration for server-hosted multi-agent execution.
        sig do
          returns(T.nilable(OpenAI::Beta::ResponseCreateParams::MultiAgent))
        end
        attr_reader :multi_agent

        sig do
          params(
            multi_agent:
              T.nilable(OpenAI::Beta::ResponseCreateParams::MultiAgent::OrHash)
          ).void
        end
        attr_writer :multi_agent

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
        sig { returns(T.nilable(OpenAI::Beta::BetaResponsePrompt)) }
        attr_reader :prompt

        sig do
          params(
            prompt: T.nilable(OpenAI::Beta::BetaResponsePrompt::OrHash)
          ).void
        end
        attr_writer :prompt

        # Used by OpenAI to cache responses for similar requests to optimize your cache
        # hit rates. Replaces the `user` field.
        # [Learn more](https://platform.openai.com/docs/guides/prompt-caching).
        sig { returns(T.nilable(String)) }
        attr_accessor :prompt_cache_key

        # Options for prompt caching. Supported for `gpt-5.6` and later models. By
        # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        # request can write up to four breakpoints. For cache matching, OpenAI considers
        # up to the latest 80 breakpoints in the conversation, without a content-block
        # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        # `ttl` defaults to `30m`, which is currently the only supported value. See the
        # [prompt caching guide](https://platform.openai.com/docs/guides/prompt-caching)
        # for current details.
        sig do
          returns(
            T.nilable(OpenAI::Beta::ResponseCreateParams::PromptCacheOptions)
          )
        end
        attr_reader :prompt_cache_options

        sig do
          params(
            prompt_cache_options:
              OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::OrHash
          ).void
        end
        attr_writer :prompt_cache_options

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
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::ResponseCreateParams::PromptCacheRetention::OrSymbol
            )
          )
        end
        attr_accessor :prompt_cache_retention

        # **gpt-5 and o-series models only**
        #
        # Configuration options for
        # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        sig do
          returns(T.nilable(OpenAI::Beta::ResponseCreateParams::Reasoning))
        end
        attr_reader :reasoning

        sig do
          params(
            reasoning:
              T.nilable(OpenAI::Beta::ResponseCreateParams::Reasoning::OrHash)
          ).void
        end
        attr_writer :reasoning

        # A stable identifier used to help detect users of your application that may be
        # violating OpenAI's usage policies. The IDs should be a string that uniquely
        # identifies each user, with a maximum length of 64 characters. We recommend
        # hashing their username or email address, in order to avoid sending us any
        # identifying information.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
        sig { returns(T.nilable(String)) }
        attr_accessor :safety_identifier

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
            T.nilable(OpenAI::Beta::ResponseCreateParams::ServiceTier::OrSymbol)
          )
        end
        attr_accessor :service_tier

        # Whether to store the generated model response for later retrieval via API.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :store

        # Options for streaming responses. Only set this when you set `stream: true`.
        sig do
          returns(T.nilable(OpenAI::Beta::ResponseCreateParams::StreamOptions))
        end
        attr_reader :stream_options

        sig do
          params(
            stream_options:
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::StreamOptions::OrHash
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
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseTextConfig)) }
        attr_reader :text

        sig { params(text: OpenAI::Beta::BetaResponseTextConfig::OrHash).void }
        attr_writer :text

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Beta::BetaToolChoiceOptions::OrSymbol,
                OpenAI::Beta::BetaToolChoiceAllowed,
                OpenAI::Beta::BetaToolChoiceTypes,
                OpenAI::Beta::BetaToolChoiceFunction,
                OpenAI::Beta::BetaToolChoiceMcp,
                OpenAI::Beta::BetaToolChoiceCustom,
                OpenAI::Beta::ResponseCreateParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam,
                OpenAI::Beta::BetaToolChoiceApplyPatch,
                OpenAI::Beta::BetaToolChoiceShell
              )
            )
          )
        end
        attr_reader :tool_choice

        sig do
          params(
            tool_choice:
              T.any(
                OpenAI::Beta::BetaToolChoiceOptions::OrSymbol,
                OpenAI::Beta::BetaToolChoiceAllowed::OrHash,
                OpenAI::Beta::BetaToolChoiceTypes::OrHash,
                OpenAI::Beta::BetaToolChoiceFunction::OrHash,
                OpenAI::Beta::BetaToolChoiceMcp::OrHash,
                OpenAI::Beta::BetaToolChoiceCustom::OrHash,
                OpenAI::Beta::ResponseCreateParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam::OrHash,
                OpenAI::Beta::BetaToolChoiceApplyPatch::OrHash,
                OpenAI::Beta::BetaToolChoiceShell::OrHash
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
        #   predefined connectors such as Google Drive and SharePoint. Learn more about
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
                  OpenAI::Beta::BetaFunctionTool,
                  OpenAI::Beta::BetaFileSearchTool,
                  OpenAI::Beta::BetaComputerTool,
                  OpenAI::Beta::BetaComputerUsePreviewTool,
                  OpenAI::Beta::BetaTool::Mcp,
                  OpenAI::Beta::BetaTool::CodeInterpreter,
                  OpenAI::Beta::BetaTool::ProgrammaticToolCalling,
                  OpenAI::Beta::BetaTool::ImageGeneration,
                  OpenAI::Beta::BetaTool::LocalShell,
                  OpenAI::Beta::BetaFunctionShellTool,
                  OpenAI::Beta::BetaCustomTool,
                  OpenAI::Beta::BetaNamespaceTool,
                  OpenAI::Beta::BetaToolSearchTool,
                  OpenAI::Beta::BetaApplyPatchTool,
                  OpenAI::Beta::BetaWebSearchTool,
                  OpenAI::Beta::BetaWebSearchPreviewTool
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
                  OpenAI::Beta::BetaFunctionTool::OrHash,
                  OpenAI::Beta::BetaFileSearchTool::OrHash,
                  OpenAI::Beta::BetaComputerTool::OrHash,
                  OpenAI::Beta::BetaComputerUsePreviewTool::OrHash,
                  OpenAI::Beta::BetaTool::Mcp::OrHash,
                  OpenAI::Beta::BetaTool::CodeInterpreter::OrHash,
                  OpenAI::Beta::BetaTool::ProgrammaticToolCalling::OrHash,
                  OpenAI::Beta::BetaTool::ImageGeneration::OrHash,
                  OpenAI::Beta::BetaTool::LocalShell::OrHash,
                  OpenAI::Beta::BetaFunctionShellTool::OrHash,
                  OpenAI::Beta::BetaCustomTool::OrHash,
                  OpenAI::Beta::BetaNamespaceTool::OrHash,
                  OpenAI::Beta::BetaToolSearchTool::OrHash,
                  OpenAI::Beta::BetaApplyPatchTool::OrHash,
                  OpenAI::Beta::BetaWebSearchTool::OrHash,
                  OpenAI::Beta::BetaWebSearchPreviewTool::OrHash
                )
              ]
          ).void
        end
        attr_writer :tools

        # An integer between 0 and 20 specifying the maximum number of most likely tokens
        # to return at each token position, each with an associated log probability. In
        # some cases, the number of returned tokens may be fewer than requested.
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
        # - `auto`: If the input to this Response exceeds the model's context window size,
        #   the model will truncate the response to fit the context window by dropping
        #   items from the beginning of the conversation.
        # - `disabled` (default): If the input size will exceed the context window size
        #   for a model, the request will fail with a 400 error.
        sig do
          returns(
            T.nilable(OpenAI::Beta::ResponseCreateParams::Truncation::OrSymbol)
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
          returns(
            T.nilable(
              T::Array[OpenAI::Beta::ResponseCreateParams::Beta::OrSymbol]
            )
          )
        end
        attr_reader :betas

        sig do
          params(
            betas: T::Array[OpenAI::Beta::ResponseCreateParams::Beta::OrSymbol]
          ).void
        end
        attr_writer :betas

        sig do
          params(
            background: T.nilable(T::Boolean),
            context_management:
              T.nilable(
                T::Array[
                  OpenAI::Beta::ResponseCreateParams::ContextManagement::OrHash
                ]
              ),
            conversation:
              T.nilable(
                T.any(
                  String,
                  OpenAI::Beta::BetaResponseConversationParam::OrHash
                )
              ),
            include:
              T.nilable(
                T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol]
              ),
            input: OpenAI::Beta::ResponseCreateParams::Input::Variants,
            instructions: T.nilable(String),
            max_output_tokens: T.nilable(Integer),
            max_tool_calls: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            model:
              T.any(
                OpenAI::Beta::ResponseCreateParams::Model::OrSymbol,
                String
              ),
            moderation:
              T.nilable(OpenAI::Beta::ResponseCreateParams::Moderation::OrHash),
            multi_agent:
              T.nilable(OpenAI::Beta::ResponseCreateParams::MultiAgent::OrHash),
            parallel_tool_calls: T.nilable(T::Boolean),
            previous_response_id: T.nilable(String),
            prompt: T.nilable(OpenAI::Beta::BetaResponsePrompt::OrHash),
            prompt_cache_key: T.nilable(String),
            prompt_cache_options:
              OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::OrHash,
            prompt_cache_retention:
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::PromptCacheRetention::OrSymbol
              ),
            reasoning:
              T.nilable(OpenAI::Beta::ResponseCreateParams::Reasoning::OrHash),
            safety_identifier: T.nilable(String),
            service_tier:
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::ServiceTier::OrSymbol
              ),
            store: T.nilable(T::Boolean),
            stream_options:
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::StreamOptions::OrHash
              ),
            temperature: T.nilable(Float),
            text: OpenAI::Beta::BetaResponseTextConfig::OrHash,
            tool_choice:
              T.any(
                OpenAI::Beta::BetaToolChoiceOptions::OrSymbol,
                OpenAI::Beta::BetaToolChoiceAllowed::OrHash,
                OpenAI::Beta::BetaToolChoiceTypes::OrHash,
                OpenAI::Beta::BetaToolChoiceFunction::OrHash,
                OpenAI::Beta::BetaToolChoiceMcp::OrHash,
                OpenAI::Beta::BetaToolChoiceCustom::OrHash,
                OpenAI::Beta::ResponseCreateParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam::OrHash,
                OpenAI::Beta::BetaToolChoiceApplyPatch::OrHash,
                OpenAI::Beta::BetaToolChoiceShell::OrHash
              ),
            tools:
              T::Array[
                T.any(
                  OpenAI::Beta::BetaFunctionTool::OrHash,
                  OpenAI::Beta::BetaFileSearchTool::OrHash,
                  OpenAI::Beta::BetaComputerTool::OrHash,
                  OpenAI::Beta::BetaComputerUsePreviewTool::OrHash,
                  OpenAI::Beta::BetaTool::Mcp::OrHash,
                  OpenAI::Beta::BetaTool::CodeInterpreter::OrHash,
                  OpenAI::Beta::BetaTool::ProgrammaticToolCalling::OrHash,
                  OpenAI::Beta::BetaTool::ImageGeneration::OrHash,
                  OpenAI::Beta::BetaTool::LocalShell::OrHash,
                  OpenAI::Beta::BetaFunctionShellTool::OrHash,
                  OpenAI::Beta::BetaCustomTool::OrHash,
                  OpenAI::Beta::BetaNamespaceTool::OrHash,
                  OpenAI::Beta::BetaToolSearchTool::OrHash,
                  OpenAI::Beta::BetaApplyPatchTool::OrHash,
                  OpenAI::Beta::BetaWebSearchTool::OrHash,
                  OpenAI::Beta::BetaWebSearchPreviewTool::OrHash
                )
              ],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            truncation:
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::Truncation::OrSymbol
              ),
            user: String,
            betas: T::Array[OpenAI::Beta::ResponseCreateParams::Beta::OrSymbol],
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Whether to run the model response in the background.
          # [Learn more](https://platform.openai.com/docs/guides/background).
          background: nil,
          # Context management configuration for this request.
          context_management: nil,
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
          # Configuration for running moderation on the input and output of this response.
          moderation: nil,
          # Configuration for server-hosted multi-agent execution.
          multi_agent: nil,
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
          # Options for prompt caching. Supported for `gpt-5.6` and later models. By
          # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
          # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
          # request can write up to four breakpoints. For cache matching, OpenAI considers
          # up to the latest 80 breakpoints in the conversation, without a content-block
          # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
          # `ttl` defaults to `30m`, which is currently the only supported value. See the
          # [prompt caching guide](https://platform.openai.com/docs/guides/prompt-caching)
          # for current details.
          prompt_cache_options: nil,
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
          prompt_cache_retention: nil,
          # **gpt-5 and o-series models only**
          #
          # Configuration options for
          # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
          reasoning: nil,
          # A stable identifier used to help detect users of your application that may be
          # violating OpenAI's usage policies. The IDs should be a string that uniquely
          # identifies each user, with a maximum length of 64 characters. We recommend
          # hashing their username or email address, in order to avoid sending us any
          # identifying information.
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
          #   predefined connectors such as Google Drive and SharePoint. Learn more about
          #   [MCP Tools](https://platform.openai.com/docs/guides/tools-connectors-mcp).
          # - **Function calls (custom tools)**: Functions that are defined by you, enabling
          #   the model to call your own code with strongly typed arguments and outputs.
          #   Learn more about
          #   [function calling](https://platform.openai.com/docs/guides/function-calling).
          #   You can also use custom tools to call your own code.
          tools: nil,
          # An integer between 0 and 20 specifying the maximum number of most likely tokens
          # to return at each token position, each with an associated log probability. In
          # some cases, the number of returned tokens may be fewer than requested.
          top_logprobs: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          # model considers the results of the tokens with top_p probability mass. So 0.1
          # means only the tokens comprising the top 10% probability mass are considered.
          #
          # We generally recommend altering this or `temperature` but not both.
          top_p: nil,
          # The truncation strategy to use for the model response.
          #
          # - `auto`: If the input to this Response exceeds the model's context window size,
          #   the model will truncate the response to fit the context window by dropping
          #   items from the beginning of the conversation.
          # - `disabled` (default): If the input size will exceed the context window size
          #   for a model, the request will fail with a 400 error.
          truncation: nil,
          # This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
          # `prompt_cache_key` instead to maintain caching optimizations. A stable
          # identifier for your end-users. Used to boost cache hit rates by better bucketing
          # similar requests and to help OpenAI detect and prevent abuse.
          # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
          user: nil,
          betas: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              background: T.nilable(T::Boolean),
              context_management:
                T.nilable(
                  T::Array[
                    OpenAI::Beta::ResponseCreateParams::ContextManagement
                  ]
                ),
              conversation:
                T.nilable(
                  T.any(String, OpenAI::Beta::BetaResponseConversationParam)
                ),
              include:
                T.nilable(
                  T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol]
                ),
              input: OpenAI::Beta::ResponseCreateParams::Input::Variants,
              instructions: T.nilable(String),
              max_output_tokens: T.nilable(Integer),
              max_tool_calls: T.nilable(Integer),
              metadata: T.nilable(T::Hash[Symbol, String]),
              model:
                T.any(
                  OpenAI::Beta::ResponseCreateParams::Model::OrSymbol,
                  String
                ),
              moderation:
                T.nilable(OpenAI::Beta::ResponseCreateParams::Moderation),
              multi_agent:
                T.nilable(OpenAI::Beta::ResponseCreateParams::MultiAgent),
              parallel_tool_calls: T.nilable(T::Boolean),
              previous_response_id: T.nilable(String),
              prompt: T.nilable(OpenAI::Beta::BetaResponsePrompt),
              prompt_cache_key: T.nilable(String),
              prompt_cache_options:
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions,
              prompt_cache_retention:
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::PromptCacheRetention::OrSymbol
                ),
              reasoning:
                T.nilable(OpenAI::Beta::ResponseCreateParams::Reasoning),
              safety_identifier: T.nilable(String),
              service_tier:
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::ServiceTier::OrSymbol
                ),
              store: T.nilable(T::Boolean),
              stream_options:
                T.nilable(OpenAI::Beta::ResponseCreateParams::StreamOptions),
              temperature: T.nilable(Float),
              text: OpenAI::Beta::BetaResponseTextConfig,
              tool_choice:
                T.any(
                  OpenAI::Beta::BetaToolChoiceOptions::OrSymbol,
                  OpenAI::Beta::BetaToolChoiceAllowed,
                  OpenAI::Beta::BetaToolChoiceTypes,
                  OpenAI::Beta::BetaToolChoiceFunction,
                  OpenAI::Beta::BetaToolChoiceMcp,
                  OpenAI::Beta::BetaToolChoiceCustom,
                  OpenAI::Beta::ResponseCreateParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam,
                  OpenAI::Beta::BetaToolChoiceApplyPatch,
                  OpenAI::Beta::BetaToolChoiceShell
                ),
              tools:
                T::Array[
                  T.any(
                    OpenAI::Beta::BetaFunctionTool,
                    OpenAI::Beta::BetaFileSearchTool,
                    OpenAI::Beta::BetaComputerTool,
                    OpenAI::Beta::BetaComputerUsePreviewTool,
                    OpenAI::Beta::BetaTool::Mcp,
                    OpenAI::Beta::BetaTool::CodeInterpreter,
                    OpenAI::Beta::BetaTool::ProgrammaticToolCalling,
                    OpenAI::Beta::BetaTool::ImageGeneration,
                    OpenAI::Beta::BetaTool::LocalShell,
                    OpenAI::Beta::BetaFunctionShellTool,
                    OpenAI::Beta::BetaCustomTool,
                    OpenAI::Beta::BetaNamespaceTool,
                    OpenAI::Beta::BetaToolSearchTool,
                    OpenAI::Beta::BetaApplyPatchTool,
                    OpenAI::Beta::BetaWebSearchTool,
                    OpenAI::Beta::BetaWebSearchPreviewTool
                  )
                ],
              top_logprobs: T.nilable(Integer),
              top_p: T.nilable(Float),
              truncation:
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::Truncation::OrSymbol
                ),
              user: String,
              betas:
                T::Array[OpenAI::Beta::ResponseCreateParams::Beta::OrSymbol],
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        class ContextManagement < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ResponseCreateParams::ContextManagement,
                OpenAI::Internal::AnyHash
              )
            end

          # The context management entry type. Currently only 'compaction' is supported.
          sig { returns(String) }
          attr_accessor :type

          # Token threshold at which compaction should be triggered for this entry.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :compact_threshold

          sig do
            params(type: String, compact_threshold: T.nilable(Integer)).returns(
              T.attached_class
            )
          end
          def self.new(
            # The context management entry type. Currently only 'compaction' is supported.
            type:,
            # Token threshold at which compaction should be triggered for this entry.
            compact_threshold: nil
          )
          end

          sig do
            override.returns(
              { type: String, compact_threshold: T.nilable(Integer) }
            )
          end
          def to_hash
          end
        end

        # The conversation that this response belongs to. Items from this conversation are
        # prepended to `input_items` for this response request. Input items and output
        # items from this response are automatically added to this conversation after this
        # response completes.
        module Conversation
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(String, OpenAI::Beta::BetaResponseConversationParam)
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::ResponseCreateParams::Conversation::Variants
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
                T::Array[OpenAI::Beta::BetaResponseInputItem::Variants]
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ResponseCreateParams::Input::Variants]
            )
          end
          def self.variants
          end
        end

        # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
        # wide range of models with different capabilities, performance characteristics,
        # and price points. Refer to the
        # [model guide](https://platform.openai.com/docs/models) to browse and compare
        # available models.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol,
                String
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ResponseCreateParams::Model::Variants]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::ResponseCreateParams::Model)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          GPT_5_6_SOL =
            T.let(
              :"gpt-5.6-sol",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_6_TERRA =
            T.let(
              :"gpt-5.6-terra",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_6_LUNA =
            T.let(
              :"gpt-5.6-luna",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_4 =
            T.let(
              :"gpt-5.4",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_4_MINI =
            T.let(
              :"gpt-5.4-mini",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_4_NANO =
            T.let(
              :"gpt-5.4-nano",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_4_MINI_2026_03_17 =
            T.let(
              :"gpt-5.4-mini-2026-03-17",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_4_NANO_2026_03_17 =
            T.let(
              :"gpt-5.4-nano-2026-03-17",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_3_CHAT_LATEST =
            T.let(
              :"gpt-5.3-chat-latest",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_2 =
            T.let(
              :"gpt-5.2",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_2_2025_12_11 =
            T.let(
              :"gpt-5.2-2025-12-11",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_2_CHAT_LATEST =
            T.let(
              :"gpt-5.2-chat-latest",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_2_PRO =
            T.let(
              :"gpt-5.2-pro",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_2_PRO_2025_12_11 =
            T.let(
              :"gpt-5.2-pro-2025-12-11",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_1 =
            T.let(
              :"gpt-5.1",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_1_2025_11_13 =
            T.let(
              :"gpt-5.1-2025-11-13",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_1_CODEX =
            T.let(
              :"gpt-5.1-codex",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_1_MINI =
            T.let(
              :"gpt-5.1-mini",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_1_CHAT_LATEST =
            T.let(
              :"gpt-5.1-chat-latest",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5 =
            T.let(
              :"gpt-5",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_MINI =
            T.let(
              :"gpt-5-mini",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_NANO =
            T.let(
              :"gpt-5-nano",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_2025_08_07 =
            T.let(
              :"gpt-5-2025-08-07",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_MINI_2025_08_07 =
            T.let(
              :"gpt-5-mini-2025-08-07",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_NANO_2025_08_07 =
            T.let(
              :"gpt-5-nano-2025-08-07",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_CHAT_LATEST =
            T.let(
              :"gpt-5-chat-latest",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_1 =
            T.let(
              :"gpt-4.1",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_1_MINI =
            T.let(
              :"gpt-4.1-mini",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_1_NANO =
            T.let(
              :"gpt-4.1-nano",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_1_2025_04_14 =
            T.let(
              :"gpt-4.1-2025-04-14",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_1_MINI_2025_04_14 =
            T.let(
              :"gpt-4.1-mini-2025-04-14",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_1_NANO_2025_04_14 =
            T.let(
              :"gpt-4.1-nano-2025-04-14",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O4_MINI =
            T.let(
              :"o4-mini",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O4_MINI_2025_04_16 =
            T.let(
              :"o4-mini-2025-04-16",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O3 =
            T.let(:o3, OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol)
          O3_2025_04_16 =
            T.let(
              :"o3-2025-04-16",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O3_MINI =
            T.let(
              :"o3-mini",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O3_MINI_2025_01_31 =
            T.let(
              :"o3-mini-2025-01-31",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O1 =
            T.let(:o1, OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol)
          O1_2024_12_17 =
            T.let(
              :"o1-2024-12-17",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O1_PREVIEW =
            T.let(
              :"o1-preview",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O1_PREVIEW_2024_09_12 =
            T.let(
              :"o1-preview-2024-09-12",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O1_MINI =
            T.let(
              :"o1-mini",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O1_MINI_2024_09_12 =
            T.let(
              :"o1-mini-2024-09-12",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O =
            T.let(
              :"gpt-4o",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_2024_11_20 =
            T.let(
              :"gpt-4o-2024-11-20",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_2024_08_06 =
            T.let(
              :"gpt-4o-2024-08-06",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_2024_05_13 =
            T.let(
              :"gpt-4o-2024-05-13",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW =
            T.let(
              :"gpt-4o-audio-preview",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW_2024_10_01 =
            T.let(
              :"gpt-4o-audio-preview-2024-10-01",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-audio-preview-2024-12-17",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW_2025_06_03 =
            T.let(
              :"gpt-4o-audio-preview-2025-06-03",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_AUDIO_PREVIEW =
            T.let(
              :"gpt-4o-mini-audio-preview",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_AUDIO_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-mini-audio-preview-2024-12-17",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_SEARCH_PREVIEW =
            T.let(
              :"gpt-4o-search-preview",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_SEARCH_PREVIEW =
            T.let(
              :"gpt-4o-mini-search-preview",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_SEARCH_PREVIEW_2025_03_11 =
            T.let(
              :"gpt-4o-search-preview-2025-03-11",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_SEARCH_PREVIEW_2025_03_11 =
            T.let(
              :"gpt-4o-mini-search-preview-2025-03-11",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          CHATGPT_4O_LATEST =
            T.let(
              :"chatgpt-4o-latest",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          CODEX_MINI_LATEST =
            T.let(
              :"codex-mini-latest",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_MINI =
            T.let(
              :"gpt-4o-mini",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_2024_07_18 =
            T.let(
              :"gpt-4o-mini-2024-07-18",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_TURBO =
            T.let(
              :"gpt-4-turbo",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_TURBO_2024_04_09 =
            T.let(
              :"gpt-4-turbo-2024-04-09",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_0125_PREVIEW =
            T.let(
              :"gpt-4-0125-preview",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_TURBO_PREVIEW =
            T.let(
              :"gpt-4-turbo-preview",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_1106_PREVIEW =
            T.let(
              :"gpt-4-1106-preview",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_VISION_PREVIEW =
            T.let(
              :"gpt-4-vision-preview",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4 =
            T.let(
              :"gpt-4",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_0314 =
            T.let(
              :"gpt-4-0314",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_0613 =
            T.let(
              :"gpt-4-0613",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_32K =
            T.let(
              :"gpt-4-32k",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_32K_0314 =
            T.let(
              :"gpt-4-32k-0314",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_4_32K_0613 =
            T.let(
              :"gpt-4-32k-0613",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO =
            T.let(
              :"gpt-3.5-turbo",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_16K =
            T.let(
              :"gpt-3.5-turbo-16k",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_0301 =
            T.let(
              :"gpt-3.5-turbo-0301",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_0613 =
            T.let(
              :"gpt-3.5-turbo-0613",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_1106 =
            T.let(
              :"gpt-3.5-turbo-1106",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_0125 =
            T.let(
              :"gpt-3.5-turbo-0125",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_16K_0613 =
            T.let(
              :"gpt-3.5-turbo-16k-0613",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O1_PRO =
            T.let(
              :"o1-pro",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O1_PRO_2025_03_19 =
            T.let(
              :"o1-pro-2025-03-19",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O3_PRO =
            T.let(
              :"o3-pro",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O3_PRO_2025_06_10 =
            T.let(
              :"o3-pro-2025-06-10",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O3_DEEP_RESEARCH =
            T.let(
              :"o3-deep-research",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O3_DEEP_RESEARCH_2025_06_26 =
            T.let(
              :"o3-deep-research-2025-06-26",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O4_MINI_DEEP_RESEARCH =
            T.let(
              :"o4-mini-deep-research",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          O4_MINI_DEEP_RESEARCH_2025_06_26 =
            T.let(
              :"o4-mini-deep-research-2025-06-26",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          COMPUTER_USE_PREVIEW =
            T.let(
              :"computer-use-preview",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          COMPUTER_USE_PREVIEW_2025_03_11 =
            T.let(
              :"computer-use-preview-2025-03-11",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_CODEX =
            T.let(
              :"gpt-5-codex",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_PRO =
            T.let(
              :"gpt-5-pro",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_PRO_2025_10_06 =
            T.let(
              :"gpt-5-pro-2025-10-06",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
          GPT_5_1_CODEX_MAX =
            T.let(
              :"gpt-5.1-codex-max",
              OpenAI::Beta::ResponseCreateParams::Model::TaggedSymbol
            )
        end

        class Moderation < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ResponseCreateParams::Moderation,
                OpenAI::Internal::AnyHash
              )
            end

          # The moderation model to use for moderated completions, e.g.
          # 'omni-moderation-latest'.
          sig { returns(String) }
          attr_accessor :model

          # The policy to apply to moderated response input and output.
          sig do
            returns(
              T.nilable(OpenAI::Beta::ResponseCreateParams::Moderation::Policy)
            )
          end
          attr_reader :policy

          sig do
            params(
              policy:
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::Moderation::Policy::OrHash
                )
            ).void
          end
          attr_writer :policy

          # Configuration for running moderation on the input and output of this response.
          sig do
            params(
              model: String,
              policy:
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::Moderation::Policy::OrHash
                )
            ).returns(T.attached_class)
          end
          def self.new(
            # The moderation model to use for moderated completions, e.g.
            # 'omni-moderation-latest'.
            model:,
            # The policy to apply to moderated response input and output.
            policy: nil
          )
          end

          sig do
            override.returns(
              {
                model: String,
                policy:
                  T.nilable(
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy
                  )
              }
            )
          end
          def to_hash
          end

          class Policy < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ResponseCreateParams::Moderation::Policy,
                  OpenAI::Internal::AnyHash
                )
              end

            # The moderation policy for the response input.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input
                )
              )
            end
            attr_reader :input

            sig do
              params(
                input:
                  T.nilable(
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input::OrHash
                  )
              ).void
            end
            attr_writer :input

            # The moderation policy for the response output.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output
                )
              )
            end
            attr_reader :output

            sig do
              params(
                output:
                  T.nilable(
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output::OrHash
                  )
              ).void
            end
            attr_writer :output

            # The policy to apply to moderated response input and output.
            sig do
              params(
                input:
                  T.nilable(
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input::OrHash
                  ),
                output:
                  T.nilable(
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output::OrHash
                  )
              ).returns(T.attached_class)
            end
            def self.new(
              # The moderation policy for the response input.
              input: nil,
              # The moderation policy for the response output.
              output: nil
            )
            end

            sig do
              override.returns(
                {
                  input:
                    T.nilable(
                      OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input
                    ),
                  output:
                    T.nilable(
                      OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output
                    )
                }
              )
            end
            def to_hash
            end

            class Input < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig do
                returns(
                  OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input::Mode::OrSymbol
                )
              end
              attr_accessor :mode

              # The moderation policy for the response input.
              sig do
                params(
                  mode:
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input::Mode::OrSymbol
                ).returns(T.attached_class)
              end
              def self.new(mode:)
              end

              sig do
                override.returns(
                  {
                    mode:
                      OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input::Mode::OrSymbol
                  }
                )
              end
              def to_hash
              end

              module Mode
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input::Mode
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                SCORE =
                  T.let(
                    :score,
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input::Mode::TaggedSymbol
                  )
                BLOCK =
                  T.let(
                    :block,
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input::Mode::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Input::Mode::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end
            end

            class Output < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig do
                returns(
                  OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output::Mode::OrSymbol
                )
              end
              attr_accessor :mode

              # The moderation policy for the response output.
              sig do
                params(
                  mode:
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output::Mode::OrSymbol
                ).returns(T.attached_class)
              end
              def self.new(mode:)
              end

              sig do
                override.returns(
                  {
                    mode:
                      OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output::Mode::OrSymbol
                  }
                )
              end
              def to_hash
              end

              module Mode
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output::Mode
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                SCORE =
                  T.let(
                    :score,
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output::Mode::TaggedSymbol
                  )
                BLOCK =
                  T.let(
                    :block,
                    OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output::Mode::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::ResponseCreateParams::Moderation::Policy::Output::Mode::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end
            end
          end
        end

        class MultiAgent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ResponseCreateParams::MultiAgent,
                OpenAI::Internal::AnyHash
              )
            end

          # Whether to enable server-hosted multi-agent execution for this response.
          sig { returns(T::Boolean) }
          attr_accessor :enabled

          # `max_concurrent_subagents` sets the maximum number of subagents that can be
          # active simultaneously across the entire agent tree. It includes all
          # descendants—children, grandchildren, and deeper subagents—but excludes the root
          # agent. The API does not impose a fixed upper bound on this setting. The default
          # is `3`, which is recommended for most workloads. Multi-agent runs also have no
          # fixed limit on tree depth or the total number of subagents created during a run.
          sig { returns(T.nilable(Integer)) }
          attr_reader :max_concurrent_subagents

          sig { params(max_concurrent_subagents: Integer).void }
          attr_writer :max_concurrent_subagents

          # Configuration for server-hosted multi-agent execution.
          sig do
            params(
              enabled: T::Boolean,
              max_concurrent_subagents: Integer
            ).returns(T.attached_class)
          end
          def self.new(
            # Whether to enable server-hosted multi-agent execution for this response.
            enabled:,
            # `max_concurrent_subagents` sets the maximum number of subagents that can be
            # active simultaneously across the entire agent tree. It includes all
            # descendants—children, grandchildren, and deeper subagents—but excludes the root
            # agent. The API does not impose a fixed upper bound on this setting. The default
            # is `3`, which is recommended for most workloads. Multi-agent runs also have no
            # fixed limit on tree depth or the total number of subagents created during a run.
            max_concurrent_subagents: nil
          )
          end

          sig do
            override.returns(
              { enabled: T::Boolean, max_concurrent_subagents: Integer }
            )
          end
          def to_hash
          end
        end

        class PromptCacheOptions < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions,
                OpenAI::Internal::AnyHash
              )
            end

          # Controls whether OpenAI automatically creates an implicit cache breakpoint.
          # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
          # and writes up to the latest three explicit breakpoints in the request. With
          # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
          # latest four explicit breakpoints. If there are no explicit breakpoints, the
          # request does not use prompt caching.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Mode::OrSymbol
              )
            )
          end
          attr_reader :mode

          sig do
            params(
              mode:
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Mode::OrSymbol
            ).void
          end
          attr_writer :mode

          # The minimum lifetime applied to every implicit and explicit cache breakpoint
          # written by the request. Defaults to `30m`, which is currently the only supported
          # value. The backend may retain cache entries for longer.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Ttl::OrSymbol
              )
            )
          end
          attr_reader :ttl

          sig do
            params(
              ttl:
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Ttl::OrSymbol
            ).void
          end
          attr_writer :ttl

          # Options for prompt caching. Supported for `gpt-5.6` and later models. By
          # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
          # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
          # request can write up to four breakpoints. For cache matching, OpenAI considers
          # up to the latest 80 breakpoints in the conversation, without a content-block
          # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
          # `ttl` defaults to `30m`, which is currently the only supported value. See the
          # [prompt caching guide](https://platform.openai.com/docs/guides/prompt-caching)
          # for current details.
          sig do
            params(
              mode:
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Mode::OrSymbol,
              ttl:
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Ttl::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Controls whether OpenAI automatically creates an implicit cache breakpoint.
            # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
            # and writes up to the latest three explicit breakpoints in the request. With
            # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
            # latest four explicit breakpoints. If there are no explicit breakpoints, the
            # request does not use prompt caching.
            mode: nil,
            # The minimum lifetime applied to every implicit and explicit cache breakpoint
            # written by the request. Defaults to `30m`, which is currently the only supported
            # value. The backend may retain cache entries for longer.
            ttl: nil
          )
          end

          sig do
            override.returns(
              {
                mode:
                  OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Mode::OrSymbol,
                ttl:
                  OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Ttl::OrSymbol
              }
            )
          end
          def to_hash
          end

          # Controls whether OpenAI automatically creates an implicit cache breakpoint.
          # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
          # and writes up to the latest three explicit breakpoints in the request. With
          # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
          # latest four explicit breakpoints. If there are no explicit breakpoints, the
          # request does not use prompt caching.
          module Mode
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Mode
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IMPLICIT =
              T.let(
                :implicit,
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Mode::TaggedSymbol
              )
            EXPLICIT =
              T.let(
                :explicit,
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Mode::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Mode::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # The minimum lifetime applied to every implicit and explicit cache breakpoint
          # written by the request. Defaults to `30m`, which is currently the only supported
          # value. The backend may retain cache entries for longer.
          module Ttl
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Ttl
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            TTL_30M =
              T.let(
                :"30m",
                OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Ttl::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ResponseCreateParams::PromptCacheOptions::Ttl::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

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
        module PromptCacheRetention
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Beta::ResponseCreateParams::PromptCacheRetention
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_MEMORY =
            T.let(
              :in_memory,
              OpenAI::Beta::ResponseCreateParams::PromptCacheRetention::TaggedSymbol
            )
          PROMPT_CACHE_RETENTION_24H =
            T.let(
              :"24h",
              OpenAI::Beta::ResponseCreateParams::PromptCacheRetention::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::ResponseCreateParams::PromptCacheRetention::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class Reasoning < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ResponseCreateParams::Reasoning,
                OpenAI::Internal::AnyHash
              )
            end

          # Controls which reasoning items are rendered back to the model on later turns. If
          # omitted or set to `auto`, the model determines the context mode. The `gpt-5.6`
          # model family defaults to `all_turns`; earlier models default to `current_turn`.
          #
          # When returned on a response, this is the effective reasoning context mode used
          # for the response.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::Reasoning::Context::OrSymbol
              )
            )
          end
          attr_accessor :context

          # Constrains effort on reasoning for reasoning models. Currently supported values
          # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
          # reasoning effort can result in faster responses and fewer tokens used on
          # reasoning in a response. Not all reasoning models support every value. See the
          # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
          # model-specific support.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::OrSymbol
              )
            )
          end
          attr_accessor :effort

          # **Deprecated:** use `summary` instead.
          #
          # A summary of the reasoning performed by the model. This can be useful for
          # debugging and understanding the model's reasoning process. One of `auto`,
          # `concise`, or `detailed`.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::Reasoning::GenerateSummary::OrSymbol
              )
            )
          end
          attr_accessor :generate_summary

          # Controls the reasoning execution mode for the request.
          #
          # When returned on a response, this is the effective execution mode.
          sig do
            returns(
              T.nilable(
                T.any(
                  String,
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Mode::OrSymbol
                )
              )
            )
          end
          attr_reader :mode

          sig do
            params(
              mode:
                T.any(
                  String,
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Mode::OrSymbol
                )
            ).void
          end
          attr_writer :mode

          # A summary of the reasoning performed by the model. This can be useful for
          # debugging and understanding the model's reasoning process. One of `auto`,
          # `concise`, or `detailed`.
          #
          # `concise` is supported for `computer-use-preview` models and all reasoning
          # models after `gpt-5`.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ResponseCreateParams::Reasoning::Summary::OrSymbol
              )
            )
          end
          attr_accessor :summary

          # **gpt-5 and o-series models only**
          #
          # Configuration options for
          # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
          sig do
            params(
              context:
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Context::OrSymbol
                ),
              effort:
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::OrSymbol
                ),
              generate_summary:
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::Reasoning::GenerateSummary::OrSymbol
                ),
              mode:
                T.any(
                  String,
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Mode::OrSymbol
                ),
              summary:
                T.nilable(
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Summary::OrSymbol
                )
            ).returns(T.attached_class)
          end
          def self.new(
            # Controls which reasoning items are rendered back to the model on later turns. If
            # omitted or set to `auto`, the model determines the context mode. The `gpt-5.6`
            # model family defaults to `all_turns`; earlier models default to `current_turn`.
            #
            # When returned on a response, this is the effective reasoning context mode used
            # for the response.
            context: nil,
            # Constrains effort on reasoning for reasoning models. Currently supported values
            # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
            # reasoning effort can result in faster responses and fewer tokens used on
            # reasoning in a response. Not all reasoning models support every value. See the
            # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
            # model-specific support.
            effort: nil,
            # **Deprecated:** use `summary` instead.
            #
            # A summary of the reasoning performed by the model. This can be useful for
            # debugging and understanding the model's reasoning process. One of `auto`,
            # `concise`, or `detailed`.
            generate_summary: nil,
            # Controls the reasoning execution mode for the request.
            #
            # When returned on a response, this is the effective execution mode.
            mode: nil,
            # A summary of the reasoning performed by the model. This can be useful for
            # debugging and understanding the model's reasoning process. One of `auto`,
            # `concise`, or `detailed`.
            #
            # `concise` is supported for `computer-use-preview` models and all reasoning
            # models after `gpt-5`.
            summary: nil
          )
          end

          sig do
            override.returns(
              {
                context:
                  T.nilable(
                    OpenAI::Beta::ResponseCreateParams::Reasoning::Context::OrSymbol
                  ),
                effort:
                  T.nilable(
                    OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::OrSymbol
                  ),
                generate_summary:
                  T.nilable(
                    OpenAI::Beta::ResponseCreateParams::Reasoning::GenerateSummary::OrSymbol
                  ),
                mode:
                  T.any(
                    String,
                    OpenAI::Beta::ResponseCreateParams::Reasoning::Mode::OrSymbol
                  ),
                summary:
                  T.nilable(
                    OpenAI::Beta::ResponseCreateParams::Reasoning::Summary::OrSymbol
                  )
              }
            )
          end
          def to_hash
          end

          # Controls which reasoning items are rendered back to the model on later turns. If
          # omitted or set to `auto`, the model determines the context mode. The `gpt-5.6`
          # model family defaults to `all_turns`; earlier models default to `current_turn`.
          #
          # When returned on a response, this is the effective reasoning context mode used
          # for the response.
          module Context
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Context
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Context::TaggedSymbol
              )
            CURRENT_TURN =
              T.let(
                :current_turn,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Context::TaggedSymbol
              )
            ALL_TURNS =
              T.let(
                :all_turns,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Context::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Context::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # Constrains effort on reasoning for reasoning models. Currently supported values
          # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
          # reasoning effort can result in faster responses and fewer tokens used on
          # reasoning in a response. Not all reasoning models support every value. See the
          # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
          # model-specific support.
          module Effort
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Effort
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            NONE =
              T.let(
                :none,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::TaggedSymbol
              )
            MINIMAL =
              T.let(
                :minimal,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::TaggedSymbol
              )
            LOW =
              T.let(
                :low,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::TaggedSymbol
              )
            MEDIUM =
              T.let(
                :medium,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::TaggedSymbol
              )
            HIGH =
              T.let(
                :high,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::TaggedSymbol
              )
            XHIGH =
              T.let(
                :xhigh,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::TaggedSymbol
              )
            MAX =
              T.let(
                :max,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Effort::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # **Deprecated:** use `summary` instead.
          #
          # A summary of the reasoning performed by the model. This can be useful for
          # debugging and understanding the model's reasoning process. One of `auto`,
          # `concise`, or `detailed`.
          module GenerateSummary
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::ResponseCreateParams::Reasoning::GenerateSummary
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Beta::ResponseCreateParams::Reasoning::GenerateSummary::TaggedSymbol
              )
            CONCISE =
              T.let(
                :concise,
                OpenAI::Beta::ResponseCreateParams::Reasoning::GenerateSummary::TaggedSymbol
              )
            DETAILED =
              T.let(
                :detailed,
                OpenAI::Beta::ResponseCreateParams::Reasoning::GenerateSummary::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ResponseCreateParams::Reasoning::GenerateSummary::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # Controls the reasoning execution mode for the request.
          #
          # When returned on a response, this is the effective execution mode.
          module Mode
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  String,
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Mode::TaggedSymbol
                )
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Mode::Variants
                ]
              )
            end
            def self.variants
            end

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Mode
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            STANDARD =
              T.let(
                :standard,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Mode::TaggedSymbol
              )
            PRO =
              T.let(
                :pro,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Mode::TaggedSymbol
              )
          end

          # A summary of the reasoning performed by the model. This can be useful for
          # debugging and understanding the model's reasoning process. One of `auto`,
          # `concise`, or `detailed`.
          #
          # `concise` is supported for `computer-use-preview` models and all reasoning
          # models after `gpt-5`.
          module Summary
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Summary
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Summary::TaggedSymbol
              )
            CONCISE =
              T.let(
                :concise,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Summary::TaggedSymbol
              )
            DETAILED =
              T.let(
                :detailed,
                OpenAI::Beta::ResponseCreateParams::Reasoning::Summary::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ResponseCreateParams::Reasoning::Summary::TaggedSymbol
                ]
              )
            end
            def self.values
            end
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
              T.all(Symbol, OpenAI::Beta::ResponseCreateParams::ServiceTier)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Beta::ResponseCreateParams::ServiceTier::TaggedSymbol
            )
          DEFAULT =
            T.let(
              :default,
              OpenAI::Beta::ResponseCreateParams::ServiceTier::TaggedSymbol
            )
          FLEX =
            T.let(
              :flex,
              OpenAI::Beta::ResponseCreateParams::ServiceTier::TaggedSymbol
            )
          SCALE =
            T.let(
              :scale,
              OpenAI::Beta::ResponseCreateParams::ServiceTier::TaggedSymbol
            )
          PRIORITY =
            T.let(
              :priority,
              OpenAI::Beta::ResponseCreateParams::ServiceTier::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::ResponseCreateParams::ServiceTier::TaggedSymbol
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
                OpenAI::Beta::ResponseCreateParams::StreamOptions,
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
                OpenAI::Beta::BetaToolChoiceOptions::TaggedSymbol,
                OpenAI::Beta::BetaToolChoiceAllowed,
                OpenAI::Beta::BetaToolChoiceTypes,
                OpenAI::Beta::BetaToolChoiceFunction,
                OpenAI::Beta::BetaToolChoiceMcp,
                OpenAI::Beta::BetaToolChoiceCustom,
                OpenAI::Beta::ResponseCreateParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam,
                OpenAI::Beta::BetaToolChoiceApplyPatch,
                OpenAI::Beta::BetaToolChoiceShell
              )
            end

          class BetaSpecificProgrammaticToolCallingParam < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ResponseCreateParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam,
                  OpenAI::Internal::AnyHash
                )
              end

            # The tool to call. Always `programmatic_tool_calling`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(
              # The tool to call. Always `programmatic_tool_calling`.
              type: :programmatic_tool_calling
            )
            end

            sig { override.returns({ type: Symbol }) }
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ResponseCreateParams::ToolChoice::Variants]
            )
          end
          def self.variants
          end
        end

        # The truncation strategy to use for the model response.
        #
        # - `auto`: If the input to this Response exceeds the model's context window size,
        #   the model will truncate the response to fit the context window by dropping
        #   items from the beginning of the conversation.
        # - `disabled` (default): If the input size will exceed the context window size
        #   for a model, the request will fail with a 400 error.
        module Truncation
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::ResponseCreateParams::Truncation)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Beta::ResponseCreateParams::Truncation::TaggedSymbol
            )
          DISABLED =
            T.let(
              :disabled,
              OpenAI::Beta::ResponseCreateParams::Truncation::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::ResponseCreateParams::Truncation::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module Beta
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::ResponseCreateParams::Beta)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          RESPONSES_MULTI_AGENT_V1 =
            T.let(
              :"responses_multi_agent=v1",
              OpenAI::Beta::ResponseCreateParams::Beta::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ResponseCreateParams::Beta::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
