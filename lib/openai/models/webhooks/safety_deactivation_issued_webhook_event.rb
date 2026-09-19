# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class SafetyDeactivationIssuedWebhookEvent < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Webhooks::SafetyDeactivationIssuedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::SafetyDeactivationIssuedWebhookEvent::Data }

        # @!attribute object
        #   Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   Always `safety.deactivation_issued`.
        #
        #   @return [Symbol, :"safety.deactivation_issued"]
        required :type, const: :"safety.deactivation_issued"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"safety.deactivation_issued")
        #   Sent when a deactivation is issued for a safety identifier in your organization.
        #
        #   @param id [String]
        #     The unique ID of the webhook event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp in seconds when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::SafetyDeactivationIssuedWebhookEvent::Data]
        #
        #   @param object [Symbol, :event]
        #     Always `event`.
        #
        #   @param type [Symbol, :"safety.deactivation_issued"]
        #     Always `safety.deactivation_issued`.

        # @see OpenAI::Models::Webhooks::SafetyDeactivationIssuedWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The safety case ID to pass to `GET /v1/safety/cases/{id}`.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   @param id [String]
          #     The safety case ID to pass to `GET /v1/safety/cases/{id}`.
        end
      end
    end
  end
end
