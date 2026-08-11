# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class ChatKit
        # Returns a wrapper that exposes the raw HTTP response for each request.
        #
        # @return [ChatKit::WithRawResponse]
        def with_raw_response
          WithRawResponse.new(
            resource: ChatKit.new(
              client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
            )
          )
        end

        # @return [OpenAI::Resources::Beta::ChatKit::Sessions]
        attr_reader :sessions

        # @return [OpenAI::Resources::Beta::ChatKit::Threads]
        attr_reader :threads

        # @api private
        #
        # @param client [OpenAI::Internal::Transport::RequestClient]
        def initialize(client:)
          @client = client
          @sessions = OpenAI::Resources::Beta::ChatKit::Sessions.new(client: client)
          @threads = OpenAI::Resources::Beta::ChatKit::Threads.new(client: client)
        end

        class WithRawResponse
          # @return [OpenAI::Resources::Beta::ChatKit::Sessions::WithRawResponse]
          attr_reader :sessions

          # @return [OpenAI::Resources::Beta::ChatKit::Threads::WithRawResponse]
          attr_reader :threads

          # @api private
          #
          # @param resource [ChatKit]
          def initialize(resource:)
            @resource = resource

            @sessions =
              OpenAI::Resources::Beta::ChatKit::Sessions::WithRawResponse.new(
                resource: @resource.sessions
              )

            @threads =
              OpenAI::Resources::Beta::ChatKit::Threads::WithRawResponse.new(
                resource: @resource.threads
              )
          end
        end
      end
    end
  end
end
