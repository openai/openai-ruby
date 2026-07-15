# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectServiceAccount = Projects::ProjectServiceAccount

        module Projects
          class ProjectServiceAccount < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectServiceAccount,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier, which can be referenced in API endpoints
            sig { returns(String) }
            attr_accessor :id

            # The Unix timestamp (in seconds) of when the service account was created
            sig { returns(Integer) }
            attr_accessor :created_at

            # The name of the service account
            sig { returns(String) }
            attr_accessor :name

            # The object type, which is always `organization.project.service_account`
            sig { returns(Symbol) }
            attr_accessor :object

            # `owner`, `member`, or `none`
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role::TaggedSymbol
              )
            end
            attr_accessor :role

            # Represents an individual service account in a project.
            sig do
              params(
                id: String,
                created_at: Integer,
                name: String,
                role:
                  OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role::OrSymbol,
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier, which can be referenced in API endpoints
              id:,
              # The Unix timestamp (in seconds) of when the service account was created
              created_at:,
              # The name of the service account
              name:,
              # `owner`, `member`, or `none`
              role:,
              # The object type, which is always `organization.project.service_account`
              object: :"organization.project.service_account"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  created_at: Integer,
                  name: String,
                  object: Symbol,
                  role:
                    OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            # `owner`, `member`, or `none`
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              OWNER =
                T.let(
                  :owner,
                  OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role::TaggedSymbol
                )
              MEMBER =
                T.let(
                  :member,
                  OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role::TaggedSymbol
                )
              NONE =
                T.let(
                  :none,
                  OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role::TaggedSymbol
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
