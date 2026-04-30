# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class RoleDeleteResponse < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::Projects::RoleDeleteResponse,
                  OpenAI::Internal::AnyHash
                )
              end

            # Identifier of the deleted role.
            sig { returns(String) }
            attr_accessor :id

            # Whether the role was deleted.
            sig { returns(T::Boolean) }
            attr_accessor :deleted

            # Always `role.deleted`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Confirmation payload returned after deleting a role.
            sig do
              params(id: String, deleted: T::Boolean, object: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # Identifier of the deleted role.
              id:,
              # Whether the role was deleted.
              deleted:,
              # Always `role.deleted`.
              object: :"role.deleted"
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
