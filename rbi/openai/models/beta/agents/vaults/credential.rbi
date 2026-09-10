# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          class Credential < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::Credential,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the credential.
            sig { returns(String) }
            attr_accessor :id

            # The authentication method and non-secret configuration for the MCP server.
            sig { returns(OpenAI::Beta::Agents::Vaults::CredentialAuth::Variants) }
            attr_accessor :auth

            # The Unix timestamp, in seconds, when the credential was created.
            sig { returns(Integer) }
            attr_accessor :created_at

            # The human-readable name of the credential.
            sig { returns(String) }
            attr_accessor :name

            # The object type. Always `vault.credential`.
            sig { returns(Symbol) }
            attr_accessor :object

            # The Unix timestamp, in seconds, when the credential was last updated.
            sig { returns(Integer) }
            attr_accessor :updated_at

            # The ID of the vault containing this credential.
            sig { returns(String) }
            attr_accessor :vault_id

            # Metadata for a stored MCP server credential. Secret values are never returned.
            sig do
              params(

                id: String,

                auth: T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuth::McpOauth::OrHash,
                  OpenAI::Beta::Agents::Vaults::CredentialAuth::StaticBearer::OrHash
                ),

                created_at: Integer,

                name: String,

                updated_at: Integer,

                vault_id: String,

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the credential.
              id:,

              # The authentication method and non-secret configuration for the MCP server.
              auth:,

              # The Unix timestamp, in seconds, when the credential was created.
              created_at:,

              # The human-readable name of the credential.
              name:,

              # The Unix timestamp, in seconds, when the credential was last updated.
              updated_at:,

              # The ID of the vault containing this credential.
              vault_id:,

              # The object type. Always `vault.credential`.

              object: :"vault.credential"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  auth: OpenAI::Beta::Agents::Vaults::CredentialAuth::Variants,
                  created_at: Integer,
                  name: String,
                  object: Symbol,
                  updated_at: Integer,
                  vault_id: String
                }
              )
            end
            def to_hash
            end

          end

        end

      end

    end

  end
end
