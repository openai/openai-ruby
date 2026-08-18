# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          class UserCreateResponse < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::Groups::UserCreateResponse,
                  OpenAI::Internal::AnyHash
                )
              end

            # Identifier of the group the user was added to.
            sig { returns(String) }
            attr_accessor :group_id

            # Always `group.user`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Identifier of the user that was added.
            sig { returns(String) }
            attr_accessor :user_id

            # Confirmation payload returned after adding a user to a group.
            sig do
              params(group_id: String, user_id: String, object: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # Identifier of the group the user was added to.
              group_id:,
              # Identifier of the user that was added.
              user_id:,
              # Always `group.user`.
              object: :"group.user"
            )
            end

            sig do
              override.returns(
                { group_id: String, object: Symbol, user_id: String }
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
