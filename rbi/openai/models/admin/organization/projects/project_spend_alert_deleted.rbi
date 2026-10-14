# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectSpendAlertDeleted = Projects::ProjectSpendAlertDeleted

        module Projects
          class ProjectSpendAlertDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectSpendAlertDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The deleted spend alert ID.
            sig { returns(String) }
            attr_accessor :id

            # Whether the spend alert was deleted.
            sig { returns(T::Boolean) }
            attr_accessor :deleted

            # Always `project.spend_alert.deleted`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Confirmation payload returned after deleting a project spend alert.
            sig do
              params(id: String, deleted: T::Boolean, object: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # The deleted spend alert ID.
              id:,
              # Whether the spend alert was deleted.
              deleted:,
              # Always `project.spend_alert.deleted`.
              object: :"project.spend_alert.deleted"
            )
            end

            sig do
              override.returns(
                { id: String, deleted: T::Boolean, object: Symbol }
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
