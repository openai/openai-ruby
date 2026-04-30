# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::APIKeys#retrieve
          class ProjectAPIKey < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier, which can be referenced in API endpoints
            #
            #   @return [String]
            required :id, String

            # @!attribute created_at
            #   The Unix timestamp (in seconds) of when the API key was created
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute last_used_at
            #   The Unix timestamp (in seconds) of when the API key was last used.
            #
            #   @return [Integer]
            required :last_used_at, Integer

            # @!attribute name
            #   The name of the API key
            #
            #   @return [String]
            required :name, String

            # @!attribute object
            #   The object type, which is always `organization.project.api_key`
            #
            #   @return [Symbol, :"organization.project.api_key"]
            required :object, const: :"organization.project.api_key"

            # @!attribute owner
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner]
            required :owner, -> { OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner }

            # @!attribute redacted_value
            #   The redacted value of the API key
            #
            #   @return [String]
            required :redacted_value, String

            # @!method initialize(id:, created_at:, last_used_at:, name:, owner:, redacted_value:, object: :"organization.project.api_key")
            #   Represents an individual API key in a project.
            #
            #   @param id [String] The identifier, which can be referenced in API endpoints
            #
            #   @param created_at [Integer] The Unix timestamp (in seconds) of when the API key was created
            #
            #   @param last_used_at [Integer] The Unix timestamp (in seconds) of when the API key was last used.
            #
            #   @param name [String] The name of the API key
            #
            #   @param owner [OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner]
            #
            #   @param redacted_value [String] The redacted value of the API key
            #
            #   @param object [Symbol, :"organization.project.api_key"] The object type, which is always `organization.project.api_key`

            # @see OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey#owner
            class Owner < OpenAI::Internal::Type::BaseModel
              # @!attribute service_account
              #   Represents an individual service account in a project.
              #
              #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectServiceAccount, nil]
              optional :service_account, -> { OpenAI::Admin::Organization::Projects::ProjectServiceAccount }

              # @!attribute type
              #   `user` or `service_account`
              #
              #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner::Type, nil]
              optional :type, enum: -> { OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type }

              # @!attribute user
              #   Represents an individual user in a project.
              #
              #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectUser, nil]
              optional :user, -> { OpenAI::Admin::Organization::Projects::ProjectUser }

              # @!method initialize(service_account: nil, type: nil, user: nil)
              #   @param service_account [OpenAI::Models::Admin::Organization::Projects::ProjectServiceAccount] Represents an individual service account in a project.
              #
              #   @param type [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner::Type] `user` or `service_account`
              #
              #   @param user [OpenAI::Models::Admin::Organization::Projects::ProjectUser] Represents an individual user in a project.

              # `user` or `service_account`
              #
              # @see OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner#type
              module Type
                extend OpenAI::Internal::Type::Enum

                USER = :user
                SERVICE_ACCOUNT = :service_account

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end
          end
        end

        ProjectAPIKey = Projects::ProjectAPIKey
      end
    end
  end
end
