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

          # The updated name of the project, this name appears in reports.
          sig { returns(String) }
          attr_accessor :name

          sig do
            params(
              project_id: String,
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            project_id:,
            # The updated name of the project, this name appears in reports.
            name:,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                project_id: String,
                name: String,
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
