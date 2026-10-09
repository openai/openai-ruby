# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class AgentEnvironmentFailedWebhookEvent < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Webhooks::AgentEnvironmentFailedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::AgentEnvironmentFailedWebhookEvent::Data }

        # @!attribute object
        #   The object type. Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   The event type. Always `agent.environment.failed`.
        #
        #   @return [Symbol, :"agent.environment.failed"]
        required :type, const: :"agent.environment.failed"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"agent.environment.failed")
        #   Sent when setup fails for a prewarmed OpenAI-hosted environment before it is
        #   attached to a session.
        #
        #   @param id [String]
        #     The unique ID of the event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp, in seconds, when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::AgentEnvironmentFailedWebhookEvent::Data]
        #     Identifies the environment whose lifecycle changed.
        #
        #   @param object [Symbol, :event]
        #     The object type. Always `event`.
        #
        #   @param type [Symbol, :"agent.environment.failed"]
        #     The event type. Always `agent.environment.failed`.

        # @see OpenAI::Models::Webhooks::AgentEnvironmentFailedWebhookEvent#data
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
