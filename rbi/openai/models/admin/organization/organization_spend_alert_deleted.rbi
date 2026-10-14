# typed: strong

module OpenAI
  module Models
    module Admin
      OrganizationSpendAlertDeleted =
        Organization::OrganizationSpendAlertDeleted

      module Organization
        class OrganizationSpendAlertDeleted < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::OrganizationSpendAlertDeleted,
                OpenAI::Internal::AnyHash
              )
            end

          # The deleted spend alert ID.
          sig { returns(String) }
          attr_accessor :id

          # Whether the spend alert was deleted.
          sig { returns(T::Boolean) }
          attr_accessor :deleted

          # Always `organization.spend_alert.deleted`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Confirmation payload returned after deleting an organization spend alert.
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
            # Always `organization.spend_alert.deleted`.
            object: :"organization.spend_alert.deleted"
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
