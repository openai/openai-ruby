# typed: strong

module OpenAI
  module Resources
    class FineTuning
      class Jobs
        sig { returns(OpenAI::Resources::FineTuning::Jobs::Checkpoints) }
        def checkpoints
        end

        # Creates a fine-tuning job which begins the process of creating a new model from
        #   a given dataset.
        #
        #   Response includes details of the enqueued job including job status and the name
        #   of the fine-tuned models once complete.
        #
        #   [Learn more about fine-tuning](https://platform.openai.com/docs/guides/fine-tuning)
        sig do
          params(
            model: T.any(String, OpenAI::Models::FineTuning::JobCreateParams::Model::OrSymbol),
            training_file: String,
            hyperparameters: T.any(OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters, OpenAI::Util::AnyHash),
            integrations: T.nilable(
              T::Array[T.any(OpenAI::Models::FineTuning::JobCreateParams::Integration, OpenAI::Util::AnyHash)]
            ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            method_: T.any(OpenAI::Models::FineTuning::JobCreateParams::Method, OpenAI::Util::AnyHash),
            seed: T.nilable(Integer),
            suffix: T.nilable(String),
            validation_file: T.nilable(String),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Models::FineTuning::FineTuningJob)
        end
        def create(
          # The name of the model to fine-tune. You can select one of the
          #   [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
          model:,
          # The ID of an uploaded file that contains training data.
          #
          #   See [upload file](https://platform.openai.com/docs/api-reference/files/create)
          #   for how to upload a file.
          #
          #   Your dataset must be formatted as a JSONL file. Additionally, you must upload
          #   your file with the purpose `fine-tune`.
          #
          #   The contents of the file should differ depending on if the model uses the
          #   [chat](https://platform.openai.com/docs/api-reference/fine-tuning/chat-input),
          #   [completions](https://platform.openai.com/docs/api-reference/fine-tuning/completions-input)
          #   format, or if the fine-tuning method uses the
          #   [preference](https://platform.openai.com/docs/api-reference/fine-tuning/preference-input)
          #   format.
          #
          #   See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
          #   for more details.
          training_file:,
          # The hyperparameters used for the fine-tuning job. This value is now deprecated
          #   in favor of `method`, and should be passed in under the `method` parameter.
          hyperparameters: nil,
          # A list of integrations to enable for your fine-tuning job.
          integrations: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          metadata: nil,
          # The method used for fine-tuning.
          method_: nil,
          # The seed controls the reproducibility of the job. Passing in the same seed and
          #   job parameters should produce the same results, but may differ in rare cases. If
          #   a seed is not specified, one will be generated for you.
          seed: nil,
          # A string of up to 64 characters that will be added to your fine-tuned model
          #   name.
          #
          #   For example, a `suffix` of "custom-model-name" would produce a model name like
          #   `ft:gpt-4o-mini:openai:custom-model-name:7p4lURel`.
          suffix: nil,
          # The ID of an uploaded file that contains validation data.
          #
          #   If you provide this file, the data is used to generate validation metrics
          #   periodically during fine-tuning. These metrics can be viewed in the fine-tuning
          #   results file. The same data should not be present in both train and validation
          #   files.
          #
          #   Your dataset must be formatted as a JSONL file. You must upload your file with
          #   the purpose `fine-tune`.
          #
          #   See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
          #   for more details.
          validation_file: nil,
          request_options: {}
        )
        end

        # Get info about a fine-tuning job.
        #
        #   [Learn more about fine-tuning](https://platform.openai.com/docs/guides/fine-tuning)
        sig do
          params(
            fine_tuning_job_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Models::FineTuning::FineTuningJob)
        end
        def retrieve(
          # The ID of the fine-tuning job.
          fine_tuning_job_id,
          request_options: {}
        )
        end

        # List your organization's fine-tuning jobs
        sig do
          params(
            after: String,
            limit: Integer,
            metadata: T.nilable(T::Hash[Symbol, String]),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::CursorPage[OpenAI::Models::FineTuning::FineTuningJob])
        end
        def list(
          # Identifier for the last job from the previous pagination request.
          after: nil,
          # Number of fine-tuning jobs to retrieve.
          limit: nil,
          # Optional metadata filter. To filter, use the syntax `metadata[k]=v`.
          #   Alternatively, set `metadata=null` to indicate no metadata.
          metadata: nil,
          request_options: {}
        )
        end

        # Immediately cancel a fine-tune job.
        sig do
          params(
            fine_tuning_job_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::Models::FineTuning::FineTuningJob)
        end
        def cancel(
          # The ID of the fine-tuning job to cancel.
          fine_tuning_job_id,
          request_options: {}
        )
        end

        # Get status updates for a fine-tuning job.
        sig do
          params(
            fine_tuning_job_id: String,
            after: String,
            limit: Integer,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(OpenAI::CursorPage[OpenAI::Models::FineTuning::FineTuningJobEvent])
        end
        def list_events(
          # The ID of the fine-tuning job to get events for.
          fine_tuning_job_id,
          # Identifier for the last event from the previous pagination request.
          after: nil,
          # Number of events to retrieve.
          limit: nil,
          request_options: {}
        )
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
