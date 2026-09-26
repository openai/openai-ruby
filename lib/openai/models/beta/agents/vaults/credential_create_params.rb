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
            #   The authentication method and write-only secret values to store.
            #
            #   @return [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::EnvironmentVariable]
            required :auth, union: -> { OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam }

            # @!attribute name
            #   The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
            #   trimming.
            #
            #   @return [String]
            required :name, String

            # @!attribute metadata
            #   Up to 16 string key-value pairs, with keys up to 64 and values up to 512
            #   characters. Defaults to an empty map.
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :metadata, OpenAI::Internal::Type::HashOf[String]

            # @!method initialize(vault_id:, auth:, name:, metadata: nil, request_options: {})
            #   @param vault_id [String]
            #
            #   @param auth [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::EnvironmentVariable]
            #     The authentication method and write-only secret values to store.
            #
            #   @param name [String]
            #     The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
            #     trimming.
            #
            #   @param metadata [Hash{Symbol=>String}]
            #     Up to 16 string key-value pairs, with keys up to 64 and values up to 512
            #     characters. Defaults to an empty map.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
