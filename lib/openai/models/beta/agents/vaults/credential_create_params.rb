# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # @see OpenAI::Resources::Beta::Agents::Vaults::Credentials#create
          class CredentialCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute vault_id
            #
            #   @return [String]
            required :vault_id, String

            # @!attribute auth
            #   The authentication method and secret values to store for the MCP server.
            #
            #   @return [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer]
            required :auth, union: -> { OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam }

            # @!attribute name
            #   The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
            #   trimming.
            #
            #   @return [String]
            required :name, String

            # @!method initialize(vault_id:, auth:, name:, request_options: {})
            #   @param vault_id [String]
            #
            #   @param auth [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer]
            #     The authentication method and secret values to store for the MCP server.
            #
            #   @param name [String]
            #     The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
            #     trimming.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
