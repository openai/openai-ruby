# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      class JobListParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute [r] after
        #   Identifier for the last job from the previous pagination request.
        #
        #   @return [String, nil]
        optional :after, String

        # @!parse
        #   # @return [String]
        #   attr_writer :after

        # @!attribute [r] limit
        #   Number of fine-tuning jobs to retrieve.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!parse
        #   # @return [Integer]
        #   attr_writer :limit

        # @!parse
        #   # @param after [String]
        #   # @param limit [Integer]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(after: nil, limit: nil, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
