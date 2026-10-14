# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # Destination permissions for an environment-variable credential. These do not
          # grant network access to the environment.
          module CredentialNetworkingParam
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Allows substitution for destinations permitted by the environment network policy. Requires `environment.network.access` to be `restricted`, with explicit `allowed_domains`.
            variant :unrestricted, -> { OpenAI::Beta::Agents::Vaults::CredentialNetworkingParam::Unrestricted }

            # Allows substitution only for the listed hosts. The environment network policy must also allow these hosts.
            variant :limited, -> { OpenAI::Beta::Agents::Vaults::CredentialNetworkingParam::Limited }

            class Unrestricted < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The type of the object. Always `unrestricted`.
              #
              #   @return [Symbol, :unrestricted]
              required :type, const: :unrestricted

              # @!method initialize(type: :unrestricted)
              #   Allows substitution for destinations permitted by the environment network
              #   policy. Requires `environment.network.access` to be `restricted`, with explicit
              #   `allowed_domains`.
              #
              #   @param type [Symbol, :unrestricted]
              #     The type of the object. Always `unrestricted`.
            end

            class Limited < OpenAI::Internal::Type::BaseModel
              # @!attribute allowed_hosts
              #   The 1 to 16 distinct allowed hostnames or IPv4 addresses, normalized to
              #   lowercase. Entries contain no scheme, path, port, or wildcard. IPv6 addresses
              #   are not supported.
              #
              #   @return [Array<String>]
              required :allowed_hosts, OpenAI::Internal::Type::ArrayOf[String]

              # @!attribute type
              #   The type of the object. Always `limited`.
              #
              #   @return [Symbol, :limited]
              required :type, const: :limited

              # @!method initialize(allowed_hosts:, type: :limited)
              #   Allows substitution only for the listed hosts. The environment network policy
              #   must also allow these hosts.
              #
              #   @param allowed_hosts [Array<String>]
              #     The 1 to 16 distinct allowed hostnames or IPv4 addresses, normalized to
              #     lowercase. Entries contain no scheme, path, port, or wildcard. IPv6 addresses
              #     are not supported.
              #
              #   @param type [Symbol, :limited]
              #     The type of the object. Always `limited`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::Agents::Vaults::CredentialNetworkingParam::Unrestricted, OpenAI::Models::Beta::Agents::Vaults::CredentialNetworkingParam::Limited)]
          end
        end
      end
    end
  end
end
