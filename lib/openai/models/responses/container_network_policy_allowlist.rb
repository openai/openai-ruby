# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ContainerNetworkPolicyAllowlist < OpenAI::Internal::Type::BaseModel
        # @!attribute allowed_domains
        #   A list of allowed domains when type is `allowlist`.
        #
        #   @return [Array<String>]
        required :allowed_domains, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute type
        #   Allow outbound network access only to specified domains. Always `allowlist`.
        #
        #   @return [Symbol, :allowlist]
        required :type, const: :allowlist

        # @!attribute domain_secrets
        #   Optional domain-scoped secrets for allowlisted domains.
        #
        #   @return [Array<OpenAI::Models::Responses::ContainerNetworkPolicyDomainSecret>, nil]
        optional :domain_secrets,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ContainerNetworkPolicyDomainSecret] }

        # @!method initialize(allowed_domains:, domain_secrets: nil, type: :allowlist)
        #   @param allowed_domains [Array<String>] A list of allowed domains when type is `allowlist`.
        #
        #   @param domain_secrets [Array<OpenAI::Models::Responses::ContainerNetworkPolicyDomainSecret>] Optional domain-scoped secrets for allowlisted domains.
        #
        #   @param type [Symbol, :allowlist] Allow outbound network access only to specified domains. Always `allowlist`.
      end
    end
  end
end
