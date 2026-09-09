# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        class Runs
          # @deprecated The Assistants API is deprecated in favor of the Responses API
          #
          # Build Assistants that can call models and use tools.
          class Steps
            # @deprecated The Assistants API is deprecated in favor of the Responses API
            #
            # Retrieves a run step.
            #
            # @overload retrieve(step_id, thread_id:, run_id:, include: nil, request_options: {})
            #
            # @param step_id [String]
            #   Path param: The ID of the run step to retrieve.
            #
            # @param thread_id [String]
            #   Path param: The ID of the thread to which the run and run step belongs.
            #
            # @param run_id [String]
            #   Path param: The ID of the run to which the run step belongs.
            #
            # @param include [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>]
            #   Query param: A list of additional fields to include in the response. Currently
            #   the only supported value is
            #   `step_details.tool_calls[*].file_search.results[*].content` to fetch the file
            #   search result content.
            #
            #   See the
            #   [file search tool documentation](https://developers.openai.com/api/docs/guides/tools-file-search#retrieval-customization)
            #   for more information.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
            #
            # @see OpenAI::Models::Beta::Threads::Runs::StepRetrieveParams
            def retrieve(step_id, params)
              parsed, options = OpenAI::Beta::Threads::Runs::StepRetrieveParams.dump_request(params)
              thread_id = parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              run_id = parsed.delete(:run_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["threads/%1$s/runs/%2$s/steps/%3$s", thread_id, run_id, step_id],
                query: query,
                model: OpenAI::Beta::Threads::Runs::RunStep,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
              )
            end

            # @deprecated The Assistants API is deprecated in favor of the Responses API
            #
            # Returns a list of run steps belonging to a run.
            #
            # @overload list(run_id, thread_id:, after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {})
            #
            # @param run_id [String]
            #   Path param: The ID of the run the run steps belong to.
            #
            # @param thread_id [String]
            #   Path param: The ID of the thread the run and run steps belong to.
            #
            # @param after [String]
            #   Query param: A cursor for use in pagination. `after` is an object ID that
            #   defines your place in the list. For instance, if you make a list request and
            #   receive 100 objects, ending with obj_foo, your subsequent call can include
            #   after=obj_foo in order to fetch the next page of the list.
            #
            # @param before [String]
            #   Query param: A cursor for use in pagination. `before` is an object ID that
            #   defines your place in the list. For instance, if you make a list request and
            #   receive 100 objects, starting with obj_foo, your subsequent call can include
            #   before=obj_foo in order to fetch the previous page of the list.
            #
            # @param include [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>]
            #   Query param: A list of additional fields to include in the response. Currently
            #   the only supported value is
            #   `step_details.tool_calls[*].file_search.results[*].content` to fetch the file
            #   search result content.
            #
            #   See the
            #   [file search tool documentation](https://developers.openai.com/api/docs/guides/tools-file-search#retrieval-customization)
            #   for more information.
            #
            # @param limit [Integer]
            #   Query param: A limit on the number of objects to be returned. Limit can range
            #   between 1 and 100, and the default is 20.
            #
            # @param order [Symbol, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order]
            #   Query param: Sort order by the `created_at` timestamp of the objects. `asc` for
            #   ascending order and `desc` for descending order.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Threads::Runs::RunStep>]
            #
            # @see OpenAI::Models::Beta::Threads::Runs::StepListParams
            def list(run_id, params)
              parsed, options = OpenAI::Beta::Threads::Runs::StepListParams.dump_request(params)
              thread_id = parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["threads/%1$s/runs/%2$s/steps", thread_id, run_id],
                query: query,
                page: OpenAI::Internal::CursorPage,
                model: OpenAI::Beta::Threads::Runs::RunStep,
                security: {bearer_auth: true},
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
