# frozen_string_literal: true

module OpenAI
  module Resources
    class Chat
      class Completions
        # @return [OpenAI::Resources::Chat::Completions::Messages]
        attr_reader :messages

        # See {OpenAI::Resources::Chat::Completions#stream_raw} for streaming counterpart.
        #
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Chat::CompletionCreateParams} for more details.
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
        #
        # @overload create(messages:, model:, audio: nil, frequency_penalty: nil, function_call: nil, functions: nil, logit_bias: nil, logprobs: nil, max_completion_tokens: nil, max_tokens: nil, metadata: nil, modalities: nil, n: nil, parallel_tool_calls: nil, prediction: nil, presence_penalty: nil, prompt_cache_key: nil, reasoning_effort: nil, response_format: nil, safety_identifier: nil, seed: nil, service_tier: nil, stop: nil, store: nil, stream_options: nil, temperature: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, user: nil, web_search_options: nil, request_options: {})
        #
        # @param messages [Array<OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam, OpenAI::Models::Chat::ChatCompletionSystemMessageParam, OpenAI::Models::Chat::ChatCompletionUserMessageParam, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam, OpenAI::Models::Chat::ChatCompletionToolMessageParam, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam>] A list of messages comprising the conversation so far. Depending on the
        #
        # @param model [String, Symbol, OpenAI::Models::ChatModel] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
        #
        # @param audio [OpenAI::Models::Chat::ChatCompletionAudioParam, nil] Parameters for audio output. Required when audio output is requested with
        #
        # @param frequency_penalty [Float, nil] Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #
        # @param function_call [Symbol, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode, OpenAI::Models::Chat::ChatCompletionFunctionCallOption] Deprecated in favor of `tool_choice`.
        #
        # @param functions [Array<OpenAI::Models::Chat::CompletionCreateParams::Function>] Deprecated in favor of `tools`.
        #
        # @param logit_bias [Hash{Symbol=>Integer}, nil] Modify the likelihood of specified tokens appearing in the completion.
        #
        # @param logprobs [Boolean, nil] Whether to return log probabilities of the output tokens or not. If true,
        #
        # @param max_completion_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a completion,
        #
        # @param max_tokens [Integer, nil] The maximum number of [tokens](/tokenizer) that can be generated in the
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        # @param modalities [Array<Symbol, OpenAI::Models::Chat::CompletionCreateParams::Modality>, nil] Output types that you would like the model to generate.
        #
        # @param n [Integer, nil] How many chat completion choices to generate for each input message. Note that y
        #
        # @param parallel_tool_calls [Boolean] Whether to enable [parallel function calling](https://platform.openai.com/docs/g
        #
        # @param prediction [OpenAI::Models::Chat::ChatCompletionPredictionContent, nil] Static predicted output content, such as the content of a text file that is
        #
        # @param presence_penalty [Float, nil] Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #
        # @param prompt_cache_key [String] Used by OpenAI to cache responses for similar requests to optimize your cache hi
        #
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil] **o-series models only**
        #
        # @param response_format [OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONSchema, OpenAI::Models::ResponseFormatJSONObject] An object specifying the format that the model must output.
        #
        # @param safety_identifier [String] A stable identifier used to help detect users of your application that may be vi
        #
        # @param seed [Integer, nil] This feature is in Beta.
        #
        # @param service_tier [Symbol, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier, nil] Specifies the processing type used for serving the request.
        #
        # @param stop [String, Array<String>, nil] Not supported with latest reasoning models `o3` and `o4-mini`.
        #
        # @param store [Boolean, nil] Whether or not to store the output of this chat completion request for
        #
        # @param stream_options [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil] Options for streaming response. Only set this when you set `stream: true`.
        #
        # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
        #
        # @param tool_choice [Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Models::Chat::ChatCompletionNamedToolChoice] Controls which (if any) tool is called by the model.
        #
        # @param tools [Array<OpenAI::Models::Chat::ChatCompletionTool>] A list of tools the model may call. Currently, only functions are supported as a
        #
        # @param top_logprobs [Integer, nil] An integer between 0 and 20 specifying the number of most likely tokens to
        #
        # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
        #
        # @param user [String] This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
        #
        # @param web_search_options [OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions] This tool searches the web for relevant results to use in a response.
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

          model = nil
          tool_models = {}
          case parsed
          in {response_format: OpenAI::StructuredOutput::JsonSchemaConverter => model}
            parsed.update(
              response_format: {
                type: :json_schema,
                json_schema: {
                  strict: true,
                  name: model.name.split("::").last,
                  schema: model.to_json_schema
                }
              }
            )
          in {response_format: {type: :json_schema, json_schema: OpenAI::StructuredOutput::JsonSchemaConverter => model}}
            parsed.fetch(:response_format).update(
              json_schema: {
                strict: true,
                name: model.name.split("::").last,
                schema: model.to_json_schema
              }
            )
          in {response_format: {type: :json_schema, json_schema: {schema: OpenAI::StructuredOutput::JsonSchemaConverter => model}}}
            parsed.dig(:response_format, :json_schema).store(:schema, model.to_json_schema)
          in {tools: Array => tools}
            mapped = tools.map do |tool|
              case tool
              in OpenAI::StructuredOutput::JsonSchemaConverter
                name = tool.name.split("::").last
                tool_models.store(name, tool)
                {
                  type: :function,
                  function: {
                    strict: true,
                    name: name,
                    parameters: tool.to_json_schema
                  }
                }
              in {function: {parameters: OpenAI::StructuredOutput::JsonSchemaConverter => params}}
                func = tool.fetch(:function)
                name = func[:name] ||= params.name.split("::").last
                tool_models.store(name, params)
                func.update(parameters: params.to_json_schema)
                tool
              else
                tool
              end
            end
            tools.replace(mapped)
          else
          end

          # rubocop:disable Metrics/BlockLength
          unwrap = ->(raw) do
            if model.is_a?(OpenAI::StructuredOutput::JsonSchemaConverter)
              raw[:choices]&.each do |choice|
                message = choice.fetch(:message)
                begin
                  parsed = JSON.parse(message.fetch(:content), symbolize_names: true)
                rescue JSON::ParserError => e
                  parsed = e
                end
                coerced = OpenAI::Internal::Type::Converter.coerce(model, parsed)
                message.store(:parsed, coerced)
              end
            end
            raw[:choices]&.each do |choice|
              choice.dig(:message, :tool_calls)&.each do |tool_call|
                func = tool_call.fetch(:function)
                next if (model = tool_models[func.fetch(:name)]).nil?

                begin
                  parsed = JSON.parse(func.fetch(:arguments), symbolize_names: true)
                rescue JSON::ParserError => e
                  parsed = e
                end
                coerced = OpenAI::Internal::Type::Converter.coerce(model, parsed)
                func.store(:parsed, coerced)
              end
            end

            raw
          end
          # rubocop:enable Metrics/BlockLength

          @client.request(
            method: :post,
            path: "chat/completions",
            body: parsed,
            unwrap: unwrap,
            model: OpenAI::Chat::ChatCompletion,
            options: options
          )
        end

        def stream
          raise NotImplementedError.new("higher level helpers are coming soon!")
        end

        # See {OpenAI::Resources::Chat::Completions#create} for non-streaming counterpart.
        #
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Chat::CompletionCreateParams} for more details.
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
        #
        # @overload stream_raw(messages:, model:, audio: nil, frequency_penalty: nil, function_call: nil, functions: nil, logit_bias: nil, logprobs: nil, max_completion_tokens: nil, max_tokens: nil, metadata: nil, modalities: nil, n: nil, parallel_tool_calls: nil, prediction: nil, presence_penalty: nil, prompt_cache_key: nil, reasoning_effort: nil, response_format: nil, safety_identifier: nil, seed: nil, service_tier: nil, stop: nil, store: nil, stream_options: nil, temperature: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, user: nil, web_search_options: nil, request_options: {})
        #
        # @param messages [Array<OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam, OpenAI::Models::Chat::ChatCompletionSystemMessageParam, OpenAI::Models::Chat::ChatCompletionUserMessageParam, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam, OpenAI::Models::Chat::ChatCompletionToolMessageParam, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam>] A list of messages comprising the conversation so far. Depending on the
        #
        # @param model [String, Symbol, OpenAI::Models::ChatModel] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
        #
        # @param audio [OpenAI::Models::Chat::ChatCompletionAudioParam, nil] Parameters for audio output. Required when audio output is requested with
        #
        # @param frequency_penalty [Float, nil] Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #
        # @param function_call [Symbol, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode, OpenAI::Models::Chat::ChatCompletionFunctionCallOption] Deprecated in favor of `tool_choice`.
        #
        # @param functions [Array<OpenAI::Models::Chat::CompletionCreateParams::Function>] Deprecated in favor of `tools`.
        #
        # @param logit_bias [Hash{Symbol=>Integer}, nil] Modify the likelihood of specified tokens appearing in the completion.
        #
        # @param logprobs [Boolean, nil] Whether to return log probabilities of the output tokens or not. If true,
        #
        # @param max_completion_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a completion,
        #
        # @param max_tokens [Integer, nil] The maximum number of [tokens](/tokenizer) that can be generated in the
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        # @param modalities [Array<Symbol, OpenAI::Models::Chat::CompletionCreateParams::Modality>, nil] Output types that you would like the model to generate.
        #
        # @param n [Integer, nil] How many chat completion choices to generate for each input message. Note that y
        #
        # @param parallel_tool_calls [Boolean] Whether to enable [parallel function calling](https://platform.openai.com/docs/g
        #
        # @param prediction [OpenAI::Models::Chat::ChatCompletionPredictionContent, nil] Static predicted output content, such as the content of a text file that is
        #
        # @param presence_penalty [Float, nil] Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #
        # @param prompt_cache_key [String] Used by OpenAI to cache responses for similar requests to optimize your cache hi
        #
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil] **o-series models only**
        #
        # @param response_format [OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONSchema, OpenAI::Models::ResponseFormatJSONObject] An object specifying the format that the model must output.
        #
        # @param safety_identifier [String] A stable identifier used to help detect users of your application that may be vi
        #
        # @param seed [Integer, nil] This feature is in Beta.
        #
        # @param service_tier [Symbol, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier, nil] Specifies the processing type used for serving the request.
        #
        # @param stop [String, Array<String>, nil] Not supported with latest reasoning models `o3` and `o4-mini`.
        #
        # @param store [Boolean, nil] Whether or not to store the output of this chat completion request for
        #
        # @param stream_options [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil] Options for streaming response. Only set this when you set `stream: true`.
        #
        # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
        #
        # @param tool_choice [Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Models::Chat::ChatCompletionNamedToolChoice] Controls which (if any) tool is called by the model.
        #
        # @param tools [Array<OpenAI::Models::Chat::ChatCompletionTool>] A list of tools the model may call. Currently, only functions are supported as a
        #
        # @param top_logprobs [Integer, nil] An integer between 0 and 20 specifying the number of most likely tokens to
        #
        # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
        #
        # @param user [String] This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use
        #
        # @param web_search_options [OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions] This tool searches the web for relevant results to use in a response.
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
            headers: {"accept" => "text/event-stream"},
            body: parsed,
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Chat::ChatCompletionChunk,
            options: options
          )
        end

        # Get a stored chat completion. Only Chat Completions that have been created with
        # the `store` parameter set to `true` will be returned.
        #
        # @overload retrieve(completion_id, request_options: {})
        #
        # @param completion_id [String] The ID of the chat completion to retrieve.
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
            options: params[:request_options]
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Chat::CompletionUpdateParams} for more details.
        #
        # Modify a stored chat completion. Only Chat Completions that have been created
        # with the `store` parameter set to `true` can be modified. Currently, the only
        # supported modification is to update the `metadata` field.
        #
        # @overload update(completion_id, metadata:, request_options: {})
        #
        # @param completion_id [String] The ID of the chat completion to update.
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
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
            options: options
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Chat::CompletionListParams} for more details.
        #
        # List stored Chat Completions. Only Chat Completions that have been stored with
        # the `store` parameter set to `true` will be returned.
        #
        # @overload list(after: nil, limit: nil, metadata: nil, model: nil, order: nil, request_options: {})
        #
        # @param after [String] Identifier for the last chat completion from the previous pagination request.
        #
        # @param limit [Integer] Number of Chat Completions to retrieve.
        #
        # @param metadata [Hash{Symbol=>String}, nil] A list of metadata keys to filter the Chat Completions by. Example:
        #
        # @param model [String] The model used to generate the Chat Completions.
        #
        # @param order [Symbol, OpenAI::Models::Chat::CompletionListParams::Order] Sort order for Chat Completions by timestamp. Use `asc` for ascending order or `
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Chat::ChatCompletion>]
        #
        # @see OpenAI::Models::Chat::CompletionListParams
        def list(params = {})
          parsed, options = OpenAI::Chat::CompletionListParams.dump_request(params)
          @client.request(
            method: :get,
            path: "chat/completions",
            query: parsed,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Chat::ChatCompletion,
            options: options
          )
        end

        # Delete a stored chat completion. Only Chat Completions that have been created
        # with the `store` parameter set to `true` can be deleted.
        #
        # @overload delete(completion_id, request_options: {})
        #
        # @param completion_id [String] The ID of the chat completion to delete.
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
