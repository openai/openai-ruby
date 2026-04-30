# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectUser = Projects::ProjectUser

        module Projects
          class ProjectUser < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectUser,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier, which can be referenced in API endpoints
            sig { returns(String) }
            attr_accessor :id

            # The Unix timestamp (in seconds) of when the project was added.
            sig { returns(Integer) }
            attr_accessor :added_at

            # The email address of the user
            sig { returns(String) }
            attr_accessor :email

            # The name of the user
            sig { returns(String) }
            attr_accessor :name

            # The object type, which is always `organization.project.user`
            sig { returns(Symbol) }
            attr_accessor :object

            # `owner` or `member`
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectUser::Role::TaggedSymbol
              )
            end
            attr_accessor :role

            # Represents an individual user in a project.
            sig do
              params(
                id: String,
                added_at: Integer,
                email: String,
                name: String,
                role:
                  OpenAI::Admin::Organization::Projects::ProjectUser::Role::OrSymbol,
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier, which can be referenced in API endpoints
              id:,
              # The Unix timestamp (in seconds) of when the project was added.
              added_at:,
              # The email address of the user
              email:,
              # The name of the user
              name:,
              # `owner` or `member`
              role:,
              # The object type, which is always `organization.project.user`
              object: :"organization.project.user"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  added_at: Integer,
                  email: String,
                  name: String,
                  object: Symbol,
                  role:
                    OpenAI::Admin::Organization::Projects::ProjectUser::Role::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            # `owner` or `member`
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::ProjectUser::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              OWNER =
                T.let(
                  :owner,
                  OpenAI::Admin::Organization::Projects::ProjectUser::Role::TaggedSymbol
                )
              MEMBER =
                T.let(
                  :member,
                  OpenAI::Admin::Organization::Projects::ProjectUser::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::ProjectUser::Role::TaggedSymbol
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
