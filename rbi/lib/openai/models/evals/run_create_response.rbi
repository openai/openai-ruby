# typed: strong

module OpenAI
  module Models
    module Evals
      class RunCreateResponse < OpenAI::Internal::Type::BaseModel
        # Unique identifier for the evaluation run.
        sig { returns(String) }
        attr_accessor :id

        # Unix timestamp (in seconds) when the evaluation run was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Information about the run's data source.
        sig do
          returns(
            T.any(
              OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource
            )
          )
        end
        attr_accessor :data_source

        # An object representing an error response from the Eval API.
        sig { returns(OpenAI::Models::Evals::EvalAPIError) }
        attr_reader :error

        sig { params(error: T.any(OpenAI::Models::Evals::EvalAPIError, OpenAI::Internal::AnyHash)).void }
        attr_writer :error

        # The identifier of the associated evaluation.
        sig { returns(String) }
        attr_accessor :eval_id

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The model that is evaluated, if applicable.
        sig { returns(String) }
        attr_accessor :model

        # The name of the evaluation run.
        sig { returns(String) }
        attr_accessor :name

        # The type of the object. Always "eval.run".
        sig { returns(Symbol) }
        attr_accessor :object

        # Usage statistics for each model during the evaluation run.
        sig { returns(T::Array[OpenAI::Models::Evals::RunCreateResponse::PerModelUsage]) }
        attr_accessor :per_model_usage

        # Results per testing criteria applied during the evaluation run.
        sig { returns(T::Array[OpenAI::Models::Evals::RunCreateResponse::PerTestingCriteriaResult]) }
        attr_accessor :per_testing_criteria_results

        # The URL to the rendered evaluation run report on the UI dashboard.
        sig { returns(String) }
        attr_accessor :report_url

        # Counters summarizing the outcomes of the evaluation run.
        sig { returns(OpenAI::Models::Evals::RunCreateResponse::ResultCounts) }
        attr_reader :result_counts

        sig do
          params(
            result_counts: T.any(OpenAI::Models::Evals::RunCreateResponse::ResultCounts, OpenAI::Internal::AnyHash)
          )
            .void
        end
        attr_writer :result_counts

        # The status of the evaluation run.
        sig { returns(String) }
        attr_accessor :status

        # A schema representing an evaluation run.
        sig do
          params(
            id: String,
            created_at: Integer,
            data_source: T.any(
              OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource
            ),
            error: T.any(OpenAI::Models::Evals::EvalAPIError, OpenAI::Internal::AnyHash),
            eval_id: String,
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: String,
            name: String,
            per_model_usage: T::Array[T.any(OpenAI::Models::Evals::RunCreateResponse::PerModelUsage, OpenAI::Internal::AnyHash)],
            per_testing_criteria_results: T::Array[T.any(OpenAI::Models::Evals::RunCreateResponse::PerTestingCriteriaResult, OpenAI::Internal::AnyHash)],
            report_url: String,
            result_counts: T.any(OpenAI::Models::Evals::RunCreateResponse::ResultCounts, OpenAI::Internal::AnyHash),
            status: String,
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          id:,
          created_at:,
          data_source:,
          error:,
          eval_id:,
          metadata:,
          model:,
          name:,
          per_model_usage:,
          per_testing_criteria_results:,
          report_url:,
          result_counts:,
          status:,
          object: :"eval.run"
        ); end
        sig do
          override
            .returns(
              {
                id: String,
                created_at: Integer,
                data_source: T.any(
                  OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
                  OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource
                ),
                error: OpenAI::Models::Evals::EvalAPIError,
                eval_id: String,
                metadata: T.nilable(T::Hash[Symbol, String]),
                model: String,
                name: String,
                object: Symbol,
                per_model_usage: T::Array[OpenAI::Models::Evals::RunCreateResponse::PerModelUsage],
                per_testing_criteria_results: T::Array[OpenAI::Models::Evals::RunCreateResponse::PerTestingCriteriaResult],
                report_url: String,
                result_counts: OpenAI::Models::Evals::RunCreateResponse::ResultCounts,
                status: String
              }
            )
        end
        def to_hash; end

        # Information about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          sig do
            override
              .returns(
                [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource]
              )
          end
          def self.variants; end
        end

        class PerModelUsage < OpenAI::Internal::Type::BaseModel
          # The number of tokens retrieved from cache.
          sig { returns(Integer) }
          attr_accessor :cached_tokens

          # The number of completion tokens generated.
          sig { returns(Integer) }
          attr_accessor :completion_tokens

          # The number of invocations.
          sig { returns(Integer) }
          attr_accessor :invocation_count

          # The name of the model.
          sig { returns(String) }
          attr_accessor :model_name

          # The number of prompt tokens used.
          sig { returns(Integer) }
          attr_accessor :prompt_tokens

          # The total number of tokens used.
          sig { returns(Integer) }
          attr_accessor :total_tokens

          sig do
            params(
              cached_tokens: Integer,
              completion_tokens: Integer,
              invocation_count: Integer,
              model_name: String,
              prompt_tokens: Integer,
              total_tokens: Integer
            )
              .returns(T.attached_class)
          end
          def self.new(
            cached_tokens:,
            completion_tokens:,
            invocation_count:,
            model_name:,
            prompt_tokens:,
            total_tokens:
          )
          end

          sig do
            override
              .returns(
                {
                  cached_tokens: Integer,
                  completion_tokens: Integer,
                  invocation_count: Integer,
                  model_name: String,
                  prompt_tokens: Integer,
                  total_tokens: Integer
                }
              )
          end
          def to_hash; end
        end

        class PerTestingCriteriaResult < OpenAI::Internal::Type::BaseModel
          # Number of tests failed for this criteria.
          sig { returns(Integer) }
          attr_accessor :failed

          # Number of tests passed for this criteria.
          sig { returns(Integer) }
          attr_accessor :passed

          # A description of the testing criteria.
          sig { returns(String) }
          attr_accessor :testing_criteria

          sig { params(failed: Integer, passed: Integer, testing_criteria: String).returns(T.attached_class) }
          def self.new(failed:, passed:, testing_criteria:); end

          sig { override.returns({failed: Integer, passed: Integer, testing_criteria: String}) }
          def to_hash; end
        end

        class ResultCounts < OpenAI::Internal::Type::BaseModel
          # Number of output items that resulted in an error.
          sig { returns(Integer) }
          attr_accessor :errored

          # Number of output items that failed to pass the evaluation.
          sig { returns(Integer) }
          attr_accessor :failed

          # Number of output items that passed the evaluation.
          sig { returns(Integer) }
          attr_accessor :passed

          # Total number of executed output items.
          sig { returns(Integer) }
          attr_accessor :total

          # Counters summarizing the outcomes of the evaluation run.
          sig do
            params(
              errored: Integer,
              failed: Integer,
              passed: Integer,
              total: Integer
            ).returns(T.attached_class)
          end
          def self.new(errored:, failed:, passed:, total:); end

          sig { override.returns({errored: Integer, failed: Integer, passed: Integer, total: Integer}) }
          def to_hash; end
        end
      end
    end
  end
end
