# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Projects#update
        class ProjectUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute project_id
          #
          #   @return [String]
          required :project_id, String

          # @!attribute external_key_id
          #   External key ID to associate with the project.
          #
          #   @return [String, nil]
          optional :external_key_id, String, nil?: true

          # @!attribute geography
          #   Geography for the project.
          #
          #   @return [String, nil]
          optional :geography, String, nil?: true

          # @!attribute name
          #   The updated name of the project, this name appears in reports.
          #
          #   @return [String, nil]
          optional :name, String, nil?: true

          # @!method initialize(project_id:, external_key_id: nil, geography: nil, name: nil, request_options: {})
          #   @param project_id [String]
          #
          #   @param external_key_id [String, nil] External key ID to associate with the project.
          #
          #   @param geography [String, nil] Geography for the project.
          #
          #   @param name [String, nil] The updated name of the project, this name appears in reports.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
