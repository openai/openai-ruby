# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          class OrganizationGroupUser < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Groups::OrganizationGroupUser,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier, which can be referenced in API endpoints
            sig { returns(String) }
            attr_accessor :id

            # The email address of the user.
            sig { returns(T.nilable(String)) }
            attr_accessor :email

            # The name of the user.
            sig { returns(String) }
            attr_accessor :name

            # Represents an individual user returned when inspecting group membership.
            sig do
              params(
                id: String,
                email: T.nilable(String),
                name: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier, which can be referenced in API endpoints
              id:,
              # The email address of the user.
              email:,
              # The name of the user.
              name:
            )
            end

            sig do
              override.returns(
                { id: String, email: T.nilable(String), name: String }
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
