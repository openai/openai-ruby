# typed: strong

module OpenAI
  module Helpers
    module Streaming
      class ResponseStream
        include OpenAI::Internal::Type::BaseStream

        # Define the type union for streaming events that can be yielded
        ResponseStreamEvent = T.type_alias do
          T.any(
            OpenAI::Streaming::ResponseTextDeltaEvent,
            OpenAI::Streaming::ResponseTextDoneEvent,
            OpenAI::Streaming::ResponseCompletedEvent,
            OpenAI::Streaming::ResponseFunctionCallArgumentsDeltaEvent,
            OpenAI::Streaming::UnknownStreamEvent,
            # Pass through other raw events
            OpenAI::Models::Responses::ResponseStreamEvent::Variants
          )
        end

        Message = type_member { {fixed: ResponseStreamEvent} }
        Elem = type_member { {fixed: ResponseStreamEvent} }

        sig do
          params(
            raw_stream: T.untyped,
            text_format: T.untyped,
            starting_after: T.nilable(Integer)
          )
            .void
        end
        def initialize(raw_stream:, text_format:, starting_after:)
        end

        sig { void }
        def close
        end

        sig { returns(T.self_type) }
        def until_done
        end

        sig { returns(OpenAI::Models::Responses::Response) }
        def get_final_response
        end

        sig { returns(String) }
        def get_output_text
        end

        sig { returns(T::Enumerator[String]) }
        def text
        end

        # Override the each method to properly type the yielded events
        sig do
          params(
            block: T.nilable(T.proc.params(event: ResponseStreamEvent).void)
          )
            .returns(T.any(T.self_type, T::Enumerator[ResponseStreamEvent]))
        end
        def each(&block)
        end

        private

        sig { returns(T.untyped) }
        def iterator
        end

        sig { params(event: ResponseStreamEvent).returns(T::Boolean) }
        def after_starting_event?(event)
        end
      end

      class ResponseStreamState
        sig { returns(T.nilable(OpenAI::Models::Responses::Response)) }
        attr_reader :completed_response

        sig { params(text_format: T.untyped, starting_after: T.nilable(Integer)).void }
        def initialize(text_format:, starting_after: nil)
        end

        sig { params(event: T.untyped, text_only: T::Boolean).returns(T::Array[T.untyped]) }
        def handle_event(event, text_only: false)
        end

        sig do
          params(
            event: T.untyped,
            current_snapshot: T.nilable(OpenAI::Models::Responses::Response)
          )
            .returns(T.nilable(OpenAI::Models::Responses::Response))
        end
        def accumulate_event(event:, current_snapshot:)
        end

        # @api private
        sig { params(event: T.untyped, items: T::Array[T.untyped]).void }
        def accumulate_output(event, items)
        end

        private

        sig { params(value: String, delta: String).returns(String) }
        def append_delta(value, delta)
        end

        sig { params(text: T.nilable(String)).returns(T.untyped) }
        def parse_structured_text(text)
        end

        sig { params(object: T.untyped, expected_type: Symbol).void }
        def assert_type(object, expected_type)
        end
      end
    end
  end
end

module OpenAI
  module Resources
    class Responses
      # See {OpenAI::Resources::Responses#create} for non-streaming counterpart.
      #
      # Creates a model response. Provide
      # [text](https://developers.openai.com/api/docs/guides/text) or
      # [image](https://developers.openai.com/api/docs/guides/images-vision) inputs to generate
      # [text](https://developers.openai.com/api/docs/guides/text) or
      # [JSON](https://developers.openai.com/api/docs/guides/structured-outputs) outputs. Have
      # the model call your own
      # [custom code](https://developers.openai.com/api/docs/guides/function-calling) or use
      # built-in [tools](https://developers.openai.com/api/docs/guides/tools) like
      # [web search](https://developers.openai.com/api/docs/guides/tools-web-search) or
      # [file search](https://developers.openai.com/api/docs/guides/tools-file-search) to use
      # your own data as input for the model's response.
      sig do
        params(
          access_programs: OpenAI::Responses::ResponseCreateParams::AccessPrograms::OrHash,
          background: T.nilable(T::Boolean),
          include: T.nilable(
            T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
          ),
          input: T.nilable(OpenAI::Responses::ResponseCreateParams::Input::Variants),
          instructions: T.nilable(String),
          max_output_tokens: T.nilable(Integer),
          max_tool_calls: T.nilable(Integer),
          metadata: T.nilable(T::Hash[Symbol, String]),
          model: T.nilable(
            T.any(
              String,
              OpenAI::ChatModel::OrSymbol,
              OpenAI::ResponsesModel::ResponsesOnlyModel::OrSymbol
            )
          ),
          parallel_tool_calls: T.nilable(T::Boolean),
          previous_response_id: T.nilable(String),
          prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
          prompt_cache_key: String,
          prompt_cache_options: T.nilable(OpenAI::Responses::ResponseCreateParams::PromptCacheOptions::OrHash),
          prompt_cache_retention: T.nilable(OpenAI::Responses::ResponseCreateParams::PromptCacheRetention::OrSymbol),
          reasoning: T.nilable(OpenAI::Reasoning::OrHash),
          response_id: T.nilable(String),
          safety_identifier: String,
          service_tier: T.nilable(
            OpenAI::Responses::ResponseCreateParams::ServiceTier::OrSymbol
          ),
          starting_after: T.nilable(Integer),
          store: T.nilable(T::Boolean),
          temperature: T.nilable(Float),
          text: T.nilable(
            T.any(
              OpenAI::Responses::ResponseTextConfig::OrHash,
              OpenAI::StructuredOutput::JsonSchemaConverter
            )
          ),
          tool_choice: T.any(
            OpenAI::Responses::ToolChoiceOptions::OrSymbol,
            OpenAI::Responses::ToolChoiceAllowed::OrHash,
            OpenAI::Responses::ToolChoiceTypes::OrHash,
            OpenAI::Responses::ToolChoiceFunction::OrHash,
            OpenAI::Responses::ToolChoiceMcp::OrHash
          ),
          tools: T.nilable(
            T::Array[
              T.any(
                OpenAI::StructuredOutput::JsonSchemaConverter,
                OpenAI::Responses::FunctionTool::OrHash,
                OpenAI::Responses::FileSearchTool::OrHash,
                OpenAI::Responses::ComputerTool::OrHash,
                OpenAI::Responses::Tool::Mcp::OrHash,
                OpenAI::Responses::Tool::CodeInterpreter::OrHash,
                OpenAI::Responses::Tool::ImageGeneration::OrHash,
                OpenAI::Responses::Tool::LocalShell::OrHash,
                OpenAI::Responses::WebSearchTool::OrHash
              )
            ]
          ),
          top_logprobs: T.nilable(Integer),
          top_p: T.nilable(Float),
          truncation: T.nilable(
            OpenAI::Responses::ResponseCreateParams::Truncation::OrSymbol
          ),
          user: String,
          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(OpenAI::Streaming::ResponseStream)
      end
      def stream(
        # Domain-specific access programs to use for this request.
        access_programs: nil,
        # Whether to run the model response in the background.
        # [Learn more](https://developers.openai.com/api/docs/guides/background).
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
        # - [Text inputs and outputs](https://developers.openai.com/api/docs/guides/text)
        # - [Image inputs](https://developers.openai.com/api/docs/guides/images-vision)
        # - [File inputs](https://developers.openai.com/api/docs/guides/file-inputs)
        # - [Conversation state](https://developers.openai.com/api/docs/guides/conversation-state)
        # - [Function calling](https://developers.openai.com/api/docs/guides/function-calling)
        input: nil,
        # A system (or developer) message inserted into the model's context.
        #
        # When using along with `previous_response_id`, the instructions from a previous
        # response will not be carried over to the next response. This makes it simple to
        # swap out system (or developer) messages in new responses.
        instructions: nil,
        # An upper bound for the number of tokens that can be generated for a response,
        # including visible output tokens and
        # [reasoning tokens](https://developers.openai.com/api/docs/guides/reasoning).
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
        # Model ID used to generate the response, like `gpt-6-astra`. OpenAI offers a wide
        # range of models with different capabilities, performance characteristics, and
        # price points. Refer to the
        # [model guide](https://developers.openai.com/api/docs/models) to browse and
        # compare available models.
        model: nil,
        # Whether to allow the model to run tool calls in parallel.
        parallel_tool_calls: nil,
        # The unique ID of the previous response to the model. Use this to create
        # multi-turn conversations. Learn more about
        # [conversation state](https://developers.openai.com/api/docs/guides/conversation-state).
        # Cannot be used in conjunction with `conversation`.
        previous_response_id: nil,
        # Reference to a prompt template and its variables.
        # [Learn more](https://developers.openai.com/api/docs/guides/text?api-mode=responses#version-prompts-in-code).
        prompt: nil,
        # Used by OpenAI to cache responses for similar requests to optimize your cache
        # hit rates. Replaces the `user` field.
        # [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching).
        prompt_cache_key: nil,
        # Options for prompt caching. Supported for `gpt-5.6` and later models. By
        # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        # request can write up to four breakpoints. For cache matching, OpenAI considers
        # up to the latest 80 breakpoints in the conversation, without a content-block
        # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        # `ttl` defaults to `30m`, which is currently the only supported value. See the
        # [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        # for current details.
        prompt_cache_options: nil,
        # Deprecated. Use `prompt_cache_options.ttl` instead.
        #
        # The retention policy for the prompt cache. Set to `24h` to enable extended
        # prompt caching, which keeps cached prefixes active for longer, up to a maximum
        # of 24 hours.
        # [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching#prompt-cache-retention).
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
        # Configuration options for
        # [reasoning models](https://developers.openai.com/api/docs/guides/reasoning).
        reasoning: nil,
        # The ID of the response whose stream to resume.
        response_id: nil,
        # A stable identifier used to help detect users of your application that may be
        # violating OpenAI's usage policies. The IDs should be a string that uniquely
        # identifies each user, with a maximum length of 128 characters. We recommend
        # hashing their username or email address, in order to avoid sending us any
        # identifying information.
        # [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        safety_identifier: nil,
        # Specifies the processing type used for serving the request.
        #
        # - If set to 'auto', then the request will be processed with the service tier
        #   configured in the Project settings. Unless otherwise configured, the Project
        #   will use 'default'.
        # - If set to 'default', then the request will be processed with the standard
        #   pricing and performance for the selected model.
        # - If set to
        #   '[flex](https://developers.openai.com/api/docs/guides/flex-processing)', then
        #   the request will be processed with the Flex Processing service tier.
        # - To opt-in to
        #   [Fast mode](https://developers.openai.com/api/docs/guides/fast-mode) at the
        #   request level, include the `service_tier=fast` or `service_tier=priority`
        #   parameter for Responses or Chat Completions. The response will show
        #   `service_tier=priority` regardless of if you specify `service_tier=fast` or
        #   `priority` in your request.
        # - If set to 'ultrafast', then the request will be processed with the
        #   access-controlled Ultrafast Processing service tier. This tier is currently
        #   available for `gpt-5.6-sol`; a response served through it will show
        #   `service_tier=ultrafast`.
        # - When not set, the default behavior is 'auto'.
        #
        # When the `service_tier` parameter is set, the response body will include the
        # `service_tier` value based on the processing mode actually used to serve the
        # request. This response value may be different from the value set in the
        # parameter.
        service_tier: nil,
        # The sequence number of the event after which to resume streaming. Can only be
        # used with `response_id`.
        starting_after: nil,
        # Whether to store the generated model response for later retrieval via API.
        store: nil,
        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        # make the output more random, while lower values like 0.2 will make it more
        # focused and deterministic. We generally recommend altering this or `top_p` but
        # not both.
        temperature: nil,
        # Configuration options for a text response from the model. Can be plain text,
        # structured JSON data, or text that conforms to a custom grammar. Learn more:
        #
        # - [Text inputs and outputs](https://developers.openai.com/api/docs/guides/text)
        # - [Structured Outputs](https://developers.openai.com/api/docs/guides/structured-outputs)
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
        #   [web search](https://developers.openai.com/api/docs/guides/tools-web-search)
        #   or
        #   [file search](https://developers.openai.com/api/docs/guides/tools-file-search).
        #   Learn more about
        #   [built-in tools](https://developers.openai.com/api/docs/guides/tools).
        # - **MCP Tools**: Integrations with third-party systems via custom MCP servers or
        #   predefined connectors such as Google Drive and SharePoint. Learn more about
        #   [MCP Tools](https://developers.openai.com/api/docs/guides/tools-connectors-mcp).
        # - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #   the model to call your own code with strongly typed arguments and outputs.
        #   Learn more about
        #   [function calling](https://developers.openai.com/api/docs/guides/function-calling).
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
        # [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        user: nil,
        request_options: {}
      )
      end
    end
  end
end
