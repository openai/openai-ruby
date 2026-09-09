# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        # @deprecated The Assistants API is deprecated in favor of the Responses API
        #
        # Build Assistants that can call models and use tools.
        class Runs
          # Build Assistants that can call models and use tools.
          # @return [OpenAI::Resources::Beta::Threads::Runs::Steps]
          attr_reader :steps

          # @deprecated The Assistants API is deprecated in favor of the Responses API
          #
          # See {OpenAI::Resources::Beta::Threads::Runs#create_stream_raw} for streaming
          # counterpart.
          #
          # Create a run.
          #
          # @overload create(thread_id, assistant_id:, include: nil, additional_instructions: nil, additional_messages: nil, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_choice: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
          #
          # @param thread_id [String]
          #   Path param: The ID of the thread to run.
          #
          # @param assistant_id [String]
          #   Body param: The ID of the
          #   [assistant](https://developers.openai.com/api/docs/assistants/migration) to use
          #   to execute this run.
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
          # @param additional_instructions [String, nil]
          #   Body param: Appends additional instructions at the end of the instructions for
          #   the run. This is useful for modifying the behavior on a per-run basis without
          #   overriding other instructions.
          #
          # @param additional_messages [Array<OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage>, nil]
          #   Body param: Adds additional messages to the thread before creating the run.
          #
          # @param instructions [String, nil]
          #   Body param: Overrides the
          #   [instructions](https://developers.openai.com/api/docs/assistants/migration) of
          #   the assistant. This is useful for modifying the behavior on a per-run basis.
          #
          # @param max_completion_tokens [Integer, nil]
          #   Body param: The maximum number of completion tokens that may be used over the
          #   course of the run. The run will make a best effort to use only the number of
          #   completion tokens specified, across multiple turns of the run. If the run
          #   exceeds the number of completion tokens specified, the run will end with status
          #   `incomplete`. See `incomplete_details` for more info.
          #
          # @param max_prompt_tokens [Integer, nil]
          #   Body param: The maximum number of prompt tokens that may be used over the course
          #   of the run. The run will make a best effort to use only the number of prompt
          #   tokens specified, across multiple turns of the run. If the run exceeds the
          #   number of prompt tokens specified, the run will end with status `incomplete`.
          #   See `incomplete_details` for more info.
          #
          # @param metadata [Hash{Symbol=>String}, nil]
          #   Body param: Set of 16 key-value pairs that can be attached to an object. This
          #   can be useful for storing additional information about the object in a
          #   structured format, and querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          #
          # @param model [String, Symbol, OpenAI::Models::ChatModel, nil]
          #   Body param: The ID of the
          #   [Model](https://developers.openai.com/api/reference/resources/models) to be used
          #   to execute this run. If a value is provided here, it will override the model
          #   associated with the assistant. If not, the model associated with the assistant
          #   will be used.
          #
          # @param parallel_tool_calls [Boolean]
          #   Body param: Whether to enable
          #   [parallel function calling](https://developers.openai.com/api/docs/guides/function-calling#parallel-function-calling)
          #   during tool use.
          #
          # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
          #   Body param: Constrains effort on reasoning for reasoning models. Currently
          #   supported values are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and
          #   `max`. Reducing reasoning effort can result in faster responses and fewer tokens
          #   used on reasoning in a response. Not all reasoning models support every value.
          #   See the
          #   [reasoning guide](https://developers.openai.com/api/docs/guides/reasoning) for
          #   model-specific support.
          #
          # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
          #   Body param: Specifies the format that the model must output. Compatible with
          #   [GPT-4o](https://developers.openai.com/api/docs/models/gpt-4o),
          #   [GPT-4 Turbo](https://developers.openai.com/api/docs/models/gpt-4-turbo), and
          #   all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #   Outputs which ensures the model will match your supplied JSON schema. Learn more
          #   in the
          #   [Structured Outputs guide](https://developers.openai.com/api/docs/guides/structured-outputs).
          #
          #   Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          #   message the model generates is valid JSON.
          #
          #   **Important:** when using JSON mode, you **must** also instruct the model to
          #   produce JSON yourself via a system or user message. Without this, the model may
          #   generate an unending stream of whitespace until the generation reaches the token
          #   limit, resulting in a long-running and seemingly "stuck" request. Also note that
          #   the message content may be partially cut off if `finish_reason="length"`, which
          #   indicates the generation exceeded `max_tokens` or the conversation exceeded the
          #   max context length.
          #
          # @param temperature [Float, nil]
          #   Body param: What sampling temperature to use, between 0 and 2. Higher values
          #   like 0.8 will make the output more random, while lower values like 0.2 will make
          #   it more focused and deterministic.
          #
          # @param tool_choice [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil]
          #   Body param: Controls which (if any) tool is called by the model. `none` means
          #   the model will not call any tools and instead generates a message. `auto` is the
          #   default value and means the model can pick between generating a message or
          #   calling one or more tools. `required` means the model must call one or more
          #   tools before responding to the user. Specifying a particular tool like
          #   `{"type": "file_search"}` or
          #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #   call that tool.
          #
          # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
          #   Body param: Override the tools the assistant can use for this run. This is
          #   useful for modifying the behavior on a per-run basis.
          #
          # @param top_p [Float, nil]
          #   Body param: An alternative to sampling with temperature, called nucleus
          #   sampling, where the model considers the results of the tokens with top_p
          #   probability mass. So 0.1 means only the tokens comprising the top 10%
          #   probability mass are considered.
          #
          #   We generally recommend altering this or temperature but not both.
          #
          # @param truncation_strategy [OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy, nil]
          #   Body param: Controls for how a thread will be truncated prior to the run. Use
          #   this to control the initial context window of the run.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunCreateParams
          def create(thread_id, params)
            query_params = [:include]
            parsed, options = OpenAI::Beta::Threads::RunCreateParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed.slice(*query_params))
            if parsed[:stream]
              message = "Please use `#create_stream_raw` for the streaming use case."
              raise ArgumentError.new(message)
            end

            @client.request(
              method: :post,
              path: ["threads/%1$s/runs", thread_id],
              query: query,
              body: parsed.except(*query_params),
              model: OpenAI::Beta::Threads::Run,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # @deprecated The Assistants API is deprecated in favor of the Responses API
          #
          # See {OpenAI::Resources::Beta::Threads::Runs#create} for non-streaming
          # counterpart.
          #
          # Create a run.
          #
          # @overload create_stream_raw(thread_id, assistant_id:, include: nil, additional_instructions: nil, additional_messages: nil, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_choice: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
          #
          # @param thread_id [String]
          #   Path param: The ID of the thread to run.
          #
          # @param assistant_id [String]
          #   Body param: The ID of the
          #   [assistant](https://developers.openai.com/api/docs/assistants/migration) to use
          #   to execute this run.
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
          # @param additional_instructions [String, nil]
          #   Body param: Appends additional instructions at the end of the instructions for
          #   the run. This is useful for modifying the behavior on a per-run basis without
          #   overriding other instructions.
          #
          # @param additional_messages [Array<OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage>, nil]
          #   Body param: Adds additional messages to the thread before creating the run.
          #
          # @param instructions [String, nil]
          #   Body param: Overrides the
          #   [instructions](https://developers.openai.com/api/docs/assistants/migration) of
          #   the assistant. This is useful for modifying the behavior on a per-run basis.
          #
          # @param max_completion_tokens [Integer, nil]
          #   Body param: The maximum number of completion tokens that may be used over the
          #   course of the run. The run will make a best effort to use only the number of
          #   completion tokens specified, across multiple turns of the run. If the run
          #   exceeds the number of completion tokens specified, the run will end with status
          #   `incomplete`. See `incomplete_details` for more info.
          #
          # @param max_prompt_tokens [Integer, nil]
          #   Body param: The maximum number of prompt tokens that may be used over the course
          #   of the run. The run will make a best effort to use only the number of prompt
          #   tokens specified, across multiple turns of the run. If the run exceeds the
          #   number of prompt tokens specified, the run will end with status `incomplete`.
          #   See `incomplete_details` for more info.
          #
          # @param metadata [Hash{Symbol=>String}, nil]
          #   Body param: Set of 16 key-value pairs that can be attached to an object. This
          #   can be useful for storing additional information about the object in a
          #   structured format, and querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          #
          # @param model [String, Symbol, OpenAI::Models::ChatModel, nil]
          #   Body param: The ID of the
          #   [Model](https://developers.openai.com/api/reference/resources/models) to be used
          #   to execute this run. If a value is provided here, it will override the model
          #   associated with the assistant. If not, the model associated with the assistant
          #   will be used.
          #
          # @param parallel_tool_calls [Boolean]
          #   Body param: Whether to enable
          #   [parallel function calling](https://developers.openai.com/api/docs/guides/function-calling#parallel-function-calling)
          #   during tool use.
          #
          # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
          #   Body param: Constrains effort on reasoning for reasoning models. Currently
          #   supported values are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and
          #   `max`. Reducing reasoning effort can result in faster responses and fewer tokens
          #   used on reasoning in a response. Not all reasoning models support every value.
          #   See the
          #   [reasoning guide](https://developers.openai.com/api/docs/guides/reasoning) for
          #   model-specific support.
          #
          # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
          #   Body param: Specifies the format that the model must output. Compatible with
          #   [GPT-4o](https://developers.openai.com/api/docs/models/gpt-4o),
          #   [GPT-4 Turbo](https://developers.openai.com/api/docs/models/gpt-4-turbo), and
          #   all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #   Outputs which ensures the model will match your supplied JSON schema. Learn more
          #   in the
          #   [Structured Outputs guide](https://developers.openai.com/api/docs/guides/structured-outputs).
          #
          #   Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          #   message the model generates is valid JSON.
          #
          #   **Important:** when using JSON mode, you **must** also instruct the model to
          #   produce JSON yourself via a system or user message. Without this, the model may
          #   generate an unending stream of whitespace until the generation reaches the token
          #   limit, resulting in a long-running and seemingly "stuck" request. Also note that
          #   the message content may be partially cut off if `finish_reason="length"`, which
          #   indicates the generation exceeded `max_tokens` or the conversation exceeded the
          #   max context length.
          #
          # @param temperature [Float, nil]
          #   Body param: What sampling temperature to use, between 0 and 2. Higher values
          #   like 0.8 will make the output more random, while lower values like 0.2 will make
          #   it more focused and deterministic.
          #
          # @param tool_choice [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil]
          #   Body param: Controls which (if any) tool is called by the model. `none` means
          #   the model will not call any tools and instead generates a message. `auto` is the
          #   default value and means the model can pick between generating a message or
          #   calling one or more tools. `required` means the model must call one or more
          #   tools before responding to the user. Specifying a particular tool like
          #   `{"type": "file_search"}` or
          #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #   call that tool.
          #
          # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
          #   Body param: Override the tools the assistant can use for this run. This is
          #   useful for modifying the behavior on a per-run basis.
          #
          # @param top_p [Float, nil]
          #   Body param: An alternative to sampling with temperature, called nucleus
          #   sampling, where the model considers the results of the tokens with top_p
          #   probability mass. So 0.1 means only the tokens comprising the top 10%
          #   probability mass are considered.
          #
          #   We generally recommend altering this or temperature but not both.
          #
          # @param truncation_strategy [OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy, nil]
          #   Body param: Controls for how a thread will be truncated prior to the run. Use
          #   this to control the initial context window of the run.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent>]
          #
          # @see OpenAI::Models::Beta::Threads::RunCreateParams
          def create_stream_raw(thread_id, params)
            query_params = [:include]
            parsed, options = OpenAI::Beta::Threads::RunCreateParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed.slice(*query_params))
            unless parsed.fetch(:stream, true)
              message = "Please use `#create` for the non-streaming use case."
              raise ArgumentError.new(message)
            end

            parsed.store(:stream, true)
            @client.request(
              method: :post,
              path: ["threads/%1$s/runs", thread_id],
              query: query,
              headers: {"accept" => "text/event-stream", "accept-encoding" => "identity"},
              body: parsed.except(*query_params),
              stream: OpenAI::Internal::Stream,
              model: OpenAI::Beta::AssistantStreamEvent,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # @deprecated The Assistants API is deprecated in favor of the Responses API
          #
          # Retrieves a run.
          #
          # @overload retrieve(run_id, thread_id:, request_options: {})
          #
          # @param run_id [String]
          #   The ID of the run to retrieve.
          #
          # @param thread_id [String]
          #   The ID of the
          #   [thread](https://developers.openai.com/api/docs/assistants/migration) that was
          #   run.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunRetrieveParams
          def retrieve(run_id, params)
            parsed, options = OpenAI::Beta::Threads::RunRetrieveParams.dump_request(params)
            thread_id = parsed.delete(:thread_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end

            @client.request(
              method: :get,
              path: ["threads/%1$s/runs/%2$s", thread_id, run_id],
              model: OpenAI::Beta::Threads::Run,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # @deprecated The Assistants API is deprecated in favor of the Responses API
          #
          # Modifies a run.
          #
          # @overload update(run_id, thread_id:, metadata: nil, request_options: {})
          #
          # @param run_id [String]
          #   Path param: The ID of the run to modify.
          #
          # @param thread_id [String]
          #   Path param: The ID of the
          #   [thread](https://developers.openai.com/api/docs/assistants/migration) that was
          #   run.
          #
          # @param metadata [Hash{Symbol=>String}, nil]
          #   Body param: Set of 16 key-value pairs that can be attached to an object. This
          #   can be useful for storing additional information about the object in a
          #   structured format, and querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunUpdateParams
          def update(run_id, params)
            parsed, options = OpenAI::Beta::Threads::RunUpdateParams.dump_request(params)
            thread_id = parsed.delete(:thread_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end

            @client.request(
              method: :post,
              path: ["threads/%1$s/runs/%2$s", thread_id, run_id],
              body: parsed,
              model: OpenAI::Beta::Threads::Run,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # @deprecated The Assistants API is deprecated in favor of the Responses API
          #
          # Returns a list of runs belonging to a thread.
          #
          # @overload list(thread_id, after: nil, before: nil, limit: nil, order: nil, request_options: {})
          #
          # @param thread_id [String]
          #   The ID of the thread the run belongs to.
          #
          # @param after [String]
          #   A cursor for use in pagination. `after` is an object ID that defines your place
          #   in the list. For instance, if you make a list request and receive 100 objects,
          #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
          #   fetch the next page of the list.
          #
          # @param before [String]
          #   A cursor for use in pagination. `before` is an object ID that defines your place
          #   in the list. For instance, if you make a list request and receive 100 objects,
          #   starting with obj_foo, your subsequent call can include before=obj_foo in order
          #   to fetch the previous page of the list.
          #
          # @param limit [Integer]
          #   A limit on the number of objects to be returned. Limit can range between 1 and
          #   100, and the default is 20.
          #
          # @param order [Symbol, OpenAI::Models::Beta::Threads::RunListParams::Order]
          #   Sort order by the `created_at` timestamp of the objects. `asc` for ascending
          #   order and `desc` for descending order.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Threads::Run>]
          #
          # @see OpenAI::Models::Beta::Threads::RunListParams
          def list(thread_id, params = {})
            parsed, options = OpenAI::Beta::Threads::RunListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: ["threads/%1$s/runs", thread_id],
              query: query,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Beta::Threads::Run,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # @deprecated The Assistants API is deprecated in favor of the Responses API
          #
          # Cancels a run that is `in_progress`.
          #
          # @overload cancel(run_id, thread_id:, request_options: {})
          #
          # @param run_id [String]
          #   The ID of the run to cancel.
          #
          # @param thread_id [String]
          #   The ID of the thread to which this run belongs.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunCancelParams
          def cancel(run_id, params)
            parsed, options = OpenAI::Beta::Threads::RunCancelParams.dump_request(params)
            thread_id = parsed.delete(:thread_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end

            @client.request(
              method: :post,
              path: ["threads/%1$s/runs/%2$s/cancel", thread_id, run_id],
              model: OpenAI::Beta::Threads::Run,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # @deprecated The Assistants API is deprecated in favor of the Responses API
          #
          # See {OpenAI::Resources::Beta::Threads::Runs#submit_tool_outputs_stream_raw} for
          # streaming counterpart.
          #
          # When a run has the `status: "requires_action"` and `required_action.type` is
          # `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          # tool calls once they're all completed. All outputs must be submitted in a single
          # request.
          #
          # @overload submit_tool_outputs(run_id, thread_id:, tool_outputs:, request_options: {})
          #
          # @param run_id [String]
          #   Path param: The ID of the run that requires the tool output submission.
          #
          # @param thread_id [String]
          #   Path param: The ID of the
          #   [thread](https://developers.openai.com/api/docs/assistants/migration) to which
          #   this run belongs.
          #
          # @param tool_outputs [Array<OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput>]
          #   Body param: A list of tools for which the outputs are being submitted.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams
          def submit_tool_outputs(run_id, params)
            parsed, options = OpenAI::Beta::Threads::RunSubmitToolOutputsParams.dump_request(params)
            if parsed[:stream]
              message = "Please use `#submit_tool_outputs_stream_raw` for the streaming use case."
              raise ArgumentError.new(message)
            end

            thread_id = parsed.delete(:thread_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end

            @client.request(
              method: :post,
              path: ["threads/%1$s/runs/%2$s/submit_tool_outputs", thread_id, run_id],
              body: parsed,
              model: OpenAI::Beta::Threads::Run,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # @deprecated The Assistants API is deprecated in favor of the Responses API
          #
          # See {OpenAI::Resources::Beta::Threads::Runs#submit_tool_outputs} for
          # non-streaming counterpart.
          #
          # When a run has the `status: "requires_action"` and `required_action.type` is
          # `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          # tool calls once they're all completed. All outputs must be submitted in a single
          # request.
          #
          # @overload submit_tool_outputs_stream_raw(run_id, thread_id:, tool_outputs:, request_options: {})
          #
          # @param run_id [String]
          #   Path param: The ID of the run that requires the tool output submission.
          #
          # @param thread_id [String]
          #   Path param: The ID of the
          #   [thread](https://developers.openai.com/api/docs/assistants/migration) to which
          #   this run belongs.
          #
          # @param tool_outputs [Array<OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput>]
          #   Body param: A list of tools for which the outputs are being submitted.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent>]
          #
          # @see OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams
          def submit_tool_outputs_stream_raw(run_id, params)
            parsed, options = OpenAI::Beta::Threads::RunSubmitToolOutputsParams.dump_request(params)
            unless parsed.fetch(:stream, true)
              message = "Please use `#submit_tool_outputs` for the non-streaming use case."
              raise ArgumentError.new(message)
            end

            parsed.store(:stream, true)
            thread_id = parsed.delete(:thread_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end

            @client.request(
              method: :post,
              path: ["threads/%1$s/runs/%2$s/submit_tool_outputs", thread_id, run_id],
              headers: {"accept" => "text/event-stream", "accept-encoding" => "identity"},
              body: parsed,
              stream: OpenAI::Internal::Stream,
              model: OpenAI::Beta::AssistantStreamEvent,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
            @steps = OpenAI::Resources::Beta::Threads::Runs::Steps.new(client: client)
          end
        end
      end
    end
  end
end
