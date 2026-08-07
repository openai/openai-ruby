# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ModelPermissions#retrieve
          class ProjectModelPermissions < OpenAI::Internal::Type::BaseModel
            # @!attribute mode
            #   Whether the project uses an allowlist or a denylist.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectModelPermissions::Mode]
            required :mode, enum: -> { OpenAI::Admin::Organization::Projects::ProjectModelPermissions::Mode }

            # @!attribute model_ids
            #   The model IDs included in the model permissions policy.
            #
            #   @return [Array<String>]
            required :model_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute object
            #   The object type, which is always `project.model_permissions`.
            #
            #   @return [Symbol, :"project.model_permissions"]
            required :object, const: :"project.model_permissions"

            # @!method initialize(mode:, model_ids:, object: :"project.model_permissions")
            #   Represents the model allowlist or denylist policy for a project.
            #
            #   @param mode [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectModelPermissions::Mode] Whether the project uses an allowlist or a denylist.
            #
            #   @param model_ids [Array<String>] The model IDs included in the model permissions policy.
            #
            #   @param object [Symbol, :"project.model_permissions"] The object type, which is always `project.model_permissions`.

            # Whether the project uses an allowlist or a denylist.
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ProjectModelPermissions#mode
            module Mode
              extend OpenAI::Internal::Type::Enum

              ALLOW_LIST = :allow_list
              DENY_LIST = :deny_list

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end

        ProjectModelPermissions = Projects::ProjectModelPermissions
      end
    end
  end
end
