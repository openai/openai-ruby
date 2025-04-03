# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Jobs
        class Checkpoints
          # List checkpoints for a fine-tuning job.
          #
          # @overload list(fine_tuning_job_id, after: nil, limit: nil, request_options: {})
          #
          # @param fine_tuning_job_id [String]
          # @param after [String]
          # @param limit [Integer]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint>]
          #
          # @see OpenAI::Models::FineTuning::Jobs::CheckpointListParams
          def list(fine_tuning_job_id, params = {})
            parsed, options = OpenAI::Models::FineTuning::Jobs::CheckpointListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["fine_tuning/jobs/%1$s/checkpoints", fine_tuning_job_id],
              query: parsed,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Models::FineTuning::Jobs::FineTuningJobCheckpoint,
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
