# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Jobs
        # @see OpenAI::Resources::FineTuning::Jobs::Checkpoints#list
        class CheckpointListParams < OpenAI::Internal::Type::BaseModel
          # @!parse
          #   extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute [r] after
          #   Identifier for the last checkpoint ID from the previous pagination request.
          #
          #   @return [String, nil]
          optional :after, String

          # @!parse
          #   # @return [String]
          #   attr_writer :after

          # @!attribute [r] limit
          #   Number of checkpoints to retrieve.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!parse
          #   # @return [Integer]
          #   attr_writer :limit

          # @!method initialize(after: nil, limit: nil, request_options: {})
          #   @param after [String]
          #   @param limit [Integer]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
