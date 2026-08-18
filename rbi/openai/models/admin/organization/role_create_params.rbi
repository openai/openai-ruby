# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class RoleCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::RoleCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

          # Permissions to grant to the role.
          sig { returns(T::Array[String]) }
          attr_accessor :permissions

          # Unique name for the role.
          sig { returns(String) }
          attr_accessor :role_name

          # Optional description of the role.
          sig { returns(T.nilable(String)) }
          attr_accessor :description

          sig do
            params(
              permissions: T::Array[String],
              role_name: String,
              description: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Permissions to grant to the role.
            permissions:,
            # Unique name for the role.
            role_name:,
            # Optional description of the role.
            description: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                permissions: T::Array[String],
                role_name: String,
                description: T.nilable(String),
                request_options: OpenAI::RequestOptions
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
