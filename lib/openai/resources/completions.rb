# frozen_string_literal: true

module OpenAI
  module Resources
    class Completions
      # Creates a completion for the provided prompt and parameters.
      #
      # @overload create(model:, prompt:, best_of: nil, echo: nil, frequency_penalty: nil, logit_bias: nil, logprobs: nil, max_tokens: nil, n: nil, presence_penalty: nil, seed: nil, stop: nil, stream_options: nil, suffix: nil, temperature: nil, top_p: nil, user: nil, request_options: {})
      #
      # @param model [String, Symbol, OpenAI::Models::CompletionCreateParams::Model]
      # @param prompt [String, Array<String>, Array<Integer>, Array<Array<Integer>>, nil]
      # @param best_of [Integer, nil]
      # @param echo [Boolean, nil]
      # @param frequency_penalty [Float, nil]
      # @param logit_bias [Hash{Symbol=>Integer}, nil]
      # @param logprobs [Integer, nil]
      # @param max_tokens [Integer, nil]
      # @param n [Integer, nil]
      # @param presence_penalty [Float, nil]
      # @param seed [Integer, nil]
      # @param stop [String, Array<String>, nil]
      # @param stream_options [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil]
      # @param suffix [String, nil]
      # @param temperature [Float, nil]
      # @param top_p [Float, nil]
      # @param user [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Completion]
      #
      # @see OpenAI::Models::CompletionCreateParams
      def create(params)
        parsed, options = OpenAI::Models::CompletionCreateParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#create_streaming` for the streaming use case."
          raise ArgumentError.new(message)
        end
        @client.request(
          method: :post,
          path: "completions",
          body: parsed,
          model: OpenAI::Models::Completion,
          options: options
        )
      end

      # Creates a completion for the provided prompt and parameters.
      #
      # @overload create_streaming(model:, prompt:, best_of: nil, echo: nil, frequency_penalty: nil, logit_bias: nil, logprobs: nil, max_tokens: nil, n: nil, presence_penalty: nil, seed: nil, stop: nil, stream_options: nil, suffix: nil, temperature: nil, top_p: nil, user: nil, request_options: {})
      #
      # @param model [String, Symbol, OpenAI::Models::CompletionCreateParams::Model]
      # @param prompt [String, Array<String>, Array<Integer>, Array<Array<Integer>>, nil]
      # @param best_of [Integer, nil]
      # @param echo [Boolean, nil]
      # @param frequency_penalty [Float, nil]
      # @param logit_bias [Hash{Symbol=>Integer}, nil]
      # @param logprobs [Integer, nil]
      # @param max_tokens [Integer, nil]
      # @param n [Integer, nil]
      # @param presence_penalty [Float, nil]
      # @param seed [Integer, nil]
      # @param stop [String, Array<String>, nil]
      # @param stream_options [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil]
      # @param suffix [String, nil]
      # @param temperature [Float, nil]
      # @param top_p [Float, nil]
      # @param user [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Stream<OpenAI::Models::Completion>]
      #
      # @see OpenAI::Models::CompletionCreateParams
      def create_streaming(params)
        parsed, options = OpenAI::Models::CompletionCreateParams.dump_request(params)
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
          stream: OpenAI::Stream,
          model: OpenAI::Models::Completion,
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
