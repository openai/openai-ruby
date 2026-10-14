# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class AgentEnvironmentSuspendedWebhookEvent < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Webhooks::AgentEnvironmentSuspendedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::AgentEnvironmentSuspendedWebhookEvent::Data }

        # @!attribute object
        #   The object type. Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   The event type. Always `agent.environment.suspended`.
        #
        #   @return [Symbol, :"agent.environment.suspended"]
        required :type, const: :"agent.environment.suspended"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"agent.environment.suspended")
        #   Sent when an agent environment is suspended and can resume from a snapshot.
        #
        #   @param id [String]
        #     The unique ID of the event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp, in seconds, when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::AgentEnvironmentSuspendedWebhookEvent::Data]
        #     Identifies the environment whose lifecycle changed.
        #
        #   @param object [Symbol, :event]
        #     The object type. Always `event`.
        #
        #   @param type [Symbol, :"agent.environment.suspended"]
        #     The event type. Always `agent.environment.suspended`.

        # @see OpenAI::Models::Webhooks::AgentEnvironmentSuspendedWebhookEvent#data
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
