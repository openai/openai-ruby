# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      # Manage fine-tuning jobs to tailor a model to your specific training data.
      class Jobs
        # Manage fine-tuning jobs to tailor a model to your specific training data.
        # @return [OpenAI::Resources::FineTuning::Jobs::Checkpoints]
        attr_reader :checkpoints

        # Creates a fine-tuning job which begins the process of creating a new model from
        # a given dataset.
        #
        # Response includes details of the enqueued job including job status and the name
        # of the fine-tuned models once complete.
        #
        # [Learn more about fine-tuning](https://developers.openai.com/api/docs/guides/model-optimization)
        #
        # @overload create(model:, training_file:, hyperparameters: nil, integrations: nil, metadata: nil, method_: nil, seed: nil, suffix: nil, validation_file: nil, request_options: {})
        #
        # @param model [String, Symbol, OpenAI::Models::FineTuning::JobCreateParams::Model]
        #   The name of the model to fine-tune. You can select one of the
        #   [supported models](https://developers.openai.com/api/docs/guides/model-optimization#fine-tuning-methods).
        #
        # @param training_file [String]
        #   The ID of an uploaded file that contains training data.
        #
        #   See
        #   [upload file](https://developers.openai.com/api/reference/resources/files/methods/create)
        #   for how to upload a file.
        #
        #   Your dataset must be formatted as a JSONL file. Additionally, you must upload
        #   your file with the purpose `fine-tune`.
        #
        #   The contents of the file should differ depending on if the model uses the
        #   [chat](https://developers.openai.com/api/docs/guides/supervised-fine-tuning#formatting-your-data),
        #   [completions](https://developers.openai.com/api/docs/guides/supervised-fine-tuning#formatting-your-data)
        #   format, or if the fine-tuning method uses the
        #   [preference](https://developers.openai.com/api/docs/guides/direct-preference-optimization)
        #   format.
        #
        #   See the
        #   [fine-tuning guide](https://developers.openai.com/api/docs/guides/model-optimization)
        #   for more details.
        #
        # @param hyperparameters [OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters]
        #   The hyperparameters used for the fine-tuning job. This value is now deprecated
        #   in favor of `method`, and should be passed in under the `method` parameter.
        #
        # @param integrations [Array<OpenAI::Models::FineTuning::JobCreateParams::Integration>, nil]
        #   A list of integrations to enable for your fine-tuning job.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param method_ [OpenAI::Models::FineTuning::JobCreateParams::Method]
        #   The method used for fine-tuning.
        #
        # @param seed [Integer, nil]
        #   The seed controls the reproducibility of the job. Passing in the same seed and
        #   job parameters should produce the same results, but may differ in rare cases. If
        #   a seed is not specified, one will be generated for you.
        #
        # @param suffix [String, nil]
        #   A string of up to 64 characters that will be added to your fine-tuned model
        #   name.
        #
        #   For example, a `suffix` of "custom-model-name" would produce a model name like
        #   `ft:gpt-4o-mini:openai:custom-model-name:7p4lURel`.
        #
        # @param validation_file [String, nil]
        #   The ID of an uploaded file that contains validation data.
        #
        #   If you provide this file, the data is used to generate validation metrics
        #   periodically during fine-tuning. These metrics can be viewed in the fine-tuning
        #   results file. The same data should not be present in both train and validation
        #   files.
        #
        #   Your dataset must be formatted as a JSONL file. You must upload your file with
        #   the purpose `fine-tune`.
        #
        #   See the
        #   [fine-tuning guide](https://developers.openai.com/api/docs/guides/model-optimization)
        #   for more details.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::FineTuning::FineTuningJob]
        #
        # @see OpenAI::Models::FineTuning::JobCreateParams
        def create(params)
          parsed, options = OpenAI::FineTuning::JobCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "fine_tuning/jobs",
            body: parsed,
            model: OpenAI::FineTuning::FineTuningJob,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Get info about a fine-tuning job.
        #
        # [Learn more about fine-tuning](https://developers.openai.com/api/docs/guides/model-optimization)
        #
        # @overload retrieve(fine_tuning_job_id, request_options: {})
        #
        # @param fine_tuning_job_id [String]
        #   The ID of the fine-tuning job.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::FineTuning::FineTuningJob]
        #
        # @see OpenAI::Models::FineTuning::JobRetrieveParams
        def retrieve(fine_tuning_job_id, params = {})
          @client.request(
            method: :get,
            path: ["fine_tuning/jobs/%1$s", fine_tuning_job_id],
            model: OpenAI::FineTuning::FineTuningJob,
            security: {bearer_auth: true},
            options: params[:request_options]
          )
        end

        # List your organization's fine-tuning jobs
        #
        # @overload list(after: nil, limit: nil, metadata: nil, request_options: {})
        #
        # @param after [String]
        #   Identifier for the last job from the previous pagination request.
        #
        # @param limit [Integer]
        #   Number of fine-tuning jobs to retrieve.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Optional metadata filter. To filter, use the syntax `metadata[k]=v`.
        #   Alternatively, set `metadata=null` to indicate no metadata.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::FineTuning::FineTuningJob>]
        #
        # @see OpenAI::Models::FineTuning::JobListParams
        def list(params = {})
          parsed, options = OpenAI::FineTuning::JobListParams.dump_request(params)
          query = OpenAI::Internal::Util.encode_query_params(parsed)
          @client.request(
            method: :get,
            path: "fine_tuning/jobs",
            query: query,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::FineTuning::FineTuningJob,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Immediately cancel a fine-tune job.
        #
        # @overload cancel(fine_tuning_job_id, request_options: {})
        #
        # @param fine_tuning_job_id [String]
        #   The ID of the fine-tuning job to cancel.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::FineTuning::FineTuningJob]
        #
        # @see OpenAI::Models::FineTuning::JobCancelParams
        def cancel(fine_tuning_job_id, params = {})
          @client.request(
            method: :post,
            path: ["fine_tuning/jobs/%1$s/cancel", fine_tuning_job_id],
            model: OpenAI::FineTuning::FineTuningJob,
            security: {bearer_auth: true},
            options: params[:request_options]
          )
        end

        # Get status updates for a fine-tuning job.
        #
        # @overload list_events(fine_tuning_job_id, after: nil, limit: nil, request_options: {})
        #
        # @param fine_tuning_job_id [String]
        #   The ID of the fine-tuning job to get events for.
        #
        # @param after [String]
        #   Identifier for the last event from the previous pagination request.
        #
        # @param limit [Integer]
        #   Number of events to retrieve.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::FineTuning::FineTuningJobEvent>]
        #
        # @see OpenAI::Models::FineTuning::JobListEventsParams
        def list_events(fine_tuning_job_id, params = {})
          parsed, options = OpenAI::FineTuning::JobListEventsParams.dump_request(params)
          query = OpenAI::Internal::Util.encode_query_params(parsed)
          @client.request(
            method: :get,
            path: ["fine_tuning/jobs/%1$s/events", fine_tuning_job_id],
            query: query,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::FineTuning::FineTuningJobEvent,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Pause a fine-tune job.
        #
        # @overload pause(fine_tuning_job_id, request_options: {})
        #
        # @param fine_tuning_job_id [String]
        #   The ID of the fine-tuning job to pause.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::FineTuning::FineTuningJob]
        #
        # @see OpenAI::Models::FineTuning::JobPauseParams
        def pause(fine_tuning_job_id, params = {})
          @client.request(
            method: :post,
            path: ["fine_tuning/jobs/%1$s/pause", fine_tuning_job_id],
            model: OpenAI::FineTuning::FineTuningJob,
            security: {bearer_auth: true},
            options: params[:request_options]
          )
        end

        # Resume a fine-tune job.
        #
        # @overload resume(fine_tuning_job_id, request_options: {})
        #
        # @param fine_tuning_job_id [String]
        #   The ID of the fine-tuning job to resume.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::FineTuning::FineTuningJob]
        #
        # @see OpenAI::Models::FineTuning::JobResumeParams
        def resume(fine_tuning_job_id, params = {})
          @client.request(
            method: :post,
            path: ["fine_tuning/jobs/%1$s/resume", fine_tuning_job_id],
            model: OpenAI::FineTuning::FineTuningJob,
            security: {bearer_auth: true},
            options: params[:request_options]
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
