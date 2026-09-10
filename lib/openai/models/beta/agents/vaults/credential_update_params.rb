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
            #   @return [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer]
            required :auth, union: -> { OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam }

            # @!method initialize(vault_id:, credential_id:, auth:, request_options: {})
            #   @param vault_id [String]
            #
            #   @param credential_id [String]
            #
            #   @param auth [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer]
            #     Replacement values for the credential's existing authentication method.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
