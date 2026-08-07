# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Roles#create
        class Role < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier for the role.
          #
          #   @return [String]
          required :id, String

          # @!attribute description
          #   Optional description of the role.
          #
          #   @return [String, nil]
          required :description, String, nil?: true

          # @!attribute name
          #   Unique name for the role.
          #
          #   @return [String]
          required :name, String

          # @!attribute object
          #   Always `role`.
          #
          #   @return [Symbol, :role]
          required :object, const: :role

          # @!attribute permissions
          #   Permissions granted by the role.
          #
          #   @return [Array<String>]
          required :permissions, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute predefined_role
          #   Whether the role is predefined and managed by OpenAI.
          #
          #   @return [Boolean]
          required :predefined_role, OpenAI::Internal::Type::Boolean

          # @!attribute resource_type
          #   Resource type the role is bound to (for example `api.organization` or
          #   `api.project`).
          #
          #   @return [String]
          required :resource_type, String

          # @!method initialize(id:, description:, name:, permissions:, predefined_role:, resource_type:, object: :role)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::Role} for more details.
          #
          #   Details about a role that can be assigned through the public Roles API.
          #
          #   @param id [String] Identifier for the role.
          #
          #   @param description [String, nil] Optional description of the role.
          #
          #   @param name [String] Unique name for the role.
          #
          #   @param permissions [Array<String>] Permissions granted by the role.
          #
          #   @param predefined_role [Boolean] Whether the role is predefined and managed by OpenAI.
          #
          #   @param resource_type [String] Resource type the role is bound to (for example `api.organization` or `api.proje
          #
          #   @param object [Symbol, :role] Always `role`.
        end
      end
    end
  end
end
