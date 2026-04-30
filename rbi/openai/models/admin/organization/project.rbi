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

          # The name of the project. This appears in reporting.
          sig { returns(String) }
          attr_accessor :name

          # The object type, which is always `organization.project`
          sig { returns(Symbol) }
          attr_accessor :object

          # `active` or `archived`
          sig do
            returns(OpenAI::Admin::Organization::Project::Status::TaggedSymbol)
          end
          attr_accessor :status

          # The Unix timestamp (in seconds) of when the project was archived or `null`.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :archived_at

          # Represents an individual project.
          sig do
            params(
              id: String,
              created_at: Integer,
              name: String,
              status: OpenAI::Admin::Organization::Project::Status::OrSymbol,
              archived_at: T.nilable(Integer),
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The identifier, which can be referenced in API endpoints
            id:,
            # The Unix timestamp (in seconds) of when the project was created.
            created_at:,
            # The name of the project. This appears in reporting.
            name:,
            # `active` or `archived`
            status:,
            # The Unix timestamp (in seconds) of when the project was archived or `null`.
            archived_at: nil,
            # The object type, which is always `organization.project`
            object: :"organization.project"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                name: String,
                object: Symbol,
                status:
                  OpenAI::Admin::Organization::Project::Status::TaggedSymbol,
                archived_at: T.nilable(Integer)
              }
            )
          end
          def to_hash
          end

          # `active` or `archived`
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Admin::Organization::Project::Status)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ACTIVE =
              T.let(
                :active,
                OpenAI::Admin::Organization::Project::Status::TaggedSymbol
              )
            ARCHIVED =
              T.let(
                :archived,
                OpenAI::Admin::Organization::Project::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::Project::Status::TaggedSymbol
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
