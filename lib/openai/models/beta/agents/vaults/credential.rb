# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # @see OpenAI::Resources::Beta::Agents::Vaults::Credentials#create
          class Credential < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the credential.
            #
            #   @return [String]
            required :id, String

            # @!attribute auth
            #   The authentication method and non-secret configuration for the MCP server.
            #
            #   @return [OpenAI::Models::Beta::Agents::Vaults::CredentialAuth::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuth::StaticBearer]
            required :auth, union: -> { OpenAI::Beta::Agents::Vaults::CredentialAuth }

            # @!attribute created_at
            #   The Unix timestamp, in seconds, when the credential was created.
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute name
            #   The human-readable name of the credential.
            #
            #   @return [String]
            required :name, String

            # @!attribute object
            #   The object type. Always `vault.credential`.
            #
            #   @return [Symbol, :"vault.credential"]
            required :object, const: :"vault.credential"

            # @!attribute updated_at
            #   The Unix timestamp, in seconds, when the credential was last updated.
            #
            #   @return [Integer]
            required :updated_at, Integer

            # @!attribute vault_id
            #   The ID of the vault containing this credential.
            #
            #   @return [String]
            required :vault_id, String

            # @!method initialize(id:, auth:, created_at:, name:, updated_at:, vault_id:, object: :"vault.credential")
            #   Metadata for a stored MCP server credential. Secret values are never returned.
            #
            #   @param id [String]
            #     The ID of the credential.
            #
            #   @param auth [OpenAI::Models::Beta::Agents::Vaults::CredentialAuth::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuth::StaticBearer]
            #     The authentication method and non-secret configuration for the MCP server.
            #
            #   @param created_at [Integer]
            #     The Unix timestamp, in seconds, when the credential was created.
            #
            #   @param name [String]
            #     The human-readable name of the credential.
            #
            #   @param updated_at [Integer]
            #     The Unix timestamp, in seconds, when the credential was last updated.
            #
            #   @param vault_id [String]
            #     The ID of the vault containing this credential.
            #
            #   @param object [Symbol, :"vault.credential"]
            #     The object type. Always `vault.credential`.
          end
        end
      end
    end
  end
end
