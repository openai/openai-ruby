# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class ServiceAccountCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ServiceAccountCreateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # The name of the service account being created.
            sig { returns(String) }
            attr_accessor :name

            # Create the service account without default roles or an API key.
            sig { returns(T.nilable(T::Boolean)) }
            attr_accessor :create_service_account_only

            sig do
              params(
                project_id: String,
                name: String,
                create_service_account_only: T.nilable(T::Boolean),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              # The name of the service account being created.
              name:,
              # Create the service account without default roles or an API key.
              create_service_account_only: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  name: String,
                  create_service_account_only: T.nilable(T::Boolean),
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
end
