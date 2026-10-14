# frozen_string_literal: true

module OpenAI
  module Resources
    class Decisions
      # Use this endpoint to quickly answer classification or scoring questions about
      # some input. You can ask multiple questions in one request.
      #
      # @overload create(input:, model:, questions:, safety_identifier: nil, request_options: {})
      #
      # @param input [String, Array<OpenAI::Models::DecisionInputMessage>]
      #   The text or images to evaluate for every question. Provide a text string or user
      #   messages containing text and images. Images can be base64 data URLs or publicly
      #   accessible HTTP(S) URLs; at most 128 images are allowed across all messages in
      #   one request. Files, audio, tools, and item references are not supported.
      #
      # @param model [String]
      #   The model to use. Only `gpt-6-luna` is supported.
      #
      # @param questions [Array<OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score>]
      #   Ask 1–200 questions about the input. Each question can be a predicate, choice,
      #   or score. Answers come back in the same order.
      #
      # @param safety_identifier [String, nil]
      #   Opaque caller-provided end-user identifier, scoped by the verified org. Match
      #   Responses' limit; this is never the authenticated user identity.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Decision]
      #
      # @see OpenAI::Models::DecisionCreateParams
      def create(params)
        parsed, options = OpenAI::DecisionCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "decisions",
          body: parsed,
          model: OpenAI::Decision,
          security: {bearer_auth: true},
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
