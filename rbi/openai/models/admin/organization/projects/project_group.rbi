# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectGroup = Projects::ProjectGroup

        module Projects
          class ProjectGroup < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectGroup,
                  OpenAI::Internal::AnyHash
                )
              end

            # Unix timestamp (in seconds) when the group was granted project access.
            sig { returns(Integer) }
            attr_accessor :created_at

            # Identifier of the group that has access to the project.
            sig { returns(String) }
            attr_accessor :group_id

            # Display name of the group.
            sig { returns(String) }
            attr_accessor :group_name

            # The type of the group.
            sig { returns(String) }
            attr_accessor :group_type

            # Always `project.group`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Identifier of the project.
            sig { returns(String) }
            attr_accessor :project_id

            # Details about a group's membership in a project.
            sig do
              params(
                created_at: Integer,
                group_id: String,
                group_name: String,
                group_type: String,
                project_id: String,
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Unix timestamp (in seconds) when the group was granted project access.
              created_at:,
              # Identifier of the group that has access to the project.
              group_id:,
              # Display name of the group.
              group_name:,
              # The type of the group.
              group_type:,
              # Identifier of the project.
              project_id:,
              # Always `project.group`.
              object: :"project.group"
            )
            end

            sig do
              override.returns(
                {
                  created_at: Integer,
                  group_id: String,
                  group_name: String,
                  group_type: String,
                  object: Symbol,
                  project_id: String
                }
              )
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
