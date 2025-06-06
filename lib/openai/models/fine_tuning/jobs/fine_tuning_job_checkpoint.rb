# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Jobs
        # @see OpenAI::Resources::FineTuning::Jobs::Checkpoints#list
        class FineTuningJobCheckpoint < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The checkpoint identifier, which can be referenced in the API endpoints.
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   The Unix timestamp (in seconds) for when the checkpoint was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute fine_tuned_model_checkpoint
          #   The name of the fine-tuned checkpoint model that is created.
          #
          #   @return [String]
          required :fine_tuned_model_checkpoint, String

          # @!attribute fine_tuning_job_id
          #   The name of the fine-tuning job that this checkpoint was created from.
          #
          #   @return [String]
          required :fine_tuning_job_id, String

          # @!attribute metrics
          #   Metrics at the step number during the fine-tuning job.
          #
          #   @return [OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics]
          required :metrics, -> { OpenAI::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics }

          # @!attribute object
          #   The object type, which is always "fine_tuning.job.checkpoint".
          #
          #   @return [Symbol, :"fine_tuning.job.checkpoint"]
          required :object, const: :"fine_tuning.job.checkpoint"

          # @!attribute step_number
          #   The step number that the checkpoint was created at.
          #
          #   @return [Integer]
          required :step_number, Integer

          # @!method initialize(id:, created_at:, fine_tuned_model_checkpoint:, fine_tuning_job_id:, metrics:, step_number:, object: :"fine_tuning.job.checkpoint")
          #   The `fine_tuning.job.checkpoint` object represents a model checkpoint for a
          #   fine-tuning job that is ready to use.
          #
          #   @param id [String] The checkpoint identifier, which can be referenced in the API endpoints.
          #
          #   @param created_at [Integer] The Unix timestamp (in seconds) for when the checkpoint was created.
          #
          #   @param fine_tuned_model_checkpoint [String] The name of the fine-tuned checkpoint model that is created.
          #
          #   @param fine_tuning_job_id [String] The name of the fine-tuning job that this checkpoint was created from.
          #
          #   @param metrics [OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics] Metrics at the step number during the fine-tuning job.
          #
          #   @param step_number [Integer] The step number that the checkpoint was created at.
          #
          #   @param object [Symbol, :"fine_tuning.job.checkpoint"] The object type, which is always "fine_tuning.job.checkpoint".

          # @see OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint#metrics
          class Metrics < OpenAI::Internal::Type::BaseModel
            # @!attribute full_valid_loss
            #
            #   @return [Float, nil]
            optional :full_valid_loss, Float

            # @!attribute full_valid_mean_token_accuracy
            #
            #   @return [Float, nil]
            optional :full_valid_mean_token_accuracy, Float

            # @!attribute step
            #
            #   @return [Float, nil]
            optional :step, Float

            # @!attribute train_loss
            #
            #   @return [Float, nil]
            optional :train_loss, Float

            # @!attribute train_mean_token_accuracy
            #
            #   @return [Float, nil]
            optional :train_mean_token_accuracy, Float

            # @!attribute valid_loss
            #
            #   @return [Float, nil]
            optional :valid_loss, Float

            # @!attribute valid_mean_token_accuracy
            #
            #   @return [Float, nil]
            optional :valid_mean_token_accuracy, Float

            # @!method initialize(full_valid_loss: nil, full_valid_mean_token_accuracy: nil, step: nil, train_loss: nil, train_mean_token_accuracy: nil, valid_loss: nil, valid_mean_token_accuracy: nil)
            #   Metrics at the step number during the fine-tuning job.
            #
            #   @param full_valid_loss [Float]
            #   @param full_valid_mean_token_accuracy [Float]
            #   @param step [Float]
            #   @param train_loss [Float]
            #   @param train_mean_token_accuracy [Float]
            #   @param valid_loss [Float]
            #   @param valid_mean_token_accuracy [Float]
          end
        end
      end
    end
  end
end
