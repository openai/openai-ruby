# frozen_string_literal: true

module OpenAI
  module Resources
    class Evals
      class Runs
        # @return [OpenAI::Resources::Evals::Runs::OutputItems]
        attr_reader :output_items

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Evals::RunCreateParams} for more details.
        #
        # Create a new evaluation run. This is the endpoint that will kick off grading.
        #
        # @overload create(eval_id, data_source:, metadata: nil, name: nil, request_options: {})
        #
        # @param eval_id [String] The ID of the evaluation to create a run for.
        #
        # @param data_source [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource] Details about the run's data source.
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
        #
        # @param name [String] The name of the run.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Evals::RunCreateResponse]
        #
        # @see OpenAI::Models::Evals::RunCreateParams
        def create(eval_id, params)
          parsed, options = OpenAI::Models::Evals::RunCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["evals/%1$s/runs", eval_id],
            body: parsed,
            model: OpenAI::Models::Evals::RunCreateResponse,
            options: options
          )
        end

        # Get an evaluation run by ID.
        #
        # @overload retrieve(run_id, eval_id:, request_options: {})
        #
        # @param run_id [String] The ID of the run to retrieve.
        #
        # @param eval_id [String] The ID of the evaluation to retrieve runs for.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Evals::RunRetrieveResponse]
        #
        # @see OpenAI::Models::Evals::RunRetrieveParams
        def retrieve(run_id, params)
          parsed, options = OpenAI::Models::Evals::RunRetrieveParams.dump_request(params)
          eval_id =
            parsed.delete(:eval_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["evals/%1$s/runs/%2$s", eval_id, run_id],
            model: OpenAI::Models::Evals::RunRetrieveResponse,
            options: options
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Evals::RunListParams} for more details.
        #
        # Get a list of runs for an evaluation.
        #
        # @overload list(eval_id, after: nil, limit: nil, order: nil, status: nil, request_options: {})
        #
        # @param eval_id [String] The ID of the evaluation to retrieve runs for.
        #
        # @param after [String] Identifier for the last run from the previous pagination request.
        #
        # @param limit [Integer] Number of runs to retrieve.
        #
        # @param order [Symbol, OpenAI::Models::Evals::RunListParams::Order] Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for de
        # ...
        #
        # @param status [Symbol, OpenAI::Models::Evals::RunListParams::Status] Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed`
        # ...
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Evals::RunListResponse>]
        #
        # @see OpenAI::Models::Evals::RunListParams
        def list(eval_id, params = {})
          parsed, options = OpenAI::Models::Evals::RunListParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["evals/%1$s/runs", eval_id],
            query: parsed,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Models::Evals::RunListResponse,
            options: options
          )
        end

        # Delete an eval run.
        #
        # @overload delete(run_id, eval_id:, request_options: {})
        #
        # @param run_id [String] The ID of the run to delete.
        #
        # @param eval_id [String] The ID of the evaluation to delete the run from.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Evals::RunDeleteResponse]
        #
        # @see OpenAI::Models::Evals::RunDeleteParams
        def delete(run_id, params)
          parsed, options = OpenAI::Models::Evals::RunDeleteParams.dump_request(params)
          eval_id =
            parsed.delete(:eval_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :delete,
            path: ["evals/%1$s/runs/%2$s", eval_id, run_id],
            model: OpenAI::Models::Evals::RunDeleteResponse,
            options: options
          )
        end

        # Cancel an ongoing evaluation run.
        #
        # @overload cancel(run_id, eval_id:, request_options: {})
        #
        # @param run_id [String] The ID of the run to cancel.
        #
        # @param eval_id [String] The ID of the evaluation whose run you want to cancel.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Evals::RunCancelResponse]
        #
        # @see OpenAI::Models::Evals::RunCancelParams
        def cancel(run_id, params)
          parsed, options = OpenAI::Models::Evals::RunCancelParams.dump_request(params)
          eval_id =
            parsed.delete(:eval_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :post,
            path: ["evals/%1$s/runs/%2$s", eval_id, run_id],
            model: OpenAI::Models::Evals::RunCancelResponse,
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @output_items = OpenAI::Resources::Evals::Runs::OutputItems.new(client: client)
        end
      end
    end
  end
end
