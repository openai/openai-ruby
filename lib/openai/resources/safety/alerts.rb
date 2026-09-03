# frozen_string_literal: true

module OpenAI
  module Resources
    class Safety
      class Alerts
        # Get a safety alert belonging to the authenticated API project.
        #
        # @overload retrieve(id, request_options: {})
        #
        # @param id [String] Project safety alert ID
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Safety::SafetyAlert]
        #
        # @see OpenAI::Models::Safety::AlertRetrieveParams
        def retrieve(id, params = {})
          @client.request(
            method: :get,
            path: ["safety/alerts/%1$s", id],
            model: OpenAI::Safety::SafetyAlert,
            security: {bearer_auth: true},
            options: params[:request_options]
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
end
