# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class RoleCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::RoleCreateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

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
                project_id: String,
                permissions: T::Array[String],
                role_name: String,
                description: T.nilable(String),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
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
                  project_id: String,
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
end
