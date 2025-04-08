# frozen_string_literal: true

module OpenAI
  module Resources
    class Evals
      class Runs
        class OutputItems
          # Get an evaluation run output item by ID.
          #
          # @overload retrieve(output_item_id, eval_id:, run_id:, request_options: {})
          #
          # @param output_item_id [String]
          # @param eval_id [String]
          # @param run_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse]
          #
          # @see OpenAI::Models::Evals::Runs::OutputItemRetrieveParams
          def retrieve(output_item_id, params)
            parsed, options = OpenAI::Models::Evals::Runs::OutputItemRetrieveParams.dump_request(params)
            eval_id =
              parsed.delete(:eval_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            run_id =
              parsed.delete(:run_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :get,
              path: ["evals/%1$s/runs/%2$s/output_items/%3$s", eval_id, run_id, output_item_id],
              model: OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse,
              options: options
            )
          end

          # Get a list of output items for an evaluation run.
          #
          # @overload list(run_id, eval_id:, after: nil, limit: nil, order: nil, status: nil, request_options: {})
          #
          # @param run_id [String]
          # @param eval_id [String]
          # @param after [String]
          # @param limit [Integer]
          # @param order [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Order]
          # @param status [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Status]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Evals::Runs::OutputItemListResponse>]
          #
          # @see OpenAI::Models::Evals::Runs::OutputItemListParams
          def list(run_id, params)
            parsed, options = OpenAI::Models::Evals::Runs::OutputItemListParams.dump_request(params)
            eval_id =
              parsed.delete(:eval_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :get,
              path: ["evals/%1$s/runs/%2$s/output_items", eval_id, run_id],
              query: parsed,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Models::Evals::Runs::OutputItemListResponse,
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
