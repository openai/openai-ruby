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

          # @!attribute name
          #   The updated name of the project, this name appears in reports.
          #
          #   @return [String]
          required :name, String

          # @!method initialize(project_id:, name:, request_options: {})
          #   @param project_id [String]
          #
          #   @param name [String] The updated name of the project, this name appears in reports.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
