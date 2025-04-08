# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      module Runs
        # @see OpenAI::Resources::Evals::Runs::OutputItems#retrieve
        class OutputItemRetrieveParams < OpenAI::Internal::Type::BaseModel
          # @!parse
          #   extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute eval_id
          #
          #   @return [String]
          required :eval_id, String

          # @!attribute run_id
          #
          #   @return [String]
          required :run_id, String

          # @!parse
          #   # @param eval_id [String]
          #   # @param run_id [String]
          #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          #   #
          #   def initialize(eval_id:, run_id:, request_options: {}, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end
      end
    end
  end
end
