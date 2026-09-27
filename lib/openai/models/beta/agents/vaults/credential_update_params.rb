# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # @see OpenAI::Resources::Beta::Agents::Vaults::Credentials#update
          class CredentialUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute vault_id
            #
            #   @return [String]
            required :vault_id, String

            # @!attribute credential_id
            #
            #   @return [String]
            required :credential_id, String

            # @!attribute auth
            #   Replacement values for the credential's existing authentication method.
            #
            #   @return [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::EnvironmentVariable, nil]
            optional :auth, union: -> { OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam }

            # @!attribute metadata
            #   Replaces all metadata. Omit to preserve it, or pass {} to clear it. Up to 16
            #   string key-value pairs, with keys up to 64 and values up to 512 characters.
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :metadata, OpenAI::Internal::Type::HashOf[String]

            # @!method initialize(vault_id:, credential_id:, auth: nil, metadata: nil, request_options: {})
            #   @param vault_id [String]
            #
            #   @param credential_id [String]
            #
            #   @param auth [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::EnvironmentVariable]
            #     Replacement values for the credential's existing authentication method.
            #
            #   @param metadata [Hash{Symbol=>String}]
            #     Replaces all metadata. Omit to preserve it, or pass {} to clear it. Up to 16
            #     string key-value pairs, with keys up to 64 and values up to 512 characters.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
