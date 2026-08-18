# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaContainerNetworkPolicyDisabled < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   Disable outbound network access. Always `disabled`.
        #
        #   @return [Symbol, :disabled]
        required :type, const: :disabled

        # @!method initialize(type: :disabled)
        #   @param type [Symbol, :disabled] Disable outbound network access. Always `disabled`.
      end
    end

    BetaContainerNetworkPolicyDisabled = Beta::BetaContainerNetworkPolicyDisabled
  end
end
