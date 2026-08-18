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

            # The object type, which is always `organization.project.user`
            sig { returns(Symbol) }
            attr_accessor :object

            # `owner` or `member`
            sig { returns(String) }
            attr_accessor :role

            # The email address of the user
            sig { returns(T.nilable(String)) }
            attr_accessor :email

            # The name of the user
            sig { returns(T.nilable(String)) }
            attr_accessor :name

            # Represents an individual user in a project.
            sig do
              params(
                id: String,
                added_at: Integer,
                role: String,
                email: T.nilable(String),
                name: T.nilable(String),
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier, which can be referenced in API endpoints
              id:,
              # The Unix timestamp (in seconds) of when the project was added.
              added_at:,
              # `owner` or `member`
              role:,
              # The email address of the user
              email: nil,
              # The name of the user
              name: nil,
              # The object type, which is always `organization.project.user`
              object: :"organization.project.user"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  added_at: Integer,
                  object: Symbol,
                  role: String,
                  email: T.nilable(String),
                  name: T.nilable(String)
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
