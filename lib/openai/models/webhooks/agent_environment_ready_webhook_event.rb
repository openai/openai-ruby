# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class AgentEnvironmentReadyWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp, in seconds, when the event was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Identifies the environment whose lifecycle changed.
        #
        #   @return [OpenAI::Models::Webhooks::AgentEnvironmentReadyWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::AgentEnvironmentReadyWebhookEvent::Data }

        # @!attribute object
        #   The object type. Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   The event type. Always `agent.environment.ready`.
        #
        #   @return [Symbol, :"agent.environment.ready"]
        required :type, const: :"agent.environment.ready"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"agent.environment.ready")
        #   Sent when a prewarmed OpenAI-hosted environment finishes setup before being
        #   attached to a session.
        #
        #   @param id [String]
        #     The unique ID of the event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp, in seconds, when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::AgentEnvironmentReadyWebhookEvent::Data]
        #     Identifies the environment whose lifecycle changed.
        #
        #   @param object [Symbol, :event]
        #     The object type. Always `event`.
        #
        #   @param type [Symbol, :"agent.environment.ready"]
        #     The event type. Always `agent.environment.ready`.

        # @see OpenAI::Models::Webhooks::AgentEnvironmentReadyWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the environment.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   Identifies the environment whose lifecycle changed.
          #
          #   @param id [String]
          #     The ID of the environment.
        end
      end
    end
  end
end
