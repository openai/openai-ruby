# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class Project < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Project,
                OpenAI::Internal::AnyHash
              )
            end

          # The identifier, which can be referenced in API endpoints
          sig { returns(String) }
          attr_accessor :id

          # The Unix timestamp (in seconds) of when the project was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # The object type, which is always `organization.project`
          sig { returns(Symbol) }
          attr_accessor :object

          # The Unix timestamp (in seconds) of when the project was archived or `null`.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :archived_at

          # The external key associated with the project.
          sig { returns(T.nilable(String)) }
          attr_accessor :external_key_id

          # The name of the project. This appears in reporting.
          sig { returns(T.nilable(String)) }
          attr_accessor :name

          # `active` or `archived`
          sig { returns(T.nilable(String)) }
          attr_accessor :status

          # Represents an individual project.
          sig do
            params(
              id: String,
              created_at: Integer,
              archived_at: T.nilable(Integer),
              external_key_id: T.nilable(String),
              name: T.nilable(String),
              status: T.nilable(String),
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The identifier, which can be referenced in API endpoints
            id:,
            # The Unix timestamp (in seconds) of when the project was created.
            created_at:,
            # The Unix timestamp (in seconds) of when the project was archived or `null`.
            archived_at: nil,
            # The external key associated with the project.
            external_key_id: nil,
            # The name of the project. This appears in reporting.
            name: nil,
            # `active` or `archived`
            status: nil,
            # The object type, which is always `organization.project`
            object: :"organization.project"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                object: Symbol,
                archived_at: T.nilable(Integer),
                external_key_id: T.nilable(String),
                name: T.nilable(String),
                status: T.nilable(String)
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
