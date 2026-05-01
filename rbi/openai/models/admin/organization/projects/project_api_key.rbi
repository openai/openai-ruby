# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectAPIKey = Projects::ProjectAPIKey

        module Projects
          class ProjectAPIKey < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectAPIKey,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier, which can be referenced in API endpoints
            sig { returns(String) }
            attr_accessor :id

            # The Unix timestamp (in seconds) of when the API key was created
            sig { returns(Integer) }
            attr_accessor :created_at

            # The Unix timestamp (in seconds) of when the API key was last used.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :last_used_at

            # The name of the API key
            sig { returns(String) }
            attr_accessor :name

            # The object type, which is always `organization.project.api_key`
            sig { returns(Symbol) }
            attr_accessor :object

            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner
              )
            end
            attr_reader :owner

            sig do
              params(
                owner:
                  OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::OrHash
              ).void
            end
            attr_writer :owner

            # The redacted value of the API key
            sig { returns(String) }
            attr_accessor :redacted_value

            # Represents an individual API key in a project.
            sig do
              params(
                id: String,
                created_at: Integer,
                last_used_at: T.nilable(Integer),
                name: String,
                owner:
                  OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::OrHash,
                redacted_value: String,
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier, which can be referenced in API endpoints
              id:,
              # The Unix timestamp (in seconds) of when the API key was created
              created_at:,
              # The Unix timestamp (in seconds) of when the API key was last used.
              last_used_at:,
              # The name of the API key
              name:,
              owner:,
              # The redacted value of the API key
              redacted_value:,
              # The object type, which is always `organization.project.api_key`
              object: :"organization.project.api_key"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  created_at: Integer,
                  last_used_at: T.nilable(Integer),
                  name: String,
                  object: Symbol,
                  owner:
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner,
                  redacted_value: String
                }
              )
            end
            def to_hash
            end

            class Owner < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The service account that owns a project API key.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::ServiceAccount
                  )
                )
              end
              attr_reader :service_account

              sig do
                params(
                  service_account:
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::ServiceAccount::OrHash
                ).void
              end
              attr_writer :service_account

              # `user` or `service_account`
              sig do
                returns(
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type::TaggedSymbol
                  )
                )
              end
              attr_reader :type

              sig do
                params(
                  type:
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type::OrSymbol
                ).void
              end
              attr_writer :type

              # The user that owns a project API key.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::User
                  )
                )
              end
              attr_reader :user

              sig do
                params(
                  user:
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::User::OrHash
                ).void
              end
              attr_writer :user

              sig do
                params(
                  service_account:
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::ServiceAccount::OrHash,
                  type:
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type::OrSymbol,
                  user:
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::User::OrHash
                ).returns(T.attached_class)
              end
              def self.new(
                # The service account that owns a project API key.
                service_account: nil,
                # `user` or `service_account`
                type: nil,
                # The user that owns a project API key.
                user: nil
              )
              end

              sig do
                override.returns(
                  {
                    service_account:
                      OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::ServiceAccount,
                    type:
                      OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type::TaggedSymbol,
                    user:
                      OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::User
                  }
                )
              end
              def to_hash
              end

              class ServiceAccount < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::ServiceAccount,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The identifier, which can be referenced in API endpoints
                sig { returns(String) }
                attr_accessor :id

                # The Unix timestamp (in seconds) of when the service account was created.
                sig { returns(Integer) }
                attr_accessor :created_at

                # The name of the service account.
                sig { returns(String) }
                attr_accessor :name

                # The service account's project role.
                sig { returns(String) }
                attr_accessor :role

                # The service account that owns a project API key.
                sig do
                  params(
                    id: String,
                    created_at: Integer,
                    name: String,
                    role: String
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The identifier, which can be referenced in API endpoints
                  id:,
                  # The Unix timestamp (in seconds) of when the service account was created.
                  created_at:,
                  # The name of the service account.
                  name:,
                  # The service account's project role.
                  role:
                )
                end

                sig do
                  override.returns(
                    {
                      id: String,
                      created_at: Integer,
                      name: String,
                      role: String
                    }
                  )
                end
                def to_hash
                end
              end

              # `user` or `service_account`
              module Type
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                USER =
                  T.let(
                    :user,
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type::TaggedSymbol
                  )
                SERVICE_ACCOUNT =
                  T.let(
                    :service_account,
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end

              class User < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::User,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The identifier, which can be referenced in API endpoints
                sig { returns(String) }
                attr_accessor :id

                # The Unix timestamp (in seconds) of when the user was created.
                sig { returns(Integer) }
                attr_accessor :created_at

                # The email address of the user.
                sig { returns(String) }
                attr_accessor :email

                # The name of the user.
                sig { returns(String) }
                attr_accessor :name

                # The user's project role.
                sig { returns(String) }
                attr_accessor :role

                # The user that owns a project API key.
                sig do
                  params(
                    id: String,
                    created_at: Integer,
                    email: String,
                    name: String,
                    role: String
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The identifier, which can be referenced in API endpoints
                  id:,
                  # The Unix timestamp (in seconds) of when the user was created.
                  created_at:,
                  # The email address of the user.
                  email:,
                  # The name of the user.
                  name:,
                  # The user's project role.
                  role:
                )
                end

                sig do
                  override.returns(
                    {
                      id: String,
                      created_at: Integer,
                      email: String,
                      name: String,
                      role: String
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
  end
end
