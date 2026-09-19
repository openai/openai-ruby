# frozen_string_literal: true

module OpenAI
  module Resources
    class Safety
      class Cases
        # Get a safety case by ID.
        #
        # @overload retrieve(id, request_options: {})
        #
        # @param id [String]
        #   Safety case ID
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Safety::SafetyCase]
        #
        # @see OpenAI::Models::Safety::CaseRetrieveParams
        def retrieve(id, params = {})
          @client.request(
            method: :get,
            path: ["safety/cases/%1$s", id],
            model: OpenAI::Safety::SafetyCase,
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
