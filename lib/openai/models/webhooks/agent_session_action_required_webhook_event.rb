# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class AgentSessionActionRequiredWebhookEvent < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Webhooks::AgentSessionActionRequiredWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data }

        # @!attribute object
        #   The object type. Always `event`.
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #   The event type. Always `agent.session.action_required`.
        #
        #   @return [Symbol, :"agent.session.action_required"]
        required :type, const: :"agent.session.action_required"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"agent.session.action_required")
        #   Sent when an agent session requires an action. Retrieve the session for action
        #   details.
        #
        #   @param id [String]
        #     The unique ID of the event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp, in seconds, when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::AgentSessionActionRequiredWebhookEvent::Data]
        #
        #   @param object [Symbol, :event]
        #     The object type. Always `event`.
        #
        #   @param type [Symbol, :"agent.session.action_required"]
        #     The event type. Always `agent.session.action_required`.

        # @see OpenAI::Models::Webhooks::AgentSessionActionRequiredWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the session.
          #
          #   @return [String]
          required :id, String

          # @!attribute required_action
          #   The action type. Retrieve the session for action details.
          #
          #   @return [OpenAI::Models::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction]
          required(
            :required_action,
            -> { OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction }
          )

          # @!method initialize(id:, required_action:)
          #   @param id [String]
          #     The ID of the session.
          #
          #   @param required_action [OpenAI::Models::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction]
          #     The action type. Retrieve the session for action details.

          # @see OpenAI::Models::Webhooks::AgentSessionActionRequiredWebhookEvent::Data#required_action
          class RequiredAction < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, OpenAI::Models::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type]
            required(
              :type,
              enum: -> { OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type }
            )

            # @!method initialize(type:)
            #   The action type. Retrieve the session for action details.
            #
            #   @param type [Symbol, OpenAI::Models::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type]

            # @see OpenAI::Models::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction#type
            module Type
              extend OpenAI::Internal::Type::Enum

              COMPUTER_USE_APPROVAL_REQUEST = :computer_use_approval_request
              FUNCTION_CALL = :function_call
              ENVIRONMENT_CONNECTION = :environment_connection

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
