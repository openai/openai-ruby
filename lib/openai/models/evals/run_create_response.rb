# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      # @see OpenAI::Resources::Evals::Runs#create
      class RunCreateResponse < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource]
        required :data_source, union: -> { OpenAI::Models::Evals::RunCreateResponse::DataSource }

        # @!attribute error
        #   An object representing an error response from the Eval API.
        #
        #   @return [OpenAI::Models::Evals::EvalAPIError]
        required :error, -> { OpenAI::Models::Evals::EvalAPIError }

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
        #   @return [Array<OpenAI::Models::Evals::RunCreateResponse::PerModelUsage>]
        required :per_model_usage,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunCreateResponse::PerModelUsage] }

        # @!attribute per_testing_criteria_results
        #   Results per testing criteria applied during the evaluation run.
        #
        #   @return [Array<OpenAI::Models::Evals::RunCreateResponse::PerTestingCriteriaResult>]
        required :per_testing_criteria_results,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunCreateResponse::PerTestingCriteriaResult] }

        # @!attribute report_url
        #   The URL to the rendered evaluation run report on the UI dashboard.
        #
        #   @return [String]
        required :report_url, String

        # @!attribute result_counts
        #   Counters summarizing the outcomes of the evaluation run.
        #
        #   @return [OpenAI::Models::Evals::RunCreateResponse::ResultCounts]
        required :result_counts, -> { OpenAI::Models::Evals::RunCreateResponse::ResultCounts }

        # @!attribute status
        #   The status of the evaluation run.
        #
        #   @return [String]
        required :status, String

        # @!parse
        #   # A schema representing an evaluation run.
        #   #
        #   # @param id [String]
        #   # @param created_at [Integer]
        #   # @param data_source [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource]
        #   # @param error [OpenAI::Models::Evals::EvalAPIError]
        #   # @param eval_id [String]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param model [String]
        #   # @param name [String]
        #   # @param per_model_usage [Array<OpenAI::Models::Evals::RunCreateResponse::PerModelUsage>]
        #   # @param per_testing_criteria_results [Array<OpenAI::Models::Evals::RunCreateResponse::PerTestingCriteriaResult>]
        #   # @param report_url [String]
        #   # @param result_counts [OpenAI::Models::Evals::RunCreateResponse::ResultCounts]
        #   # @param status [String]
        #   # @param object [Symbol, :"eval.run"]
        #   #
        #   def initialize(
        #     id:,
        #     created_at:,
        #     data_source:,
        #     error:,
        #     eval_id:,
        #     metadata:,
        #     model:,
        #     name:,
        #     per_model_usage:,
        #     per_testing_criteria_results:,
        #     report_url:,
        #     result_counts:,
        #     status:,
        #     object: :"eval.run",
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # Information about the run's data source.
        #
        # @see OpenAI::Models::Evals::RunCreateResponse#data_source
        module DataSource
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A JsonlRunDataSource object with that specifies a JSONL file that matches the eval
          variant :jsonl, -> { OpenAI::Models::Evals::CreateEvalJSONLRunDataSource }

          # A CompletionsRunDataSource object describing a model sampling configuration.
          variant :completions, -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource }

          # @!parse
          #   # @return [Array(OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource)]
          #   def self.variants; end
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

          # @!parse
          #   # @param cached_tokens [Integer]
          #   # @param completion_tokens [Integer]
          #   # @param invocation_count [Integer]
          #   # @param model_name [String]
          #   # @param prompt_tokens [Integer]
          #   # @param total_tokens [Integer]
          #   #
          #   def initialize(cached_tokens:, completion_tokens:, invocation_count:, model_name:, prompt_tokens:, total_tokens:, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
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

          # @!parse
          #   # @param failed [Integer]
          #   # @param passed [Integer]
          #   # @param testing_criteria [String]
          #   #
          #   def initialize(failed:, passed:, testing_criteria:, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end

        # @see OpenAI::Models::Evals::RunCreateResponse#result_counts
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

          # @!parse
          #   # Counters summarizing the outcomes of the evaluation run.
          #   #
          #   # @param errored [Integer]
          #   # @param failed [Integer]
          #   # @param passed [Integer]
          #   # @param total [Integer]
          #   #
          #   def initialize(errored:, failed:, passed:, total:, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end
      end
    end
  end
end
