# typed: strong

module OpenAI
  module Models
    module Responses
      class ContainerNetworkPolicyDomainSecret < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ContainerNetworkPolicyDomainSecret,
              OpenAI::Internal::AnyHash
            )
          end

        # The domain associated with the secret.
        sig { returns(String) }
        attr_accessor :domain

        # The name of the secret to inject for the domain.
        sig { returns(String) }
        attr_accessor :name

        # The secret value to inject for the domain.
        sig { returns(String) }
        attr_accessor :value

        sig do
          params(domain: String, name: String, value: String).returns(
            T.attached_class
          )
        end
        def self.new(
          # The domain associated with the secret.
          domain:,
          # The name of the secret to inject for the domain.
          name:,
          # The secret value to inject for the domain.
          value:
        )
        end

        sig do
          override.returns({ domain: String, name: String, value: String })
        end
        def to_hash
        end
      end
    end
  end
end
