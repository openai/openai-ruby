# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectModelPermissions = Projects::ProjectModelPermissions

        module Projects
          class ProjectModelPermissions < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectModelPermissions,
                  OpenAI::Internal::AnyHash
                )
              end

            # Whether the project uses an allowlist or a denylist.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectModelPermissions::Mode::TaggedSymbol
              )
            end
            attr_accessor :mode

            # The model IDs included in the model permissions policy.
            sig { returns(T::Array[String]) }
            attr_accessor :model_ids

            # The object type, which is always `project.model_permissions`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Represents the model allowlist or denylist policy for a project.
            sig do
              params(
                mode:
                  OpenAI::Admin::Organization::Projects::ProjectModelPermissions::Mode::OrSymbol,
                model_ids: T::Array[String],
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Whether the project uses an allowlist or a denylist.
              mode:,
              # The model IDs included in the model permissions policy.
              model_ids:,
              # The object type, which is always `project.model_permissions`.
              object: :"project.model_permissions"
            )
            end

            sig do
              override.returns(
                {
                  mode:
                    OpenAI::Admin::Organization::Projects::ProjectModelPermissions::Mode::TaggedSymbol,
                  model_ids: T::Array[String],
                  object: Symbol
                }
              )
            end
            def to_hash
            end

            # Whether the project uses an allowlist or a denylist.
            module Mode
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::ProjectModelPermissions::Mode
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ALLOW_LIST =
                T.let(
                  :allow_list,
                  OpenAI::Admin::Organization::Projects::ProjectModelPermissions::Mode::TaggedSymbol
                )
              DENY_LIST =
                T.let(
                  :deny_list,
                  OpenAI::Admin::Organization::Projects::ProjectModelPermissions::Mode::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::ProjectModelPermissions::Mode::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end
        end
      end
    end
  end
end
