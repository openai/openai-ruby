# frozen_string_literal: true

module OpenAI
  module Internal
    module Transport
      # Converts ordinary generated resource requests into raw responses while
      # preserving the resource method's request construction.
      #
      # @api private
      class RawResponseClient
        include OpenAI::Internal::Transport::RequestClient

        # @param client [OpenAI::Internal::Transport::BaseClient]
        def initialize(client)
          @client = client
        end

        # @param req [Hash{Symbol=>Object}]
        # @return [OpenAI::RawResponse]
        def request(req) = @client.raw_request(req)
      end
    end
  end
end
