# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Jobs
        # @see OpenAI::Resources::FineTuning::Jobs::Checkpoints#list
        class CheckpointListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   Identifier for the last checkpoint ID from the previous pagination request.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute limit
          #   Number of checkpoints to retrieve.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!method initialize(after: nil, limit: nil, request_options: {})
          #   @param after [String]
          #   @param limit [Integer]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
