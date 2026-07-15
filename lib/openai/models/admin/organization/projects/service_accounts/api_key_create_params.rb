# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module ServiceAccounts
            # @see OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts::APIKeys#create
            class APIKeyCreateParams < OpenAI::Internal::Type::BaseModel
              extend OpenAI::Internal::Type::RequestParameters::Converter
              include OpenAI::Internal::Type::RequestParameters

              # @!attribute project_id
              #
              #   @return [String]
              required :project_id, String

              # @!attribute service_account_id
              #
              #   @return [String]
              required :service_account_id, String

              # @!attribute name
              #   API key name.
              #
              #   @return [String, nil]
              optional :name, String

              # @!attribute scopes
              #   API key scopes.
              #
              #   @return [Array<String>, nil]
              optional :scopes, OpenAI::Internal::Type::ArrayOf[String]

              # @!method initialize(project_id:, service_account_id:, name: nil, scopes: nil, request_options: {})
              #   @param project_id [String]
              #
              #   @param service_account_id [String]
              #
              #   @param name [String] API key name.
              #
              #   @param scopes [Array<String>] API key scopes.
              #
              #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
            end
          end
        end
      end
    end
  end
end
