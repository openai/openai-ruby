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
              #
              #   @return [String]
              required :id, String

              # @!attribute created_at
              #
              #   @return [Integer]
              required :created_at, Integer

              # @!attribute name
              #
              #   @return [String]
              required :name, String

              # @!attribute object
              #   The object type, which is always `organization.project.service_account.api_key`
              #
              #   @return [Symbol, :"organization.project.service_account.api_key"]
              required :object, const: :"organization.project.service_account.api_key"

              # @!attribute value
              #
              #   @return [String]
              required :value, String

              # @!method initialize(id:, created_at:, name:, value:, object: :"organization.project.service_account.api_key")
              #   @param id [String]
              #
              #   @param created_at [Integer]
              #
              #   @param name [String]
              #
              #   @param value [String]
              #
              #   @param object [Symbol, :"organization.project.service_account.api_key"] The object type, which is always `organization.project.service_account.api_key`
            end
          end
        end
      end
    end
  end
end
