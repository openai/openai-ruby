# frozen_string_literal: true

module OpenAI
  module Resources
    class Webhooks
      class EventTypes
        # Returns webhook event types visible to the authenticated project.
        #
        # @overload list(request_options: {})
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Webhooks::WebhookEventTypeList]
        #
        # @see OpenAI::Models::Webhooks::EventTypeListParams
        def list(params = {})
          @client.request(
            method: :get,
            path: "webhook_event_types",
            model: OpenAI::Webhooks::WebhookEventTypeList,
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
