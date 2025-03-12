# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Jobs
        class FineTuningJobCheckpoint < OpenAI::BaseModel
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          sig { returns(Integer) }
          def created_at
          end

          sig { params(_: Integer).returns(Integer) }
          def created_at=(_)
          end

          sig { returns(String) }
          def fine_tuned_model_checkpoint
          end

          sig { params(_: String).returns(String) }
          def fine_tuned_model_checkpoint=(_)
          end

          sig { returns(String) }
          def fine_tuning_job_id
          end

          sig { params(_: String).returns(String) }
          def fine_tuning_job_id=(_)
          end

          sig { returns(OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics) }
          def metrics
          end

          sig do
            params(_: OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics)
              .returns(OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics)
          end
          def metrics=(_)
          end

          sig { returns(Symbol) }
          def object
          end

          sig { params(_: Symbol).returns(Symbol) }
          def object=(_)
          end

          sig { returns(Integer) }
          def step_number
          end

          sig { params(_: Integer).returns(Integer) }
          def step_number=(_)
          end

          sig do
            params(
              id: String,
              created_at: Integer,
              fine_tuned_model_checkpoint: String,
              fine_tuning_job_id: String,
              metrics: OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics,
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

          class Metrics < OpenAI::BaseModel
            sig { returns(T.nilable(Float)) }
            def full_valid_loss
            end

            sig { params(_: Float).returns(Float) }
            def full_valid_loss=(_)
            end

            sig { returns(T.nilable(Float)) }
            def full_valid_mean_token_accuracy
            end

            sig { params(_: Float).returns(Float) }
            def full_valid_mean_token_accuracy=(_)
            end

            sig { returns(T.nilable(Float)) }
            def step
            end

            sig { params(_: Float).returns(Float) }
            def step=(_)
            end

            sig { returns(T.nilable(Float)) }
            def train_loss
            end

            sig { params(_: Float).returns(Float) }
            def train_loss=(_)
            end

            sig { returns(T.nilable(Float)) }
            def train_mean_token_accuracy
            end

            sig { params(_: Float).returns(Float) }
            def train_mean_token_accuracy=(_)
            end

            sig { returns(T.nilable(Float)) }
            def valid_loss
            end

            sig { params(_: Float).returns(Float) }
            def valid_loss=(_)
            end

            sig { returns(T.nilable(Float)) }
            def valid_mean_token_accuracy
            end

            sig { params(_: Float).returns(Float) }
            def valid_mean_token_accuracy=(_)
            end

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
