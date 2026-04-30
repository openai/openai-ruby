# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts#retrieve
          class ProjectServiceAccount < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier, which can be referenced in API endpoints
            #
            #   @return [String]
            required :id, String

            # @!attribute created_at
            #   The Unix timestamp (in seconds) of when the service account was created
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute name
            #   The name of the service account
            #
            #   @return [String]
            required :name, String

            # @!attribute object
            #   The object type, which is always `organization.project.service_account`
            #
            #   @return [Symbol, :"organization.project.service_account"]
            required :object, const: :"organization.project.service_account"

            # @!attribute role
            #   `owner` or `member`
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectServiceAccount::Role]
            required :role, enum: -> { OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role }

            # @!method initialize(id:, created_at:, name:, role:, object: :"organization.project.service_account")
            #   Represents an individual service account in a project.
            #
            #   @param id [String] The identifier, which can be referenced in API endpoints
            #
            #   @param created_at [Integer] The Unix timestamp (in seconds) of when the service account was created
            #
            #   @param name [String] The name of the service account
            #
            #   @param role [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectServiceAccount::Role] `owner` or `member`
            #
            #   @param object [Symbol, :"organization.project.service_account"] The object type, which is always `organization.project.service_account`

            # `owner` or `member`
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ProjectServiceAccount#role
            module Role
              extend OpenAI::Internal::Type::Enum

              OWNER = :owner
              MEMBER = :member

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end

        ProjectServiceAccount = Projects::ProjectServiceAccount
      end
    end
  end
end
