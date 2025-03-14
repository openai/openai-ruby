# frozen_string_literal: true

module OpenAI
  module Resources
    class Moderations
      # Classifies if text and/or image inputs are potentially harmful. Learn more in
      #   the [moderation guide](https://platform.openai.com/docs/guides/moderation).
      #
      # @param params [OpenAI::Models::ModerationCreateParams, Hash{Symbol=>Object}] .
      #
      #   @option params [String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>] :input Input (or inputs) to classify. Can be a single string, an array of strings, or
      #     an array of multi-modal input objects similar to other models.
      #
      #   @option params [String, Symbol, OpenAI::Models::ModerationModel] :model The content moderation model you would like to use. Learn more in
      #     [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      #     learn about available models
      #     [here](https://platform.openai.com/docs/models#moderation).
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::ModerationCreateResponse]
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

      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end
