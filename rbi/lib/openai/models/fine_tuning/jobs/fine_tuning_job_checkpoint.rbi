# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Jobs
        class FineTuningJobCheckpoint < OpenAI::Internal::Type::BaseModel
          # The checkpoint identifier, which can be referenced in the API endpoints.
          sig { returns(String) }
          attr_accessor :id

          # The Unix timestamp (in seconds) for when the checkpoint was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # The name of the fine-tuned checkpoint model that is created.
          sig { returns(String) }
          attr_accessor :fine_tuned_model_checkpoint

          # The name of the fine-tuning job that this checkpoint was created from.
          sig { returns(String) }
          attr_accessor :fine_tuning_job_id

          # Metrics at the step number during the fine-tuning job.
          sig { returns(OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics) }
          attr_reader :metrics

          sig do
            params(
              metrics: T.any(OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :metrics

          # The object type, which is always "fine_tuning.job.checkpoint".
          sig { returns(Symbol) }
          attr_accessor :object

          # The step number that the checkpoint was created at.
          sig { returns(Integer) }
          attr_accessor :step_number

          # The `fine_tuning.job.checkpoint` object represents a model checkpoint for a
          #   fine-tuning job that is ready to use.
          sig do
            params(
              id: String,
              created_at: Integer,
              fine_tuned_model_checkpoint: String,
              fine_tuning_job_id: String,
              metrics: T.any(OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics, OpenAI::Internal::AnyHash),
              step_number: Integer,
              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(
            id:,
            created_at:,
            fine_tuned_model_checkpoint:,
            fine_tuning_job_id:,
            metrics:,
            step_number:,
            object: :"fine_tuning.job.checkpoint"
          )
          end

          sig do
            override
              .returns(
                {
                  id: String,
                  created_at: Integer,
                  fine_tuned_model_checkpoint: String,
                  fine_tuning_job_id: String,
                  metrics: OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics,
                  object: Symbol,
                  step_number: Integer
                }
              )
          end
          def to_hash
          end

          class Metrics < OpenAI::Internal::Type::BaseModel
            sig { returns(T.nilable(Float)) }
            attr_reader :full_valid_loss

            sig { params(full_valid_loss: Float).void }
            attr_writer :full_valid_loss

            sig { returns(T.nilable(Float)) }
            attr_reader :full_valid_mean_token_accuracy

            sig { params(full_valid_mean_token_accuracy: Float).void }
            attr_writer :full_valid_mean_token_accuracy

            sig { returns(T.nilable(Float)) }
            attr_reader :step

            sig { params(step: Float).void }
            attr_writer :step

            sig { returns(T.nilable(Float)) }
            attr_reader :train_loss

            sig { params(train_loss: Float).void }
            attr_writer :train_loss

            sig { returns(T.nilable(Float)) }
            attr_reader :train_mean_token_accuracy

            sig { params(train_mean_token_accuracy: Float).void }
            attr_writer :train_mean_token_accuracy

            sig { returns(T.nilable(Float)) }
            attr_reader :valid_loss

            sig { params(valid_loss: Float).void }
            attr_writer :valid_loss

            sig { returns(T.nilable(Float)) }
            attr_reader :valid_mean_token_accuracy

            sig { params(valid_mean_token_accuracy: Float).void }
            attr_writer :valid_mean_token_accuracy

            # Metrics at the step number during the fine-tuning job.
            sig do
              params(
                full_valid_loss: Float,
                full_valid_mean_token_accuracy: Float,
                step: Float,
                train_loss: Float,
                train_mean_token_accuracy: Float,
                valid_loss: Float,
                valid_mean_token_accuracy: Float
              )
                .returns(T.attached_class)
            end
            def self.new(
              full_valid_loss: nil,
              full_valid_mean_token_accuracy: nil,
              step: nil,
              train_loss: nil,
              train_mean_token_accuracy: nil,
              valid_loss: nil,
              valid_mean_token_accuracy: nil
            )
            end

            sig do
              override
                .returns(
                  {
                    full_valid_loss: Float,
                    full_valid_mean_token_accuracy: Float,
                    step: Float,
                    train_loss: Float,
                    train_mean_token_accuracy: Float,
                    valid_loss: Float,
                    valid_mean_token_accuracy: Float
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
end
