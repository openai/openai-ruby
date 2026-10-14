# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionUpdateConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute delegation
        #   Delegation settings to update. The delegation type must match the current
        #   session; omitted settings retain their values.
        #
        #   @return [OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionUpdateConfig::Delegation::Responses, nil]
        optional :delegation, union: -> { OpenAI::Live::SessionUpdateConfig::Delegation }, nil?: true

        # @!method initialize(delegation: nil)
        #   Changes to an active Live session. Only delegation backend settings can be
        #   updated after startup.
        #
        #   @param delegation [OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionUpdateConfig::Delegation::Responses, nil]
        #     Delegation settings to update. The delegation type must match the current
        #     session; omitted settings retain their values.

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

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Live::ClientDelegation, OpenAI::Models::Live::SessionUpdateConfig::Delegation::Responses)]
        end
      end
    end
  end
end
