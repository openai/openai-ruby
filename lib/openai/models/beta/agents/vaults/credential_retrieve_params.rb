# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # @see OpenAI::Resources::Beta::Agents::Vaults::Credentials#retrieve
          class CredentialRetrieveParams < OpenAI::Internal::Type::BaseModel
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

            # @!method initialize(vault_id:, credential_id:, request_options: {})
            #   @param vault_id [String]
            #   @param credential_id [String]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
