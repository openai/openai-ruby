# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class GroupDeleteResponse < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::Projects::GroupDeleteResponse,
                  OpenAI::Internal::AnyHash
                )
              end

            # Whether the group membership in the project was removed.
            sig { returns(T::Boolean) }
            attr_accessor :deleted

            # Always `project.group.deleted`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Confirmation payload returned after removing a group from a project.
            sig do
              params(deleted: T::Boolean, object: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # Whether the group membership in the project was removed.
              deleted:,
              # Always `project.group.deleted`.
              object: :"project.group.deleted"
            )
            end

            sig { override.returns({ deleted: T::Boolean, object: Symbol }) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
