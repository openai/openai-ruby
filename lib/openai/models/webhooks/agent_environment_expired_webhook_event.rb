# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class AgentEnvironmentExpiredWebhookEvent < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Webhooks::AgentEnvironmentExpiredWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::AgentEnvironmentExpiredWebhookEvent::Data }

        # @!attribute object
        #   The object type. Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   The event type. Always `agent.environment.expired`.
        #
        #   @return [Symbol, :"agent.environment.expired"]
        required :type, const: :"agent.environment.expired"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"agent.environment.expired")
        #   Sent when an agent environment expires and can no longer resume from a snapshot.
        #
        #   @param id [String]
        #     The unique ID of the event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp, in seconds, when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::AgentEnvironmentExpiredWebhookEvent::Data]
        #     Identifies the environment whose lifecycle changed.
        #
        #   @param object [Symbol, :event]
        #     The object type. Always `event`.
        #
        #   @param type [Symbol, :"agent.environment.expired"]
        #     The event type. Always `agent.environment.expired`.

        # @see OpenAI::Models::Webhooks::AgentEnvironmentExpiredWebhookEvent#data
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
