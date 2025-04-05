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
        # @overload create(model:, training_file:, hyperparameters: nil, integrations: nil, metadata: nil, method_: nil, seed: nil, suffix: nil, validation_file: nil, request_options: {})
        #
        # @param model [String, Symbol, OpenAI::Models::FineTuning::JobCreateParams::Model]
        # @param training_file [String]
        # @param hyperparameters [OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters]
        # @param integrations [Array<OpenAI::Models::FineTuning::JobCreateParams::Integration>, nil]
        # @param metadata [Hash{Symbol=>String}, nil]
        # @param method_ [OpenAI::Models::FineTuning::JobCreateParams::Method]
        # @param seed [Integer, nil]
        # @param suffix [String, nil]
        # @param validation_file [String, nil]
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
            body: parsed.transform_keys(method_: :method),
            model: OpenAI::Models::FineTuning::FineTuningJob,
            options: options
          )
        end

        # Get info about a fine-tuning job.
        #
        #   [Learn more about fine-tuning](https://platform.openai.com/docs/guides/fine-tuning)
        #
        # @overload retrieve(fine_tuning_job_id, request_options: {})
        #
        # @param fine_tuning_job_id [String]
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

        # List your organization's fine-tuning jobs
        #
        # @overload list(after: nil, limit: nil, metadata: nil, request_options: {})
        #
        # @param after [String]
        # @param limit [Integer]
        # @param metadata [Hash{Symbol=>String}, nil]
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

        # Immediately cancel a fine-tune job.
        #
        # @overload cancel(fine_tuning_job_id, request_options: {})
        #
        # @param fine_tuning_job_id [String]
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

        # Get status updates for a fine-tuning job.
        #
        # @overload list_events(fine_tuning_job_id, after: nil, limit: nil, request_options: {})
        #
        # @param fine_tuning_job_id [String]
        # @param after [String]
        # @param limit [Integer]
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
