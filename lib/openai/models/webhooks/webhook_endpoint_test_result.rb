# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      # @see OpenAI::Resources::Webhooks#test_
      class WebhookEndpointTestResult < OpenAI::Internal::Type::BaseModel
        # @!attribute event_type
        #   The event type sent in the test.
        #
        #   @return [String]
        required :event_type, String

        # @!attribute object
        #   The object type, which is always webhook_endpoint.test.
        #
        #   @return [Symbol, :"webhook_endpoint.test"]
        required :object, const: :"webhook_endpoint.test"

        # @!attribute status_code
        #   The HTTP status code returned by the endpoint.
        #
        #   @return [Integer]
        required :status_code, Integer

        # @!attribute success
        #   Whether the test request completed. Always true for returned results; use
        #   status_code to determine the endpoint response.
        #
        #   @return [Boolean]
        required :success, OpenAI::Internal::Type::Boolean

        # @!attribute webhook_endpoint_id
        #   The ID of the webhook endpoint that received the test.
        #
        #   @return [String]
        required :webhook_endpoint_id, String

        # @!method initialize(event_type:, status_code:, success:, webhook_endpoint_id:, object: :"webhook_endpoint.test")
        #   @param event_type [String]
        #     The event type sent in the test.
        #
        #   @param status_code [Integer]
        #     The HTTP status code returned by the endpoint.
        #
        #   @param success [Boolean]
        #     Whether the test request completed. Always true for returned results; use
        #     status_code to determine the endpoint response.
        #
        #   @param webhook_endpoint_id [String]
        #     The ID of the webhook endpoint that received the test.
        #
        #   @param object [Symbol, :"webhook_endpoint.test"]
        #     The object type, which is always webhook_endpoint.test.
      end
    end
  end
end
