# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          class UserDeleteResponse < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::Groups::UserDeleteResponse,
                  OpenAI::Internal::AnyHash
                )
              end

            # Whether the group membership was removed.
            sig { returns(T::Boolean) }
            attr_accessor :deleted

            # Always `group.user.deleted`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Confirmation payload returned after removing a user from a group.
            sig do
              params(deleted: T::Boolean, object: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # Whether the group membership was removed.
              deleted:,
              # Always `group.user.deleted`.
              object: :"group.user.deleted"
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
