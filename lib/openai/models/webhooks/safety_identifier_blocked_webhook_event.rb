# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class SafetyIdentifierBlockedWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the request was blocked.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::SafetyIdentifierBlockedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `safety_identifier.blocked`.
        #
        #   @return [Symbol, :"safety_identifier.blocked"]
        required :type, const: :"safety_identifier.blocked"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::SafetyIdentifierBlockedWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"safety_identifier.blocked")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::SafetyIdentifierBlockedWebhookEvent} for more
        #   details.
        #
        #   Sent when a request associated with a safety identifier has been blocked.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the request was blocked.
        #
        #   @param data [OpenAI::Models::Webhooks::SafetyIdentifierBlockedWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::SafetyIdentifierBlockedWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"safety_identifier.blocked"] The type of the event. Always `safety_identifier.blocked`.

        # @see OpenAI::Models::Webhooks::SafetyIdentifierBlockedWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute safety_category
          #   The safety category that triggered the block, such as `bio` or `cyber`.
          #
          #   @return [String]
          required :safety_category, String

          # @!attribute safety_identifier
          #   The stable safety identifier associated with the blocked request.
          #
          #   @return [String]
          required :safety_identifier, String

          # @!attribute model
          #   The model used for the blocked request, if available.
          #
          #   @return [String, nil]
          optional :model, String

          # @!attribute project_id
          #   The project associated with the blocked request, if available.
          #
          #   @return [String, nil]
          optional :project_id, String

          # @!attribute request_id
          #   The OpenAI request ID for the blocked request, if available.
          #
          #   @return [String, nil]
          optional :request_id, String

          # @!method initialize(safety_category:, safety_identifier:, model: nil, project_id: nil, request_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::SafetyIdentifierBlockedWebhookEvent::Data} for more
          #   details.
          #
          #   Event data payload.
          #
          #   @param safety_category [String] The safety category that triggered the block, such as `bio` or `cyber`.
          #
          #   @param safety_identifier [String] The stable safety identifier associated with the blocked request.
          #
          #   @param model [String] The model used for the blocked request, if available.
          #
          #   @param project_id [String] The project associated with the blocked request, if available.
          #
          #   @param request_id [String] The OpenAI request ID for the blocked request, if available.
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::SafetyIdentifierBlockedWebhookEvent#object
        module Object
          extend OpenAI::Internal::Type::Enum

          EVENT = :event

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
