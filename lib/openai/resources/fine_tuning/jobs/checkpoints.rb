# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Jobs
        # Manage fine-tuning jobs to tailor a model to your specific training data.
        class Checkpoints
          # Returns a wrapper that exposes the raw HTTP response for each request.
          #
          # @return [Checkpoints::WithRawResponse]
          def with_raw_response
            WithRawResponse.new(
              resource: Checkpoints.new(
                client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
              )
            )
          end

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
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: ["fine_tuning/jobs/%1$s/checkpoints", fine_tuning_job_id],
              query: query,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::FineTuning::Jobs::FineTuningJobCheckpoint,
              security: {bearer_auth: true},
              options: options
            )
          end

          # @api private
          #
          # @param client [OpenAI::Internal::Transport::RequestClient]
          def initialize(client:)
            @client = client
          end

          class WithRawResponse
            def list(fine_tuning_job_id, params = {})
              @resource.list(fine_tuning_job_id, params)
            end

            # @api private
            #
            # @param resource [Checkpoints]
            def initialize(resource:)
              @resource = resource
            end
          end
        end
      end
    end
  end
end
