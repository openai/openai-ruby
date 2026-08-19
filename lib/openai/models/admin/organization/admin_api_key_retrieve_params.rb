# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AdminAPIKeys#retrieve
        class AdminAPIKeyRetrieveParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute key_id
          #   The ID of the API key.
          #
          #   @return [String]
          required :key_id, String

          # @!method initialize(key_id:, request_options: {})
          #   @param key_id [String] The ID of the API key.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
