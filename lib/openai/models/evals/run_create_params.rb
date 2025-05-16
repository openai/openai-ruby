# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      # @see OpenAI::Resources::Evals::Runs#create
      class RunCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute data_source
        #   Details about the run's data source.
        #
        #   @return [OpenAI::Evals::CreateEvalJSONLRunDataSource, OpenAI::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Evals::CreateEvalResponsesRunDataSource]
        required :data_source, union: -> { OpenAI::Evals::RunCreateParams::DataSource }

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
        #   The name of the run.
        #
        #   @return [String, nil]
        optional :name, String

        # @!method initialize(data_source:, metadata: nil, name: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Evals::RunCreateParams} for more details.
        #
        #   @param data_source [OpenAI::Evals::CreateEvalJSONLRunDataSource, OpenAI::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Evals::CreateEvalResponsesRunDataSource] Details about the run's data source.
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param name [String] The name of the run.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Details about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          # A JsonlRunDataSource object with that specifies a JSONL file that matches the eval
          variant -> { OpenAI::Evals::CreateEvalJSONLRunDataSource }

          # A CompletionsRunDataSource object describing a model sampling configuration.
          variant -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource }

          # A ResponsesRunDataSource object describing a model sampling configuration.
          variant -> { OpenAI::Evals::CreateEvalResponsesRunDataSource }

          # @!method self.variants
          #   @return [Array(OpenAI::Evals::CreateEvalJSONLRunDataSource, OpenAI::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Evals::CreateEvalResponsesRunDataSource)]

          define_sorbet_constant!(:Variants) do
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource,
                OpenAI::Evals::CreateEvalResponsesRunDataSource
              )
            end
          end
        end
      end
    end
  end
end
