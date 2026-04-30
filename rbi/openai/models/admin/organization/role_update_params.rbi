# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class RoleUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::RoleUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :role_id

          # New description for the role.
          sig { returns(T.nilable(String)) }
          attr_accessor :description

          # Updated set of permissions for the role.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :permissions

          # New name for the role.
          sig { returns(T.nilable(String)) }
          attr_accessor :role_name

          sig do
            params(
              role_id: String,
              description: T.nilable(String),
              permissions: T.nilable(T::Array[String]),
              role_name: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            role_id:,
            # New description for the role.
            description: nil,
            # Updated set of permissions for the role.
            permissions: nil,
            # New name for the role.
            role_name: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                role_id: String,
                description: T.nilable(String),
                permissions: T.nilable(T::Array[String]),
                role_name: T.nilable(String),
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
