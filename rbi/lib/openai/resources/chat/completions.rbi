# typed: strong

module OpenAI
  module Resources
    class Chat
      class Completions
        sig { returns(OpenAI::Resources::Chat::Completions::Messages) }
        attr_reader :messages

        # **Starting a new project?** We recommend trying
        #   [Responses](https://platform.openai.com/docs/api-reference/responses) to take
        #   advantage of the latest OpenAI platform features. Compare
        #   [Chat Completions with Responses](https://platform.openai.com/docs/guides/responses-vs-chat-completions?api-mode=responses).
        #
        #   ---
        #
        #   Creates a model response for the given chat conversation. Learn more in the
        #   [text generation](https://platform.openai.com/docs/guides/text-generation),
        #   [vision](https://platform.openai.com/docs/guides/vision), and
        #   [audio](https://platform.openai.com/docs/guides/audio) guides.
        #
        #   Parameter support can differ depending on the model used to generate the
        #   response, particularly for newer reasoning models. Parameters that are only
        #   supported for reasoning models are noted below. For the current state of
        #   unsupported parameters in reasoning models,
        #   [refer to the reasoning guide](https://platform.openai.com/docs/guides/reasoning).
        sig do
          params(
            messages: T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Util::AnyHash,
              OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Models::Chat::ChatCompletionUserMessageParam,
              OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Models::Chat::ChatCompletionToolMessageParam,
              OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
            )
            ],
            model: T.any(String, OpenAI::Models::ChatModel::OrSymbol),
            audio: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionAudioParam, OpenAI::Util::AnyHash)),
            frequency_penalty: T.nilable(Float),
            function_call: T.any(
              OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
              OpenAI::Models::Chat::ChatCompletionFunctionCallOption,
              OpenAI::Util::AnyHash
            ),
            functions: T::Array[T.any(OpenAI::Models::Chat::CompletionCreateParams::Function, OpenAI::Util::AnyHash)],
            logit_bias: T.nilable(T::Hash[Symbol, Integer]),
            logprobs: T.nilable(T::Boolean),
            max_completion_tokens: T.nilable(Integer),
            max_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            modalities: T.nilable(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Modality::OrSymbol]),
            n: T.nilable(Integer),
            parallel_tool_calls: T::Boolean,
            prediction: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionPredictionContent, OpenAI::Util::AnyHash)),
            presence_penalty: T.nilable(Float),
            reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
            response_format: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Util::AnyHash,
              OpenAI::Models::ResponseFormatJSONSchema,
              OpenAI::Models::ResponseFormatJSONObject
            ),
            seed: T.nilable(Integer),
            service_tier: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::ServiceTier::OrSymbol),
            stop: T.nilable(T.any(String, T::Array[String])),
            store: T.nilable(T::Boolean),
            stream_options: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionStreamOptions, OpenAI::Util::AnyHash)),
            temperature: T.nilable(Float),
            tool_choice: T.any(
              OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol,
              OpenAI::Models::Chat::ChatCompletionNamedToolChoice,
              OpenAI::Util::AnyHash
            ),
            tools: T::Array[T.any(OpenAI::Models::Chat::ChatCompletionTool, OpenAI::Util::AnyHash)],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            user: String,
            web_search_options: T.any(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions, OpenAI::Util::AnyHash),
            stream: T.noreturn,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Models::Chat::ChatCompletion)
        end
        def create(
          # A list of messages comprising the conversation so far. Depending on the
          #   [model](https://platform.openai.com/docs/models) you use, different message
          #   types (modalities) are supported, like
          #   [text](https://platform.openai.com/docs/guides/text-generation),
          #   [images](https://platform.openai.com/docs/guides/vision), and
          #   [audio](https://platform.openai.com/docs/guides/audio).
          messages:,
          # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
          #   wide range of models with different capabilities, performance characteristics,
          #   and price points. Refer to the
          #   [model guide](https://platform.openai.com/docs/models) to browse and compare
          #   available models.
          model:,
          # Parameters for audio output. Required when audio output is requested with
          #   `modalities: ["audio"]`.
          #   [Learn more](https://platform.openai.com/docs/guides/audio).
          audio: nil,
          # Number between -2.0 and 2.0. Positive values penalize new tokens based on their
          #   existing frequency in the text so far, decreasing the model's likelihood to
          #   repeat the same line verbatim.
          frequency_penalty: nil,
          # Deprecated in favor of `tool_choice`.
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
          function_call: nil,
          # Deprecated in favor of `tools`.
          #
          #   A list of functions the model may generate JSON inputs for.
          functions: nil,
          # Modify the likelihood of specified tokens appearing in the completion.
          #
          #   Accepts a JSON object that maps tokens (specified by their token ID in the
          #   tokenizer) to an associated bias value from -100 to 100. Mathematically, the
          #   bias is added to the logits generated by the model prior to sampling. The exact
          #   effect will vary per model, but values between -1 and 1 should decrease or
          #   increase likelihood of selection; values like -100 or 100 should result in a ban
          #   or exclusive selection of the relevant token.
          logit_bias: nil,
          # Whether to return log probabilities of the output tokens or not. If true,
          #   returns the log probabilities of each output token returned in the `content` of
          #   `message`.
          logprobs: nil,
          # An upper bound for the number of tokens that can be generated for a completion,
          #   including visible output tokens and
          #   [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
          max_completion_tokens: nil,
          # The maximum number of [tokens](/tokenizer) that can be generated in the chat
          #   completion. This value can be used to control
          #   [costs](https://openai.com/api/pricing/) for text generated via API.
          #
          #   This value is now deprecated in favor of `max_completion_tokens`, and is not
          #   compatible with
          #   [o1 series models](https://platform.openai.com/docs/guides/reasoning).
          max_tokens: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          metadata: nil,
          # Output types that you would like the model to generate. Most models are capable
          #   of generating text, which is the default:
          #
          #   `["text"]`
          #
          #   The `gpt-4o-audio-preview` model can also be used to
          #   [generate audio](https://platform.openai.com/docs/guides/audio). To request that
          #   this model generate both text and audio responses, you can use:
          #
          #   `["text", "audio"]`
          modalities: nil,
          # How many chat completion choices to generate for each input message. Note that
          #   you will be charged based on the number of generated tokens across all of the
          #   choices. Keep `n` as `1` to minimize costs.
          n: nil,
          # Whether to enable
          #   [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          #   during tool use.
          parallel_tool_calls: nil,
          # Static predicted output content, such as the content of a text file that is
          #   being regenerated.
          prediction: nil,
          # Number between -2.0 and 2.0. Positive values penalize new tokens based on
          #   whether they appear in the text so far, increasing the model's likelihood to
          #   talk about new topics.
          presence_penalty: nil,
          # **o-series models only**
          #
          #   Constrains effort on reasoning for
          #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
          #   result in faster responses and fewer tokens used on reasoning in a response.
          reasoning_effort: nil,
          # An object specifying the format that the model must output.
          #
          #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #   Outputs which ensures the model will match your supplied JSON schema. Learn more
          #   in the
          #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #   Setting to `{ "type": "json_object" }` enables the older JSON mode, which
          #   ensures the message the model generates is valid JSON. Using `json_schema` is
          #   preferred for models that support it.
          response_format: nil,
          # This feature is in Beta. If specified, our system will make a best effort to
          #   sample deterministically, such that repeated requests with the same `seed` and
          #   parameters should return the same result. Determinism is not guaranteed, and you
          #   should refer to the `system_fingerprint` response parameter to monitor changes
          #   in the backend.
          seed: nil,
          # Specifies the latency tier to use for processing the request. This parameter is
          #   relevant for customers subscribed to the scale tier service:
          #
          #   - If set to 'auto', and the Project is Scale tier enabled, the system will
          #     utilize scale tier credits until they are exhausted.
          #   - If set to 'auto', and the Project is not Scale tier enabled, the request will
          #     be processed using the default service tier with a lower uptime SLA and no
          #     latency guarentee.
          #   - If set to 'default', the request will be processed using the default service
          #     tier with a lower uptime SLA and no latency guarentee.
          #   - When not set, the default behavior is 'auto'.
          #
          #   When this parameter is set, the response body will include the `service_tier`
          #   utilized.
          service_tier: nil,
          # Up to 4 sequences where the API will stop generating further tokens. The
          #   returned text will not contain the stop sequence.
          stop: nil,
          # Whether or not to store the output of this chat completion request for use in
          #   our [model distillation](https://platform.openai.com/docs/guides/distillation)
          #   or [evals](https://platform.openai.com/docs/guides/evals) products.
          store: nil,
          # Options for streaming response. Only set this when you set `stream: true`.
          stream_options: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          #   make the output more random, while lower values like 0.2 will make it more
          #   focused and deterministic. We generally recommend altering this or `top_p` but
          #   not both.
          temperature: nil,
          # Controls which (if any) tool is called by the model. `none` means the model will
          #   not call any tool and instead generates a message. `auto` means the model can
          #   pick between generating a message or calling one or more tools. `required` means
          #   the model must call one or more tools. Specifying a particular tool via
          #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #   call that tool.
          #
          #   `none` is the default when no tools are present. `auto` is the default if tools
          #   are present.
          tool_choice: nil,
          # A list of tools the model may call. Currently, only functions are supported as a
          #   tool. Use this to provide a list of functions the model may generate JSON inputs
          #   for. A max of 128 functions are supported.
          tools: nil,
          # An integer between 0 and 20 specifying the number of most likely tokens to
          #   return at each token position, each with an associated log probability.
          #   `logprobs` must be set to `true` if this parameter is used.
          top_logprobs: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          #   model considers the results of the tokens with top_p probability mass. So 0.1
          #   means only the tokens comprising the top 10% probability mass are considered.
          #
          #   We generally recommend altering this or `temperature` but not both.
          top_p: nil,
          # A unique identifier representing your end-user, which can help OpenAI to monitor
          #   and detect abuse.
          #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
          user: nil,
          # This tool searches the web for relevant results to use in a response. Learn more
          #   about the
          #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat).
          web_search_options: nil,
          # There is no need to provide `stream:`. Instead, use `#create_streaming` or
          #   `#create` for streaming and non-streaming use cases, respectively.
          stream: false,
          request_options: {}
        )
        end

        # **Starting a new project?** We recommend trying
        #   [Responses](https://platform.openai.com/docs/api-reference/responses) to take
        #   advantage of the latest OpenAI platform features. Compare
        #   [Chat Completions with Responses](https://platform.openai.com/docs/guides/responses-vs-chat-completions?api-mode=responses).
        #
        #   ---
        #
        #   Creates a model response for the given chat conversation. Learn more in the
        #   [text generation](https://platform.openai.com/docs/guides/text-generation),
        #   [vision](https://platform.openai.com/docs/guides/vision), and
        #   [audio](https://platform.openai.com/docs/guides/audio) guides.
        #
        #   Parameter support can differ depending on the model used to generate the
        #   response, particularly for newer reasoning models. Parameters that are only
        #   supported for reasoning models are noted below. For the current state of
        #   unsupported parameters in reasoning models,
        #   [refer to the reasoning guide](https://platform.openai.com/docs/guides/reasoning).
        sig do
          params(
            messages: T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Util::AnyHash,
              OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Models::Chat::ChatCompletionUserMessageParam,
              OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Models::Chat::ChatCompletionToolMessageParam,
              OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
            )
            ],
            model: T.any(String, OpenAI::Models::ChatModel::OrSymbol),
            audio: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionAudioParam, OpenAI::Util::AnyHash)),
            frequency_penalty: T.nilable(Float),
            function_call: T.any(
              OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
              OpenAI::Models::Chat::ChatCompletionFunctionCallOption,
              OpenAI::Util::AnyHash
            ),
            functions: T::Array[T.any(OpenAI::Models::Chat::CompletionCreateParams::Function, OpenAI::Util::AnyHash)],
            logit_bias: T.nilable(T::Hash[Symbol, Integer]),
            logprobs: T.nilable(T::Boolean),
            max_completion_tokens: T.nilable(Integer),
            max_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            modalities: T.nilable(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Modality::OrSymbol]),
            n: T.nilable(Integer),
            parallel_tool_calls: T::Boolean,
            prediction: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionPredictionContent, OpenAI::Util::AnyHash)),
            presence_penalty: T.nilable(Float),
            reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
            response_format: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Util::AnyHash,
              OpenAI::Models::ResponseFormatJSONSchema,
              OpenAI::Models::ResponseFormatJSONObject
            ),
            seed: T.nilable(Integer),
            service_tier: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::ServiceTier::OrSymbol),
            stop: T.nilable(T.any(String, T::Array[String])),
            store: T.nilable(T::Boolean),
            stream_options: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletionStreamOptions, OpenAI::Util::AnyHash)),
            temperature: T.nilable(Float),
            tool_choice: T.any(
              OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol,
              OpenAI::Models::Chat::ChatCompletionNamedToolChoice,
              OpenAI::Util::AnyHash
            ),
            tools: T::Array[T.any(OpenAI::Models::Chat::ChatCompletionTool, OpenAI::Util::AnyHash)],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            user: String,
            web_search_options: T.any(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions, OpenAI::Util::AnyHash),
            stream: T.noreturn,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Stream[OpenAI::Models::Chat::ChatCompletionChunk])
        end
        def create_streaming(
          # A list of messages comprising the conversation so far. Depending on the
          #   [model](https://platform.openai.com/docs/models) you use, different message
          #   types (modalities) are supported, like
          #   [text](https://platform.openai.com/docs/guides/text-generation),
          #   [images](https://platform.openai.com/docs/guides/vision), and
          #   [audio](https://platform.openai.com/docs/guides/audio).
          messages:,
          # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
          #   wide range of models with different capabilities, performance characteristics,
          #   and price points. Refer to the
          #   [model guide](https://platform.openai.com/docs/models) to browse and compare
          #   available models.
          model:,
          # Parameters for audio output. Required when audio output is requested with
          #   `modalities: ["audio"]`.
          #   [Learn more](https://platform.openai.com/docs/guides/audio).
          audio: nil,
          # Number between -2.0 and 2.0. Positive values penalize new tokens based on their
          #   existing frequency in the text so far, decreasing the model's likelihood to
          #   repeat the same line verbatim.
          frequency_penalty: nil,
          # Deprecated in favor of `tool_choice`.
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
          function_call: nil,
          # Deprecated in favor of `tools`.
          #
          #   A list of functions the model may generate JSON inputs for.
          functions: nil,
          # Modify the likelihood of specified tokens appearing in the completion.
          #
          #   Accepts a JSON object that maps tokens (specified by their token ID in the
          #   tokenizer) to an associated bias value from -100 to 100. Mathematically, the
          #   bias is added to the logits generated by the model prior to sampling. The exact
          #   effect will vary per model, but values between -1 and 1 should decrease or
          #   increase likelihood of selection; values like -100 or 100 should result in a ban
          #   or exclusive selection of the relevant token.
          logit_bias: nil,
          # Whether to return log probabilities of the output tokens or not. If true,
          #   returns the log probabilities of each output token returned in the `content` of
          #   `message`.
          logprobs: nil,
          # An upper bound for the number of tokens that can be generated for a completion,
          #   including visible output tokens and
          #   [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
          max_completion_tokens: nil,
          # The maximum number of [tokens](/tokenizer) that can be generated in the chat
          #   completion. This value can be used to control
          #   [costs](https://openai.com/api/pricing/) for text generated via API.
          #
          #   This value is now deprecated in favor of `max_completion_tokens`, and is not
          #   compatible with
          #   [o1 series models](https://platform.openai.com/docs/guides/reasoning).
          max_tokens: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          metadata: nil,
          # Output types that you would like the model to generate. Most models are capable
          #   of generating text, which is the default:
          #
          #   `["text"]`
          #
          #   The `gpt-4o-audio-preview` model can also be used to
          #   [generate audio](https://platform.openai.com/docs/guides/audio). To request that
          #   this model generate both text and audio responses, you can use:
          #
          #   `["text", "audio"]`
          modalities: nil,
          # How many chat completion choices to generate for each input message. Note that
          #   you will be charged based on the number of generated tokens across all of the
          #   choices. Keep `n` as `1` to minimize costs.
          n: nil,
          # Whether to enable
          #   [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          #   during tool use.
          parallel_tool_calls: nil,
          # Static predicted output content, such as the content of a text file that is
          #   being regenerated.
          prediction: nil,
          # Number between -2.0 and 2.0. Positive values penalize new tokens based on
          #   whether they appear in the text so far, increasing the model's likelihood to
          #   talk about new topics.
          presence_penalty: nil,
          # **o-series models only**
          #
          #   Constrains effort on reasoning for
          #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
          #   result in faster responses and fewer tokens used on reasoning in a response.
          reasoning_effort: nil,
          # An object specifying the format that the model must output.
          #
          #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #   Outputs which ensures the model will match your supplied JSON schema. Learn more
          #   in the
          #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #   Setting to `{ "type": "json_object" }` enables the older JSON mode, which
          #   ensures the message the model generates is valid JSON. Using `json_schema` is
          #   preferred for models that support it.
          response_format: nil,
          # This feature is in Beta. If specified, our system will make a best effort to
          #   sample deterministically, such that repeated requests with the same `seed` and
          #   parameters should return the same result. Determinism is not guaranteed, and you
          #   should refer to the `system_fingerprint` response parameter to monitor changes
          #   in the backend.
          seed: nil,
          # Specifies the latency tier to use for processing the request. This parameter is
          #   relevant for customers subscribed to the scale tier service:
          #
          #   - If set to 'auto', and the Project is Scale tier enabled, the system will
          #     utilize scale tier credits until they are exhausted.
          #   - If set to 'auto', and the Project is not Scale tier enabled, the request will
          #     be processed using the default service tier with a lower uptime SLA and no
          #     latency guarentee.
          #   - If set to 'default', the request will be processed using the default service
          #     tier with a lower uptime SLA and no latency guarentee.
          #   - When not set, the default behavior is 'auto'.
          #
          #   When this parameter is set, the response body will include the `service_tier`
          #   utilized.
          service_tier: nil,
          # Up to 4 sequences where the API will stop generating further tokens. The
          #   returned text will not contain the stop sequence.
          stop: nil,
          # Whether or not to store the output of this chat completion request for use in
          #   our [model distillation](https://platform.openai.com/docs/guides/distillation)
          #   or [evals](https://platform.openai.com/docs/guides/evals) products.
          store: nil,
          # Options for streaming response. Only set this when you set `stream: true`.
          stream_options: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          #   make the output more random, while lower values like 0.2 will make it more
          #   focused and deterministic. We generally recommend altering this or `top_p` but
          #   not both.
          temperature: nil,
          # Controls which (if any) tool is called by the model. `none` means the model will
          #   not call any tool and instead generates a message. `auto` means the model can
          #   pick between generating a message or calling one or more tools. `required` means
          #   the model must call one or more tools. Specifying a particular tool via
          #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #   call that tool.
          #
          #   `none` is the default when no tools are present. `auto` is the default if tools
          #   are present.
          tool_choice: nil,
          # A list of tools the model may call. Currently, only functions are supported as a
          #   tool. Use this to provide a list of functions the model may generate JSON inputs
          #   for. A max of 128 functions are supported.
          tools: nil,
          # An integer between 0 and 20 specifying the number of most likely tokens to
          #   return at each token position, each with an associated log probability.
          #   `logprobs` must be set to `true` if this parameter is used.
          top_logprobs: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          #   model considers the results of the tokens with top_p probability mass. So 0.1
          #   means only the tokens comprising the top 10% probability mass are considered.
          #
          #   We generally recommend altering this or `temperature` but not both.
          top_p: nil,
          # A unique identifier representing your end-user, which can help OpenAI to monitor
          #   and detect abuse.
          #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
          user: nil,
          # This tool searches the web for relevant results to use in a response. Learn more
          #   about the
          #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat).
          web_search_options: nil,
          # There is no need to provide `stream:`. Instead, use `#create_streaming` or
          #   `#create` for streaming and non-streaming use cases, respectively.
          stream: true,
          request_options: {}
        )
        end

        # Get a stored chat completion. Only Chat Completions that have been created with
        #   the `store` parameter set to `true` will be returned.
        sig do
          params(
            completion_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Models::Chat::ChatCompletion)
        end
        def retrieve(
          # The ID of the chat completion to retrieve.
          completion_id,
          request_options: {}
        )
        end

        # Modify a stored chat completion. Only Chat Completions that have been created
        #   with the `store` parameter set to `true` can be modified. Currently, the only
        #   supported modification is to update the `metadata` field.
        sig do
          params(
            completion_id: String,
            metadata: T.nilable(T::Hash[Symbol, String]),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Models::Chat::ChatCompletion)
        end
        def update(
          # The ID of the chat completion to update.
          completion_id,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          metadata:,
          request_options: {}
        )
        end

        # List stored Chat Completions. Only Chat Completions that have been stored with
        #   the `store` parameter set to `true` will be returned.
        sig do
          params(
            after: String,
            limit: Integer,
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: String,
            order: OpenAI::Models::Chat::CompletionListParams::Order::OrSymbol,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::CursorPage[OpenAI::Models::Chat::ChatCompletion])
        end
        def list(
          # Identifier for the last chat completion from the previous pagination request.
          after: nil,
          # Number of Chat Completions to retrieve.
          limit: nil,
          # A list of metadata keys to filter the Chat Completions by. Example:
          #
          #   `metadata[key1]=value1&metadata[key2]=value2`
          metadata: nil,
          # The model used to generate the Chat Completions.
          model: nil,
          # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
          #   `desc` for descending order. Defaults to `asc`.
          order: nil,
          request_options: {}
        )
        end

        # Delete a stored chat completion. Only Chat Completions that have been created
        #   with the `store` parameter set to `true` can be deleted.
        sig do
          params(
            completion_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Models::Chat::ChatCompletionDeleted)
        end
        def delete(
          # The ID of the chat completion to delete.
          completion_id,
          request_options: {}
        )
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
