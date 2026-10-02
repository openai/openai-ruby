# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class AgentSessionCreatedWebhookEvent < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Webhooks::AgentSessionCreatedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data }

        # @!attribute object
        #   The object type. Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   The event type. Always `agent.session.created`.
        #
        #   @return [Symbol, :"agent.session.created"]
        required :type, const: :"agent.session.created"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"agent.session.created")
        #   Sent when an agent session is created.
        #
        #   @param id [String]
        #     The unique ID of the event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp, in seconds, when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::AgentSessionCreatedWebhookEvent::Data]
        #
        #   @param object [Symbol, :event]
        #     The object type. Always `event`.
        #
        #   @param type [Symbol, :"agent.session.created"]
        #     The event type. Always `agent.session.created`.

        # @see OpenAI::Models::Webhooks::AgentSessionCreatedWebhookEvent#data
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

          # @!attribute connect
          #
          #   @return [OpenAI::Models::Webhooks::AgentSessionCreatedWebhookEvent::Data::Connect, nil]
          optional :connect, -> { OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data::Connect }

          # @!attribute environment_id
          #   The ID of the environment, when one exists.
          #
          #   @return [String, nil]
          optional :environment_id, String

          # @!method initialize(id:, environment_type:, connect: nil, environment_id: nil)
          #   @param id [String]
          #     The ID of the session.
          #
          #   @param environment_type [String]
          #     The environment type: `none`, `openai_hosted`, or `self_hosted`.
          #
          #   @param connect [OpenAI::Models::Webhooks::AgentSessionCreatedWebhookEvent::Data::Connect]
          #
          #   @param environment_id [String]
          #     The ID of the environment, when one exists.

          # @see OpenAI::Models::Webhooks::AgentSessionCreatedWebhookEvent::Data#connect
          class Connect < OpenAI::Internal::Type::BaseModel
            # @!attribute remote_url
            #   The URL used to connect the self-hosted environment.
            #
            #   @return [String]
            required :remote_url, String

            # @!method initialize(remote_url:)
            #   @param remote_url [String]
            #     The URL used to connect the self-hosted environment.
          end
        end
      end
    end
  end
end
