# typed: strong

module OpenAI
  module Models
    module Evals
      class RunCancelResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Models::Evals::RunCancelResponse,
              OpenAI::Internal::AnyHash
            )
          end

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
              OpenAI::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Evals::CreateEvalCompletionsRunDataSource,
              OpenAI::Evals::CreateEvalResponsesRunDataSource
            )
          )
        end
        attr_accessor :data_source

        # An object representing an error response from the Eval API.
        sig { returns(OpenAI::Evals::EvalAPIError) }
        attr_reader :error

        sig { params(error: OpenAI::Evals::EvalAPIError::OrHash).void }
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
        sig do
          returns(
            T::Array[OpenAI::Models::Evals::RunCancelResponse::PerModelUsage]
          )
        end
        attr_accessor :per_model_usage

        # Results per testing criteria applied during the evaluation run.
        sig do
          returns(
            T::Array[
              OpenAI::Models::Evals::RunCancelResponse::PerTestingCriteriaResult
            ]
          )
        end
        attr_accessor :per_testing_criteria_results

        # The URL to the rendered evaluation run report on the UI dashboard.
        sig { returns(String) }
        attr_accessor :report_url

        # Counters summarizing the outcomes of the evaluation run.
        sig { returns(OpenAI::Models::Evals::RunCancelResponse::ResultCounts) }
        attr_reader :result_counts

        sig do
          params(
            result_counts:
              OpenAI::Models::Evals::RunCancelResponse::ResultCounts::OrHash
          ).void
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
            data_source:
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::OrHash,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::OrHash
              ),
            error: OpenAI::Evals::EvalAPIError::OrHash,
            eval_id: String,
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: String,
            name: String,
            per_model_usage:
              T::Array[
                OpenAI::Models::Evals::RunCancelResponse::PerModelUsage::OrHash
              ],
            per_testing_criteria_results:
              T::Array[
                OpenAI::Models::Evals::RunCancelResponse::PerTestingCriteriaResult::OrHash
              ],
            report_url: String,
            result_counts:
              OpenAI::Models::Evals::RunCancelResponse::ResultCounts::OrHash,
            status: String,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the evaluation run.
          id:,
          # Unix timestamp (in seconds) when the evaluation run was created.
          created_at:,
          # Information about the run's data source.
          data_source:,
          # An object representing an error response from the Eval API.
          error:,
          # The identifier of the associated evaluation.
          eval_id:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata:,
          # The model that is evaluated, if applicable.
          model:,
          # The name of the evaluation run.
          name:,
          # Usage statistics for each model during the evaluation run.
          per_model_usage:,
          # Results per testing criteria applied during the evaluation run.
          per_testing_criteria_results:,
          # The URL to the rendered evaluation run report on the UI dashboard.
          report_url:,
          # Counters summarizing the outcomes of the evaluation run.
          result_counts:,
          # The status of the evaluation run.
          status:,
          # The type of the object. Always "eval.run".
          object: :"eval.run"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data_source:
                T.any(
                  OpenAI::Evals::CreateEvalJSONLRunDataSource,
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource,
                  OpenAI::Evals::CreateEvalResponsesRunDataSource
                ),
              error: OpenAI::Evals::EvalAPIError,
              eval_id: String,
              metadata: T.nilable(T::Hash[Symbol, String]),
              model: String,
              name: String,
              object: Symbol,
              per_model_usage:
                T::Array[
                  OpenAI::Models::Evals::RunCancelResponse::PerModelUsage
                ],
              per_testing_criteria_results:
                T::Array[
                  OpenAI::Models::Evals::RunCancelResponse::PerTestingCriteriaResult
                ],
              report_url: String,
              result_counts:
                OpenAI::Models::Evals::RunCancelResponse::ResultCounts,
              status: String
            }
          )
        end
        def to_hash
        end

        # Information about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource,
                OpenAI::Evals::CreateEvalResponsesRunDataSource
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Models::Evals::RunCancelResponse::DataSource::Variants
              ]
            )
          end
          def self.variants
          end
        end

        class PerModelUsage < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Evals::RunCancelResponse::PerModelUsage,
                OpenAI::Internal::AnyHash
              )
            end

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
            ).returns(T.attached_class)
          end
          def self.new(
            # The number of tokens retrieved from cache.
            cached_tokens:,
            # The number of completion tokens generated.
            completion_tokens:,
            # The number of invocations.
            invocation_count:,
            # The name of the model.
            model_name:,
            # The number of prompt tokens used.
            prompt_tokens:,
            # The total number of tokens used.
            total_tokens:
          )
          end

          sig do
            override.returns(
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
          def to_hash
          end
        end

        class PerTestingCriteriaResult < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Evals::RunCancelResponse::PerTestingCriteriaResult,
                OpenAI::Internal::AnyHash
              )
            end

          # Number of tests failed for this criteria.
          sig { returns(Integer) }
          attr_accessor :failed

          # Number of tests passed for this criteria.
          sig { returns(Integer) }
          attr_accessor :passed

          # A description of the testing criteria.
          sig { returns(String) }
          attr_accessor :testing_criteria

          sig do
            params(
              failed: Integer,
              passed: Integer,
              testing_criteria: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Number of tests failed for this criteria.
            failed:,
            # Number of tests passed for this criteria.
            passed:,
            # A description of the testing criteria.
            testing_criteria:
          )
          end

          sig do
            override.returns(
              { failed: Integer, passed: Integer, testing_criteria: String }
            )
          end
          def to_hash
          end
        end

        class ResultCounts < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Evals::RunCancelResponse::ResultCounts,
                OpenAI::Internal::AnyHash
              )
            end

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
          def self.new(
            # Number of output items that resulted in an error.
            errored:,
            # Number of output items that failed to pass the evaluation.
            failed:,
            # Number of output items that passed the evaluation.
            passed:,
            # Total number of executed output items.
            total:
          )
          end

          sig do
            override.returns(
              {
                errored: Integer,
                failed: Integer,
                passed: Integer,
                total: Integer
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
