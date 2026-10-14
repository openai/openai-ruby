# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module Projects

          class ServiceAccountCreateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
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

            # Number of seconds until the initial API key expires. If omitted or null, the key
            # does not expire unless the effective organization or project policy requires an
            # expiration. When a policy sets a maximum lifetime, this value must be provided
            # and must not exceed that limit. A non-null value cannot be used when
            # `create_service_account_only` is true.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :expires_in_seconds

            sig do
              params(

                project_id: String,

                name: String,

                create_service_account_only: T.nilable(T::Boolean),

                expires_in_seconds: T.nilable(Integer),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              project_id:,

              # The name of the service account being created.
              name:,

              # Create the service account without default roles or an API key.
              create_service_account_only: nil,

              # Number of seconds until the initial API key expires. If omitted or null, the key
              # does not expire unless the effective organization or project policy requires an
              # expiration. When a policy sets a maximum lifetime, this value must be provided
              # and must not exceed that limit. A non-null value cannot be used when
              # `create_service_account_only` is true.
              expires_in_seconds: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  name: String,
                  create_service_account_only: T.nilable(T::Boolean),
                  expires_in_seconds: T.nilable(Integer),
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
