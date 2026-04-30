# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          # @see OpenAI::Resources::Admin::Organization::Groups::Roles#list
          class RoleListResponse < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   Identifier for the role.
            #
            #   @return [String]
            required :id, String

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

            # @!method initialize(id:, created_at:, created_by:, created_by_user_obj:, description:, metadata:, name:, permissions:, predefined_role:, resource_type:, updated_at:)
            #   Detailed information about a role assignment entry returned when listing
            #   assignments.
            #
            #   @param id [String] Identifier for the role.
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
          end
        end
      end
    end
  end
end
