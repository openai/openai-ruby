# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectSpendLimitDeleted = Projects::ProjectSpendLimitDeleted

        module Projects
          class ProjectSpendLimitDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectSpendLimitDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # Whether the hard spend limit was deleted.
            sig { returns(T::Boolean) }
            attr_accessor :deleted

            # The object type, which is always `project.spend_limit.deleted`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Confirmation payload returned after deleting a project hard spend limit.
            sig do
              params(deleted: T::Boolean, object: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # Whether the hard spend limit was deleted.
              deleted:,
              # The object type, which is always `project.spend_limit.deleted`.
              object: :"project.spend_limit.deleted"
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
