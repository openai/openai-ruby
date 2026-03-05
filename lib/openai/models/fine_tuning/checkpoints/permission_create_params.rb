# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        # @see OpenAI::Resources::FineTuning::Checkpoints::Permissions#create
        class PermissionCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute fine_tuned_model_checkpoint
          #
          #   @return [String]
          required :fine_tuned_model_checkpoint, String

          # @!attribute project_ids
          #   The project identifiers to grant access to.
          #
          #   @return [Array<String>]
          required :project_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!method initialize(fine_tuned_model_checkpoint:, project_ids:, request_options: {})
          #   @param fine_tuned_model_checkpoint [String]
          #
          #   @param project_ids [Array<String>] The project identifiers to grant access to.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
