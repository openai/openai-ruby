# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      # @see OpenAI::Resources::Evals::Runs#create
      class RunCreateParams < OpenAI::Internal::Type::BaseModel
        # @!parse
        #   extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute data_source
        #   Details about the run's data source.
        #
        #   @return [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource]
        required :data_source, union: -> { OpenAI::Models::Evals::RunCreateParams::DataSource }

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

        # @!attribute [r] name
        #   The name of the run.
        #
        #   @return [String, nil]
        optional :name, String

        # @!parse
        #   # @return [String]
        #   attr_writer :name

        # @!parse
        #   # @param data_source [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param name [String]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(data_source:, metadata: nil, name: nil, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # Details about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          # A JsonlRunDataSource object with that specifies a JSONL file that matches the eval
          variant -> { OpenAI::Models::Evals::CreateEvalJSONLRunDataSource }

          # A CompletionsRunDataSource object describing a model sampling configuration.
          variant -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource }

          # @!parse
          #   # @return [Array(OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource)]
          #   def self.variants; end
        end
      end
    end
  end
end
