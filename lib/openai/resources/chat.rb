# frozen_string_literal: true

module OpenAI
  module Resources
    class Chat
      # Returns a wrapper that exposes the raw HTTP response for each request.
      #
      # @return [Chat::WithRawResponse]
      def with_raw_response
        WithRawResponse.new(
          resource: Chat.new(
            client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
          )
        )
      end

      # Given a list of messages comprising a conversation, the model will return a
      # response.
      # @return [OpenAI::Resources::Chat::Completions]
      attr_reader :completions

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::RequestClient]
      def initialize(client:)
        @client = client
        @completions = OpenAI::Resources::Chat::Completions.new(client: client)
      end

      class WithRawResponse
        # Given a list of messages comprising a conversation, the model will return a
        # response.
        # @return [OpenAI::Resources::Chat::Completions::WithRawResponse]
        attr_reader :completions

        # @api private
        #
        # @param resource [Chat]
        def initialize(resource:)
          @resource = resource

          @completions =
            OpenAI::Resources::Chat::Completions::WithRawResponse.new(
              resource: @resource.completions
            )
        end
      end
    end
  end
end
