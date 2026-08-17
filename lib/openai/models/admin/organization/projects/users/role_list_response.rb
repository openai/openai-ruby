# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module Users
            # @see OpenAI::Resources::Admin::Organization::Projects::Users::Roles#list
            class RoleListResponse < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   Identifier for the role.
              #
              #   @return [String]
              required :id, String

              # @!attribute assignment_sources
              #   Principals from which the role assignment is inherited, when available.
              #
              #   @return [Array<OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse::AssignmentSource>, nil]
              required :assignment_sources,
                       -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse::AssignmentSource] },
                       nil?: true

              # @!attribute created_at
              #   When the role was created.
              #
              #   @return [Integer, nil]
              required :created_at, Integer, nil?: true

              # @!attribute created_by
              #   Identifier of the actor who created the role.
              #
              #   @return [String, nil]
              required :created_by, String, nil?: true

              # @!attribute created_by_user_obj
              #   User details for the actor that created the role, when available.
              #
              #   @return [Hash{Symbol=>Object}, nil]
              required :created_by_user_obj,
                       OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown],
                       nil?: true

              # @!attribute description
              #   Description of the role.
              #
              #   @return [String, nil]
              required :description, String, nil?: true

              # @!attribute metadata
              #   Arbitrary metadata stored on the role.
              #
              #   @return [Hash{Symbol=>Object}, nil]
              required :metadata, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown], nil?: true

              # @!attribute name
              #   Name of the role.
              #
              #   @return [String]
              required :name, String

              # @!attribute permissions
              #   Permissions associated with the role.
              #
              #   @return [Array<String>]
              required :permissions, OpenAI::Internal::Type::ArrayOf[String]

              # @!attribute predefined_role
              #   Whether the role is predefined by OpenAI.
              #
              #   @return [Boolean]
              required :predefined_role, OpenAI::Internal::Type::Boolean

              # @!attribute resource_type
              #   Resource type the role applies to.
              #
              #   @return [String]
              required :resource_type, String

              # @!attribute updated_at
              #   When the role was last updated.
              #
              #   @return [Integer, nil]
              required :updated_at, Integer, nil?: true

              # @!method initialize(id:, assignment_sources:, created_at:, created_by:, created_by_user_obj:, description:, metadata:, name:, permissions:, predefined_role:, resource_type:, updated_at:)
              #   Detailed information about a role assignment entry returned when listing
              #   assignments.
              #
              #   @param id [String] Identifier for the role.
              #
              #   @param assignment_sources [Array<OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse::AssignmentSource>, nil] Principals from which the role assignment is inherited, when available.
              #
              #   @param created_at [Integer, nil] When the role was created.
              #
              #   @param created_by [String, nil] Identifier of the actor who created the role.
              #
              #   @param created_by_user_obj [Hash{Symbol=>Object}, nil] User details for the actor that created the role, when available.
              #
              #   @param description [String, nil] Description of the role.
              #
              #   @param metadata [Hash{Symbol=>Object}, nil] Arbitrary metadata stored on the role.
              #
              #   @param name [String] Name of the role.
              #
              #   @param permissions [Array<String>] Permissions associated with the role.
              #
              #   @param predefined_role [Boolean] Whether the role is predefined by OpenAI.
              #
              #   @param resource_type [String] Resource type the role applies to.
              #
              #   @param updated_at [Integer, nil] When the role was last updated.

              class AssignmentSource < OpenAI::Internal::Type::BaseModel
                # @!attribute principal_id
                #
                #   @return [String]
                required :principal_id, String

                # @!attribute principal_type
                #
                #   @return [String]
                required :principal_type, String

                # @!method initialize(principal_id:, principal_type:)
                #   @param principal_id [String]
                #   @param principal_type [String]
              end
            end
          end
        end
      end
    end
  end
end
