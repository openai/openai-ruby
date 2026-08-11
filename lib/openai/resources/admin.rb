# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      # Returns a wrapper that exposes the raw HTTP response for each request.
      #
      # @return [Admin::WithRawResponse]
      def with_raw_response
        WithRawResponse.new(
          resource: Admin.new(
            client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
          )
        )
      end

      # @return [OpenAI::Resources::Admin::Organization]
      attr_reader :organization

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::RequestClient]
      def initialize(client:)
        @client = client
        @organization = OpenAI::Resources::Admin::Organization.new(client: client)
      end

      class WithRawResponse
        # @return [OpenAI::Resources::Admin::Organization::WithRawResponse]
        attr_reader :organization

        # @api private
        #
        # @param resource [Admin]
        def initialize(resource:)
          @resource = resource

          @organization =
            OpenAI::Resources::Admin::Organization::WithRawResponse.new(
              resource: @resource.organization
            )
        end
      end
    end
  end
end
