# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        # @see OpenAI::Resources::FineTuning::Checkpoints::Permissions#delete
        class PermissionDeleteParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute fine_tuned_model_checkpoint
          #
          #   @return [String]
          required :fine_tuned_model_checkpoint, String

          # @!method initialize(fine_tuned_model_checkpoint:, request_options: {})
          #   @param fine_tuned_model_checkpoint [String]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
