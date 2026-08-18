# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class Role < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Role,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier for the role.
          sig { returns(String) }
          attr_accessor :id

          # Optional description of the role.
          sig { returns(T.nilable(String)) }
          attr_accessor :description

          # Unique name for the role.
          sig { returns(String) }
          attr_accessor :name

          # Always `role`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Permissions granted by the role.
          sig { returns(T::Array[String]) }
          attr_accessor :permissions

          # Whether the role is predefined and managed by OpenAI.
          sig { returns(T::Boolean) }
          attr_accessor :predefined_role

          # Resource type the role is bound to (for example `api.organization` or
          # `api.project`).
          sig { returns(String) }
          attr_accessor :resource_type

          # Details about a role that can be assigned through the public Roles API.
          sig do
            params(
              id: String,
              description: T.nilable(String),
              name: String,
              permissions: T::Array[String],
              predefined_role: T::Boolean,
              resource_type: String,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier for the role.
            id:,
            # Optional description of the role.
            description:,
            # Unique name for the role.
            name:,
            # Permissions granted by the role.
            permissions:,
            # Whether the role is predefined and managed by OpenAI.
            predefined_role:,
            # Resource type the role is bound to (for example `api.organization` or
            # `api.project`).
            resource_type:,
            # Always `role`.
            object: :role
          )
          end

          sig do
            override.returns(
              {
                id: String,
                description: T.nilable(String),
                name: String,
                object: Symbol,
                permissions: T::Array[String],
                predefined_role: T::Boolean,
                resource_type: String
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
