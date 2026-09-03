# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class SafetyAlertCreatedWebhookEvent < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Webhooks::SafetyAlertCreatedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::SafetyAlertCreatedWebhookEvent::Data }

        # @!attribute object
        #   Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   Always `safety.alert.created`.
        #
        #   @return [Symbol, :"safety.alert.created"]
        required :type, const: :"safety.alert.created"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"safety.alert.created")
        #   Sent when an approved safety alert is available for an API project.
        #
        #   @param id [String] The unique ID of the webhook event.
        #
        #   @param created_at [Integer] The Unix timestamp in seconds when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::SafetyAlertCreatedWebhookEvent::Data]
        #
        #   @param object [Symbol, :event] Always `event`.
        #
        #   @param type [Symbol, :"safety.alert.created"] Always `safety.alert.created`.

        # @see OpenAI::Models::Webhooks::SafetyAlertCreatedWebhookEvent#data
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
