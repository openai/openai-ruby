# typed: strong

module OpenAI
  module Resources
    class Beta
      class Threads
        class Runs
          class Steps
            # Retrieves a run step.
            sig do
              params(
                step_id: String,
                thread_id: String,
                run_id: String,
                include: T::Array[OpenAI::Models::Beta::Threads::Runs::RunStepInclude::OrSymbol],
                request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
              )
                .returns(OpenAI::Models::Beta::Threads::Runs::RunStep)
            end
            def retrieve(
              # Path param: The ID of the run step to retrieve.
              step_id,
              # Path param: The ID of the thread to which the run and run step belongs.
              thread_id:,
              # Path param: The ID of the run to which the run step belongs.
              run_id:,
              # Query param: A list of additional fields to include in the response. Currently
              #   the only supported value is
              #   `step_details.tool_calls[*].file_search.results[*].content` to fetch the file
              #   search result content.
              #
              #   See the
              #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
              #   for more information.
              include: nil,
              request_options: {}
            ); end
            # Returns a list of run steps belonging to a run.
            sig do
              params(
                run_id: String,
                thread_id: String,
                after: String,
                before: String,
                include: T::Array[OpenAI::Models::Beta::Threads::Runs::RunStepInclude::OrSymbol],
                limit: Integer,
                order: OpenAI::Models::Beta::Threads::Runs::StepListParams::Order::OrSymbol,
                request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
              )
                .returns(OpenAI::Internal::CursorPage[OpenAI::Models::Beta::Threads::Runs::RunStep])
            end
            def list(
              # Path param: The ID of the run the run steps belong to.
              run_id,
              # Path param: The ID of the thread the run and run steps belong to.
              thread_id:,
              # Query param: A cursor for use in pagination. `after` is an object ID that
              #   defines your place in the list. For instance, if you make a list request and
              #   receive 100 objects, ending with obj_foo, your subsequent call can include
              #   after=obj_foo in order to fetch the next page of the list.
              after: nil,
              # Query param: A cursor for use in pagination. `before` is an object ID that
              #   defines your place in the list. For instance, if you make a list request and
              #   receive 100 objects, starting with obj_foo, your subsequent call can include
              #   before=obj_foo in order to fetch the previous page of the list.
              before: nil,
              # Query param: A list of additional fields to include in the response. Currently
              #   the only supported value is
              #   `step_details.tool_calls[*].file_search.results[*].content` to fetch the file
              #   search result content.
              #
              #   See the
              #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
              #   for more information.
              include: nil,
              # Query param: A limit on the number of objects to be returned. Limit can range
              #   between 1 and 100, and the default is 20.
              limit: nil,
              # Query param: Sort order by the `created_at` timestamp of the objects. `asc` for
              #   ascending order and `desc` for descending order.
              order: nil,
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
end
