# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        class Runs
          class Steps
            # Retrieves a run step.
            #
            # @param step_id [String] Path param: The ID of the run step to retrieve.
            #
            # @param params [OpenAI::Models::Beta::Threads::Runs::StepRetrieveParams, Hash{Symbol=>Object}] .
            #
            #   @option params [String] :thread_id Path param: The ID of the thread to which the run and run step belongs.
            #
            #   @option params [String] :run_id Path param: The ID of the run to which the run step belongs.
            #
            #   @option params [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>] :include Query param: A list of additional fields to include in the response. Currently
            #     the only supported value is
            #     `step_details.tool_calls[*].file_search.results[*].content` to fetch the file
            #     search result content.
            #
            #     See the
            #     [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            #     for more information.
            #
            #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
            #
            # @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
            def retrieve(step_id, params)
              parsed, options = OpenAI::Models::Beta::Threads::Runs::StepRetrieveParams.dump_request(params)
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
                path: ["threads/%0s/runs/%1s/steps/%2s", thread_id, run_id, step_id],
                query: parsed,
                model: OpenAI::Models::Beta::Threads::Runs::RunStep,
                options: options
              )
            end

            # Returns a list of run steps belonging to a run.
            #
            # @param run_id [String] Path param: The ID of the run the run steps belong to.
            #
            # @param params [OpenAI::Models::Beta::Threads::Runs::StepListParams, Hash{Symbol=>Object}] .
            #
            #   @option params [String] :thread_id Path param: The ID of the thread the run and run steps belong to.
            #
            #   @option params [String] :after Query param: A cursor for use in pagination. `after` is an object ID that
            #     defines your place in the list. For instance, if you make a list request and
            #     receive 100 objects, ending with obj_foo, your subsequent call can include
            #     after=obj_foo in order to fetch the next page of the list.
            #
            #   @option params [String] :before Query param: A cursor for use in pagination. `before` is an object ID that
            #     defines your place in the list. For instance, if you make a list request and
            #     receive 100 objects, starting with obj_foo, your subsequent call can include
            #     before=obj_foo in order to fetch the previous page of the list.
            #
            #   @option params [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>] :include Query param: A list of additional fields to include in the response. Currently
            #     the only supported value is
            #     `step_details.tool_calls[*].file_search.results[*].content` to fetch the file
            #     search result content.
            #
            #     See the
            #     [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            #     for more information.
            #
            #   @option params [Integer] :limit Query param: A limit on the number of objects to be returned. Limit can range
            #     between 1 and 100, and the default is 20.
            #
            #   @option params [Symbol, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order] :order Query param: Sort order by the `created_at` timestamp of the objects. `asc` for
            #     ascending order and `desc` for descending order.
            #
            #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
            #
            # @return [OpenAI::CursorPage<OpenAI::Models::Beta::Threads::Runs::RunStep>]
            def list(run_id, params)
              parsed, options = OpenAI::Models::Beta::Threads::Runs::StepListParams.dump_request(params)
              thread_id =
                parsed.delete(:thread_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["threads/%0s/runs/%1s/steps", thread_id, run_id],
                query: parsed,
                page: OpenAI::CursorPage,
                model: OpenAI::Models::Beta::Threads::Runs::RunStep,
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
end
