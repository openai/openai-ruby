# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      # @see OpenAI::Resources::Evals::Runs#list
      class RunListResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the evaluation run.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   Unix timestamp (in seconds) when the evaluation run was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data_source
        #   Information about the run's data source.
        #
        #   @return [OpenAI::Evals::CreateEvalJSONLRunDataSource, OpenAI::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Evals::CreateEvalResponsesRunDataSource]
        required :data_source, union: -> { OpenAI::Models::Evals::RunListResponse::DataSource }

        # @!attribute error
        #   An object representing an error response from the Eval API.
        #
        #   @return [OpenAI::Evals::EvalAPIError]
        required :error, -> { OpenAI::Evals::EvalAPIError }

        # @!attribute eval_id
        #   The identifier of the associated evaluation.
        #
        #   @return [String]
        required :eval_id, String

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        required :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!attribute model
        #   The model that is evaluated, if applicable.
        #
        #   @return [String]
        required :model, String

        # @!attribute name
        #   The name of the evaluation run.
        #
        #   @return [String]
        required :name, String

        # @!attribute object
        #   The type of the object. Always "eval.run".
        #
        #   @return [Symbol, :"eval.run"]
        required :object, const: :"eval.run"

        # @!attribute per_model_usage
        #   Usage statistics for each model during the evaluation run.
        #
        #   @return [Array<OpenAI::Models::Evals::RunListResponse::PerModelUsage>]
        required :per_model_usage,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunListResponse::PerModelUsage] }

        # @!attribute per_testing_criteria_results
        #   Results per testing criteria applied during the evaluation run.
        #
        #   @return [Array<OpenAI::Models::Evals::RunListResponse::PerTestingCriteriaResult>]
        required :per_testing_criteria_results,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunListResponse::PerTestingCriteriaResult] }

        # @!attribute report_url
        #   The URL to the rendered evaluation run report on the UI dashboard.
        #
        #   @return [String]
        required :report_url, String

        # @!attribute result_counts
        #   Counters summarizing the outcomes of the evaluation run.
        #
        #   @return [OpenAI::Models::Evals::RunListResponse::ResultCounts]
        required :result_counts, -> { OpenAI::Models::Evals::RunListResponse::ResultCounts }

        # @!attribute status
        #   The status of the evaluation run.
        #
        #   @return [String]
        required :status, String

        # @!method initialize(id:, created_at:, data_source:, error:, eval_id:, metadata:, model:, name:, per_model_usage:, per_testing_criteria_results:, report_url:, result_counts:, status:, object: :"eval.run")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Evals::RunListResponse} for more details.
        #
        #   A schema representing an evaluation run.
        #
        #   @param id [String] Unique identifier for the evaluation run.
        #
        #   @param created_at [Integer] Unix timestamp (in seconds) when the evaluation run was created.
        #
        #   @param data_source [OpenAI::Evals::CreateEvalJSONLRunDataSource, OpenAI::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Evals::CreateEvalResponsesRunDataSource] Information about the run's data source.
        #
        #   @param error [OpenAI::Evals::EvalAPIError] An object representing an error response from the Eval API.
        #
        #   @param eval_id [String] The identifier of the associated evaluation.
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param model [String] The model that is evaluated, if applicable.
        #
        #   @param name [String] The name of the evaluation run.
        #
        #   @param per_model_usage [Array<OpenAI::Models::Evals::RunListResponse::PerModelUsage>] Usage statistics for each model during the evaluation run.
        #
        #   @param per_testing_criteria_results [Array<OpenAI::Models::Evals::RunListResponse::PerTestingCriteriaResult>] Results per testing criteria applied during the evaluation run.
        #
        #   @param report_url [String] The URL to the rendered evaluation run report on the UI dashboard.
        #
        #   @param result_counts [OpenAI::Models::Evals::RunListResponse::ResultCounts] Counters summarizing the outcomes of the evaluation run.
        #
        #   @param status [String] The status of the evaluation run.
        #
        #   @param object [Symbol, :"eval.run"] The type of the object. Always "eval.run".

        # Information about the run's data source.
        #
        # @see OpenAI::Models::Evals::RunListResponse#data_source
        module DataSource
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A JsonlRunDataSource object with that specifies a JSONL file that matches the eval
          variant :jsonl, -> { OpenAI::Evals::CreateEvalJSONLRunDataSource }

          # A CompletionsRunDataSource object describing a model sampling configuration.
          variant :completions, -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource }

          # A ResponsesRunDataSource object describing a model sampling configuration.
          variant :responses, -> { OpenAI::Evals::CreateEvalResponsesRunDataSource }

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

        class PerModelUsage < OpenAI::Internal::Type::BaseModel
          # @!attribute cached_tokens
          #   The number of tokens retrieved from cache.
          #
          #   @return [Integer]
          required :cached_tokens, Integer

          # @!attribute completion_tokens
          #   The number of completion tokens generated.
          #
          #   @return [Integer]
          required :completion_tokens, Integer

          # @!attribute invocation_count
          #   The number of invocations.
          #
          #   @return [Integer]
          required :invocation_count, Integer

          # @!attribute model_name
          #   The name of the model.
          #
          #   @return [String]
          required :model_name, String

          # @!attribute prompt_tokens
          #   The number of prompt tokens used.
          #
          #   @return [Integer]
          required :prompt_tokens, Integer

          # @!attribute total_tokens
          #   The total number of tokens used.
          #
          #   @return [Integer]
          required :total_tokens, Integer

          # @!method initialize(cached_tokens:, completion_tokens:, invocation_count:, model_name:, prompt_tokens:, total_tokens:)
          #   @param cached_tokens [Integer] The number of tokens retrieved from cache.
          #
          #   @param completion_tokens [Integer] The number of completion tokens generated.
          #
          #   @param invocation_count [Integer] The number of invocations.
          #
          #   @param model_name [String] The name of the model.
          #
          #   @param prompt_tokens [Integer] The number of prompt tokens used.
          #
          #   @param total_tokens [Integer] The total number of tokens used.
        end

        class PerTestingCriteriaResult < OpenAI::Internal::Type::BaseModel
          # @!attribute failed
          #   Number of tests failed for this criteria.
          #
          #   @return [Integer]
          required :failed, Integer

          # @!attribute passed
          #   Number of tests passed for this criteria.
          #
          #   @return [Integer]
          required :passed, Integer

          # @!attribute testing_criteria
          #   A description of the testing criteria.
          #
          #   @return [String]
          required :testing_criteria, String

          # @!method initialize(failed:, passed:, testing_criteria:)
          #   @param failed [Integer] Number of tests failed for this criteria.
          #
          #   @param passed [Integer] Number of tests passed for this criteria.
          #
          #   @param testing_criteria [String] A description of the testing criteria.
        end

        # @see OpenAI::Models::Evals::RunListResponse#result_counts
        class ResultCounts < OpenAI::Internal::Type::BaseModel
          # @!attribute errored
          #   Number of output items that resulted in an error.
          #
          #   @return [Integer]
          required :errored, Integer

          # @!attribute failed
          #   Number of output items that failed to pass the evaluation.
          #
          #   @return [Integer]
          required :failed, Integer

          # @!attribute passed
          #   Number of output items that passed the evaluation.
          #
          #   @return [Integer]
          required :passed, Integer

          # @!attribute total
          #   Total number of executed output items.
          #
          #   @return [Integer]
          required :total, Integer

          # @!method initialize(errored:, failed:, passed:, total:)
          #   Counters summarizing the outcomes of the evaluation run.
          #
          #   @param errored [Integer] Number of output items that resulted in an error.
          #
          #   @param failed [Integer] Number of output items that failed to pass the evaluation.
          #
          #   @param passed [Integer] Number of output items that passed the evaluation.
          #
          #   @param total [Integer] Total number of executed output items.
        end
      end
    end
  end
end
