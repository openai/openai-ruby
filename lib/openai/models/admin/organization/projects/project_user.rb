# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Users#create
          class ProjectUser < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier, which can be referenced in API endpoints
            #
            #   @return [String]
            required :id, String

            # @!attribute added_at
            #   The Unix timestamp (in seconds) of when the project was added.
            #
            #   @return [Integer]
            required :added_at, Integer

            # @!attribute email
            #   The email address of the user
            #
            #   @return [String]
            required :email, String

            # @!attribute name
            #   The name of the user
            #
            #   @return [String]
            required :name, String

            # @!attribute object
            #   The object type, which is always `organization.project.user`
            #
            #   @return [Symbol, :"organization.project.user"]
            required :object, const: :"organization.project.user"

            # @!attribute role
            #   `owner` or `member`
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectUser::Role]
            required :role, enum: -> { OpenAI::Admin::Organization::Projects::ProjectUser::Role }

            # @!method initialize(id:, added_at:, email:, name:, role:, object: :"organization.project.user")
            #   Represents an individual user in a project.
            #
            #   @param id [String] The identifier, which can be referenced in API endpoints
            #
            #   @param added_at [Integer] The Unix timestamp (in seconds) of when the project was added.
            #
            #   @param email [String] The email address of the user
            #
            #   @param name [String] The name of the user
            #
            #   @param role [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectUser::Role] `owner` or `member`
            #
            #   @param object [Symbol, :"organization.project.user"] The object type, which is always `organization.project.user`

            # `owner` or `member`
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ProjectUser#role
            module Role
              extend OpenAI::Internal::Type::Enum

              OWNER = :owner
              MEMBER = :member

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end

        ProjectUser = Projects::ProjectUser
      end
    end
  end
end
