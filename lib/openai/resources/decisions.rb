# frozen_string_literal: true

module OpenAI
  module Resources
    class Decisions
      # Use this endpoint to ask classification or scoring questions about the same
      # input. You’ll get the answers back in the order you asked the questions.
      #
      # For text, you can pass a string. You can also send user messages containing
      # `input_text` and `input_image` parts, with up to 128 images per request. Images
      # can be base64 data URLs or publicly accessible HTTP(S) URLs. File IDs aren’t
      # accepted. Other message roles, function calls, files, audio, and item references
      # aren’t supported.
      #
      # Sometimes a question returns a refusal instead of an answer. The result has type
      # `refusal` and includes the question’s name, or `null` if you didn’t give it one.
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
      #
      # @param questions [Array<OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score>]
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
