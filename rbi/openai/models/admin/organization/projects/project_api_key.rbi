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
            sig { returns(Integer) }
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
                last_used_at: Integer,
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
                  last_used_at: Integer,
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

              # Represents an individual service account in a project.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::ProjectServiceAccount
                  )
                )
              end
              attr_reader :service_account

              sig do
                params(
                  service_account:
                    OpenAI::Admin::Organization::Projects::ProjectServiceAccount::OrHash
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

              # Represents an individual user in a project.
              sig do
                returns(
                  T.nilable(OpenAI::Admin::Organization::Projects::ProjectUser)
                )
              end
              attr_reader :user

              sig do
                params(
                  user:
                    OpenAI::Admin::Organization::Projects::ProjectUser::OrHash
                ).void
              end
              attr_writer :user

              sig do
                params(
                  service_account:
                    OpenAI::Admin::Organization::Projects::ProjectServiceAccount::OrHash,
                  type:
                    OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type::OrSymbol,
                  user:
                    OpenAI::Admin::Organization::Projects::ProjectUser::OrHash
                ).returns(T.attached_class)
              end
              def self.new(
                # Represents an individual service account in a project.
                service_account: nil,
                # `user` or `service_account`
                type: nil,
                # Represents an individual user in a project.
                user: nil
              )
              end

              sig do
                override.returns(
                  {
                    service_account:
                      OpenAI::Admin::Organization::Projects::ProjectServiceAccount,
                    type:
                      OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner::Type::TaggedSymbol,
                    user: OpenAI::Admin::Organization::Projects::ProjectUser
                  }
                )
              end
              def to_hash
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
            end
          end
        end
      end
    end
  end
end
