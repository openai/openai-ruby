# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      # @see OpenAI::Resources::Webhooks#create
      class WebhookEndpointWithSecret < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the webhook endpoint.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp when the endpoint was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute event_types
        #   The event types that trigger deliveries to this endpoint.
        #
        #   @return [Array<String>]
        required :event_types, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute name
        #   The human-readable name of the endpoint.
        #
        #   @return [String]
        required :name, String

        # @!attribute object
        #   The object type, which is always webhook_endpoint.
        #
        #   @return [Symbol, :webhook_endpoint]
        required :object, const: :webhook_endpoint

        # @!attribute signing_secret
        #   The endpoint's signing secret. This is returned only when the endpoint is
        #   created or the secret is rotated.
        #
        #   @return [String]
        required :signing_secret, String

        # @!attribute signing_secret_hint
        #   A masked hint for the endpoint's signing secret.
        #
        #   @return [String, nil]
        required :signing_secret_hint, String, nil?: true

        # @!attribute url
        #   The HTTPS URL that receives webhook deliveries.
        #
        #   @return [String]
        required :url, String

        # @!attribute updated_at
        #   The Unix timestamp of the last endpoint configuration or signing-secret change.
        #   Initialized at creation; tests and unchanged updates do not advance it.
        #
        #   @return [Integer, nil]
        optional :updated_at, Integer

        # @!method initialize(id:, created_at:, event_types:, name:, signing_secret:, signing_secret_hint:, url:, updated_at: nil, object: :webhook_endpoint)
        #   @param id [String]
        #     The unique ID of the webhook endpoint.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp when the endpoint was created.
        #
        #   @param event_types [Array<String>]
        #     The event types that trigger deliveries to this endpoint.
        #
        #   @param name [String]
        #     The human-readable name of the endpoint.
        #
        #   @param signing_secret [String]
        #     The endpoint's signing secret. This is returned only when the endpoint is
        #     created or the secret is rotated.
        #
        #   @param signing_secret_hint [String, nil]
        #     A masked hint for the endpoint's signing secret.
        #
        #   @param url [String]
        #     The HTTPS URL that receives webhook deliveries.
        #
        #   @param updated_at [Integer]
        #     The Unix timestamp of the last endpoint configuration or signing-secret change.
        #     Initialized at creation; tests and unchanged updates do not advance it.
        #
        #   @param object [Symbol, :webhook_endpoint]
        #     The object type, which is always webhook_endpoint.

        # Keep diagnostics safe without changing field access or serialization.
        def to_s = deep_to_h.merge(signing_secret: "[REDACTED]").to_s

        def inspect
          converted = self.class.recursively_to_h(self, convert: true)
          converted[:signing_secret] = "[REDACTED]"
          "#<#{self.class}:0x#{object_id.to_s(16)} #{converted}>"
        end
      end
    end
  end
end
