# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts#create
          class ServiceAccountCreateResponse < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #
            #   @return [String]
            required :id, String

            # @!attribute api_key
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey]
            required :api_key,
                     -> { OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey }

            # @!attribute created_at
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute name
            #
            #   @return [String]
            required :name, String

            # @!attribute object
            #
            #   @return [Symbol, :"organization.project.service_account"]
            required :object, const: :"organization.project.service_account"

            # @!attribute role
            #   Service accounts can only have one role of type `member`
            #
            #   @return [Symbol, :member]
            required :role, const: :member

            # @!method initialize(id:, api_key:, created_at:, name:, object: :"organization.project.service_account", role: :member)
            #   @param id [String]
            #
            #   @param api_key [OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey]
            #
            #   @param created_at [Integer]
            #
            #   @param name [String]
            #
            #   @param object [Symbol, :"organization.project.service_account"]
            #
            #   @param role [Symbol, :member] Service accounts can only have one role of type `member`

            # @see OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse#api_key
            class APIKey < OpenAI::Internal::Type::BaseModel
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
