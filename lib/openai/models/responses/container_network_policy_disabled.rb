# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Responses
      class ContainerNetworkPolicyDisabled < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   Disable outbound network access. Always `disabled`.
        #
        #   @return [Symbol, :disabled]
        required :type, const: :disabled

        # @!method initialize(type: :disabled)
        #   @param type [Symbol, :disabled] Disable outbound network access. Always `disabled`.
      end
    end
  end
end
