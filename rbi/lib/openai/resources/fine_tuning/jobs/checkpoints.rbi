# typed: strong

module OpenAI
  module Resources
    class FineTuning
      class Jobs
        class Checkpoints
          # List checkpoints for a fine-tuning job.
          sig do
            params(
              fine_tuning_job_id: String,
              after: String,
              limit: Integer,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
            )
              .returns(OpenAI::Internal::CursorPage[OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint])
          end
          def list(
            # The ID of the fine-tuning job to get checkpoints for.
            fine_tuning_job_id,
            # Identifier for the last checkpoint ID from the previous pagination request.
            after: nil,
            # Number of checkpoints to retrieve.
            limit: nil,
            request_options: {}
          )
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
