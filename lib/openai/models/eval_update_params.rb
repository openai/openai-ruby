# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Evals#update
    class EvalUpdateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute metadata
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      #
      #   @return [Hash{Symbol=>String}, nil]
      optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

      # @!attribute name
      #   Rename the evaluation.
      #
      #   @return [String, nil]
      optional :name, String

      # @!method initialize(metadata: nil, name: nil, request_options: {})
      #   @param metadata [Hash{Symbol=>String}, nil]
      #   @param name [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
