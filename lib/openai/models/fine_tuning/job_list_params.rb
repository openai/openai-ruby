# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      # @see OpenAI::Resources::FineTuning::Jobs#list
      class JobListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute after
        #   Identifier for the last job from the previous pagination request.
        #
        #   @return [String, nil]
        optional :after, String

        # @!attribute limit
        #   Number of fine-tuning jobs to retrieve.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!attribute metadata
        #   Optional metadata filter. To filter, use the syntax `metadata[k]=v`.
        #   Alternatively, set `metadata=null` to indicate no metadata.
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!method initialize(after: nil, limit: nil, metadata: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::FineTuning::JobListParams} for more details.
        #
        #   @param after [String] Identifier for the last job from the previous pagination request.
        #
        #   @param limit [Integer] Number of fine-tuning jobs to retrieve.
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Optional metadata filter. To filter, use the syntax `metadata[k]=v`. Alternative
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
