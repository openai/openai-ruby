# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Jobs
        class Checkpoints
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::FineTuning::Jobs::CheckpointListParams} for more details.
          #
          # List checkpoints for a fine-tuning job.
          #
          # @overload list(fine_tuning_job_id, after: nil, limit: nil, request_options: {})
          #
          # @param fine_tuning_job_id [String] The ID of the fine-tuning job to get checkpoints for.
          #
          # @param after [String] Identifier for the last checkpoint ID from the previous pagination request.
          #
          # @param limit [Integer] Number of checkpoints to retrieve.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint>]
          #
          # @see OpenAI::Models::FineTuning::Jobs::CheckpointListParams
          def list(fine_tuning_job_id, params = {})
            parsed, options = OpenAI::FineTuning::Jobs::CheckpointListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["fine_tuning/jobs/%1$s/checkpoints", fine_tuning_job_id],
              query: parsed,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::FineTuning::Jobs::FineTuningJobCheckpoint,
              options: options
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
