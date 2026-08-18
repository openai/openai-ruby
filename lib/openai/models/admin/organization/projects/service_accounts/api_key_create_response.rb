# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module ServiceAccounts
            # @see OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts::APIKeys#create
            class APIKeyCreateResponse < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   The identifier of the API key.
              #
              #   @return [String]
              required :id, String

              # @!attribute created_at
              #   The Unix timestamp (in seconds) when the API key was created.
              #
              #   @return [Integer]
              required :created_at, Integer

              # @!attribute name
              #   The name of the API key.
              #
              #   @return [String]
              required :name, String

              # @!attribute object
              #   The object type, which is always `organization.project.service_account.api_key`
              #
              #   @return [Symbol, :"organization.project.service_account.api_key"]
              required :object, const: :"organization.project.service_account.api_key"

              # @!attribute value
              #   The unredacted API key value.
              #
              #   @return [String]
              required :value, String

              # @!method initialize(id:, created_at:, name:, value:, object: :"organization.project.service_account.api_key")
              #   @param id [String] The identifier of the API key.
              #
              #   @param created_at [Integer] The Unix timestamp (in seconds) when the API key was created.
              #
              #   @param name [String] The name of the API key.
              #
              #   @param value [String] The unredacted API key value.
              #
              #   @param object [Symbol, :"organization.project.service_account.api_key"] The object type, which is always `organization.project.service_account.api_key`
            end
          end
        end
      end
    end
  end
end
