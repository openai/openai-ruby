# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts#create
          class ServiceAccountCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute name
            #   The name of the service account being created.
            #
            #   @return [String]
            required :name, String

            # @!attribute create_service_account_only
            #   Create the service account without default roles or an API key.
            #
            #   @return [Boolean, nil]
            optional :create_service_account_only, OpenAI::Internal::Type::Boolean, nil?: true

            # @!attribute expires_in_seconds
            #   Number of seconds until the initial API key expires. If omitted or null, the key
            #   does not expire unless the effective organization or project policy requires an
            #   expiration. When a policy sets a maximum lifetime, this value must be provided
            #   and must not exceed that limit. A non-null value cannot be used when
            #   `create_service_account_only` is true.
            #
            #   @return [Integer, nil]
            optional :expires_in_seconds, Integer, nil?: true

            # @!method initialize(project_id:, name:, create_service_account_only: nil, expires_in_seconds: nil, request_options: {})
            #   @param project_id [String]
            #
            #   @param name [String]
            #     The name of the service account being created.
            #
            #   @param create_service_account_only [Boolean, nil]
            #     Create the service account without default roles or an API key.
            #
            #   @param expires_in_seconds [Integer, nil]
            #     Number of seconds until the initial API key expires. If omitted or null, the key
            #     does not expire unless the effective organization or project policy requires an
            #     expiration. When a policy sets a maximum lifetime, this value must be provided
            #     and must not exceed that limit. A non-null value cannot be used when
            #     `create_service_account_only` is true.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
