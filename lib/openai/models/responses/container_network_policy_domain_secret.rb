# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ContainerNetworkPolicyDomainSecret < OpenAI::Internal::Type::BaseModel
        # @!attribute domain
        #   The domain associated with the secret.
        #
        #   @return [String]
        required :domain, String

        # @!attribute name
        #   The name of the secret to inject for the domain.
        #
        #   @return [String]
        required :name, String

        # @!attribute value
        #   The secret value to inject for the domain.
        #
        #   @return [String]
        required :value, String

        # @!method initialize(domain:, name:, value:)
        #   @param domain [String] The domain associated with the secret.
        #
        #   @param name [String] The name of the secret to inject for the domain.
        #
        #   @param value [String] The secret value to inject for the domain.
      end
    end
  end
end
