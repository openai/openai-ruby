# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      # Returns a wrapper that exposes the raw HTTP response for each request.
      #
      # @return [Beta::WithRawResponse]
      def with_raw_response
        WithRawResponse.new(
          resource: Beta.new(
            client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
          )
        )
      end

      # @return [OpenAI::Resources::Beta::Responses]
      attr_reader :responses

      # @return [OpenAI::Resources::Beta::ChatKit]
      attr_reader :chatkit

      # Build Assistants that can call models and use tools.
      # @return [OpenAI::Resources::Beta::Assistants]
      attr_reader :assistants

      # Build Assistants that can call models and use tools.
      # @return [OpenAI::Resources::Beta::Threads]
      attr_reader :threads

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::RequestClient]
      def initialize(client:)
        @client = client
        @responses = OpenAI::Resources::Beta::Responses.new(client: client)
        @chatkit = OpenAI::Resources::Beta::ChatKit.new(client: client)
        @assistants = OpenAI::Resources::Beta::Assistants.new(client: client)
        @threads = OpenAI::Resources::Beta::Threads.new(client: client)
      end

      class WithRawResponse
        # @return [OpenAI::Resources::Beta::Responses::WithRawResponse]
        attr_reader :responses

        # @return [OpenAI::Resources::Beta::ChatKit::WithRawResponse]
        attr_reader :chatkit

        # Build Assistants that can call models and use tools.
        # @return [OpenAI::Resources::Beta::Assistants::WithRawResponse]
        attr_reader :assistants

        # Build Assistants that can call models and use tools.
        # @return [OpenAI::Resources::Beta::Threads::WithRawResponse]
        attr_reader :threads

        # @api private
        #
        # @param resource [Beta]
        def initialize(resource:)
          @resource = resource

          @responses =
            OpenAI::Resources::Beta::Responses::WithRawResponse.new(
              resource: @resource.responses
            )

          @chatkit =
            OpenAI::Resources::Beta::ChatKit::WithRawResponse.new(
              resource: @resource.chatkit
            )

          @assistants =
            OpenAI::Resources::Beta::Assistants::WithRawResponse.new(
              resource: @resource.assistants
            )

          @threads =
            OpenAI::Resources::Beta::Threads::WithRawResponse.new(
              resource: @resource.threads
            )
        end
      end
    end
  end
end
