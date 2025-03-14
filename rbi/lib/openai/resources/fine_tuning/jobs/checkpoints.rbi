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
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::CursorPage[OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint])
          end
          def list(fine_tuning_job_id, after: nil, limit: nil, request_options: {})
          end

          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
