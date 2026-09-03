# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class SafetyOrgAlertCreatedWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the webhook event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp in seconds when the event was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #
        #   @return [OpenAI::Models::Webhooks::SafetyOrgAlertCreatedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::SafetyOrgAlertCreatedWebhookEvent::Data }

        # @!attribute object
        #   Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   Always `safety.org_alert.created`.
        #
        #   @return [Symbol, :"safety.org_alert.created"]
        required :type, const: :"safety.org_alert.created"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"safety.org_alert.created")
        #   Sent when an approved safety alert is available for an enterprise workspace.
        #
        #   @param id [String] The unique ID of the webhook event.
        #
        #   @param created_at [Integer] The Unix timestamp in seconds when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::SafetyOrgAlertCreatedWebhookEvent::Data]
        #
        #   @param object [Symbol, :event] Always `event`.
        #
        #   @param type [Symbol, :"safety.org_alert.created"] Always `safety.org_alert.created`.

        # @see OpenAI::Models::Webhooks::SafetyOrgAlertCreatedWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The safety alert ID to pass to `GET /v1/safety/alerts/{id}`.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   @param id [String] The safety alert ID to pass to `GET /v1/safety/alerts/{id}`.
        end
      end
    end
  end
end
