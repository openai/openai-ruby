# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Jobs
        class Checkpoints
          # List checkpoints for a fine-tuning job.
          #
          # @param fine_tuning_job_id [String] The ID of the fine-tuning job to get checkpoints for.
          #
          # @param params [OpenAI::Models::FineTuning::Jobs::CheckpointListParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :after Identifier for the last checkpoint ID from the previous pagination request.
          #
          #   @option params [Integer] :limit Number of checkpoints to retrieve.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::CursorPage<OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint>]
          def list(fine_tuning_job_id, params = {})
            parsed, options = OpenAI::Models::FineTuning::Jobs::CheckpointListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["fine_tuning/jobs/%0s/checkpoints", fine_tuning_job_id],
              query: parsed,
              page: OpenAI::CursorPage,
              model: OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint,
              options: options
            )
          end

          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
