# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class Project < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
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

          # The residency configuration for the project.
          sig { returns(T.nilable(OpenAI::Admin::Organization::Project::Residency::TaggedSymbol)) }
          attr_reader :residency

          sig { params(residency: OpenAI::Admin::Organization::Project::Residency::OrSymbol).void }
          attr_writer :residency

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

              residency: OpenAI::Admin::Organization::Project::Residency::OrSymbol,

              status: T.nilable(String),

              object: Symbol
            )
              .returns(T.attached_class)
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

            # The residency configuration for the project.
            residency: nil,

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
                residency: OpenAI::Admin::Organization::Project::Residency::TaggedSymbol,
                status: T.nilable(String)
              }
            )
          end
          def to_hash
          end

          # The residency configuration for the project.
          module Residency
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Admin::Organization::Project::Residency) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            GLOBAL = T.let(:GLOBAL, OpenAI::Admin::Organization::Project::Residency::TaggedSymbol)
            US_STORAGE_PROCESSING = T.let(
              :US_STORAGE_PROCESSING,
              OpenAI::Admin::Organization::Project::Residency::TaggedSymbol
            )
            EU_STORAGE_PROCESSING = T.let(
              :EU_STORAGE_PROCESSING,
              OpenAI::Admin::Organization::Project::Residency::TaggedSymbol
            )
            JP_STORAGE = T.let(:JP_STORAGE, OpenAI::Admin::Organization::Project::Residency::TaggedSymbol)
            KR_STORAGE = T.let(:KR_STORAGE, OpenAI::Admin::Organization::Project::Residency::TaggedSymbol)
            CA_STORAGE = T.let(:CA_STORAGE, OpenAI::Admin::Organization::Project::Residency::TaggedSymbol)
            SG_STORAGE = T.let(:SG_STORAGE, OpenAI::Admin::Organization::Project::Residency::TaggedSymbol)
            IN_STORAGE = T.let(:IN_STORAGE, OpenAI::Admin::Organization::Project::Residency::TaggedSymbol)
            AU_STORAGE = T.let(:AU_STORAGE, OpenAI::Admin::Organization::Project::Residency::TaggedSymbol)
            GB_STORAGE = T.let(:GB_STORAGE, OpenAI::Admin::Organization::Project::Residency::TaggedSymbol)
            AE_STORAGE = T.let(:AE_STORAGE, OpenAI::Admin::Organization::Project::Residency::TaggedSymbol)
            AE_STORAGE_PROCESSING = T.let(
              :AE_STORAGE_PROCESSING,
              OpenAI::Admin::Organization::Project::Residency::TaggedSymbol
            )

            sig { override.returns(T::Array[OpenAI::Admin::Organization::Project::Residency::TaggedSymbol]) }
            def self.values
            end
          end

        end

      end

    end

  end
end
