# typed: strong

module OpenAI
  module Models
    module Admin
      OrganizationSpendLimitDeleted =
        Organization::OrganizationSpendLimitDeleted

      module Organization
        class OrganizationSpendLimitDeleted < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::OrganizationSpendLimitDeleted,
                OpenAI::Internal::AnyHash
              )
            end

          # Whether the hard spend limit was deleted.
          sig { returns(T::Boolean) }
          attr_accessor :deleted

          # The object type, which is always `organization.spend_limit.deleted`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Confirmation payload returned after deleting an organization hard spend limit.
          sig do
            params(deleted: T::Boolean, object: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # Whether the hard spend limit was deleted.
            deleted:,
            # The object type, which is always `organization.spend_limit.deleted`.
            object: :"organization.spend_limit.deleted"
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
