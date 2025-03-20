# typed: strong

module OpenAI
  module Models
    module Chat
      class CompletionCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # A list of messages comprising the conversation so far. Depending on the
        #   [model](https://platform.openai.com/docs/models) you use, different message
        #   types (modalities) are supported, like
        #   [text](https://platform.openai.com/docs/guides/text-generation),
        #   [images](https://platform.openai.com/docs/guides/vision), and
        #   [audio](https://platform.openai.com/docs/guides/audio).
        sig do
          returns(
            T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Models::Chat::ChatCompletionUserMessageParam,
              OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Models::Chat::ChatCompletionToolMessageParam,
              OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
            )
            ]
          )
        end
        def messages
        end

        sig do
          params(
            _: T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Models::Chat::ChatCompletionUserMessageParam,
              OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Models::Chat::ChatCompletionToolMessageParam,
              OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
            )
            ]
          )
            .returns(
              T::Array[
              T.any(
                OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
                OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
                OpenAI::Models::Chat::ChatCompletionUserMessageParam,
                OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
                OpenAI::Models::Chat::ChatCompletionToolMessageParam,
                OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
              )
              ]
            )
        end
        def messages=(_)
        end

        # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        sig { returns(T.any(String, OpenAI::Models::ChatModel::OrSymbol)) }
        def model
        end

        sig do
          params(_: T.any(String, OpenAI::Models::ChatModel::OrSymbol))
            .returns(T.any(String, OpenAI::Models::ChatModel::OrSymbol))
        end
        def model=(_)
        end

        # Parameters for audio output. Required when audio output is requested with
        #   `modalities: ["audio"]`.
        #   [Learn more](https://platform.openai.com/docs/guides/audio).
        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam)) }
        def audio
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam))
        end
        def audio=(_)
        end

        # Number between -2.0 and 2.0. Positive values penalize new tokens based on their
        #   existing frequency in the text so far, decreasing the model's likelihood to
        #   repeat the same line verbatim.
        sig { returns(T.nilable(Float)) }
        def frequency_penalty
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def frequency_penalty=(_)
        end

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
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
                OpenAI::Models::Chat::ChatCompletionFunctionCallOption
              )
            )
          )
        end
        def function_call
        end

        sig do
          params(
            _: T.any(
              OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
              OpenAI::Models::Chat::ChatCompletionFunctionCallOption
            )
          )
            .returns(
              T.any(
                OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
                OpenAI::Models::Chat::ChatCompletionFunctionCallOption
              )
            )
        end
        def function_call=(_)
        end

        # Deprecated in favor of `tools`.
        #
        #   A list of functions the model may generate JSON inputs for.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function])) }
        def functions
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function])
            .returns(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function])
        end
        def functions=(_)
        end

        # Modify the likelihood of specified tokens appearing in the completion.
        #
        #   Accepts a JSON object that maps tokens (specified by their token ID in the
        #   tokenizer) to an associated bias value from -100 to 100. Mathematically, the
        #   bias is added to the logits generated by the model prior to sampling. The exact
        #   effect will vary per model, but values between -1 and 1 should decrease or
        #   increase likelihood of selection; values like -100 or 100 should result in a ban
        #   or exclusive selection of the relevant token.
        sig { returns(T.nilable(T::Hash[Symbol, Integer])) }
        def logit_bias
        end

        sig { params(_: T.nilable(T::Hash[Symbol, Integer])).returns(T.nilable(T::Hash[Symbol, Integer])) }
        def logit_bias=(_)
        end

        # Whether to return log probabilities of the output tokens or not. If true,
        #   returns the log probabilities of each output token returned in the `content` of
        #   `message`.
        sig { returns(T.nilable(T::Boolean)) }
        def logprobs
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def logprobs=(_)
        end

        # An upper bound for the number of tokens that can be generated for a completion,
        #   including visible output tokens and
        #   [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(Integer)) }
        def max_completion_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def max_completion_tokens=(_)
        end

        # The maximum number of [tokens](/tokenizer) that can be generated in the chat
        #   completion. This value can be used to control
        #   [costs](https://openai.com/api/pricing/) for text generated via API.
        #
        #   This value is now deprecated in favor of `max_completion_tokens`, and is not
        #   compatible with
        #   [o1 series models](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(Integer)) }
        def max_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def max_tokens=(_)
        end

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        def metadata
        end

        sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
        def metadata=(_)
        end

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
        sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Modality::OrSymbol])) }
        def modalities
        end

        sig do
          params(_: T.nilable(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Modality::OrSymbol]))
            .returns(T.nilable(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Modality::OrSymbol]))
        end
        def modalities=(_)
        end

        # How many chat completion choices to generate for each input message. Note that
        #   you will be charged based on the number of generated tokens across all of the
        #   choices. Keep `n` as `1` to minimize costs.
        sig { returns(T.nilable(Integer)) }
        def n
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def n=(_)
        end

        # Whether to enable
        #   [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
        #   during tool use.
        sig { returns(T.nilable(T::Boolean)) }
        def parallel_tool_calls
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def parallel_tool_calls=(_)
        end

        # Static predicted output content, such as the content of a text file that is
        #   being regenerated.
        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent)) }
        def prediction
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent))
        end
        def prediction=(_)
        end

        # Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #   whether they appear in the text so far, increasing the model's likelihood to
        #   talk about new topics.
        sig { returns(T.nilable(Float)) }
        def presence_penalty
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def presence_penalty=(_)
        end

        # **o-series models only**
        #
        #   Constrains effort on reasoning for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
        #   result in faster responses and fewer tokens used on reasoning in a response.
        sig { returns(T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol)) }
        def reasoning_effort
        end

        sig do
          params(_: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol))
            .returns(T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol))
        end
        def reasoning_effort=(_)
        end

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
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONSchema,
                OpenAI::Models::ResponseFormatJSONObject
              )
            )
          )
        end
        def response_format
        end

        sig do
          params(
            _: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Models::ResponseFormatJSONSchema,
              OpenAI::Models::ResponseFormatJSONObject
            )
          )
            .returns(
              T.any(
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONSchema,
                OpenAI::Models::ResponseFormatJSONObject
              )
            )
        end
        def response_format=(_)
        end

        # This feature is in Beta. If specified, our system will make a best effort to
        #   sample deterministically, such that repeated requests with the same `seed` and
        #   parameters should return the same result. Determinism is not guaranteed, and you
        #   should refer to the `system_fingerprint` response parameter to monitor changes
        #   in the backend.
        sig { returns(T.nilable(Integer)) }
        def seed
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def seed=(_)
        end

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
        sig { returns(T.nilable(OpenAI::Models::Chat::CompletionCreateParams::ServiceTier::OrSymbol)) }
        def service_tier
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::ServiceTier::OrSymbol))
            .returns(T.nilable(OpenAI::Models::Chat::CompletionCreateParams::ServiceTier::OrSymbol))
        end
        def service_tier=(_)
        end

        # Up to 4 sequences where the API will stop generating further tokens. The
        #   returned text will not contain the stop sequence.
        sig { returns(T.nilable(T.any(String, T::Array[String]))) }
        def stop
        end

        sig do
          params(
            _: T.nilable(
              T.any(
                String,
                T::Array[String]
              )
            )
          ).returns(T.nilable(T.any(String, T::Array[String])))
        end
        def stop=(_)
        end

        # Whether or not to store the output of this chat completion request for use in
        #   our [model distillation](https://platform.openai.com/docs/guides/distillation)
        #   or [evals](https://platform.openai.com/docs/guides/evals) products.
        sig { returns(T.nilable(T::Boolean)) }
        def store
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def store=(_)
        end

        # Options for streaming response. Only set this when you set `stream: true`.
        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions)) }
        def stream_options
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions))
        end
        def stream_options=(_)
        end

        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic. We generally recommend altering this or `top_p` but
        #   not both.
        sig { returns(T.nilable(Float)) }
        def temperature
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def temperature=(_)
        end

        # Controls which (if any) tool is called by the model. `none` means the model will
        #   not call any tool and instead generates a message. `auto` means the model can
        #   pick between generating a message or calling one or more tools. `required` means
        #   the model must call one or more tools. Specifying a particular tool via
        #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #   call that tool.
        #
        #   `none` is the default when no tools are present. `auto` is the default if tools
        #   are present.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol,
                OpenAI::Models::Chat::ChatCompletionNamedToolChoice
              )
            )
          )
        end
        def tool_choice
        end

        sig do
          params(
            _: T.any(
              OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol,
              OpenAI::Models::Chat::ChatCompletionNamedToolChoice
            )
          )
            .returns(
              T.any(
                OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol,
                OpenAI::Models::Chat::ChatCompletionNamedToolChoice
              )
            )
        end
        def tool_choice=(_)
        end

        # A list of tools the model may call. Currently, only functions are supported as a
        #   tool. Use this to provide a list of functions the model may generate JSON inputs
        #   for. A max of 128 functions are supported.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTool])) }
        def tools
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::ChatCompletionTool])
            .returns(T::Array[OpenAI::Models::Chat::ChatCompletionTool])
        end
        def tools=(_)
        end

        # An integer between 0 and 20 specifying the number of most likely tokens to
        #   return at each token position, each with an associated log probability.
        #   `logprobs` must be set to `true` if this parameter is used.
        sig { returns(T.nilable(Integer)) }
        def top_logprobs
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def top_logprobs=(_)
        end

        # An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        sig { returns(T.nilable(Float)) }
        def top_p
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def top_p=(_)
        end

        # A unique identifier representing your end-user, which can help OpenAI to monitor
        #   and detect abuse.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        sig { returns(T.nilable(String)) }
        def user
        end

        sig { params(_: String).returns(String) }
        def user=(_)
        end

        # This tool searches the web for relevant results to use in a response. Learn more
        #   about the
        #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat).
        sig { returns(T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions)) }
        def web_search_options
        end

        sig do
          params(_: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions)
            .returns(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions)
        end
        def web_search_options=(_)
        end

        sig do
          params(
            messages: T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Models::Chat::ChatCompletionUserMessageParam,
              OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Models::Chat::ChatCompletionToolMessageParam,
              OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
            )
            ],
            model: T.any(String, OpenAI::Models::ChatModel::OrSymbol),
            audio: T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam),
            frequency_penalty: T.nilable(Float),
            function_call: T.any(
              OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
              OpenAI::Models::Chat::ChatCompletionFunctionCallOption
            ),
            functions: T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function],
            logit_bias: T.nilable(T::Hash[Symbol, Integer]),
            logprobs: T.nilable(T::Boolean),
            max_completion_tokens: T.nilable(Integer),
            max_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            modalities: T.nilable(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Modality::OrSymbol]),
            n: T.nilable(Integer),
            parallel_tool_calls: T::Boolean,
            prediction: T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent),
            presence_penalty: T.nilable(Float),
            reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
            response_format: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Models::ResponseFormatJSONSchema,
              OpenAI::Models::ResponseFormatJSONObject
            ),
            seed: T.nilable(Integer),
            service_tier: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::ServiceTier::OrSymbol),
            stop: T.nilable(T.any(String, T::Array[String])),
            store: T.nilable(T::Boolean),
            stream_options: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions),
            temperature: T.nilable(Float),
            tool_choice: T.any(
              OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol,
              OpenAI::Models::Chat::ChatCompletionNamedToolChoice
            ),
            tools: T::Array[OpenAI::Models::Chat::ChatCompletionTool],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            user: String,
            web_search_options: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          messages:,
          model:,
          audio: nil,
          frequency_penalty: nil,
          function_call: nil,
          functions: nil,
          logit_bias: nil,
          logprobs: nil,
          max_completion_tokens: nil,
          max_tokens: nil,
          metadata: nil,
          modalities: nil,
          n: nil,
          parallel_tool_calls: nil,
          prediction: nil,
          presence_penalty: nil,
          reasoning_effort: nil,
          response_format: nil,
          seed: nil,
          service_tier: nil,
          stop: nil,
          store: nil,
          stream_options: nil,
          temperature: nil,
          tool_choice: nil,
          tools: nil,
          top_logprobs: nil,
          top_p: nil,
          user: nil,
          web_search_options: nil,
          request_options: {}
        )
        end

        sig do
          override
            .returns(
              {
                messages: T::Array[
                T.any(
                  OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
                  OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
                  OpenAI::Models::Chat::ChatCompletionUserMessageParam,
                  OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
                  OpenAI::Models::Chat::ChatCompletionToolMessageParam,
                  OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
                )
                ],
                model: T.any(String, OpenAI::Models::ChatModel::OrSymbol),
                audio: T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam),
                frequency_penalty: T.nilable(Float),
                function_call: T.any(
                  OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
                  OpenAI::Models::Chat::ChatCompletionFunctionCallOption
                ),
                functions: T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function],
                logit_bias: T.nilable(T::Hash[Symbol, Integer]),
                logprobs: T.nilable(T::Boolean),
                max_completion_tokens: T.nilable(Integer),
                max_tokens: T.nilable(Integer),
                metadata: T.nilable(T::Hash[Symbol, String]),
                modalities: T.nilable(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Modality::OrSymbol]),
                n: T.nilable(Integer),
                parallel_tool_calls: T::Boolean,
                prediction: T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent),
                presence_penalty: T.nilable(Float),
                reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
                response_format: T.any(
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONSchema,
                  OpenAI::Models::ResponseFormatJSONObject
                ),
                seed: T.nilable(Integer),
                service_tier: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::ServiceTier::OrSymbol),
                stop: T.nilable(T.any(String, T::Array[String])),
                store: T.nilable(T::Boolean),
                stream_options: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions),
                temperature: T.nilable(Float),
                tool_choice: T.any(
                  OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol,
                  OpenAI::Models::Chat::ChatCompletionNamedToolChoice
                ),
                tools: T::Array[OpenAI::Models::Chat::ChatCompletionTool],
                top_logprobs: T.nilable(Integer),
                top_p: T.nilable(Float),
                user: String,
                web_search_options: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        module Model
          extend OpenAI::Union

          Variants = type_template(:out) { {fixed: T.any(String, OpenAI::Models::ChatModel::OrSymbol)} }
        end

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
        module FunctionCall
          extend OpenAI::Union

          Variants =
            type_template(:out) do
              {
                fixed: T.any(
                  OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
                  OpenAI::Models::Chat::ChatCompletionFunctionCallOption
                )
              }
            end

          # `none` means the model will not call a function and instead generates a message.
          #   `auto` means the model can pick between generating a message or calling a
          #   function.
          module FunctionCallMode
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode) }
            OrSymbol =
              T.type_alias { T.any(Symbol, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::TaggedSymbol) }

            NONE =
              T.let(:none, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol)
            AUTO =
              T.let(:auto, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol)
          end
        end

        class Function < OpenAI::BaseModel
          # The name of the function to be called. Must be a-z, A-Z, 0-9, or contain
          #   underscores and dashes, with a maximum length of 64.
          sig { returns(String) }
          def name
          end

          sig { params(_: String).returns(String) }
          def name=(_)
          end

          # A description of what the function does, used by the model to choose when and
          #   how to call the function.
          sig { returns(T.nilable(String)) }
          def description
          end

          sig { params(_: String).returns(String) }
          def description=(_)
          end

          # The parameters the functions accepts, described as a JSON Schema object. See the
          #   [guide](https://platform.openai.com/docs/guides/function-calling) for examples,
          #   and the
          #   [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for
          #   documentation about the format.
          #
          #   Omitting `parameters` defines a function with an empty parameter list.
          sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
          def parameters
          end

          sig { params(_: T::Hash[Symbol, T.anything]).returns(T::Hash[Symbol, T.anything]) }
          def parameters=(_)
          end

          sig do
            params(name: String, description: String, parameters: T::Hash[Symbol, T.anything])
              .returns(T.attached_class)
          end
          def self.new(name:, description: nil, parameters: nil)
          end

          sig do
            override.returns({name: String, description: String, parameters: T::Hash[Symbol, T.anything]})
          end
          def to_hash
          end
        end

        module Modality
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::CompletionCreateParams::Modality) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Chat::CompletionCreateParams::Modality::TaggedSymbol) }

          TEXT = T.let(:text, OpenAI::Models::Chat::CompletionCreateParams::Modality::OrSymbol)
          AUDIO = T.let(:audio, OpenAI::Models::Chat::CompletionCreateParams::Modality::OrSymbol)
        end

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
        module ResponseFormat
          extend OpenAI::Union

          Variants =
            type_template(:out) do
              {
                fixed: T.any(
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONSchema,
                  OpenAI::Models::ResponseFormatJSONObject
                )
              }
            end
        end

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
        module ServiceTier
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier::TaggedSymbol) }

          AUTO = T.let(:auto, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier::OrSymbol)
          DEFAULT = T.let(:default, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier::OrSymbol)
        end

        # Up to 4 sequences where the API will stop generating further tokens. The
        #   returned text will not contain the stop sequence.
        module Stop
          extend OpenAI::Union

          Variants = type_template(:out) { {fixed: T.nilable(T.any(String, T::Array[String]))} }

          StringArray = T.let(OpenAI::ArrayOf[String], OpenAI::Converter)
        end

        class WebSearchOptions < OpenAI::BaseModel
          # High level guidance for the amount of context window space to use for the
          #   search. One of `low`, `medium`, or `high`. `medium` is the default.
          sig do
            returns(
              T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::SearchContextSize::OrSymbol)
            )
          end
          def search_context_size
          end

          sig do
            params(_: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::SearchContextSize::OrSymbol)
              .returns(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::SearchContextSize::OrSymbol)
          end
          def search_context_size=(_)
          end

          # Approximate location parameters for the search.
          sig { returns(T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation)) }
          def user_location
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation))
              .returns(T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation))
          end
          def user_location=(_)
          end

          # This tool searches the web for relevant results to use in a response. Learn more
          #   about the
          #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat).
          sig do
            params(
              search_context_size: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::SearchContextSize::OrSymbol,
              user_location: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation)
            )
              .returns(T.attached_class)
          end
          def self.new(search_context_size: nil, user_location: nil)
          end

          sig do
            override
              .returns(
                {
                  search_context_size: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::SearchContextSize::OrSymbol,
                  user_location: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation)
                }
              )
          end
          def to_hash
          end

          # High level guidance for the amount of context window space to use for the
          #   search. One of `low`, `medium`, or `high`. `medium` is the default.
          module SearchContextSize
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::SearchContextSize) }
            OrSymbol =
              T.type_alias do
                T.any(
                  Symbol,
                  OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::SearchContextSize::TaggedSymbol
                )
              end

            LOW =
              T.let(:low, OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::SearchContextSize::OrSymbol)
            MEDIUM =
              T.let(
                :medium,
                OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::SearchContextSize::OrSymbol
              )
            HIGH =
              T.let(:high, OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::SearchContextSize::OrSymbol)
          end

          class UserLocation < OpenAI::BaseModel
            # Approximate location parameters for the search.
            sig { returns(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation::Approximate) }
            def approximate
            end

            sig do
              params(_: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation::Approximate)
                .returns(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation::Approximate)
            end
            def approximate=(_)
            end

            # The type of location approximation. Always `approximate`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # Approximate location parameters for the search.
            sig do
              params(
                approximate: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation::Approximate,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(approximate:, type: :approximate)
            end

            sig do
              override
                .returns(
                  {
                    approximate: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation::Approximate,
                    type: Symbol
                  }
                )
            end
            def to_hash
            end

            class Approximate < OpenAI::BaseModel
              # Free text input for the city of the user, e.g. `San Francisco`.
              sig { returns(T.nilable(String)) }
              def city
              end

              sig { params(_: String).returns(String) }
              def city=(_)
              end

              # The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of
              #   the user, e.g. `US`.
              sig { returns(T.nilable(String)) }
              def country
              end

              sig { params(_: String).returns(String) }
              def country=(_)
              end

              # Free text input for the region of the user, e.g. `California`.
              sig { returns(T.nilable(String)) }
              def region
              end

              sig { params(_: String).returns(String) }
              def region=(_)
              end

              # The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the
              #   user, e.g. `America/Los_Angeles`.
              sig { returns(T.nilable(String)) }
              def timezone
              end

              sig { params(_: String).returns(String) }
              def timezone=(_)
              end

              # Approximate location parameters for the search.
              sig do
                params(
                  city: String,
                  country: String,
                  region: String,
                  timezone: String
                ).returns(T.attached_class)
              end
              def self.new(city: nil, country: nil, region: nil, timezone: nil)
              end

              sig { override.returns({city: String, country: String, region: String, timezone: String}) }
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
