# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Jobs
        # @return [OpenAI::Resources::FineTuning::Jobs::Checkpoints]
        attr_reader :checkpoints

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::FineTuning::JobCreateParams} for more details.
        #
        # Creates a fine-tuning job which begins the process of creating a new model from
        # a given dataset.
        #
        # Response includes details of the enqueued job including job status and the name
        # of the fine-tuned models once complete.
        #
        # [Learn more about fine-tuning](https://platform.openai.com/docs/guides/fine-tuning)
        #
        # @overload create(model:, training_file:, hyperparameters: nil, integrations: nil, metadata: nil, method_: nil, seed: nil, suffix: nil, validation_file: nil, request_options: {})
        #
        # @param model [String, Symbol, OpenAI::Models::FineTuning::JobCreateParams::Model] The name of the model to fine-tune. You can select one of the ...
        #
        # @param training_file [String] The ID of an uploaded file that contains training data. ...
        #
        # @param hyperparameters [OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters] The hyperparameters used for the fine-tuning job. ...
        #
        # @param integrations [Array<OpenAI::Models::FineTuning::JobCreateParams::Integration>, nil] A list of integrations to enable for your fine-tuning job.
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
        #
        # @param method_ [OpenAI::Models::FineTuning::JobCreateParams::Method] The method used for fine-tuning.
        #
        # @param seed [Integer, nil] The seed controls the reproducibility of the job. Passing in the same seed and j
        # ...
        #
        # @param suffix [String, nil] A string of up to 64 characters that will be added to your fine-tuned model name
        # ...
        #
        # @param validation_file [String, nil] The ID of an uploaded file that contains validation data. ...
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
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

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::FineTuning::JobRetrieveParams} for more details.
        #
        # Get info about a fine-tuning job.
        #
        # [Learn more about fine-tuning](https://platform.openai.com/docs/guides/fine-tuning)
        #
        # @overload retrieve(fine_tuning_job_id, request_options: {})
        #
        # @param fine_tuning_job_id [String] The ID of the fine-tuning job. ...
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
            model: OpenAI::Models::FineTuning::FineTuningJob,
            options: params[:request_options]
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::FineTuning::JobListParams} for more details.
        #
        # List your organization's fine-tuning jobs
        #
        # @overload list(after: nil, limit: nil, metadata: nil, request_options: {})
        #
        # @param after [String] Identifier for the last job from the previous pagination request.
        #
        # @param limit [Integer] Number of fine-tuning jobs to retrieve.
        #
        # @param metadata [Hash{Symbol=>String}, nil] Optional metadata filter. To filter, use the syntax `metadata[k]=v`. Alternative
        # ...
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::FineTuning::FineTuningJob>]
        #
        # @see OpenAI::Models::FineTuning::JobListParams
        def list(params = {})
          parsed, options = OpenAI::Models::FineTuning::JobListParams.dump_request(params)
          @client.request(
            method: :get,
            path: "fine_tuning/jobs",
            query: parsed,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Models::FineTuning::FineTuningJob,
            options: options
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::FineTuning::JobCancelParams} for more details.
        #
        # Immediately cancel a fine-tune job.
        #
        # @overload cancel(fine_tuning_job_id, request_options: {})
        #
        # @param fine_tuning_job_id [String] The ID of the fine-tuning job to cancel. ...
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
            model: OpenAI::Models::FineTuning::FineTuningJob,
            options: params[:request_options]
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::FineTuning::JobListEventsParams} for more details.
        #
        # Get status updates for a fine-tuning job.
        #
        # @overload list_events(fine_tuning_job_id, after: nil, limit: nil, request_options: {})
        #
        # @param fine_tuning_job_id [String] The ID of the fine-tuning job to get events for. ...
        #
        # @param after [String] Identifier for the last event from the previous pagination request.
        #
        # @param limit [Integer] Number of events to retrieve.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::FineTuning::FineTuningJobEvent>]
        #
        # @see OpenAI::Models::FineTuning::JobListEventsParams
        def list_events(fine_tuning_job_id, params = {})
          parsed, options = OpenAI::Models::FineTuning::JobListEventsParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["fine_tuning/jobs/%1$s/events", fine_tuning_job_id],
            query: parsed,
            page: OpenAI::Internal::CursorPage,
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
