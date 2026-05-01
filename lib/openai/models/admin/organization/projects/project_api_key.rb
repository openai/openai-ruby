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
            #   @return [Integer, nil]
            required :last_used_at, Integer, nil?: true

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
            #   @param last_used_at [Integer, nil] The Unix timestamp (in seconds) of when the API key was last used.
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
              #   The service account that owns a project API key.
              #
              #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner::ServiceAccount, nil]
              optional :service_account,
                       -> { OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::ServiceAccount }

              # @!attribute type
              #   `user` or `service_account`
              #
              #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner::Type, nil]
              optional :type, enum: -> { OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type }

              # @!attribute user
              #   The user that owns a project API key.
              #
              #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner::User, nil]
              optional :user, -> { OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::User }

              # @!method initialize(service_account: nil, type: nil, user: nil)
              #   @param service_account [OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner::ServiceAccount] The service account that owns a project API key.
              #
              #   @param type [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner::Type] `user` or `service_account`
              #
              #   @param user [OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner::User] The user that owns a project API key.

              # @see OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner#service_account
              class ServiceAccount < OpenAI::Internal::Type::BaseModel
                # @!attribute id
                #   The identifier, which can be referenced in API endpoints
                #
                #   @return [String]
                required :id, String

                # @!attribute created_at
                #   The Unix timestamp (in seconds) of when the service account was created.
                #
                #   @return [Integer]
                required :created_at, Integer

                # @!attribute name
                #   The name of the service account.
                #
                #   @return [String]
                required :name, String

                # @!attribute role
                #   The service account's project role.
                #
                #   @return [String]
                required :role, String

                # @!method initialize(id:, created_at:, name:, role:)
                #   The service account that owns a project API key.
                #
                #   @param id [String] The identifier, which can be referenced in API endpoints
                #
                #   @param created_at [Integer] The Unix timestamp (in seconds) of when the service account was created.
                #
                #   @param name [String] The name of the service account.
                #
                #   @param role [String] The service account's project role.
              end

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

              # @see OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey::Owner#user
              class User < OpenAI::Internal::Type::BaseModel
                # @!attribute id
                #   The identifier, which can be referenced in API endpoints
                #
                #   @return [String]
                required :id, String

                # @!attribute created_at
                #   The Unix timestamp (in seconds) of when the user was created.
                #
                #   @return [Integer]
                required :created_at, Integer

                # @!attribute email
                #   The email address of the user.
                #
                #   @return [String]
                required :email, String

                # @!attribute name
                #   The name of the user.
                #
                #   @return [String]
                required :name, String

                # @!attribute role
                #   The user's project role.
                #
                #   @return [String]
                required :role, String

                # @!method initialize(id:, created_at:, email:, name:, role:)
                #   The user that owns a project API key.
                #
                #   @param id [String] The identifier, which can be referenced in API endpoints
                #
                #   @param created_at [Integer] The Unix timestamp (in seconds) of when the user was created.
                #
                #   @param email [String] The email address of the user.
                #
                #   @param name [String] The name of the user.
                #
                #   @param role [String] The user's project role.
              end
            end
          end
        end

        ProjectAPIKey = Projects::ProjectAPIKey
      end
    end
  end
end
