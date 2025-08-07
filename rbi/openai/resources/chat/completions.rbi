# typed: strong

module OpenAI
  module Resources
    class Chat
      class Completions
        sig { returns(OpenAI::Resources::Chat::Completions::Messages) }
        attr_reader :messages

        # See {OpenAI::Resources::Chat::Completions#stream_raw} for streaming counterpart.
        #
        # **Starting a new project?** We recommend trying
        # [Responses](https://platform.openai.com/docs/api-reference/responses) to take
        # advantage of the latest OpenAI platform features. Compare
        # [Chat Completions with Responses](https://platform.openai.com/docs/guides/responses-vs-chat-completions?api-mode=responses).
        #
        # ---
        #
        # Creates a model response for the given chat conversation. Learn more in the
        # [text generation](https://platform.openai.com/docs/guides/text-generation),
        # [vision](https://platform.openai.com/docs/guides/vision), and
        # [audio](https://platform.openai.com/docs/guides/audio) guides.
        #
        # Parameter support can differ depending on the model used to generate the
        # response, particularly for newer reasoning models. Parameters that are only
        # supported for reasoning models are noted below. For the current state of
        # unsupported parameters in reasoning models,
        # [refer to the reasoning guide](https://platform.openai.com/docs/guides/reasoning).
        sig do
          params(
            messages:
              T::Array[
                T.any(
                  OpenAI::Chat::ChatCompletionDeveloperMessageParam::OrHash,
                  OpenAI::Chat::ChatCompletionSystemMessageParam::OrHash,
                  OpenAI::Chat::ChatCompletionUserMessageParam::OrHash,
                  OpenAI::Chat::ChatCompletionAssistantMessageParam::OrHash,
                  OpenAI::Chat::ChatCompletionToolMessageParam::OrHash,
                  OpenAI::Chat::ChatCompletionFunctionMessageParam::OrHash
                )
              ],
            model: T.any(String, OpenAI::ChatModel::OrSymbol),
            audio: T.nilable(OpenAI::Chat::ChatCompletionAudioParam::OrHash),
            frequency_penalty: T.nilable(Float),
            function_call:
              T.any(
                OpenAI::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
                OpenAI::Chat::ChatCompletionFunctionCallOption::OrHash
              ),
            functions:
              T::Array[OpenAI::Chat::CompletionCreateParams::Function::OrHash],
            logit_bias: T.nilable(T::Hash[Symbol, Integer]),
            logprobs: T.nilable(T::Boolean),
            max_completion_tokens: T.nilable(Integer),
            max_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            modalities:
              T.nilable(
                T::Array[
                  OpenAI::Chat::CompletionCreateParams::Modality::OrSymbol
                ]
              ),
            n: T.nilable(Integer),
            parallel_tool_calls: T::Boolean,
            prediction:
              T.nilable(OpenAI::Chat::ChatCompletionPredictionContent::OrHash),
            presence_penalty: T.nilable(Float),
            prompt_cache_key: String,
            reasoning_effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
            response_format:
              T.any(
                OpenAI::ResponseFormatText::OrHash,
                OpenAI::ResponseFormatJSONSchema::OrHash,
                OpenAI::ResponseFormatJSONObject::OrHash
              ),
            safety_identifier: String,
            seed: T.nilable(Integer),
            service_tier:
              T.nilable(
                OpenAI::Chat::CompletionCreateParams::ServiceTier::OrSymbol
              ),
            stop:
              T.nilable(OpenAI::Chat::CompletionCreateParams::Stop::Variants),
            store: T.nilable(T::Boolean),
            stream_options:
              T.nilable(OpenAI::Chat::ChatCompletionStreamOptions::OrHash),
            temperature: T.nilable(Float),
            tool_choice:
              T.any(
                OpenAI::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol,
                OpenAI::Chat::ChatCompletionAllowedToolChoice::OrHash,
                OpenAI::Chat::ChatCompletionNamedToolChoice::OrHash,
                OpenAI::Chat::ChatCompletionNamedToolChoiceCustom::OrHash
              ),
            tools:
              T::Array[
                T.any(
                  OpenAI::Chat::ChatCompletionFunctionTool::OrHash,
                  OpenAI::Chat::ChatCompletionCustomTool::OrHash
                )
              ],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            user: String,
            verbosity:
              T.nilable(
                OpenAI::Chat::CompletionCreateParams::Verbosity::OrSymbol
              ),
            web_search_options:
              OpenAI::Chat::CompletionCreateParams::WebSearchOptions::OrHash,
            stream: T.noreturn,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Chat::ChatCompletion)
        end
        def create(
          # A list of messages comprising the conversation so far. Depending on the
          # [model](https://platform.openai.com/docs/models) you use, different message
          # types (modalities) are supported, like
          # [text](https://platform.openai.com/docs/guides/text-generation),
          # [images](https://platform.openai.com/docs/guides/vision), and
          # [audio](https://platform.openai.com/docs/guides/audio).
          messages:,
          # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
          # wide range of models with different capabilities, performance characteristics,
          # and price points. Refer to the
          # [model guide](https://platform.openai.com/docs/models) to browse and compare
          # available models.
          model:,
          # Parameters for audio output. Required when audio output is requested with
          # `modalities: ["audio"]`.
          # [Learn more](https://platform.openai.com/docs/guides/audio).
          audio: nil,
          # Number between -2.0 and 2.0. Positive values penalize new tokens based on their
          # existing frequency in the text so far, decreasing the model's likelihood to
          # repeat the same line verbatim.
          frequency_penalty: nil,
          # Deprecated in favor of `tool_choice`.
          #
          # Controls which (if any) function is called by the model.
          #
          # `none` means the model will not call a function and instead generates a message.
          #
          # `auto` means the model can pick between generating a message or calling a
          # function.
          #
          # Specifying a particular function via `{"name": "my_function"}` forces the model
          # to call that function.
          #
          # `none` is the default when no functions are present. `auto` is the default if
          # functions are present.
          function_call: nil,
          # Deprecated in favor of `tools`.
          #
          # A list of functions the model may generate JSON inputs for.
          functions: nil,
          # Modify the likelihood of specified tokens appearing in the completion.
          #
          # Accepts a JSON object that maps tokens (specified by their token ID in the
          # tokenizer) to an associated bias value from -100 to 100. Mathematically, the
          # bias is added to the logits generated by the model prior to sampling. The exact
          # effect will vary per model, but values between -1 and 1 should decrease or
          # increase likelihood of selection; values like -100 or 100 should result in a ban
          # or exclusive selection of the relevant token.
          logit_bias: nil,
          # Whether to return log probabilities of the output tokens or not. If true,
          # returns the log probabilities of each output token returned in the `content` of
          # `message`.
          logprobs: nil,
          # An upper bound for the number of tokens that can be generated for a completion,
          # including visible output tokens and
          # [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
          max_completion_tokens: nil,
          # The maximum number of [tokens](/tokenizer) that can be generated in the chat
          # completion. This value can be used to control
          # [costs](https://openai.com/api/pricing/) for text generated via API.
          #
          # This value is now deprecated in favor of `max_completion_tokens`, and is not
          # compatible with
          # [o-series models](https://platform.openai.com/docs/guides/reasoning).
          max_tokens: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # Output types that you would like the model to generate. Most models are capable
          # of generating text, which is the default:
          #
          # `["text"]`
          #
          # The `gpt-4o-audio-preview` model can also be used to
          # [generate audio](https://platform.openai.com/docs/guides/audio). To request that
          # this model generate both text and audio responses, you can use:
          #
          # `["text", "audio"]`
          modalities: nil,
          # How many chat completion choices to generate for each input message. Note that
          # you will be charged based on the number of generated tokens across all of the
          # choices. Keep `n` as `1` to minimize costs.
          n: nil,
          # Whether to enable
          # [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          # during tool use.
          parallel_tool_calls: nil,
          # Static predicted output content, such as the content of a text file that is
          # being regenerated.
          prediction: nil,
          # Number between -2.0 and 2.0. Positive values penalize new tokens based on
          # whether they appear in the text so far, increasing the model's likelihood to
          # talk about new topics.
          presence_penalty: nil,
          # Used by OpenAI to cache responses for similar requests to optimize your cache
          # hit rates. Replaces the `user` field.
          # [Learn more](https://platform.openai.com/docs/guides/prompt-caching).
          prompt_cache_key: nil,
          # Constrains effort on reasoning for
          # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          # supported values are `minimal`, `low`, `medium`, and `high`. Reducing reasoning
          # effort can result in faster responses and fewer tokens used on reasoning in a
          # response.
          reasoning_effort: nil,
          # An object specifying the format that the model must output.
          #
          # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          # Outputs which ensures the model will match your supplied JSON schema. Learn more
          # in the
          # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          # Setting to `{ "type": "json_object" }` enables the older JSON mode, which
          # ensures the message the model generates is valid JSON. Using `json_schema` is
          # preferred for models that support it.
          response_format: nil,
          # A stable identifier used to help detect users of your application that may be
          # violating OpenAI's usage policies. The IDs should be a string that uniquely
          # identifies each user. We recommend hashing their username or email address, in
          # order to avoid sending us any identifying information.
          # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
          safety_identifier: nil,
          # This feature is in Beta. If specified, our system will make a best effort to
          # sample deterministically, such that repeated requests with the same `seed` and
          # parameters should return the same result. Determinism is not guaranteed, and you
          # should refer to the `system_fingerprint` response parameter to monitor changes
          # in the backend.
          seed: nil,
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
          # Not supported with latest reasoning models `o3` and `o4-mini`.
          #
          # Up to 4 sequences where the API will stop generating further tokens. The
          # returned text will not contain the stop sequence.
          stop: nil,
          # Whether or not to store the output of this chat completion request for use in
          # our [model distillation](https://platform.openai.com/docs/guides/distillation)
          # or [evals](https://platform.openai.com/docs/guides/evals) products.
          #
          # Supports text and image inputs. Note: image inputs over 10MB will be dropped.
          store: nil,
          # Options for streaming response. Only set this when you set `stream: true`.
          stream_options: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          # make the output more random, while lower values like 0.2 will make it more
          # focused and deterministic. We generally recommend altering this or `top_p` but
          # not both.
          temperature: nil,
          # Controls which (if any) tool is called by the model. `none` means the model will
          # not call any tool and instead generates a message. `auto` means the model can
          # pick between generating a message or calling one or more tools. `required` means
          # the model must call one or more tools. Specifying a particular tool via
          # `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          # call that tool.
          #
          # `none` is the default when no tools are present. `auto` is the default if tools
          # are present.
          tool_choice: nil,
          # A list of tools the model may call. You can provide either
          # [custom tools](https://platform.openai.com/docs/guides/function-calling#custom-tools)
          # or [function tools](https://platform.openai.com/docs/guides/function-calling).
          tools: nil,
          # An integer between 0 and 20 specifying the number of most likely tokens to
          # return at each token position, each with an associated log probability.
          # `logprobs` must be set to `true` if this parameter is used.
          top_logprobs: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          # model considers the results of the tokens with top_p probability mass. So 0.1
          # means only the tokens comprising the top 10% probability mass are considered.
          #
          # We generally recommend altering this or `temperature` but not both.
          top_p: nil,
          # This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
          # `prompt_cache_key` instead to maintain caching optimizations. A stable
          # identifier for your end-users. Used to boost cache hit rates by better bucketing
          # similar requests and to help OpenAI detect and prevent abuse.
          # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
          user: nil,
          # Constrains the verbosity of the model's response. Lower values will result in
          # more concise responses, while higher values will result in more verbose
          # responses. Currently supported values are `low`, `medium`, and `high`.
          verbosity: nil,
          # This tool searches the web for relevant results to use in a response. Learn more
          # about the
          # [web search tool](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat).
          web_search_options: nil,
          # There is no need to provide `stream:`. Instead, use `#stream_raw` or `#create`
          # for streaming and non-streaming use cases, respectively.
          stream: false,
          request_options: {}
        )
        end

        # See {OpenAI::Resources::Chat::Completions#create} for non-streaming counterpart.
        #
        # **Starting a new project?** We recommend trying
        # [Responses](https://platform.openai.com/docs/api-reference/responses) to take
        # advantage of the latest OpenAI platform features. Compare
        # [Chat Completions with Responses](https://platform.openai.com/docs/guides/responses-vs-chat-completions?api-mode=responses).
        #
        # ---
        #
        # Creates a model response for the given chat conversation. Learn more in the
        # [text generation](https://platform.openai.com/docs/guides/text-generation),
        # [vision](https://platform.openai.com/docs/guides/vision), and
        # [audio](https://platform.openai.com/docs/guides/audio) guides.
        #
        # Parameter support can differ depending on the model used to generate the
        # response, particularly for newer reasoning models. Parameters that are only
        # supported for reasoning models are noted below. For the current state of
        # unsupported parameters in reasoning models,
        # [refer to the reasoning guide](https://platform.openai.com/docs/guides/reasoning).
        sig do
          params(
            messages:
              T::Array[
                T.any(
                  OpenAI::Chat::ChatCompletionDeveloperMessageParam::OrHash,
                  OpenAI::Chat::ChatCompletionSystemMessageParam::OrHash,
                  OpenAI::Chat::ChatCompletionUserMessageParam::OrHash,
                  OpenAI::Chat::ChatCompletionAssistantMessageParam::OrHash,
                  OpenAI::Chat::ChatCompletionToolMessageParam::OrHash,
                  OpenAI::Chat::ChatCompletionFunctionMessageParam::OrHash
                )
              ],
            model: T.any(String, OpenAI::ChatModel::OrSymbol),
            audio: T.nilable(OpenAI::Chat::ChatCompletionAudioParam::OrHash),
            frequency_penalty: T.nilable(Float),
            function_call:
              T.any(
                OpenAI::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
                OpenAI::Chat::ChatCompletionFunctionCallOption::OrHash
              ),
            functions:
              T::Array[OpenAI::Chat::CompletionCreateParams::Function::OrHash],
            logit_bias: T.nilable(T::Hash[Symbol, Integer]),
            logprobs: T.nilable(T::Boolean),
            max_completion_tokens: T.nilable(Integer),
            max_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            modalities:
              T.nilable(
                T::Array[
                  OpenAI::Chat::CompletionCreateParams::Modality::OrSymbol
                ]
              ),
            n: T.nilable(Integer),
            parallel_tool_calls: T::Boolean,
            prediction:
              T.nilable(OpenAI::Chat::ChatCompletionPredictionContent::OrHash),
            presence_penalty: T.nilable(Float),
            prompt_cache_key: String,
            reasoning_effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
            response_format:
              T.any(
                OpenAI::ResponseFormatText::OrHash,
                OpenAI::ResponseFormatJSONSchema::OrHash,
                OpenAI::ResponseFormatJSONObject::OrHash
              ),
            safety_identifier: String,
            seed: T.nilable(Integer),
            service_tier:
              T.nilable(
                OpenAI::Chat::CompletionCreateParams::ServiceTier::OrSymbol
              ),
            stop:
              T.nilable(OpenAI::Chat::CompletionCreateParams::Stop::Variants),
            store: T.nilable(T::Boolean),
            stream_options:
              T.nilable(OpenAI::Chat::ChatCompletionStreamOptions::OrHash),
            temperature: T.nilable(Float),
            tool_choice:
              T.any(
                OpenAI::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol,
                OpenAI::Chat::ChatCompletionAllowedToolChoice::OrHash,
                OpenAI::Chat::ChatCompletionNamedToolChoice::OrHash,
                OpenAI::Chat::ChatCompletionNamedToolChoiceCustom::OrHash
              ),
            tools:
              T::Array[
                T.any(
                  OpenAI::Chat::ChatCompletionFunctionTool::OrHash,
                  OpenAI::Chat::ChatCompletionCustomTool::OrHash
                )
              ],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            user: String,
            verbosity:
              T.nilable(
                OpenAI::Chat::CompletionCreateParams::Verbosity::OrSymbol
              ),
            web_search_options:
              OpenAI::Chat::CompletionCreateParams::WebSearchOptions::OrHash,
            stream: T.noreturn,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Internal::Stream[OpenAI::Chat::ChatCompletionChunk])
        end
        def stream_raw(
          # A list of messages comprising the conversation so far. Depending on the
          # [model](https://platform.openai.com/docs/models) you use, different message
          # types (modalities) are supported, like
          # [text](https://platform.openai.com/docs/guides/text-generation),
          # [images](https://platform.openai.com/docs/guides/vision), and
          # [audio](https://platform.openai.com/docs/guides/audio).
          messages:,
          # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
          # wide range of models with different capabilities, performance characteristics,
          # and price points. Refer to the
          # [model guide](https://platform.openai.com/docs/models) to browse and compare
          # available models.
          model:,
          # Parameters for audio output. Required when audio output is requested with
          # `modalities: ["audio"]`.
          # [Learn more](https://platform.openai.com/docs/guides/audio).
          audio: nil,
          # Number between -2.0 and 2.0. Positive values penalize new tokens based on their
          # existing frequency in the text so far, decreasing the model's likelihood to
          # repeat the same line verbatim.
          frequency_penalty: nil,
          # Deprecated in favor of `tool_choice`.
          #
          # Controls which (if any) function is called by the model.
          #
          # `none` means the model will not call a function and instead generates a message.
          #
          # `auto` means the model can pick between generating a message or calling a
          # function.
          #
          # Specifying a particular function via `{"name": "my_function"}` forces the model
          # to call that function.
          #
          # `none` is the default when no functions are present. `auto` is the default if
          # functions are present.
          function_call: nil,
          # Deprecated in favor of `tools`.
          #
          # A list of functions the model may generate JSON inputs for.
          functions: nil,
          # Modify the likelihood of specified tokens appearing in the completion.
          #
          # Accepts a JSON object that maps tokens (specified by their token ID in the
          # tokenizer) to an associated bias value from -100 to 100. Mathematically, the
          # bias is added to the logits generated by the model prior to sampling. The exact
          # effect will vary per model, but values between -1 and 1 should decrease or
          # increase likelihood of selection; values like -100 or 100 should result in a ban
          # or exclusive selection of the relevant token.
          logit_bias: nil,
          # Whether to return log probabilities of the output tokens or not. If true,
          # returns the log probabilities of each output token returned in the `content` of
          # `message`.
          logprobs: nil,
          # An upper bound for the number of tokens that can be generated for a completion,
          # including visible output tokens and
          # [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
          max_completion_tokens: nil,
          # The maximum number of [tokens](/tokenizer) that can be generated in the chat
          # completion. This value can be used to control
          # [costs](https://openai.com/api/pricing/) for text generated via API.
          #
          # This value is now deprecated in favor of `max_completion_tokens`, and is not
          # compatible with
          # [o-series models](https://platform.openai.com/docs/guides/reasoning).
          max_tokens: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # Output types that you would like the model to generate. Most models are capable
          # of generating text, which is the default:
          #
          # `["text"]`
          #
          # The `gpt-4o-audio-preview` model can also be used to
          # [generate audio](https://platform.openai.com/docs/guides/audio). To request that
          # this model generate both text and audio responses, you can use:
          #
          # `["text", "audio"]`
          modalities: nil,
          # How many chat completion choices to generate for each input message. Note that
          # you will be charged based on the number of generated tokens across all of the
          # choices. Keep `n` as `1` to minimize costs.
          n: nil,
          # Whether to enable
          # [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          # during tool use.
          parallel_tool_calls: nil,
          # Static predicted output content, such as the content of a text file that is
          # being regenerated.
          prediction: nil,
          # Number between -2.0 and 2.0. Positive values penalize new tokens based on
          # whether they appear in the text so far, increasing the model's likelihood to
          # talk about new topics.
          presence_penalty: nil,
          # Used by OpenAI to cache responses for similar requests to optimize your cache
          # hit rates. Replaces the `user` field.
          # [Learn more](https://platform.openai.com/docs/guides/prompt-caching).
          prompt_cache_key: nil,
          # Constrains effort on reasoning for
          # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          # supported values are `minimal`, `low`, `medium`, and `high`. Reducing reasoning
          # effort can result in faster responses and fewer tokens used on reasoning in a
          # response.
          reasoning_effort: nil,
          # An object specifying the format that the model must output.
          #
          # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          # Outputs which ensures the model will match your supplied JSON schema. Learn more
          # in the
          # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          # Setting to `{ "type": "json_object" }` enables the older JSON mode, which
          # ensures the message the model generates is valid JSON. Using `json_schema` is
          # preferred for models that support it.
          response_format: nil,
          # A stable identifier used to help detect users of your application that may be
          # violating OpenAI's usage policies. The IDs should be a string that uniquely
          # identifies each user. We recommend hashing their username or email address, in
          # order to avoid sending us any identifying information.
          # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
          safety_identifier: nil,
          # This feature is in Beta. If specified, our system will make a best effort to
          # sample deterministically, such that repeated requests with the same `seed` and
          # parameters should return the same result. Determinism is not guaranteed, and you
          # should refer to the `system_fingerprint` response parameter to monitor changes
          # in the backend.
          seed: nil,
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
          # Not supported with latest reasoning models `o3` and `o4-mini`.
          #
          # Up to 4 sequences where the API will stop generating further tokens. The
          # returned text will not contain the stop sequence.
          stop: nil,
          # Whether or not to store the output of this chat completion request for use in
          # our [model distillation](https://platform.openai.com/docs/guides/distillation)
          # or [evals](https://platform.openai.com/docs/guides/evals) products.
          #
          # Supports text and image inputs. Note: image inputs over 10MB will be dropped.
          store: nil,
          # Options for streaming response. Only set this when you set `stream: true`.
          stream_options: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          # make the output more random, while lower values like 0.2 will make it more
          # focused and deterministic. We generally recommend altering this or `top_p` but
          # not both.
          temperature: nil,
          # Controls which (if any) tool is called by the model. `none` means the model will
          # not call any tool and instead generates a message. `auto` means the model can
          # pick between generating a message or calling one or more tools. `required` means
          # the model must call one or more tools. Specifying a particular tool via
          # `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          # call that tool.
          #
          # `none` is the default when no tools are present. `auto` is the default if tools
          # are present.
          tool_choice: nil,
          # A list of tools the model may call. You can provide either
          # [custom tools](https://platform.openai.com/docs/guides/function-calling#custom-tools)
          # or [function tools](https://platform.openai.com/docs/guides/function-calling).
          tools: nil,
          # An integer between 0 and 20 specifying the number of most likely tokens to
          # return at each token position, each with an associated log probability.
          # `logprobs` must be set to `true` if this parameter is used.
          top_logprobs: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          # model considers the results of the tokens with top_p probability mass. So 0.1
          # means only the tokens comprising the top 10% probability mass are considered.
          #
          # We generally recommend altering this or `temperature` but not both.
          top_p: nil,
          # This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
          # `prompt_cache_key` instead to maintain caching optimizations. A stable
          # identifier for your end-users. Used to boost cache hit rates by better bucketing
          # similar requests and to help OpenAI detect and prevent abuse.
          # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).
          user: nil,
          # Constrains the verbosity of the model's response. Lower values will result in
          # more concise responses, while higher values will result in more verbose
          # responses. Currently supported values are `low`, `medium`, and `high`.
          verbosity: nil,
          # This tool searches the web for relevant results to use in a response. Learn more
          # about the
          # [web search tool](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat).
          web_search_options: nil,
          # There is no need to provide `stream:`. Instead, use `#stream_raw` or `#create`
          # for streaming and non-streaming use cases, respectively.
          stream: true,
          request_options: {}
        )
        end

        # Get a stored chat completion. Only Chat Completions that have been created with
        # the `store` parameter set to `true` will be returned.
        sig do
          params(
            completion_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Chat::ChatCompletion)
        end
        def retrieve(
          # The ID of the chat completion to retrieve.
          completion_id,
          request_options: {}
        )
        end

        # Modify a stored chat completion. Only Chat Completions that have been created
        # with the `store` parameter set to `true` can be modified. Currently, the only
        # supported modification is to update the `metadata` field.
        sig do
          params(
            completion_id: String,
            metadata: T.nilable(T::Hash[Symbol, String]),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Chat::ChatCompletion)
        end
        def update(
          # The ID of the chat completion to update.
          completion_id,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata:,
          request_options: {}
        )
        end

        # List stored Chat Completions. Only Chat Completions that have been stored with
        # the `store` parameter set to `true` will be returned.
        sig do
          params(
            after: String,
            limit: Integer,
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: String,
            order: OpenAI::Chat::CompletionListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Internal::CursorPage[OpenAI::Chat::ChatCompletion])
        end
        def list(
          # Identifier for the last chat completion from the previous pagination request.
          after: nil,
          # Number of Chat Completions to retrieve.
          limit: nil,
          # A list of metadata keys to filter the Chat Completions by. Example:
          #
          # `metadata[key1]=value1&metadata[key2]=value2`
          metadata: nil,
          # The model used to generate the Chat Completions.
          model: nil,
          # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `asc`.
          order: nil,
          request_options: {}
        )
        end

        # Delete a stored chat completion. Only Chat Completions that have been created
        # with the `store` parameter set to `true` can be deleted.
        sig do
          params(
            completion_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Chat::ChatCompletionDeleted)
        end
        def delete(
          # The ID of the chat completion to delete.
          completion_id,
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
end
