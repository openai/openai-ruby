# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      # Returns a wrapper that exposes the raw HTTP response for each request.
      #
      # @return [Realtime::WithRawResponse]
      def with_raw_response
        WithRawResponse.new(
          resource: Realtime.new(
            client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
          )
        )
      end

      # @return [OpenAI::Resources::Realtime::ClientSecrets]
      attr_reader :client_secrets

      # @return [OpenAI::Resources::Realtime::Calls]
      attr_reader :calls

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::RequestClient]
      def initialize(client:)
        @client = client
        @client_secrets = OpenAI::Resources::Realtime::ClientSecrets.new(client: client)
        @calls = OpenAI::Resources::Realtime::Calls.new(client: client)
      end

      class WithRawResponse
        # @return [OpenAI::Resources::Realtime::ClientSecrets::WithRawResponse]
        attr_reader :client_secrets

        # @return [OpenAI::Resources::Realtime::Calls::WithRawResponse]
        attr_reader :calls

        # @api private
        #
        # @param resource [Realtime]
        def initialize(resource:)
          @resource = resource

          @client_secrets =
            OpenAI::Resources::Realtime::ClientSecrets::WithRawResponse.new(
              resource: @resource.client_secrets
            )

          @calls =
            OpenAI::Resources::Realtime::Calls::WithRawResponse.new(
              resource: @resource.calls
            )
        end
      end
    end
  end
end
