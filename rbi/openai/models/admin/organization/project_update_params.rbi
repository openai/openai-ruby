# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class ProjectUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::ProjectUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :project_id

          # External key ID to associate with the project.
          sig { returns(T.nilable(String)) }
          attr_accessor :external_key_id

          # Geography for the project.
          sig { returns(T.nilable(String)) }
          attr_accessor :geography

          # The updated name of the project, this name appears in reports.
          sig { returns(T.nilable(String)) }
          attr_accessor :name

          sig do
            params(
              project_id: String,
              external_key_id: T.nilable(String),
              geography: T.nilable(String),
              name: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            project_id:,
            # External key ID to associate with the project.
            external_key_id: nil,
            # Geography for the project.
            geography: nil,
            # The updated name of the project, this name appears in reports.
            name: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                project_id: String,
                external_key_id: T.nilable(String),
                geography: T.nilable(String),
                name: T.nilable(String),
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
