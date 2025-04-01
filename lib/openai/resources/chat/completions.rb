# frozen_string_literal: true

module OpenAI
  module Resources
    class Chat
      class Completions
        # @return [OpenAI::Resources::Chat::Completions::Messages]
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
        #
        # @overload create(messages:, model:, audio: nil, frequency_penalty: nil, function_call: nil, functions: nil, logit_bias: nil, logprobs: nil, max_completion_tokens: nil, max_tokens: nil, metadata: nil, modalities: nil, n: nil, parallel_tool_calls: nil, prediction: nil, presence_penalty: nil, reasoning_effort: nil, response_format: nil, seed: nil, service_tier: nil, stop: nil, store: nil, stream_options: nil, temperature: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, user: nil, web_search_options: nil, request_options: {})
        #
        # @param messages [Array<OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam, OpenAI::Models::Chat::ChatCompletionSystemMessageParam, OpenAI::Models::Chat::ChatCompletionUserMessageParam, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam, OpenAI::Models::Chat::ChatCompletionToolMessageParam, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam>]
        # @param model [String, Symbol, OpenAI::Models::ChatModel]
        # @param audio [OpenAI::Models::Chat::ChatCompletionAudioParam, nil]
        # @param frequency_penalty [Float, nil]
        # @param function_call [Symbol, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode, OpenAI::Models::Chat::ChatCompletionFunctionCallOption]
        # @param functions [Array<OpenAI::Models::Chat::CompletionCreateParams::Function>]
        # @param logit_bias [Hash{Symbol=>Integer}, nil]
        # @param logprobs [Boolean, nil]
        # @param max_completion_tokens [Integer, nil]
        # @param max_tokens [Integer, nil]
        # @param metadata [Hash{Symbol=>String}, nil]
        # @param modalities [Array<Symbol, OpenAI::Models::Chat::CompletionCreateParams::Modality>, nil]
        # @param n [Integer, nil]
        # @param parallel_tool_calls [Boolean]
        # @param prediction [OpenAI::Models::Chat::ChatCompletionPredictionContent, nil]
        # @param presence_penalty [Float, nil]
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
        # @param response_format [OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONSchema, OpenAI::Models::ResponseFormatJSONObject]
        # @param seed [Integer, nil]
        # @param service_tier [Symbol, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier, nil]
        # @param stop [String, Array<String>, nil]
        # @param store [Boolean, nil]
        # @param stream_options [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil]
        # @param temperature [Float, nil]
        # @param tool_choice [Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Models::Chat::ChatCompletionNamedToolChoice]
        # @param tools [Array<OpenAI::Models::Chat::ChatCompletionTool>]
        # @param top_logprobs [Integer, nil]
        # @param top_p [Float, nil]
        # @param user [String]
        # @param web_search_options [OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Chat::ChatCompletion]
        #
        # @see OpenAI::Models::Chat::CompletionCreateParams
        def create(params)
          parsed, options = OpenAI::Models::Chat::CompletionCreateParams.dump_request(params)
          if parsed[:stream]
            message = "Please use `#stream_raw` for the streaming use case."
            raise ArgumentError.new(message)
          end
          @client.request(
            method: :post,
            path: "chat/completions",
            body: parsed,
            model: OpenAI::Models::Chat::ChatCompletion,
            options: options
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
        #
        # @overload stream_raw(messages:, model:, audio: nil, frequency_penalty: nil, function_call: nil, functions: nil, logit_bias: nil, logprobs: nil, max_completion_tokens: nil, max_tokens: nil, metadata: nil, modalities: nil, n: nil, parallel_tool_calls: nil, prediction: nil, presence_penalty: nil, reasoning_effort: nil, response_format: nil, seed: nil, service_tier: nil, stop: nil, store: nil, stream_options: nil, temperature: nil, tool_choice: nil, tools: nil, top_logprobs: nil, top_p: nil, user: nil, web_search_options: nil, request_options: {})
        #
        # @param messages [Array<OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam, OpenAI::Models::Chat::ChatCompletionSystemMessageParam, OpenAI::Models::Chat::ChatCompletionUserMessageParam, OpenAI::Models::Chat::ChatCompletionAssistantMessageParam, OpenAI::Models::Chat::ChatCompletionToolMessageParam, OpenAI::Models::Chat::ChatCompletionFunctionMessageParam>]
        # @param model [String, Symbol, OpenAI::Models::ChatModel]
        # @param audio [OpenAI::Models::Chat::ChatCompletionAudioParam, nil]
        # @param frequency_penalty [Float, nil]
        # @param function_call [Symbol, OpenAI::Models::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode, OpenAI::Models::Chat::ChatCompletionFunctionCallOption]
        # @param functions [Array<OpenAI::Models::Chat::CompletionCreateParams::Function>]
        # @param logit_bias [Hash{Symbol=>Integer}, nil]
        # @param logprobs [Boolean, nil]
        # @param max_completion_tokens [Integer, nil]
        # @param max_tokens [Integer, nil]
        # @param metadata [Hash{Symbol=>String}, nil]
        # @param modalities [Array<Symbol, OpenAI::Models::Chat::CompletionCreateParams::Modality>, nil]
        # @param n [Integer, nil]
        # @param parallel_tool_calls [Boolean]
        # @param prediction [OpenAI::Models::Chat::ChatCompletionPredictionContent, nil]
        # @param presence_penalty [Float, nil]
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
        # @param response_format [OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONSchema, OpenAI::Models::ResponseFormatJSONObject]
        # @param seed [Integer, nil]
        # @param service_tier [Symbol, OpenAI::Models::Chat::CompletionCreateParams::ServiceTier, nil]
        # @param stop [String, Array<String>, nil]
        # @param store [Boolean, nil]
        # @param stream_options [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil]
        # @param temperature [Float, nil]
        # @param tool_choice [Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Models::Chat::ChatCompletionNamedToolChoice]
        # @param tools [Array<OpenAI::Models::Chat::ChatCompletionTool>]
        # @param top_logprobs [Integer, nil]
        # @param top_p [Float, nil]
        # @param user [String]
        # @param web_search_options [OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Stream<OpenAI::Models::Chat::ChatCompletionChunk>]
        #
        # @see OpenAI::Models::Chat::CompletionCreateParams
        def stream_raw(params)
          parsed, options = OpenAI::Models::Chat::CompletionCreateParams.dump_request(params)
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
            stream: OpenAI::Stream,
            model: OpenAI::Models::Chat::ChatCompletionChunk,
            options: options
          )
        end

        # Get a stored chat completion. Only Chat Completions that have been created with
        #   the `store` parameter set to `true` will be returned.
        #
        # @overload retrieve(completion_id, request_options: {})
        #
        # @param completion_id [String]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Chat::ChatCompletion]
        #
        # @see OpenAI::Models::Chat::CompletionRetrieveParams
        def retrieve(completion_id, params = {})
          @client.request(
            method: :get,
            path: ["chat/completions/%1$s", completion_id],
            model: OpenAI::Models::Chat::ChatCompletion,
            options: params[:request_options]
          )
        end

        # Modify a stored chat completion. Only Chat Completions that have been created
        #   with the `store` parameter set to `true` can be modified. Currently, the only
        #   supported modification is to update the `metadata` field.
        #
        # @overload update(completion_id, metadata:, request_options: {})
        #
        # @param completion_id [String]
        # @param metadata [Hash{Symbol=>String}, nil]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Chat::ChatCompletion]
        #
        # @see OpenAI::Models::Chat::CompletionUpdateParams
        def update(completion_id, params)
          parsed, options = OpenAI::Models::Chat::CompletionUpdateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["chat/completions/%1$s", completion_id],
            body: parsed,
            model: OpenAI::Models::Chat::ChatCompletion,
            options: options
          )
        end

        # List stored Chat Completions. Only Chat Completions that have been stored with
        #   the `store` parameter set to `true` will be returned.
        #
        # @overload list(after: nil, limit: nil, metadata: nil, model: nil, order: nil, request_options: {})
        #
        # @param after [String]
        # @param limit [Integer]
        # @param metadata [Hash{Symbol=>String}, nil]
        # @param model [String]
        # @param order [Symbol, OpenAI::Models::Chat::CompletionListParams::Order]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::CursorPage<OpenAI::Models::Chat::ChatCompletion>]
        #
        # @see OpenAI::Models::Chat::CompletionListParams
        def list(params = {})
          parsed, options = OpenAI::Models::Chat::CompletionListParams.dump_request(params)
          @client.request(
            method: :get,
            path: "chat/completions",
            query: parsed,
            page: OpenAI::CursorPage,
            model: OpenAI::Models::Chat::ChatCompletion,
            options: options
          )
        end

        # Delete a stored chat completion. Only Chat Completions that have been created
        #   with the `store` parameter set to `true` can be deleted.
        #
        # @overload delete(completion_id, request_options: {})
        #
        # @param completion_id [String]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Chat::ChatCompletionDeleted]
        #
        # @see OpenAI::Models::Chat::CompletionDeleteParams
        def delete(completion_id, params = {})
          @client.request(
            method: :delete,
            path: ["chat/completions/%1$s", completion_id],
            model: OpenAI::Models::Chat::ChatCompletionDeleted,
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
