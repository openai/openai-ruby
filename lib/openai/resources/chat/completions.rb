# frozen_string_literal: true

require_relative "../../helpers/structured_output/chat_completion_parser"

module OpenAI
  module Resources
    class Chat
      # Given a list of messages comprising a conversation, the model will return a
      # response.
      class Completions
        # Given a list of messages comprising a conversation, the model will return a
        # response.
        # @return [OpenAI::Resources::Chat::Completions::Messages]
        attr_reader :messages

        # See {OpenAI::Resources::Chat::Completions#stream_raw} for streaming counterpart.
        #
        # **Starting a new project?** We recommend trying
        # [Responses](https://developers.openai.com/api/reference/resources/responses) to
        # take advantage of the latest OpenAI platform features. Compare
        # [Chat Completions with Responses](https://developers.openai.com/api/docs/guides/migrate-to-responses?api-mode=responses).
        #
        # ---
        #
        # Creates a model response for the given chat conversation. Learn more in the
        # [text generation](https://developers.openai.com/api/docs/guides/text),
        # [vision](https://developers.openai.com/api/docs/guides/images-vision), and
        # [audio](https://developers.openai.com/api/docs/guides/audio) guides.
        #
        # Parameter support can differ depending on the model used to generate the
        # response, particularly for newer reasoning models. Parameters that are only
        # supported for reasoning models are noted below. For the current state of
        # unsupported parameters in reasoning models,
        # [refer to the reasoning guide](https://developers.openai.com/api/docs/guides/reasoning).
        #
        # Returns a chat completion object, or a streamed sequence of chat completion
        # chunk objects if the request is streamed.
        #
        # @overload create(messages:, model:, audio: nil, frequency_penalty: nil, function_call: nil, functions: nil, logit_bias: nil, logprobs: nil, max_completion_tokens: nil, max_tokens: nil, metadata: nil, modalities: nil, moderation: nil, n: nil, parallel_tool_calls: nil, prediction: nil, presence_penalty: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning_effort: nil, response_format: nil, safety_identifier: nil, seed: nil, service_tier: nil, stop: nil, store: nil, stream_options: nil, temperature: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, user: nil, verbosity: nil, web_search_options: nil, request_options: {})
        #
        # @param messages [Array<OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam, OpenAI::Models::Chat::ChatCompletionSystemMessageParam, OpenAI::Models::Chat::ChatCompletionUserMessageParam, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam, OpenAI::Models::Chat::ChatCompletionToolMessageParam, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam>]
        #   A list of messages comprising the conversation so far. Depending on the
        #   [model](https://developers.openai.com/api/docs/models) you use, different
        #   message types (modalities) are supported, like
        #   [text](https://developers.openai.com/api/docs/guides/text),
        #   [images](https://developers.openai.com/api/docs/guides/images-vision), and
        #   [audio](https://developers.openai.com/api/docs/guides/audio).
        #
        # @param model [String, Symbol, OpenAI::Models::ChatModel]
        #   Model ID used to generate the response, like `gpt-6-astra` or `o3`. OpenAI
        #   offers a wide range of models with different capabilities, performance
        #   characteristics, and price points. Refer to the
        #   [model guide](https://developers.openai.com/api/docs/models) to browse and
        #   compare available models.
        #
        # @param audio [OpenAI::Models::Chat::ChatCompletionAudioParam, nil]
        #   Parameters for audio output. Required when audio output is requested with
        #   `modalities: ["audio"]`.
        #   [Learn more](https://developers.openai.com/api/docs/guides/audio).
        #
        # @param frequency_penalty [Float, nil]
        #   Number between -2.0 and 2.0. Positive values penalize new tokens based on their
        #   existing frequency in the text so far, decreasing the model's likelihood to
        #   repeat the same line verbatim.
        #
        # @param function_call [Symbol, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode, OpenAI::Models::Chat::ChatCompletionFunctionCallOption]
        #   Deprecated in favor of `tool_choice`.
        #
        #   Controls which (if any) function is called by the model.
        #
        #   `none` means the model will not call a function and instead generates a message.
        #
        #   `auto` means the model can pick between generating a message or calling a
        #   function.
        #
        #   Specifying a particular function via `{"name": "my_function"}` forces the model
        #   to call that function.
        #
        #   `none` is the default when no functions are present. `auto` is the default if
        #   functions are present.
        #
        # @param functions [Array<OpenAI::Models::Chat::CompletionCreateParams::Function>]
        #   Deprecated in favor of `tools`.
        #
        #   A list of functions the model may generate JSON inputs for.
        #
        # @param logit_bias [Hash{Symbol=>Integer}, nil]
        #   Modify the likelihood of specified tokens appearing in the completion.
        #
        #   Accepts a JSON object that maps tokens (specified by their token ID in the
        #   tokenizer) to an associated bias value from -100 to 100. Mathematically, the
        #   bias is added to the logits generated by the model prior to sampling. The exact
        #   effect will vary per model, but values between -1 and 1 should decrease or
        #   increase likelihood of selection; values like -100 or 100 should result in a ban
        #   or exclusive selection of the relevant token.
        #
        # @param logprobs [Boolean, nil]
        #   Whether to return log probabilities of the output tokens or not. If true,
        #   returns the log probabilities of each output token returned in the `content` of
        #   `message`.
        #
        # @param max_completion_tokens [Integer, nil]
        #   An upper bound for the number of tokens that can be generated for a completion,
        #   including visible output tokens and
        #   [reasoning tokens](https://developers.openai.com/api/docs/guides/reasoning).
        #
        # @param max_tokens [Integer, nil]
        #   The maximum number of [tokens](https://platform.openai.com/tokenizer) that can
        #   be generated in the chat completion. This value can be used to control
        #   [costs](https://openai.com/api/pricing/) for text generated via API.
        #
        #   This value is now deprecated in favor of `max_completion_tokens`, and is not
        #   compatible with
        #   [o-series models](https://developers.openai.com/api/docs/guides/reasoning).
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param modalities [Array<Symbol, OpenAI::Models::Chat::CompletionCreateParams::Modality>, nil]
        #   Output types that you would like the model to generate. Most models are capable
        #   of generating text, which is the default:
        #
        #   `["text"]`
        #
        #   The `gpt-4o-audio-preview` model can also be used to
        #   [generate audio](https://developers.openai.com/api/docs/guides/audio). To
        #   request that this model generate both text and audio responses, you can use:
        #
        #   `["text", "audio"]`
        #
        # @param moderation [OpenAI::Models::Chat::CompletionCreateParams::Moderation, nil]
        #   Configuration for running moderation on the request input and generated output.
        #
        # @param n [Integer, nil]
        #   How many chat completion choices to generate for each input message. Note that
        #   you will be charged based on the number of generated tokens across all of the
        #   choices. Keep `n` as `1` to minimize costs.
        #
        # @param parallel_tool_calls [Boolean]
        #   Whether to enable
        #   [parallel function calling](https://developers.openai.com/api/docs/guides/function-calling#parallel-function-calling)
        #   during tool use.
        #
        # @param prediction [OpenAI::Models::Chat::ChatCompletionPredictionContent, nil]
        #   Static predicted output content, such as the content of a text file that is
        #   being regenerated.
        #
        # @param presence_penalty [Float, nil]
        #   Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #   whether they appear in the text so far, increasing the model's likelihood to
        #   talk about new topics.
        #
        # @param prompt_cache_key [String, nil]
        #   Used by OpenAI to cache responses for similar requests to optimize your cache
        #   hit rates. Replaces the `user` field.
        #   [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching).
        #
        # @param prompt_cache_options [OpenAI::Models::Chat::CompletionCreateParams::PromptCacheOptions]
        #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
        #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        #   request can write up to four breakpoints. For cache matching, OpenAI considers
        #   up to the latest 80 breakpoints in the conversation, without a content-block
        #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        #   `ttl` defaults to `30m`, which is currently the only supported value. See the
        #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        #   for current details.
        #
        # @param prompt_cache_retention [Symbol, OpenAI::Models::Chat::CompletionCreateParams::PromptCacheRetention, nil]
        #   Deprecated. Use `prompt_cache_options.ttl` instead.
        #
        #   The retention policy for the prompt cache. Set to `24h` to enable extended
        #   prompt caching, which keeps cached prefixes active for longer, up to a maximum
        #   of 24 hours.
        #   [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching#prompt-cache-retention).
        #   This field expresses a maximum retention policy, while
        #   `prompt_cache_options.ttl` expresses a minimum cache lifetime. The two fields
        #   are independent and do not interact. For `gpt-5.5`, `gpt-5.5-pro`, and future
        #   models, only `24h` is supported.
        #
        #   For older models that support both `in_memory` and `24h`, the default depends on
        #   your organization's data retention policy:
        #
        #   - Organizations without ZDR enabled default to `24h`.
        #   - Organizations with ZDR enabled default to `in_memory` when
        #     `prompt_cache_retention` is not specified.
        #
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
        #   Constrains effort on reasoning for reasoning models. Currently supported values
        #   are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
        #   reasoning effort can result in faster responses and fewer tokens used on
        #   reasoning in a response. Not all reasoning models support every value. See the
        #   [reasoning guide](https://developers.openai.com/api/docs/guides/reasoning) for
        #   model-specific support.
        #
        # @param response_format [OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONSchema, OpenAI::Models::ResponseFormatJSONObject]
        #   An object specifying the format that the model must output.
        #
        #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        #   Outputs which ensures the model will match your supplied JSON schema. Learn more
        #   in the
        #   [Structured Outputs guide](https://developers.openai.com/api/docs/guides/structured-outputs).
        #
        #   Setting to `{ "type": "json_object" }` enables the older JSON mode, which
        #   ensures the message the model generates is valid JSON. Using `json_schema` is
        #   preferred for models that support it.
        #
        # @param safety_identifier [String, nil]
        #   A stable identifier used to help detect users of your application that may be
        #   violating OpenAI's usage policies. The IDs should be a string that uniquely
        #   identifies each user, with a maximum length of 64 characters. We recommend
        #   hashing their username or email address, in order to avoid sending us any
        #   identifying information.
        #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        #
        # @param seed [Integer, nil]
        #   This feature is in Beta. If specified, our system will make a best effort to
        #   sample deterministically, such that repeated requests with the same `seed` and
        #   parameters should return the same result. Determinism is not guaranteed, and you
        #   should refer to the `system_fingerprint` response parameter to monitor changes
        #   in the backend.
        #
        # @param service_tier [Symbol, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier, nil]
        #   Specifies the processing type used for serving the request.
        #
        #   - If set to 'auto', then the request will be processed with the service tier
        #     configured in the Project settings. Unless otherwise configured, the Project
        #     will use 'default'.
        #   - If set to 'default', then the request will be processed with the standard
        #     pricing and performance for the selected model.
        #   - If set to
        #     '[flex](https://developers.openai.com/api/docs/guides/flex-processing)', then
        #     the request will be processed with the Flex Processing service tier.
        #   - To opt-in to
        #     [Fast mode](https://developers.openai.com/api/docs/guides/fast-mode) at the
        #     request level, include the `service_tier=fast` or `service_tier=priority`
        #     parameter for Responses or Chat Completions. The response will show
        #     `service_tier=priority` regardless of if you specify `service_tier=fast` or
        #     `priority` in your request.
        #   - When not set, the default behavior is 'auto'.
        #
        #   When the `service_tier` parameter is set, the response body will include the
        #   `service_tier` value based on the processing mode actually used to serve the
        #   request. This response value may be different from the value set in the
        #   parameter.
        #
        # @param stop [String, Array<String>, nil]
        #   Not supported with latest reasoning models `o3` and `o4-mini`.
        #
        #   Up to 4 sequences where the API will stop generating further tokens. The
        #   returned text will not contain the stop sequence.
        #
        # @param store [Boolean, nil]
        #   Whether or not to store the output of this chat completion request for use in
        #   our
        #   [model distillation](https://developers.openai.com/api/docs/guides/supervised-fine-tuning#distilling-from-a-larger-model)
        #   or [evals](https://developers.openai.com/api/docs/guides/evals) products.
        #
        #   Supports text and image inputs. Note: image inputs over 8MB will be dropped.
        #
        # @param stream_options [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil]
        #   Options for streaming response. Only set this when you set `stream: true`.
        #
        # @param temperature [Float, nil]
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic. We generally recommend altering this or `top_p` but
        #   not both.
        #
        # @param tool_choice [Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Models::Chat::ChatCompletionAllowedToolChoice, OpenAI::Models::Chat::ChatCompletionNamedToolChoice, OpenAI::Models::Chat::ChatCompletionNamedToolChoiceCustom]
        #   Controls which (if any) tool is called by the model. `none` means the model will
        #   not call any tool and instead generates a message. `auto` means the model can
        #   pick between generating a message or calling one or more tools. `required` means
        #   the model must call one or more tools. Specifying a particular tool via
        #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #   call that tool.
        #
        #   `none` is the default when no tools are present. `auto` is the default if tools
        #   are present.
        #
        # @param tools [Array<OpenAI::Models::Chat::ChatCompletionFunctionTool, OpenAI::Models::Chat::ChatCompletionCustomTool>]
        #   A list of tools the model may call. You can provide either
        #   [custom tools](https://developers.openai.com/api/docs/guides/function-calling#custom-tools)
        #   or
        #   [function tools](https://developers.openai.com/api/docs/guides/function-calling).
        #
        # @param top_logprobs [Integer, nil]
        #   An integer between 0 and 20 specifying the maximum number of most likely tokens
        #   to return at each token position, each with an associated log probability. In
        #   some cases, the number of returned tokens may be fewer than requested.
        #   `logprobs` must be set to `true` if this parameter is used.
        #
        # @param top_p [Float, nil]
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        #
        # @param user [String]
        #   This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
        #   `prompt_cache_key` instead to maintain caching optimizations. A stable
        #   identifier for your end-users. Used to boost cache hit rates by better bucketing
        #   similar requests and to help OpenAI detect and prevent abuse.
        #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        #
        # @param verbosity [Symbol, OpenAI::Models::Chat::CompletionCreateParams::Verbosity, nil]
        #   Constrains the verbosity of the model's response. Lower values will result in
        #   more concise responses, while higher values will result in more verbose
        #   responses. Currently supported values are `low`, `medium`, and `high`. The
        #   default is `medium`.
        #
        # @param web_search_options [OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions]
        #   This tool searches the web for relevant results to use in a response. Learn more
        #   about the
        #   [web search tool](https://developers.openai.com/api/docs/guides/tools-web-search).
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Chat::ChatCompletion]
        #
        # @see OpenAI::Models::Chat::CompletionCreateParams
        def create(params)
          parsed, options = OpenAI::Chat::CompletionCreateParams.dump_request(params)
          if parsed[:stream]
            message = "Please use `#stream_raw` for the streaming use case."
            raise ArgumentError.new(message)
          end

          model, tool_models = get_structured_output_models(parsed)

          unwrap = OpenAI::Helpers::StructuredOutput::ChatCompletionParser.build_unwrap(model, tool_models)

          @client.request(
            method: :post,
            path: "chat/completions",
            body: parsed,
            unwrap: unwrap,
            model: OpenAI::Chat::ChatCompletion,
            security: {bearer_auth: true},
            options: options
          )
        end

        def get_structured_output_models(parsed)
          OpenAI::Helpers::StructuredOutput::ChatCompletionParser.get_models(parsed)
        end

        def build_tools_with_models(tools, tool_models)
          OpenAI::Helpers::StructuredOutput::ChatCompletionParser.build_tools(tools, tool_models)
        end

        def stream(params)
          parsed, options = OpenAI::Chat::CompletionCreateParams.dump_request(params)

          parsed.store(:stream, true)

          response_format, tool_models = get_structured_output_models(parsed)

          input_tools = build_tools_with_models(parsed[:tools], tool_models)

          raw_stream = @client.request(
            method: :post,
            path: "chat/completions",
            headers: {"accept" => "text/event-stream"},
            body: parsed,
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Chat::ChatCompletionChunk,
            security: {bearer_auth: true},
            options: options
          )

          OpenAI::Helpers::Streaming::ChatCompletionStream.new(
            raw_stream: raw_stream,
            response_format: response_format,
            input_tools: input_tools
          )
        end

        # See {OpenAI::Resources::Chat::Completions#create} for non-streaming counterpart.
        #
        # **Starting a new project?** We recommend trying
        # [Responses](https://developers.openai.com/api/reference/resources/responses) to
        # take advantage of the latest OpenAI platform features. Compare
        # [Chat Completions with Responses](https://developers.openai.com/api/docs/guides/migrate-to-responses?api-mode=responses).
        #
        # ---
        #
        # Creates a model response for the given chat conversation. Learn more in the
        # [text generation](https://developers.openai.com/api/docs/guides/text),
        # [vision](https://developers.openai.com/api/docs/guides/images-vision), and
        # [audio](https://developers.openai.com/api/docs/guides/audio) guides.
        #
        # Parameter support can differ depending on the model used to generate the
        # response, particularly for newer reasoning models. Parameters that are only
        # supported for reasoning models are noted below. For the current state of
        # unsupported parameters in reasoning models,
        # [refer to the reasoning guide](https://developers.openai.com/api/docs/guides/reasoning).
        #
        # Returns a chat completion object, or a streamed sequence of chat completion
        # chunk objects if the request is streamed.
        #
        # @overload stream_raw(messages:, model:, audio: nil, frequency_penalty: nil, function_call: nil, functions: nil, logit_bias: nil, logprobs: nil, max_completion_tokens: nil, max_tokens: nil, metadata: nil, modalities: nil, moderation: nil, n: nil, parallel_tool_calls: nil, prediction: nil, presence_penalty: nil, prompt_cache_key: nil, prompt_cache_options: nil, prompt_cache_retention: nil, reasoning_effort: nil, response_format: nil, safety_identifier: nil, seed: nil, service_tier: nil, stop: nil, store: nil, stream_options: nil, temperature: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, user: nil, verbosity: nil, web_search_options: nil, request_options: {})
        #
        # @param messages [Array<OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam, OpenAI::Models::Chat::ChatCompletionSystemMessageParam, OpenAI::Models::Chat::ChatCompletionUserMessageParam, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam, OpenAI::Models::Chat::ChatCompletionToolMessageParam, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam>]
        #   A list of messages comprising the conversation so far. Depending on the
        #   [model](https://developers.openai.com/api/docs/models) you use, different
        #   message types (modalities) are supported, like
        #   [text](https://developers.openai.com/api/docs/guides/text),
        #   [images](https://developers.openai.com/api/docs/guides/images-vision), and
        #   [audio](https://developers.openai.com/api/docs/guides/audio).
        #
        # @param model [String, Symbol, OpenAI::Models::ChatModel]
        #   Model ID used to generate the response, like `gpt-6-astra` or `o3`. OpenAI
        #   offers a wide range of models with different capabilities, performance
        #   characteristics, and price points. Refer to the
        #   [model guide](https://developers.openai.com/api/docs/models) to browse and
        #   compare available models.
        #
        # @param audio [OpenAI::Models::Chat::ChatCompletionAudioParam, nil]
        #   Parameters for audio output. Required when audio output is requested with
        #   `modalities: ["audio"]`.
        #   [Learn more](https://developers.openai.com/api/docs/guides/audio).
        #
        # @param frequency_penalty [Float, nil]
        #   Number between -2.0 and 2.0. Positive values penalize new tokens based on their
        #   existing frequency in the text so far, decreasing the model's likelihood to
        #   repeat the same line verbatim.
        #
        # @param function_call [Symbol, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode, OpenAI::Models::Chat::ChatCompletionFunctionCallOption]
        #   Deprecated in favor of `tool_choice`.
        #
        #   Controls which (if any) function is called by the model.
        #
        #   `none` means the model will not call a function and instead generates a message.
        #
        #   `auto` means the model can pick between generating a message or calling a
        #   function.
        #
        #   Specifying a particular function via `{"name": "my_function"}` forces the model
        #   to call that function.
        #
        #   `none` is the default when no functions are present. `auto` is the default if
        #   functions are present.
        #
        # @param functions [Array<OpenAI::Models::Chat::CompletionCreateParams::Function>]
        #   Deprecated in favor of `tools`.
        #
        #   A list of functions the model may generate JSON inputs for.
        #
        # @param logit_bias [Hash{Symbol=>Integer}, nil]
        #   Modify the likelihood of specified tokens appearing in the completion.
        #
        #   Accepts a JSON object that maps tokens (specified by their token ID in the
        #   tokenizer) to an associated bias value from -100 to 100. Mathematically, the
        #   bias is added to the logits generated by the model prior to sampling. The exact
        #   effect will vary per model, but values between -1 and 1 should decrease or
        #   increase likelihood of selection; values like -100 or 100 should result in a ban
        #   or exclusive selection of the relevant token.
        #
        # @param logprobs [Boolean, nil]
        #   Whether to return log probabilities of the output tokens or not. If true,
        #   returns the log probabilities of each output token returned in the `content` of
        #   `message`.
        #
        # @param max_completion_tokens [Integer, nil]
        #   An upper bound for the number of tokens that can be generated for a completion,
        #   including visible output tokens and
        #   [reasoning tokens](https://developers.openai.com/api/docs/guides/reasoning).
        #
        # @param max_tokens [Integer, nil]
        #   The maximum number of [tokens](https://platform.openai.com/tokenizer) that can
        #   be generated in the chat completion. This value can be used to control
        #   [costs](https://openai.com/api/pricing/) for text generated via API.
        #
        #   This value is now deprecated in favor of `max_completion_tokens`, and is not
        #   compatible with
        #   [o-series models](https://developers.openai.com/api/docs/guides/reasoning).
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param modalities [Array<Symbol, OpenAI::Models::Chat::CompletionCreateParams::Modality>, nil]
        #   Output types that you would like the model to generate. Most models are capable
        #   of generating text, which is the default:
        #
        #   `["text"]`
        #
        #   The `gpt-4o-audio-preview` model can also be used to
        #   [generate audio](https://developers.openai.com/api/docs/guides/audio). To
        #   request that this model generate both text and audio responses, you can use:
        #
        #   `["text", "audio"]`
        #
        # @param moderation [OpenAI::Models::Chat::CompletionCreateParams::Moderation, nil]
        #   Configuration for running moderation on the request input and generated output.
        #
        # @param n [Integer, nil]
        #   How many chat completion choices to generate for each input message. Note that
        #   you will be charged based on the number of generated tokens across all of the
        #   choices. Keep `n` as `1` to minimize costs.
        #
        # @param parallel_tool_calls [Boolean]
        #   Whether to enable
        #   [parallel function calling](https://developers.openai.com/api/docs/guides/function-calling#parallel-function-calling)
        #   during tool use.
        #
        # @param prediction [OpenAI::Models::Chat::ChatCompletionPredictionContent, nil]
        #   Static predicted output content, such as the content of a text file that is
        #   being regenerated.
        #
        # @param presence_penalty [Float, nil]
        #   Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #   whether they appear in the text so far, increasing the model's likelihood to
        #   talk about new topics.
        #
        # @param prompt_cache_key [String, nil]
        #   Used by OpenAI to cache responses for similar requests to optimize your cache
        #   hit rates. Replaces the `user` field.
        #   [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching).
        #
        # @param prompt_cache_options [OpenAI::Models::Chat::CompletionCreateParams::PromptCacheOptions]
        #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
        #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        #   request can write up to four breakpoints. For cache matching, OpenAI considers
        #   up to the latest 80 breakpoints in the conversation, without a content-block
        #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        #   `ttl` defaults to `30m`, which is currently the only supported value. See the
        #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        #   for current details.
        #
        # @param prompt_cache_retention [Symbol, OpenAI::Models::Chat::CompletionCreateParams::PromptCacheRetention, nil]
        #   Deprecated. Use `prompt_cache_options.ttl` instead.
        #
        #   The retention policy for the prompt cache. Set to `24h` to enable extended
        #   prompt caching, which keeps cached prefixes active for longer, up to a maximum
        #   of 24 hours.
        #   [Learn more](https://developers.openai.com/api/docs/guides/prompt-caching#prompt-cache-retention).
        #   This field expresses a maximum retention policy, while
        #   `prompt_cache_options.ttl` expresses a minimum cache lifetime. The two fields
        #   are independent and do not interact. For `gpt-5.5`, `gpt-5.5-pro`, and future
        #   models, only `24h` is supported.
        #
        #   For older models that support both `in_memory` and `24h`, the default depends on
        #   your organization's data retention policy:
        #
        #   - Organizations without ZDR enabled default to `24h`.
        #   - Organizations with ZDR enabled default to `in_memory` when
        #     `prompt_cache_retention` is not specified.
        #
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
        #   Constrains effort on reasoning for reasoning models. Currently supported values
        #   are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
        #   reasoning effort can result in faster responses and fewer tokens used on
        #   reasoning in a response. Not all reasoning models support every value. See the
        #   [reasoning guide](https://developers.openai.com/api/docs/guides/reasoning) for
        #   model-specific support.
        #
        # @param response_format [OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONSchema, OpenAI::Models::ResponseFormatJSONObject]
        #   An object specifying the format that the model must output.
        #
        #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        #   Outputs which ensures the model will match your supplied JSON schema. Learn more
        #   in the
        #   [Structured Outputs guide](https://developers.openai.com/api/docs/guides/structured-outputs).
        #
        #   Setting to `{ "type": "json_object" }` enables the older JSON mode, which
        #   ensures the message the model generates is valid JSON. Using `json_schema` is
        #   preferred for models that support it.
        #
        # @param safety_identifier [String, nil]
        #   A stable identifier used to help detect users of your application that may be
        #   violating OpenAI's usage policies. The IDs should be a string that uniquely
        #   identifies each user, with a maximum length of 64 characters. We recommend
        #   hashing their username or email address, in order to avoid sending us any
        #   identifying information.
        #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        #
        # @param seed [Integer, nil]
        #   This feature is in Beta. If specified, our system will make a best effort to
        #   sample deterministically, such that repeated requests with the same `seed` and
        #   parameters should return the same result. Determinism is not guaranteed, and you
        #   should refer to the `system_fingerprint` response parameter to monitor changes
        #   in the backend.
        #
        # @param service_tier [Symbol, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier, nil]
        #   Specifies the processing type used for serving the request.
        #
        #   - If set to 'auto', then the request will be processed with the service tier
        #     configured in the Project settings. Unless otherwise configured, the Project
        #     will use 'default'.
        #   - If set to 'default', then the request will be processed with the standard
        #     pricing and performance for the selected model.
        #   - If set to
        #     '[flex](https://developers.openai.com/api/docs/guides/flex-processing)', then
        #     the request will be processed with the Flex Processing service tier.
        #   - To opt-in to
        #     [Fast mode](https://developers.openai.com/api/docs/guides/fast-mode) at the
        #     request level, include the `service_tier=fast` or `service_tier=priority`
        #     parameter for Responses or Chat Completions. The response will show
        #     `service_tier=priority` regardless of if you specify `service_tier=fast` or
        #     `priority` in your request.
        #   - When not set, the default behavior is 'auto'.
        #
        #   When the `service_tier` parameter is set, the response body will include the
        #   `service_tier` value based on the processing mode actually used to serve the
        #   request. This response value may be different from the value set in the
        #   parameter.
        #
        # @param stop [String, Array<String>, nil]
        #   Not supported with latest reasoning models `o3` and `o4-mini`.
        #
        #   Up to 4 sequences where the API will stop generating further tokens. The
        #   returned text will not contain the stop sequence.
        #
        # @param store [Boolean, nil]
        #   Whether or not to store the output of this chat completion request for use in
        #   our
        #   [model distillation](https://developers.openai.com/api/docs/guides/supervised-fine-tuning#distilling-from-a-larger-model)
        #   or [evals](https://developers.openai.com/api/docs/guides/evals) products.
        #
        #   Supports text and image inputs. Note: image inputs over 8MB will be dropped.
        #
        # @param stream_options [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil]
        #   Options for streaming response. Only set this when you set `stream: true`.
        #
        # @param temperature [Float, nil]
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic. We generally recommend altering this or `top_p` but
        #   not both.
        #
        # @param tool_choice [Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Models::Chat::ChatCompletionAllowedToolChoice, OpenAI::Models::Chat::ChatCompletionNamedToolChoice, OpenAI::Models::Chat::ChatCompletionNamedToolChoiceCustom]
        #   Controls which (if any) tool is called by the model. `none` means the model will
        #   not call any tool and instead generates a message. `auto` means the model can
        #   pick between generating a message or calling one or more tools. `required` means
        #   the model must call one or more tools. Specifying a particular tool via
        #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #   call that tool.
        #
        #   `none` is the default when no tools are present. `auto` is the default if tools
        #   are present.
        #
        # @param tools [Array<OpenAI::Models::Chat::ChatCompletionFunctionTool, OpenAI::Models::Chat::ChatCompletionCustomTool>]
        #   A list of tools the model may call. You can provide either
        #   [custom tools](https://developers.openai.com/api/docs/guides/function-calling#custom-tools)
        #   or
        #   [function tools](https://developers.openai.com/api/docs/guides/function-calling).
        #
        # @param top_logprobs [Integer, nil]
        #   An integer between 0 and 20 specifying the maximum number of most likely tokens
        #   to return at each token position, each with an associated log probability. In
        #   some cases, the number of returned tokens may be fewer than requested.
        #   `logprobs` must be set to `true` if this parameter is used.
        #
        # @param top_p [Float, nil]
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        #
        # @param user [String]
        #   This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
        #   `prompt_cache_key` instead to maintain caching optimizations. A stable
        #   identifier for your end-users. Used to boost cache hit rates by better bucketing
        #   similar requests and to help OpenAI detect and prevent abuse.
        #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        #
        # @param verbosity [Symbol, OpenAI::Models::Chat::CompletionCreateParams::Verbosity, nil]
        #   Constrains the verbosity of the model's response. Lower values will result in
        #   more concise responses, while higher values will result in more verbose
        #   responses. Currently supported values are `low`, `medium`, and `high`. The
        #   default is `medium`.
        #
        # @param web_search_options [OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions]
        #   This tool searches the web for relevant results to use in a response. Learn more
        #   about the
        #   [web search tool](https://developers.openai.com/api/docs/guides/tools-web-search).
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Stream<OpenAI::Models::Chat::ChatCompletionChunk>]
        #
        # @see OpenAI::Models::Chat::CompletionCreateParams
        def stream_raw(params)
          parsed, options = OpenAI::Chat::CompletionCreateParams.dump_request(params)
          unless parsed.fetch(:stream, true)
            message = "Please use `#create` for the non-streaming use case."
            raise ArgumentError.new(message)
          end

          parsed.store(:stream, true)
          @client.request(
            method: :post,
            path: "chat/completions",
            headers: {"accept" => "text/event-stream", "accept-encoding" => "identity"},
            body: parsed,
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Chat::ChatCompletionChunk,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Get a stored chat completion. Only Chat Completions that have been created with
        # the `store` parameter set to `true` will be returned.
        #
        # @overload retrieve(completion_id, request_options: {})
        #
        # @param completion_id [String]
        #   The ID of the chat completion to retrieve.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Chat::ChatCompletion]
        #
        # @see OpenAI::Models::Chat::CompletionRetrieveParams
        def retrieve(completion_id, params = {})
          @client.request(
            method: :get,
            path: ["chat/completions/%1$s", completion_id],
            model: OpenAI::Chat::ChatCompletion,
            security: {bearer_auth: true},
            options: params[:request_options]
          )
        end

        # Modify a stored chat completion. Only Chat Completions that have been created
        # with the `store` parameter set to `true` can be modified. Currently, the only
        # supported modification is to update the `metadata` field.
        #
        # @overload update(completion_id, metadata:, request_options: {})
        #
        # @param completion_id [String]
        #   The ID of the chat completion to update.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Chat::ChatCompletion]
        #
        # @see OpenAI::Models::Chat::CompletionUpdateParams
        def update(completion_id, params)
          parsed, options = OpenAI::Chat::CompletionUpdateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["chat/completions/%1$s", completion_id],
            body: parsed,
            model: OpenAI::Chat::ChatCompletion,
            security: {bearer_auth: true},
            options: options
          )
        end

        # List stored Chat Completions. Only Chat Completions that have been stored with
        # the `store` parameter set to `true` will be returned.
        #
        # @overload list(after: nil, limit: nil, metadata: nil, model: nil, order: nil, request_options: {})
        #
        # @param after [String]
        #   Identifier for the last chat completion from the previous pagination request.
        #
        # @param limit [Integer]
        #   Number of Chat Completions to retrieve.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   A list of metadata keys to filter the Chat Completions by. Example:
        #
        #   `metadata[key1]=value1&metadata[key2]=value2`
        #
        # @param model [String]
        #   The model used to generate the Chat Completions.
        #
        # @param order [Symbol, OpenAI::Models::Chat::CompletionListParams::Order]
        #   Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        #   `desc` for descending order. Defaults to `asc`.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Chat::ChatCompletion>]
        #
        # @see OpenAI::Models::Chat::CompletionListParams
        def list(params = {})
          parsed, options = OpenAI::Chat::CompletionListParams.dump_request(params)
          query = OpenAI::Internal::Util.encode_query_params(parsed)
          @client.request(
            method: :get,
            path: "chat/completions",
            query: query,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Chat::ChatCompletion,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Delete a stored chat completion. Only Chat Completions that have been created
        # with the `store` parameter set to `true` can be deleted.
        #
        # @overload delete(completion_id, request_options: {})
        #
        # @param completion_id [String]
        #   The ID of the chat completion to delete.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Chat::ChatCompletionDeleted]
        #
        # @see OpenAI::Models::Chat::CompletionDeleteParams
        def delete(completion_id, params = {})
          @client.request(
            method: :delete,
            path: ["chat/completions/%1$s", completion_id],
            model: OpenAI::Chat::ChatCompletionDeleted,
            security: {bearer_auth: true},
            options: params[:request_options]
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @messages = OpenAI::Resources::Chat::Completions::Messages.new(client: client)
        end
      end
    end
  end
end
