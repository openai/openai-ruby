# typed: strong

module OpenAI
  module Resources
    class Evals
      class Runs
        class OutputItems
          # Get an evaluation run output item by ID.
          sig do
            params(
              output_item_id: String,
              eval_id: String,
              run_id: String,
              request_options: OpenAI::RequestOpts
            )
              .returns(OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse)
          end
          def retrieve(
            # The ID of the output item to retrieve.
            output_item_id,
            # The ID of the evaluation to retrieve runs for.
            eval_id:,
            # The ID of the run to retrieve.
            run_id:,
            request_options: {}
          ); end
          # Get a list of output items for an evaluation run.
          sig do
            params(
              run_id: String,
              eval_id: String,
              after: String,
              limit: Integer,
              order: OpenAI::Models::Evals::Runs::OutputItemListParams::Order::OrSymbol,
              status: OpenAI::Models::Evals::Runs::OutputItemListParams::Status::OrSymbol,
              request_options: OpenAI::RequestOpts
            )
              .returns(OpenAI::Internal::CursorPage[OpenAI::Models::Evals::Runs::OutputItemListResponse])
          end
          def list(
            # Path param: The ID of the run to retrieve output items for.
            run_id,
            # Path param: The ID of the evaluation to retrieve runs for.
            eval_id:,
            # Query param: Identifier for the last output item from the previous pagination
            # request.
            after: nil,
            # Query param: Number of output items to retrieve.
            limit: nil,
            # Query param: Sort order for output items by timestamp. Use `asc` for ascending
            # order or `desc` for descending order. Defaults to `asc`.
            order: nil,
            # Query param: Filter output items by status. Use `failed` to filter by failed
            # output items or `pass` to filter by passed output items.
            status: nil,
            request_options: {}
          ); end
          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:); end
        end
      end
    end
  end
end
