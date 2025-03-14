# frozen_string_literal: true

module OpenAI
  module Resources
    class Chat
      class Completions
        # Creates a model response for the given chat conversation. Learn more in the
        #   [text generation](https://platform.openai.com/docs/guides/text-generation),
        #   [vision](https://platform.openai.com/docs/guides/vision), and
        #   [audio](https://platform.openai.com/docs/guides/audio) guides.
        #
        #   Parameter support can differ depending on the model used to generate the
        #   response, particularly for newer reasoning models. Parameters that are only
        #   supported for reasoning models are noted below. For the current state of
        #   unsupported parameters in reasoning models,
        #   [refer to the reasoning guide](https://platform.openai.com/docs/guides/reasoning).
        #
        # @param params [OpenAI::Models::Chat::CompletionCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [Array<OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam, OpenAI::Models::Chat::ChatCompletionSystemMessageParam, OpenAI::Models::Chat::ChatCompletionUserMessageParam, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam, OpenAI::Models::Chat::ChatCompletionToolMessageParam, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam>] :messages A list of messages comprising the conversation so far. Depending on the
        #     [model](https://platform.openai.com/docs/models) you use, different message
        #     types (modalities) are supported, like
        #     [text](https://platform.openai.com/docs/guides/text-generation),
        #     [images](https://platform.openai.com/docs/guides/vision), and
        #     [audio](https://platform.openai.com/docs/guides/audio).
        #
        #   @option params [String, Symbol, OpenAI::Models::ChatModel] :model ID of the model to use. See the
        #     [model endpoint compatibility](https://platform.openai.com/docs/models#model-endpoint-compatibility)
        #     table for details on which models work with the Chat API.
        #
        #   @option params [OpenAI::Models::Chat::ChatCompletionAudioParam, nil] :audio Parameters for audio output. Required when audio output is requested with
        #     `modalities: ["audio"]`.
        #     [Learn more](https://platform.openai.com/docs/guides/audio).
        #
        #   @option params [Float, nil] :frequency_penalty Number between -2.0 and 2.0. Positive values penalize new tokens based on their
        #     existing frequency in the text so far, decreasing the model's likelihood to
        #     repeat the same line verbatim.
        #
        #   @option params [Symbol, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::Auto, OpenAI::Models::Chat::ChatCompletionFunctionCallOption] :function_call Deprecated in favor of `tool_choice`.
        #
        #     Controls which (if any) function is called by the model.
        #
        #     `none` means the model will not call a function and instead generates a message.
        #
        #     `auto` means the model can pick between generating a message or calling a
        #     function.
        #
        #     Specifying a particular function via `{"name": "my_function"}` forces the model
        #     to call that function.
        #
        #     `none` is the default when no functions are present. `auto` is the default if
        #     functions are present.
        #
        #   @option params [Array<OpenAI::Models::Chat::CompletionCreateParams::Function>] :functions Deprecated in favor of `tools`.
        #
        #     A list of functions the model may generate JSON inputs for.
        #
        #   @option params [Hash{Symbol=>Integer}, nil] :logit_bias Modify the likelihood of specified tokens appearing in the completion.
        #
        #     Accepts a JSON object that maps tokens (specified by their token ID in the
        #     tokenizer) to an associated bias value from -100 to 100. Mathematically, the
        #     bias is added to the logits generated by the model prior to sampling. The exact
        #     effect will vary per model, but values between -1 and 1 should decrease or
        #     increase likelihood of selection; values like -100 or 100 should result in a ban
        #     or exclusive selection of the relevant token.
        #
        #   @option params [Boolean, nil] :logprobs Whether to return log probabilities of the output tokens or not. If true,
        #     returns the log probabilities of each output token returned in the `content` of
        #     `message`.
        #
        #   @option params [Integer, nil] :max_completion_tokens An upper bound for the number of tokens that can be generated for a completion,
        #     including visible output tokens and
        #     [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @option params [Integer, nil] :max_tokens The maximum number of [tokens](/tokenizer) that can be generated in the chat
        #     completion. This value can be used to control
        #     [costs](https://openai.com/api/pricing/) for text generated via API.
        #
        #     This value is now deprecated in favor of `max_completion_tokens`, and is not
        #     compatible with
        #     [o1 series models](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [Array<Symbol, OpenAI::Models::Chat::ChatCompletionModality>, nil] :modalities Output types that you would like the model to generate for this request. Most
        #     models are capable of generating text, which is the default:
        #
        #     `["text"]`
        #
        #     The `gpt-4o-audio-preview` model can also be used to
        #     [generate audio](https://platform.openai.com/docs/guides/audio). To request that
        #     this model generate both text and audio responses, you can use:
        #
        #     `["text", "audio"]`
        #
        #   @option params [Integer, nil] :n How many chat completion choices to generate for each input message. Note that
        #     you will be charged based on the number of generated tokens across all of the
        #     choices. Keep `n` as `1` to minimize costs.
        #
        #   @option params [Boolean] :parallel_tool_calls Whether to enable
        #     [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
        #     during tool use.
        #
        #   @option params [OpenAI::Models::Chat::ChatCompletionPredictionContent, nil] :prediction Static predicted output content, such as the content of a text file that is
        #     being regenerated.
        #
        #   @option params [Float, nil] :presence_penalty Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #     whether they appear in the text so far, increasing the model's likelihood to
        #     talk about new topics.
        #
        #   @option params [Symbol, OpenAI::Models::Chat::ChatCompletionReasoningEffort, nil] :reasoning_effort **o1 and o3-mini models only**
        #
        #     Constrains effort on reasoning for
        #     [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        #     supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
        #     result in faster responses and fewer tokens used on reasoning in a response.
        #
        #   @option params [OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema] :response_format An object specifying the format that the model must output.
        #
        #     Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        #     Outputs which ensures the model will match your supplied JSON schema. Learn more
        #     in the
        #     [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        #     Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
        #     message the model generates is valid JSON.
        #
        #     **Important:** when using JSON mode, you **must** also instruct the model to
        #     produce JSON yourself via a system or user message. Without this, the model may
        #     generate an unending stream of whitespace until the generation reaches the token
        #     limit, resulting in a long-running and seemingly "stuck" request. Also note that
        #     the message content may be partially cut off if `finish_reason="length"`, which
        #     indicates the generation exceeded `max_tokens` or the conversation exceeded the
        #     max context length.
        #
        #   @option params [Integer, nil] :seed This feature is in Beta. If specified, our system will make a best effort to
        #     sample deterministically, such that repeated requests with the same `seed` and
        #     parameters should return the same result. Determinism is not guaranteed, and you
        #     should refer to the `system_fingerprint` response parameter to monitor changes
        #     in the backend.
        #
        #   @option params [Symbol, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier, nil] :service_tier Specifies the latency tier to use for processing the request. This parameter is
        #     relevant for customers subscribed to the scale tier service:
        #
        #     - If set to 'auto', and the Project is Scale tier enabled, the system will
        #       utilize scale tier credits until they are exhausted.
        #     - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #       be processed using the default service tier with a lower uptime SLA and no
        #       latency guarantee.
        #     - If set to 'default', the request will be processed using the default service
        #       tier with a lower uptime SLA and no latency guarantee.
        #     - When not set, the default behavior is 'auto'.
        #
        #   @option params [String, Array<String>, nil] :stop Up to 4 sequences where the API will stop generating further tokens.
        #
        #   @option params [Boolean, nil] :store Whether or not to store the output of this chat completion request for use in
        #     our [model distillation](https://platform.openai.com/docs/guides/distillation)
        #     or [evals](https://platform.openai.com/docs/guides/evals) products.
        #
        #   @option params [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil] :stream_options Options for streaming response. Only set this when you set `stream: true`.
        #
        #   @option params [Float, nil] :temperature What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #     make the output more random, while lower values like 0.2 will make it more
        #     focused and deterministic. We generally recommend altering this or `top_p` but
        #     not both.
        #
        #   @option params [Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Models::Chat::ChatCompletionNamedToolChoice] :tool_choice Controls which (if any) tool is called by the model. `none` means the model will
        #     not call any tool and instead generates a message. `auto` means the model can
        #     pick between generating a message or calling one or more tools. `required` means
        #     the model must call one or more tools. Specifying a particular tool via
        #     `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #     call that tool.
        #
        #     `none` is the default when no tools are present. `auto` is the default if tools
        #     are present.
        #
        #   @option params [Array<OpenAI::Models::Chat::ChatCompletionTool>] :tools A list of tools the model may call. Currently, only functions are supported as a
        #     tool. Use this to provide a list of functions the model may generate JSON inputs
        #     for. A max of 128 functions are supported.
        #
        #   @option params [Integer, nil] :top_logprobs An integer between 0 and 20 specifying the number of most likely tokens to
        #     return at each token position, each with an associated log probability.
        #     `logprobs` must be set to `true` if this parameter is used.
        #
        #   @option params [Float, nil] :top_p An alternative to sampling with temperature, called nucleus sampling, where the
        #     model considers the results of the tokens with top_p probability mass. So 0.1
        #     means only the tokens comprising the top 10% probability mass are considered.
        #
        #     We generally recommend altering this or `temperature` but not both.
        #
        #   @option params [String] :user A unique identifier representing your end-user, which can help OpenAI to monitor
        #     and detect abuse.
        #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Chat::ChatCompletion]
        def create(params)
          parsed, options = OpenAI::Models::Chat::CompletionCreateParams.dump_request(params)
          parsed.delete(:stream)
          @client.request(
            method: :post,
            path: "chat/completions",
            body: parsed,
            model: OpenAI::Models::Chat::ChatCompletion,
            options: options
          )
        end

        # Creates a model response for the given chat conversation. Learn more in the
        #   [text generation](https://platform.openai.com/docs/guides/text-generation),
        #   [vision](https://platform.openai.com/docs/guides/vision), and
        #   [audio](https://platform.openai.com/docs/guides/audio) guides.
        #
        #   Parameter support can differ depending on the model used to generate the
        #   response, particularly for newer reasoning models. Parameters that are only
        #   supported for reasoning models are noted below. For the current state of
        #   unsupported parameters in reasoning models,
        #   [refer to the reasoning guide](https://platform.openai.com/docs/guides/reasoning).
        #
        # @param params [OpenAI::Models::Chat::CompletionCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [Array<OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam, OpenAI::Models::Chat::ChatCompletionSystemMessageParam, OpenAI::Models::Chat::ChatCompletionUserMessageParam, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam, OpenAI::Models::Chat::ChatCompletionToolMessageParam, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam>] :messages A list of messages comprising the conversation so far. Depending on the
        #     [model](https://platform.openai.com/docs/models) you use, different message
        #     types (modalities) are supported, like
        #     [text](https://platform.openai.com/docs/guides/text-generation),
        #     [images](https://platform.openai.com/docs/guides/vision), and
        #     [audio](https://platform.openai.com/docs/guides/audio).
        #
        #   @option params [String, Symbol, OpenAI::Models::ChatModel] :model ID of the model to use. See the
        #     [model endpoint compatibility](https://platform.openai.com/docs/models#model-endpoint-compatibility)
        #     table for details on which models work with the Chat API.
        #
        #   @option params [OpenAI::Models::Chat::ChatCompletionAudioParam, nil] :audio Parameters for audio output. Required when audio output is requested with
        #     `modalities: ["audio"]`.
        #     [Learn more](https://platform.openai.com/docs/guides/audio).
        #
        #   @option params [Float, nil] :frequency_penalty Number between -2.0 and 2.0. Positive values penalize new tokens based on their
        #     existing frequency in the text so far, decreasing the model's likelihood to
        #     repeat the same line verbatim.
        #
        #   @option params [Symbol, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::Auto, OpenAI::Models::Chat::ChatCompletionFunctionCallOption] :function_call Deprecated in favor of `tool_choice`.
        #
        #     Controls which (if any) function is called by the model.
        #
        #     `none` means the model will not call a function and instead generates a message.
        #
        #     `auto` means the model can pick between generating a message or calling a
        #     function.
        #
        #     Specifying a particular function via `{"name": "my_function"}` forces the model
        #     to call that function.
        #
        #     `none` is the default when no functions are present. `auto` is the default if
        #     functions are present.
        #
        #   @option params [Array<OpenAI::Models::Chat::CompletionCreateParams::Function>] :functions Deprecated in favor of `tools`.
        #
        #     A list of functions the model may generate JSON inputs for.
        #
        #   @option params [Hash{Symbol=>Integer}, nil] :logit_bias Modify the likelihood of specified tokens appearing in the completion.
        #
        #     Accepts a JSON object that maps tokens (specified by their token ID in the
        #     tokenizer) to an associated bias value from -100 to 100. Mathematically, the
        #     bias is added to the logits generated by the model prior to sampling. The exact
        #     effect will vary per model, but values between -1 and 1 should decrease or
        #     increase likelihood of selection; values like -100 or 100 should result in a ban
        #     or exclusive selection of the relevant token.
        #
        #   @option params [Boolean, nil] :logprobs Whether to return log probabilities of the output tokens or not. If true,
        #     returns the log probabilities of each output token returned in the `content` of
        #     `message`.
        #
        #   @option params [Integer, nil] :max_completion_tokens An upper bound for the number of tokens that can be generated for a completion,
        #     including visible output tokens and
        #     [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @option params [Integer, nil] :max_tokens The maximum number of [tokens](/tokenizer) that can be generated in the chat
        #     completion. This value can be used to control
        #     [costs](https://openai.com/api/pricing/) for text generated via API.
        #
        #     This value is now deprecated in favor of `max_completion_tokens`, and is not
        #     compatible with
        #     [o1 series models](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [Array<Symbol, OpenAI::Models::Chat::ChatCompletionModality>, nil] :modalities Output types that you would like the model to generate for this request. Most
        #     models are capable of generating text, which is the default:
        #
        #     `["text"]`
        #
        #     The `gpt-4o-audio-preview` model can also be used to
        #     [generate audio](https://platform.openai.com/docs/guides/audio). To request that
        #     this model generate both text and audio responses, you can use:
        #
        #     `["text", "audio"]`
        #
        #   @option params [Integer, nil] :n How many chat completion choices to generate for each input message. Note that
        #     you will be charged based on the number of generated tokens across all of the
        #     choices. Keep `n` as `1` to minimize costs.
        #
        #   @option params [Boolean] :parallel_tool_calls Whether to enable
        #     [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
        #     during tool use.
        #
        #   @option params [OpenAI::Models::Chat::ChatCompletionPredictionContent, nil] :prediction Static predicted output content, such as the content of a text file that is
        #     being regenerated.
        #
        #   @option params [Float, nil] :presence_penalty Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #     whether they appear in the text so far, increasing the model's likelihood to
        #     talk about new topics.
        #
        #   @option params [Symbol, OpenAI::Models::Chat::ChatCompletionReasoningEffort, nil] :reasoning_effort **o1 and o3-mini models only**
        #
        #     Constrains effort on reasoning for
        #     [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        #     supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
        #     result in faster responses and fewer tokens used on reasoning in a response.
        #
        #   @option params [OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema] :response_format An object specifying the format that the model must output.
        #
        #     Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        #     Outputs which ensures the model will match your supplied JSON schema. Learn more
        #     in the
        #     [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        #     Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
        #     message the model generates is valid JSON.
        #
        #     **Important:** when using JSON mode, you **must** also instruct the model to
        #     produce JSON yourself via a system or user message. Without this, the model may
        #     generate an unending stream of whitespace until the generation reaches the token
        #     limit, resulting in a long-running and seemingly "stuck" request. Also note that
        #     the message content may be partially cut off if `finish_reason="length"`, which
        #     indicates the generation exceeded `max_tokens` or the conversation exceeded the
        #     max context length.
        #
        #   @option params [Integer, nil] :seed This feature is in Beta. If specified, our system will make a best effort to
        #     sample deterministically, such that repeated requests with the same `seed` and
        #     parameters should return the same result. Determinism is not guaranteed, and you
        #     should refer to the `system_fingerprint` response parameter to monitor changes
        #     in the backend.
        #
        #   @option params [Symbol, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier, nil] :service_tier Specifies the latency tier to use for processing the request. This parameter is
        #     relevant for customers subscribed to the scale tier service:
        #
        #     - If set to 'auto', and the Project is Scale tier enabled, the system will
        #       utilize scale tier credits until they are exhausted.
        #     - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #       be processed using the default service tier with a lower uptime SLA and no
        #       latency guarantee.
        #     - If set to 'default', the request will be processed using the default service
        #       tier with a lower uptime SLA and no latency guarantee.
        #     - When not set, the default behavior is 'auto'.
        #
        #   @option params [String, Array<String>, nil] :stop Up to 4 sequences where the API will stop generating further tokens.
        #
        #   @option params [Boolean, nil] :store Whether or not to store the output of this chat completion request for use in
        #     our [model distillation](https://platform.openai.com/docs/guides/distillation)
        #     or [evals](https://platform.openai.com/docs/guides/evals) products.
        #
        #   @option params [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil] :stream_options Options for streaming response. Only set this when you set `stream: true`.
        #
        #   @option params [Float, nil] :temperature What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #     make the output more random, while lower values like 0.2 will make it more
        #     focused and deterministic. We generally recommend altering this or `top_p` but
        #     not both.
        #
        #   @option params [Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Models::Chat::ChatCompletionNamedToolChoice] :tool_choice Controls which (if any) tool is called by the model. `none` means the model will
        #     not call any tool and instead generates a message. `auto` means the model can
        #     pick between generating a message or calling one or more tools. `required` means
        #     the model must call one or more tools. Specifying a particular tool via
        #     `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #     call that tool.
        #
        #     `none` is the default when no tools are present. `auto` is the default if tools
        #     are present.
        #
        #   @option params [Array<OpenAI::Models::Chat::ChatCompletionTool>] :tools A list of tools the model may call. Currently, only functions are supported as a
        #     tool. Use this to provide a list of functions the model may generate JSON inputs
        #     for. A max of 128 functions are supported.
        #
        #   @option params [Integer, nil] :top_logprobs An integer between 0 and 20 specifying the number of most likely tokens to
        #     return at each token position, each with an associated log probability.
        #     `logprobs` must be set to `true` if this parameter is used.
        #
        #   @option params [Float, nil] :top_p An alternative to sampling with temperature, called nucleus sampling, where the
        #     model considers the results of the tokens with top_p probability mass. So 0.1
        #     means only the tokens comprising the top 10% probability mass are considered.
        #
        #     We generally recommend altering this or `temperature` but not both.
        #
        #   @option params [String] :user A unique identifier representing your end-user, which can help OpenAI to monitor
        #     and detect abuse.
        #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Stream<OpenAI::Models::Chat::ChatCompletionChunk>]
        def create_streaming(params)
          parsed, options = OpenAI::Models::Chat::CompletionCreateParams.dump_request(params)
          parsed.store(:stream, true)
          @client.request(
            method: :post,
            path: "chat/completions",
            headers: {"accept" => "text/event-stream"},
            body: parsed,
            stream: OpenAI::Stream,
            model: OpenAI::Models::Chat::ChatCompletionChunk,
            options: options
          )
        end

        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
