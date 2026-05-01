# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class ProjectCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::ProjectCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

          # The friendly name of the project, this name appears in reports.
          sig { returns(String) }
          attr_accessor :name

          # External key ID to associate with the project.
          sig { returns(T.nilable(String)) }
          attr_accessor :external_key_id

          # Create the project with the specified data residency region. Your organization
          # must have access to Data residency functionality in order to use. See
          # [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
          # to review the functionality and limitations of setting this field.
          sig { returns(T.nilable(String)) }
          attr_accessor :geography

          sig do
            params(
              name: String,
              external_key_id: T.nilable(String),
              geography: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The friendly name of the project, this name appears in reports.
            name:,
            # External key ID to associate with the project.
            external_key_id: nil,
            # Create the project with the specified data residency region. Your organization
            # must have access to Data residency functionality in order to use. See
            # [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
            # to review the functionality and limitations of setting this field.
            geography: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                name: String,
                external_key_id: T.nilable(String),
                geography: T.nilable(String),
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
