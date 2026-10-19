# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionUpdateConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute delegation
        #   Delegation settings to update. The delegation type must match the current
        #   session; omitted settings retain their values.
        #
        #   @return [OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionUpdateConfig::Delegation::Responses, OpenAI::Models::Live::SessionUpdateConfig::Delegation::Decisions, nil]
        optional :delegation, union: -> { OpenAI::Live::SessionUpdateConfig::Delegation }, nil?: true

        # @!attribute triggers
        #   At most one Decisions trigger per transcript event type. Triggers run
        #   independently of delegation. On update, omit triggers to keep the current
        #   configuration, send a list to replace it, or send an empty list to disable
        #   triggers.
        #
        #   @return [Array<OpenAI::Models::Live::DecisionTrigger>, nil]
        optional :triggers, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Live::DecisionTrigger] }

        # @!method initialize(delegation: nil, triggers: nil)
        #   Changes to an active Live session's delegation settings and transcript triggers.
        #
        #   @param delegation [OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionUpdateConfig::Delegation::Responses, OpenAI::Models::Live::SessionUpdateConfig::Delegation::Decisions, nil]
        #     Delegation settings to update. The delegation type must match the current
        #     session; omitted settings retain their values.
        #
        #   @param triggers [Array<OpenAI::Models::Live::DecisionTrigger>]
        #     At most one Decisions trigger per transcript event type. Triggers run
        #     independently of delegation. On update, omit triggers to keep the current
        #     configuration, send a list to replace it, or send an empty list to disable
        #     triggers.

        # Delegation settings to update. The delegation type must match the current
        # session; omitted settings retain their values.
        #
        # @see OpenAI::Models::Live::SessionUpdateConfig#delegation
        module Delegation
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Delegate tasks to your application. The Live session emits delegation events that your backend handles.
          variant :client, -> { OpenAI::Live::ClientDelegation }

          # Update the Responses backend for an existing Live session without changing delegation ownership.
          variant :responses, -> { OpenAI::Live::SessionUpdateConfig::Delegation::Responses }

          variant :decisions, -> { OpenAI::Live::SessionUpdateConfig::Delegation::Decisions }

          class Responses < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The delegation owner. Always `responses` for tasks handled by the Responses API.
            #
            #   @return [Symbol, :responses]
            required :type, const: :responses

            # @!attribute responses
            #   Responses backend settings to update. Omitted settings keep their existing
            #   values.
            #
            #   @return [OpenAI::Models::Live::ResponsesDelegationUpdateConfig, nil]
            optional :responses, -> { OpenAI::Live::ResponsesDelegationUpdateConfig }

            # @!method initialize(responses: nil, type: :responses)
            #   Update the Responses backend for an existing Live session without changing
            #   delegation ownership.
            #
            #   @param responses [OpenAI::Models::Live::ResponsesDelegationUpdateConfig]
            #     Responses backend settings to update. Omitted settings keep their existing
            #     values.
            #
            #   @param type [Symbol, :responses]
            #     The delegation owner. Always `responses` for tasks handled by the Responses API.
          end

          class Decisions < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :decisions]
            required :type, const: :decisions

            # @!attribute decisions
            #
            #   @return [OpenAI::Models::Live::DecisionsDelegationUpdateConfig, nil]
            optional :decisions, -> { OpenAI::Live::DecisionsDelegationUpdateConfig }

            # @!method initialize(decisions: nil, type: :decisions)
            #   @param decisions [OpenAI::Models::Live::DecisionsDelegationUpdateConfig]
            #   @param type [Symbol, :decisions]
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionUpdateConfig::Delegation::Responses, OpenAI::Models::Live::SessionUpdateConfig::Delegation::Decisions)]
        end
      end
    end
  end
end
