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
        #   Optional metadata filter. To filter, use the syntax `metadata[k]=v`. Omitting
        #   the parameter or passing an empty object applies no metadata filter. An empty
        #   value, such as `metadata[k]=`, filters for that key with an empty string value.
        #   To select jobs with null metadata, send the literal query string
        #   `metadata=null`. Nullable caller types do not specify how a client serializes
        #   null for a deep-object parameter. Use a raw query parameter if the client omits
        #   null. Do not combine the two query forms.
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!method initialize(after: nil, limit: nil, metadata: nil, request_options: {})
        #   @param after [String]
        #     Identifier for the last job from the previous pagination request.
        #
        #   @param limit [Integer]
        #     Number of fine-tuning jobs to retrieve.
        #
        #   @param metadata [Hash{Symbol=>String}, nil]
        #     Optional metadata filter. To filter, use the syntax `metadata[k]=v`. Omitting
        #     the parameter or passing an empty object applies no metadata filter. An empty
        #     value, such as `metadata[k]=`, filters for that key with an empty string value.
        #     To select jobs with null metadata, send the literal query string
        #     `metadata=null`. Nullable caller types do not specify how a client serializes
        #     null for a deep-object parameter. Use a raw query parameter if the client omits
        #     null. Do not combine the two query forms.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
