# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class AgentSessionFailedWebhookEvent < OpenAI::Internal::Type::BaseModel
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
        #
        #   @return [OpenAI::Models::Webhooks::AgentSessionFailedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::AgentSessionFailedWebhookEvent::Data }

        # @!attribute object
        #   The object type. Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   The event type. Always `agent.session.failed`.
        #
        #   @return [Symbol, :"agent.session.failed"]
        required :type, const: :"agent.session.failed"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"agent.session.failed")
        #   Sent when an agent session fails.
        #
        #   @param id [String]
        #     The unique ID of the event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp, in seconds, when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::AgentSessionFailedWebhookEvent::Data]
        #
        #   @param object [Symbol, :event]
        #     The object type. Always `event`.
        #
        #   @param type [Symbol, :"agent.session.failed"]
        #     The event type. Always `agent.session.failed`.

        # @see OpenAI::Models::Webhooks::AgentSessionFailedWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the session.
          #
          #   @return [String]
          required :id, String

          # @!attribute environment_type
          #   The environment type: `none`, `openai_hosted`, or `self_hosted`.
          #
          #   @return [String]
          required :environment_type, String

          # @!attribute environment_id
          #   The ID of the environment, when one exists.
          #
          #   @return [String, nil]
          optional :environment_id, String

          # @!method initialize(id:, environment_type:, environment_id: nil)
          #   @param id [String]
          #     The ID of the session.
          #
          #   @param environment_type [String]
          #     The environment type: `none`, `openai_hosted`, or `self_hosted`.
          #
          #   @param environment_id [String]
          #     The ID of the environment, when one exists.
        end
      end
    end
  end
end
