# frozen_string_literal: true

module OpenAI
  module Helpers
    module Realtime
      # Raw-response access for endpoints whose success body is not modeled JSON.
      module BaseClientExtension
        # Execute the request specified by `req` without decoding its response.
        #
        # @api private
        #
        # @param req [Hash{Symbol=>Object}]
        # @return [OpenAI::HTTPClient::Response]
        def request_raw(req)
          _, response, log_context = perform_request(req)
          log_context.observe_raw_response(response)
        end
      end
    end
  end
end

OpenAI::Internal::Transport::BaseClient.include(OpenAI::Helpers::Realtime::BaseClientExtension)
