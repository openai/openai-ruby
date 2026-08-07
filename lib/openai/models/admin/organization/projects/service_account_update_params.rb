# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts#update
          class ServiceAccountUpdateParams < OpenAI::Internal::Type::BaseModel
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
            #   The updated service account name.
            #
            #   @return [String, nil]
            optional :name, String

            # @!attribute role
            #   The updated service account role.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ServiceAccountUpdateParams::Role, nil]
            optional :role, enum: -> { OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams::Role }

            # @!method initialize(project_id:, service_account_id:, name: nil, role: nil, request_options: {})
            #   @param project_id [String]
            #
            #   @param service_account_id [String]
            #
            #   @param name [String] The updated service account name.
            #
            #   @param role [Symbol, OpenAI::Models::Admin::Organization::Projects::ServiceAccountUpdateParams::Role] The updated service account role.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # The updated service account role.
            module Role
              extend OpenAI::Internal::Type::Enum

              MEMBER = :member
              OWNER = :owner

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
