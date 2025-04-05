# frozen_string_literal: true

module OpenAI
  module Resources
    class Moderations
      # Classifies if text and/or image inputs are potentially harmful. Learn more in
      # the [moderation guide](https://platform.openai.com/docs/guides/moderation).
      #
      # @overload create(input:, model: nil, request_options: {})
      #
      # @param input [String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>]
      # @param model [String, Symbol, OpenAI::Models::ModerationModel]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ModerationCreateResponse]
      #
      # @see OpenAI::Models::ModerationCreateParams
      def create(params)
        parsed, options = OpenAI::Models::ModerationCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "moderations",
          body: parsed,
          model: OpenAI::Models::ModerationCreateResponse,
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
