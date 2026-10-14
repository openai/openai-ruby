# typed: strong

module OpenAI
  module Models
    module Responses
      class ContainerNetworkPolicyAllowlist < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ContainerNetworkPolicyAllowlist,
              OpenAI::Internal::AnyHash
            )
          end

        # A list of allowed domains when type is `allowlist`.
        sig { returns(T::Array[String]) }
        attr_accessor :allowed_domains

        # Allow outbound network access only to specified domains. Always `allowlist`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional domain-scoped secrets for allowlisted domains.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Responses::ContainerNetworkPolicyDomainSecret]
            )
          )
        end
        attr_reader :domain_secrets

        sig do
          params(
            domain_secrets:
              T::Array[
                OpenAI::Responses::ContainerNetworkPolicyDomainSecret::OrHash
              ]
          ).void
        end
        attr_writer :domain_secrets

        sig do
          params(
            allowed_domains: T::Array[String],
            domain_secrets:
              T::Array[
                OpenAI::Responses::ContainerNetworkPolicyDomainSecret::OrHash
              ],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A list of allowed domains when type is `allowlist`.
          allowed_domains:,
          # Optional domain-scoped secrets for allowlisted domains.
          domain_secrets: nil,
          # Allow outbound network access only to specified domains. Always `allowlist`.
          type: :allowlist
        )
        end

        sig do
          override.returns(
            {
              allowed_domains: T::Array[String],
              type: Symbol,
              domain_secrets:
                T::Array[OpenAI::Responses::ContainerNetworkPolicyDomainSecret]
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
