# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          # Destination permissions for an environment-variable credential. These do not
          # grant network access to the environment.
          module CredentialNetworkingParam
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::CredentialNetworkingParam::Unrestricted,
                OpenAI::Beta::Agents::Vaults::CredentialNetworkingParam::Limited
              )
            end

            class Unrestricted < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialNetworkingParam::Unrestricted,
                  OpenAI::Internal::AnyHash
                )
              end

              # The type of the object. Always `unrestricted`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Allows substitution for destinations permitted by the environment network
              # policy. Requires `environment.network.access` to be `restricted`, with explicit
              # `allowed_domains`.
              sig do
                params(

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The type of the object. Always `unrestricted`.

                type: :unrestricted
              )
              end

              sig do
                override.returns(
                  {type: Symbol}
                )
              end
              def to_hash
              end

            end

            class Limited < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialNetworkingParam::Limited,
                  OpenAI::Internal::AnyHash
                )
              end

              # The 1 to 16 distinct allowed hostnames or IPv4 addresses, normalized to
              # lowercase. Entries contain no scheme, path, port, or wildcard. IPv6 addresses
              # are not supported.
              sig { returns(T::Array[String]) }
              attr_accessor :allowed_hosts

              # The type of the object. Always `limited`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Allows substitution only for the listed hosts. The environment network policy
              # must also allow these hosts.
              sig do
                params(

                  allowed_hosts: T::Array[String],

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The 1 to 16 distinct allowed hostnames or IPv4 addresses, normalized to
                # lowercase. Entries contain no scheme, path, port, or wildcard. IPv6 addresses
                # are not supported.
                allowed_hosts:,

                # The type of the object. Always `limited`.

                type: :limited
              )
              end

              sig do
                override.returns(
                  {allowed_hosts: T::Array[String], type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig { override.returns(T::Array[OpenAI::Beta::Agents::Vaults::CredentialNetworkingParam::Variants]) }
            def self.variants
            end

          end

        end

      end

    end

  end
end
