# typed: strong

module OpenAI
  module Resources
    class Evals
      class Runs
        sig { returns(OpenAI::Resources::Evals::Runs::OutputItems) }
        attr_reader :output_items

        # Create a new evaluation run. This is the endpoint that will kick off grading.
        sig do
          params(
            eval_id: String,
            data_source: T.any(
              OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource,
              OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource
            ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
          )
            .returns(OpenAI::Models::Evals::RunCreateResponse)
        end
        def create(
          # The ID of the evaluation to create a run for.
          eval_id,
          # Details about the run's data source.
          data_source:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # The name of the run.
          name: nil,
          request_options: {}
        ); end
        # Get an evaluation run by ID.
        sig do
          params(
            run_id: String,
            eval_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
          )
            .returns(OpenAI::Models::Evals::RunRetrieveResponse)
        end
        def retrieve(
          # The ID of the run to retrieve.
          run_id,
          # The ID of the evaluation to retrieve runs for.
          eval_id:,
          request_options: {}
        ); end
        # Get a list of runs for an evaluation.
        sig do
          params(
            eval_id: String,
            after: String,
            limit: Integer,
            order: OpenAI::Models::Evals::RunListParams::Order::OrSymbol,
            status: OpenAI::Models::Evals::RunListParams::Status::OrSymbol,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
          )
            .returns(OpenAI::Internal::CursorPage[OpenAI::Models::Evals::RunListResponse])
        end
        def list(
          # The ID of the evaluation to retrieve runs for.
          eval_id,
          # Identifier for the last run from the previous pagination request.
          after: nil,
          # Number of runs to retrieve.
          limit: nil,
          # Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for
          # descending order. Defaults to `asc`.
          order: nil,
          # Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed`
          # | `canceled`.
          status: nil,
          request_options: {}
        ); end
        # Delete an eval run.
        sig do
          params(
            run_id: String,
            eval_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
          )
            .returns(OpenAI::Models::Evals::RunDeleteResponse)
        end
        def delete(
          # The ID of the run to delete.
          run_id,
          # The ID of the evaluation to delete the run from.
          eval_id:,
          request_options: {}
        ); end
        # Cancel an ongoing evaluation run.
        sig do
          params(
            run_id: String,
            eval_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
          )
            .returns(OpenAI::Models::Evals::RunCancelResponse)
        end
        def cancel(
          # The ID of the run to cancel.
          run_id,
          # The ID of the evaluation whose run you want to cancel.
          eval_id:,
          request_options: {}
        ); end
        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:); end
      end
    end
  end
end
