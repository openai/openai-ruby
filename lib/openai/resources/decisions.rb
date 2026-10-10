# frozen_string_literal: true

module OpenAI
  module Resources
    class Decisions
      # Evaluate ordered classification and scoring questions against shared input.
      # Answers are returned in question order.
      #
      # Supply input as a string or user messages containing text and inline images.
      # Only user messages with `input_text` and `input_image` parts are supported;
      # non-user roles, function calls, files, audio, and item references are not
      # supported. Images require a data URL, not an external URL or file ID. At most
      # 128 images are allowed across the request.
      #
      # Each question can return a refusal instead of a scored answer. A refusal has
      # type `refusal` and the corresponding question name, or null if unnamed.
      #
      # @overload create(input:, model:, questions:, safety_identifier: nil, request_options: {})
      #
      # @param input [String, Array<OpenAI::Models::DecisionInputMessage>]
      #   The text or images to evaluate for every question. Provide a text string or user
      #   messages containing text and inline images. Images must be inline data URLs; at
      #   most 128 images are allowed across all messages in one request. External URLs,
      #   files, audio, tools, and item references are not supported.
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
