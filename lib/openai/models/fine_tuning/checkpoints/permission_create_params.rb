# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        # @see OpenAI::Resources::FineTuning::Checkpoints::Permissions#create
        class PermissionCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute project_ids
          #   The project identifiers to grant access to.
          #
          #   @return [Array<String>]
          required :project_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!method initialize(project_ids:, request_options: {})
          #   @param project_ids [Array<String>] The project identifiers to grant access to.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
