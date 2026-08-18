# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AdminAPIKeys#create
        class AdminAPIKeyCreateResponse < OpenAI::Models::Admin::Organization::AdminAPIKey
          # @!attribute value
          #   The value of the API key. Only shown on create.
          #
          #   @return [String]
          required :value, String

          # @!method initialize(id:, created_at:, expires_at:, owner:, redacted_value:, value:, last_used_at: nil, name: nil, object: :"organization.admin_api_key")
          #   Represents an individual Admin API key in an org.
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints
          #
          #   @param created_at [Integer] The Unix timestamp (in seconds) of when the API key was created
          #
          #   @param expires_at [Integer, nil] The Unix timestamp (in seconds) of when the API key expires
          #
          #   @param owner [OpenAI::Models::Admin::Organization::AdminAPIKey::Owner]
          #
          #   @param redacted_value [String] The redacted value of the API key
          #
          #   @param value [String] The value of the API key. Only shown on create.
          #
          #   @param last_used_at [Integer, nil] The Unix timestamp (in seconds) of when the API key was last used
          #
          #   @param name [String, nil] The name of the API key
          #
          #   @param object [Symbol, :"organization.admin_api_key"] The object type, which is always `organization.admin_api_key`
        end
      end
    end
  end
end
