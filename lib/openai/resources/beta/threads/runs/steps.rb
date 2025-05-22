# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        class Runs
          class Steps
            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Beta::Threads::Runs::StepRetrieveParams} for more details.
            #
            # Retrieves a run step.
            #
            # @overload retrieve(step_id, thread_id:, run_id:, include: nil, request_options: {})
            #
            # @param step_id [String] Path param: The ID of the run step to retrieve.
            #
            # @param thread_id [String] Path param: The ID of the thread to which the run and run step belongs.
            #
            # @param run_id [String] Path param: The ID of the run to which the run step belongs.
            #
            # @param include [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>] Query param: A list of additional fields to include in the response. Currently t
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
            #
            # @see OpenAI::Models::Beta::Threads::Runs::StepRetrieveParams
            def retrieve(step_id, params)
              parsed, options = OpenAI::Beta::Threads::Runs::StepRetrieveParams.dump_request(params)
              thread_id =
                parsed.delete(:thread_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              run_id =
                parsed.delete(:run_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["threads/%1$s/runs/%2$s/steps/%3$s", thread_id, run_id, step_id],
                query: parsed,
                model: OpenAI::Beta::Threads::Runs::RunStep,
                options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Beta::Threads::Runs::StepListParams} for more details.
            #
            # Returns a list of run steps belonging to a run.
            #
            # @overload list(run_id, thread_id:, after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {})
            #
            # @param run_id [String] Path param: The ID of the run the run steps belong to.
            #
            # @param thread_id [String] Path param: The ID of the thread the run and run steps belong to.
            #
            # @param after [String] Query param: A cursor for use in pagination. `after` is an object ID that define
            #
            # @param before [String] Query param: A cursor for use in pagination. `before` is an object ID that defin
            #
            # @param include [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>] Query param: A list of additional fields to include in the response. Currently t
            #
            # @param limit [Integer] Query param: A limit on the number of objects to be returned. Limit can range be
            #
            # @param order [Symbol, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order] Query param: Sort order by the `created_at` timestamp of the objects. `asc` for
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Threads::Runs::RunStep>]
            #
            # @see OpenAI::Models::Beta::Threads::Runs::StepListParams
            def list(run_id, params)
              parsed, options = OpenAI::Beta::Threads::Runs::StepListParams.dump_request(params)
              thread_id =
                parsed.delete(:thread_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["threads/%1$s/runs/%2$s/steps", thread_id, run_id],
                query: parsed,
                page: OpenAI::Internal::CursorPage,
                model: OpenAI::Beta::Threads::Runs::RunStep,
                options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
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
end
