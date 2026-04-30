# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class GroupDeleteResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Admin::Organization::GroupDeleteResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier of the deleted group.
          sig { returns(String) }
          attr_accessor :id

          # Whether the group was deleted.
          sig { returns(T::Boolean) }
          attr_accessor :deleted

          # Always `group.deleted`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Confirmation payload returned after deleting a group.
          sig do
            params(id: String, deleted: T::Boolean, object: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # Identifier of the deleted group.
            id:,
            # Whether the group was deleted.
            deleted:,
            # Always `group.deleted`.
            object: :"group.deleted"
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
