# typed: strong

module OpenAI
  module Resources
    class FineTuning
      class Jobs
        sig { returns(OpenAI::Resources::FineTuning::Jobs::Checkpoints) }
        def checkpoints
        end

        sig do
          params(
            model: T.any(String, Symbol),
            training_file: String,
            hyperparameters: OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters,
            integrations: T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration]),
            metadata: T.nilable(OpenAI::Models::Metadata),
            method_: OpenAI::Models::FineTuning::JobCreateParams::Method,
            seed: T.nilable(Integer),
            suffix: T.nilable(String),
            validation_file: T.nilable(String),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::FineTuning::FineTuningJob)
        end
        def create(
          model:,
          training_file:,
          hyperparameters: nil,
          integrations: nil,
          metadata: nil,
          method_: nil,
          seed: nil,
          suffix: nil,
          validation_file: nil,
          request_options: {}
        )
        end

        sig do
          params(
            fine_tuning_job_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::FineTuning::FineTuningJob)
        end
        def retrieve(fine_tuning_job_id, request_options: {})
        end

        sig do
          params(
            after: String,
            limit: Integer,
            metadata: T.nilable(T::Hash[Symbol, String]),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::CursorPage[OpenAI::Models::FineTuning::FineTuningJob])
        end
        def list(after: nil, limit: nil, metadata: nil, request_options: {})
        end

        sig do
          params(
            fine_tuning_job_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::FineTuning::FineTuningJob)
        end
        def cancel(fine_tuning_job_id, request_options: {})
        end

        sig do
          params(
            fine_tuning_job_id: String,
            after: String,
            limit: Integer,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::CursorPage[OpenAI::Models::FineTuning::FineTuningJobEvent])
        end
        def list_events(fine_tuning_job_id, after: nil, limit: nil, request_options: {})
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
