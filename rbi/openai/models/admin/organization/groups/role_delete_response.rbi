# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          class RoleDeleteResponse < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::Groups::RoleDeleteResponse,
                  OpenAI::Internal::AnyHash
                )
              end

            # Whether the assignment was removed.
            sig { returns(T::Boolean) }
            attr_accessor :deleted

            # Identifier for the deleted assignment, such as `group.role.deleted` or
            # `user.role.deleted`.
            sig { returns(String) }
            attr_accessor :object

            # Confirmation payload returned after unassigning a role.
            sig do
              params(deleted: T::Boolean, object: String).returns(
                T.attached_class
              )
            end
            def self.new(
              # Whether the assignment was removed.
              deleted:,
              # Identifier for the deleted assignment, such as `group.role.deleted` or
              # `user.role.deleted`.
              object:
            )
            end

            sig { override.returns({ deleted: T::Boolean, object: String }) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
