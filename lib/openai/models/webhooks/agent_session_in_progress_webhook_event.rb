# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class AgentSessionInProgressWebhookEvent < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Webhooks::AgentSessionInProgressWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::AgentSessionInProgressWebhookEvent::Data }

        # @!attribute object
        #   The object type. Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   The event type. Always `agent.session.in_progress`.
        #
        #   @return [Symbol, :"agent.session.in_progress"]
        required :type, const: :"agent.session.in_progress"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"agent.session.in_progress")
        #   Sent when an agent session enters the in-progress state.
        #
        #   @param id [String]
        #     The unique ID of the event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp, in seconds, when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::AgentSessionInProgressWebhookEvent::Data]
        #
        #   @param object [Symbol, :event]
        #     The object type. Always `event`.
        #
        #   @param type [Symbol, :"agent.session.in_progress"]
        #     The event type. Always `agent.session.in_progress`.

        # @see OpenAI::Models::Webhooks::AgentSessionInProgressWebhookEvent#data
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
