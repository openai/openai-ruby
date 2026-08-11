# frozen_string_literal: true

module OpenAI
  module Resources
    # Given text and/or image inputs, classifies if those inputs are potentially
    # harmful.
    class Moderations
      # Returns a wrapper that exposes the raw HTTP response for each request.
      #
      # @return [Moderations::WithRawResponse]
      def with_raw_response
        WithRawResponse.new(
          resource: Moderations.new(
            client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
          )
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::ModerationCreateParams} for more details.
      #
      # Classifies if text and/or image inputs are potentially harmful. Learn more in
      # the [moderation guide](https://platform.openai.com/docs/guides/moderation).
      #
      # @overload create(input:, model: nil, request_options: {})
      #
      # @param input [String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>] Input (or inputs) to classify. Can be a single string, an array of strings, or
      #
      # @param model [String, Symbol, OpenAI::Models::ModerationModel] The content moderation model you would like to use. Learn more in
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
      # @param client [OpenAI::Internal::Transport::RequestClient]
      def initialize(client:)
        @client = client
      end

      class WithRawResponse
        def create(params)
          @resource.create(params)
        end

        # @api private
        #
        # @param resource [Moderations]
        def initialize(resource:)
          @resource = resource
        end
      end
    end
  end
end
