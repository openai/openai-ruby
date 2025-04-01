# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Jobs
        # @return [OpenAI::Resources::FineTuning::Jobs::Checkpoints]
        attr_reader :checkpoints

        # Creates a fine-tuning job which begins the process of creating a new model from
        #   a given dataset.
        #
        #   Response includes details of the enqueued job including job status and the name
        #   of the fine-tuned models once complete.
        #
        #   [Learn more about fine-tuning](https://platform.openai.com/docs/guides/fine-tuning)
        #
        # @param params [OpenAI::Models::FineTuning::JobCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String, Symbol] :model The name of the model to fine-tune. You can select one of the
        #     [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        #
        #   @option params [String] :training_file The ID of an uploaded file that contains training data.
        #
        #     See [upload file](https://platform.openai.com/docs/api-reference/files/create)
        #     for how to upload a file.
        #
        #     Your dataset must be formatted as a JSONL file. Additionally, you must upload
        #     your file with the purpose `fine-tune`.
        #
        #     The contents of the file should differ depending on if the model uses the
        #     [chat](https://platform.openai.com/docs/api-reference/fine-tuning/chat-input),
        #     [completions](https://platform.openai.com/docs/api-reference/fine-tuning/completions-input)
        #     format, or if the fine-tuning method uses the
        #     [preference](https://platform.openai.com/docs/api-reference/fine-tuning/preference-input)
        #     format.
        #
        #     See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
        #     for more details.
        #
        #   @option params [OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters] :hyperparameters The hyperparameters used for the fine-tuning job. This value is now deprecated
        #     in favor of `method`, and should be passed in under the `method` parameter.
        #
        #   @option params [Array<OpenAI::Models::FineTuning::JobCreateParams::Integration>, nil] :integrations A list of integrations to enable for your fine-tuning job.
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [OpenAI::Models::FineTuning::JobCreateParams::Method] :method_ The method used for fine-tuning.
        #
        #   @option params [Integer, nil] :seed The seed controls the reproducibility of the job. Passing in the same seed and
        #     job parameters should produce the same results, but may differ in rare cases. If
        #     a seed is not specified, one will be generated for you.
        #
        #   @option params [String, nil] :suffix A string of up to 64 characters that will be added to your fine-tuned model
        #     name.
        #
        #     For example, a `suffix` of "custom-model-name" would produce a model name like
        #     `ft:gpt-4o-mini:openai:custom-model-name:7p4lURel`.
        #
        #   @option params [String, nil] :validation_file The ID of an uploaded file that contains validation data.
        #
        #     If you provide this file, the data is used to generate validation metrics
        #     periodically during fine-tuning. These metrics can be viewed in the fine-tuning
        #     results file. The same data should not be present in both train and validation
        #     files.
        #
        #     Your dataset must be formatted as a JSONL file. You must upload your file with
        #     the purpose `fine-tune`.
        #
        #     See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
        #     for more details.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::FineTuning::FineTuningJob]
        #
        # @see OpenAI::Models::FineTuning::JobCreateParams
        def create(params)
          parsed, options = OpenAI::Models::FineTuning::JobCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "fine_tuning/jobs",
            body: parsed,
            model: OpenAI::Models::FineTuning::FineTuningJob,
            options: options
          )
        end

        # Get info about a fine-tuning job.
        #
        #   [Learn more about fine-tuning](https://platform.openai.com/docs/guides/fine-tuning)
        #
        # @param fine_tuning_job_id [String] The ID of the fine-tuning job.
        #
        # @param params [OpenAI::Models::FineTuning::JobRetrieveParams, Hash{Symbol=>Object}] .
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::FineTuning::FineTuningJob]
        #
        # @see OpenAI::Models::FineTuning::JobRetrieveParams
        def retrieve(fine_tuning_job_id, params = {})
          @client.request(
            method: :get,
            path: ["fine_tuning/jobs/%1$s", fine_tuning_job_id],
            model: OpenAI::Models::FineTuning::FineTuningJob,
            options: params[:request_options]
          )
        end

        # List your organization's fine-tuning jobs
        #
        # @param params [OpenAI::Models::FineTuning::JobListParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :after Identifier for the last job from the previous pagination request.
        #
        #   @option params [Integer] :limit Number of fine-tuning jobs to retrieve.
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Optional metadata filter. To filter, use the syntax `metadata[k]=v`.
        #     Alternatively, set `metadata=null` to indicate no metadata.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::CursorPage<OpenAI::Models::FineTuning::FineTuningJob>]
        #
        # @see OpenAI::Models::FineTuning::JobListParams
        def list(params = {})
          parsed, options = OpenAI::Models::FineTuning::JobListParams.dump_request(params)
          @client.request(
            method: :get,
            path: "fine_tuning/jobs",
            query: parsed,
            page: OpenAI::CursorPage,
            model: OpenAI::Models::FineTuning::FineTuningJob,
            options: options
          )
        end

        # Immediately cancel a fine-tune job.
        #
        # @param fine_tuning_job_id [String] The ID of the fine-tuning job to cancel.
        #
        # @param params [OpenAI::Models::FineTuning::JobCancelParams, Hash{Symbol=>Object}] .
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::FineTuning::FineTuningJob]
        #
        # @see OpenAI::Models::FineTuning::JobCancelParams
        def cancel(fine_tuning_job_id, params = {})
          @client.request(
            method: :post,
            path: ["fine_tuning/jobs/%1$s/cancel", fine_tuning_job_id],
            model: OpenAI::Models::FineTuning::FineTuningJob,
            options: params[:request_options]
          )
        end

        # Get status updates for a fine-tuning job.
        #
        # @param fine_tuning_job_id [String] The ID of the fine-tuning job to get events for.
        #
        # @param params [OpenAI::Models::FineTuning::JobListEventsParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :after Identifier for the last event from the previous pagination request.
        #
        #   @option params [Integer] :limit Number of events to retrieve.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::CursorPage<OpenAI::Models::FineTuning::FineTuningJobEvent>]
        #
        # @see OpenAI::Models::FineTuning::JobListEventsParams
        def list_events(fine_tuning_job_id, params = {})
          parsed, options = OpenAI::Models::FineTuning::JobListEventsParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["fine_tuning/jobs/%1$s/events", fine_tuning_job_id],
            query: parsed,
            page: OpenAI::CursorPage,
            model: OpenAI::Models::FineTuning::FineTuningJobEvent,
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @checkpoints = OpenAI::Resources::FineTuning::Jobs::Checkpoints.new(client: client)
        end
      end
    end
  end
end
