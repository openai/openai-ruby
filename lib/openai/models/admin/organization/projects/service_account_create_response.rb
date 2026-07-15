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
            #   @return [OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey, nil]
            required :api_key,
                     -> { OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey },
                     nil?: true

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
            #   Service accounts created with default project membership have role `member`.
            #   Accounts created with `create_service_account_only` have role `none`.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::Role]
            required :role,
                     enum: -> { OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::Role }

            # @!method initialize(id:, api_key:, created_at:, name:, role:, object: :"organization.project.service_account")
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse}
            #   for more details.
            #
            #   @param id [String]
            #
            #   @param api_key [OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey, nil]
            #
            #   @param created_at [Integer]
            #
            #   @param name [String]
            #
            #   @param role [Symbol, OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::Role] Service accounts created with default project membership have role `member`. Acc
            #
            #   @param object [Symbol, :"organization.project.service_account"]

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

            # Service accounts created with default project membership have role `member`.
            # Accounts created with `create_service_account_only` have role `none`.
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse#role
            module Role
              extend OpenAI::Internal::Type::Enum

              MEMBER = :member
              NONE = :none

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
