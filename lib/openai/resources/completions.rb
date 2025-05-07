# frozen_string_literal: true

module OpenAI
  module Resources
    class Completions
      # See {OpenAI::Resources::Completions#create_streaming} for streaming counterpart.
      #
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::CompletionCreateParams} for more details.
      #
      # Creates a completion for the provided prompt and parameters.
      #
      # @overload create(model:, prompt:, best_of: nil, echo: nil, frequency_penalty: nil, logit_bias: nil, logprobs: nil, max_tokens: nil, n: nil, presence_penalty: nil, seed: nil, stop: nil, stream_options: nil, suffix: nil, temperature: nil, top_p: nil, user: nil, request_options: {})
      #
      # @param model [String, Symbol, OpenAI::CompletionCreateParams::Model] ID of the model to use. You can use the [List models](https://platform.openai.co
      #
      # @param prompt [String, Array<String>, Array<Integer>, Array<Array<Integer>>, nil] The prompt(s) to generate completions for, encoded as a string, array of strings
      #
      # @param best_of [Integer, nil] Generates `best_of` completions server-side and returns the "best" (the one with
      #
      # @param echo [Boolean, nil] Echo back the prompt in addition to the completion
      #
      # @param frequency_penalty [Float, nil] Number between -2.0 and 2.0. Positive values penalize new tokens based on their
      #
      # @param logit_bias [Hash{Symbol=>Integer}, nil] Modify the likelihood of specified tokens appearing in the completion.
      #
      # @param logprobs [Integer, nil] Include the log probabilities on the `logprobs` most likely output tokens, as we
      #
      # @param max_tokens [Integer, nil] The maximum number of [tokens](/tokenizer) that can be generated in the completi
      #
      # @param n [Integer, nil] How many completions to generate for each prompt.
      #
      # @param presence_penalty [Float, nil] Number between -2.0 and 2.0. Positive values penalize new tokens based on whethe
      #
      # @param seed [Integer, nil] If specified, our system will make a best effort to sample deterministically, su
      #
      # @param stop [String, Array<String>, nil] Not supported with latest reasoning models `o3` and `o4-mini`.
      #
      # @param stream_options [OpenAI::Chat::ChatCompletionStreamOptions, nil] Options for streaming response. Only set this when you set `stream: true`.
      #
      # @param suffix [String, nil] The suffix that comes after a completion of inserted text.
      #
      # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
      #
      # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling, where the
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Completion]
      #
      # @see OpenAI::Models::CompletionCreateParams
      def create(params)
        parsed, options = OpenAI::CompletionCreateParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#create_streaming` for the streaming use case."
          raise ArgumentError.new(message)
        end
        @client.request(
          method: :post,
          path: "completions",
          body: parsed,
          model: OpenAI::Completion,
          options: options
        )
      end

      # See {OpenAI::Resources::Completions#create} for non-streaming counterpart.
      #
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::CompletionCreateParams} for more details.
      #
      # Creates a completion for the provided prompt and parameters.
      #
      # @overload create_streaming(model:, prompt:, best_of: nil, echo: nil, frequency_penalty: nil, logit_bias: nil, logprobs: nil, max_tokens: nil, n: nil, presence_penalty: nil, seed: nil, stop: nil, stream_options: nil, suffix: nil, temperature: nil, top_p: nil, user: nil, request_options: {})
      #
      # @param model [String, Symbol, OpenAI::CompletionCreateParams::Model] ID of the model to use. You can use the [List models](https://platform.openai.co
      #
      # @param prompt [String, Array<String>, Array<Integer>, Array<Array<Integer>>, nil] The prompt(s) to generate completions for, encoded as a string, array of strings
      #
      # @param best_of [Integer, nil] Generates `best_of` completions server-side and returns the "best" (the one with
      #
      # @param echo [Boolean, nil] Echo back the prompt in addition to the completion
      #
      # @param frequency_penalty [Float, nil] Number between -2.0 and 2.0. Positive values penalize new tokens based on their
      #
      # @param logit_bias [Hash{Symbol=>Integer}, nil] Modify the likelihood of specified tokens appearing in the completion.
      #
      # @param logprobs [Integer, nil] Include the log probabilities on the `logprobs` most likely output tokens, as we
      #
      # @param max_tokens [Integer, nil] The maximum number of [tokens](/tokenizer) that can be generated in the completi
      #
      # @param n [Integer, nil] How many completions to generate for each prompt.
      #
      # @param presence_penalty [Float, nil] Number between -2.0 and 2.0. Positive values penalize new tokens based on whethe
      #
      # @param seed [Integer, nil] If specified, our system will make a best effort to sample deterministically, su
      #
      # @param stop [String, Array<String>, nil] Not supported with latest reasoning models `o3` and `o4-mini`.
      #
      # @param stream_options [OpenAI::Chat::ChatCompletionStreamOptions, nil] Options for streaming response. Only set this when you set `stream: true`.
      #
      # @param suffix [String, nil] The suffix that comes after a completion of inserted text.
      #
      # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
      #
      # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling, where the
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Completion>]
      #
      # @see OpenAI::Models::CompletionCreateParams
      def create_streaming(params)
        parsed, options = OpenAI::CompletionCreateParams.dump_request(params)
        unless parsed.fetch(:stream, true)
          message = "Please use `#create` for the non-streaming use case."
          raise ArgumentError.new(message)
        end
        parsed.store(:stream, true)
        @client.request(
          method: :post,
          path: "completions",
          headers: {"accept" => "text/event-stream"},
          body: parsed,
          stream: OpenAI::Internal::Stream,
          model: OpenAI::Completion,
          options: options
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end
