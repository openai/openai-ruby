# frozen_string_literal: true

module OpenAI
  module Resources
    # Given text and/or image inputs, classifies if those inputs are potentially
    # harmful.
    class Moderations
      # Classifies if text and/or image inputs are potentially harmful. Learn more in
      # the
      # [moderation guide](https://developers.openai.com/api/docs/guides/moderation).
      #
      # @overload create(input:, model: nil, request_options: {})
      #
      # @param input [String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>]
      #   Input (or inputs) to classify. Can be a single string, an array of strings, or
      #   an array of multi-modal input objects similar to other models.
      #
      # @param model [String, Symbol, OpenAI::Models::ModerationModel]
      #   The content moderation model you would like to use. Learn more in
      #   [the moderation guide](https://developers.openai.com/api/docs/guides/moderation),
      #   and learn about available models
      #   [here](https://developers.openai.com/api/docs/guides/moderation).
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ModerationCreateResponse]
      #
      # @see OpenAI::Models::ModerationCreateParams
      def create(params)
        parsed, options = OpenAI::ModerationCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "moderations",
          body: parsed,
          model: OpenAI::Models::ModerationCreateResponse,
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
