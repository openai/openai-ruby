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

            # @!attribute object
            #   The object type, which is always `organization.project.user`
            #
            #   @return [Symbol, :"organization.project.user"]
            required :object, const: :"organization.project.user"

            # @!attribute role
            #   `owner` or `member`
            #
            #   @return [String]
            required :role, String

            # @!attribute email
            #   The email address of the user
            #
            #   @return [String, nil]
            optional :email, String, nil?: true

            # @!attribute name
            #   The name of the user
            #
            #   @return [String, nil]
            optional :name, String, nil?: true

            # @!method initialize(id:, added_at:, role:, email: nil, name: nil, object: :"organization.project.user")
            #   Represents an individual user in a project.
            #
            #   @param id [String] The identifier, which can be referenced in API endpoints
            #
            #   @param added_at [Integer] The Unix timestamp (in seconds) of when the project was added.
            #
            #   @param role [String] `owner` or `member`
            #
            #   @param email [String, nil] The email address of the user
            #
            #   @param name [String, nil] The name of the user
            #
            #   @param object [Symbol, :"organization.project.user"] The object type, which is always `organization.project.user`
          end
        end

        ProjectUser = Projects::ProjectUser
      end
    end
  end
end
