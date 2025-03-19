# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        class Runs
          # @return [OpenAI::Resources::Beta::Threads::Runs::Steps]
          attr_reader :steps

          # Create a run.
          #
          # @param thread_id [String] Path param: The ID of the thread to run.
          #
          # @param params [OpenAI::Models::Beta::Threads::RunCreateParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :assistant_id Body param: The ID of the
          #     [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
          #     execute this run.
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
          #   @option params [String, nil] :additional_instructions Body param: Appends additional instructions at the end of the instructions for
          #     the run. This is useful for modifying the behavior on a per-run basis without
          #     overriding other instructions.
          #
          #   @option params [Array<OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage>, nil] :additional_messages Body param: Adds additional messages to the thread before creating the run.
          #
          #   @option params [String, nil] :instructions Body param: Overrides the
          #     [instructions](https://platform.openai.com/docs/api-reference/assistants/createAssistant)
          #     of the assistant. This is useful for modifying the behavior on a per-run basis.
          #
          #   @option params [Integer, nil] :max_completion_tokens Body param: The maximum number of completion tokens that may be used over the
          #     course of the run. The run will make a best effort to use only the number of
          #     completion tokens specified, across multiple turns of the run. If the run
          #     exceeds the number of completion tokens specified, the run will end with status
          #     `incomplete`. See `incomplete_details` for more info.
          #
          #   @option params [Integer, nil] :max_prompt_tokens Body param: The maximum number of prompt tokens that may be used over the course
          #     of the run. The run will make a best effort to use only the number of prompt
          #     tokens specified, across multiple turns of the run. If the run exceeds the
          #     number of prompt tokens specified, the run will end with status `incomplete`.
          #     See `incomplete_details` for more info.
          #
          #   @option params [Hash{Symbol=>String}, nil] :metadata Body param: Set of 16 key-value pairs that can be attached to an object. This
          #     can be useful for storing additional information about the object in a
          #     structured format, and querying for objects via API or the dashboard.
          #
          #     Keys are strings with a maximum length of 64 characters. Values are strings with
          #     a maximum length of 512 characters.
          #
          #   @option params [String, Symbol, OpenAI::Models::ChatModel, nil] :model Body param: The ID of the
          #     [Model](https://platform.openai.com/docs/api-reference/models) to be used to
          #     execute this run. If a value is provided here, it will override the model
          #     associated with the assistant. If not, the model associated with the assistant
          #     will be used.
          #
          #   @option params [Boolean] :parallel_tool_calls Body param: Whether to enable
          #     [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          #     during tool use.
          #
          #   @option params [Symbol, OpenAI::Models::ReasoningEffort, nil] :reasoning_effort Body param: **o-series models only**
          #
          #     Constrains effort on reasoning for
          #     [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          #     supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
          #     result in faster responses and fewer tokens used on reasoning in a response.
          #
          #   @option params [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil] :response_format Body param: Specifies the format that the model must output. Compatible with
          #     [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          #     [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          #     and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          #     Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #     Outputs which ensures the model will match your supplied JSON schema. Learn more
          #     in the
          #     [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #     Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          #     message the model generates is valid JSON.
          #
          #     **Important:** when using JSON mode, you **must** also instruct the model to
          #     produce JSON yourself via a system or user message. Without this, the model may
          #     generate an unending stream of whitespace until the generation reaches the token
          #     limit, resulting in a long-running and seemingly "stuck" request. Also note that
          #     the message content may be partially cut off if `finish_reason="length"`, which
          #     indicates the generation exceeded `max_tokens` or the conversation exceeded the
          #     max context length.
          #
          #   @option params [Float, nil] :temperature Body param: What sampling temperature to use, between 0 and 2. Higher values
          #     like 0.8 will make the output more random, while lower values like 0.2 will make
          #     it more focused and deterministic.
          #
          #   @option params [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil] :tool_choice Body param: Controls which (if any) tool is called by the model. `none` means
          #     the model will not call any tools and instead generates a message. `auto` is the
          #     default value and means the model can pick between generating a message or
          #     calling one or more tools. `required` means the model must call one or more
          #     tools before responding to the user. Specifying a particular tool like
          #     `{"type": "file_search"}` or
          #     `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #     call that tool.
          #
          #   @option params [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil] :tools Body param: Override the tools the assistant can use for this run. This is
          #     useful for modifying the behavior on a per-run basis.
          #
          #   @option params [Float, nil] :top_p Body param: An alternative to sampling with temperature, called nucleus
          #     sampling, where the model considers the results of the tokens with top_p
          #     probability mass. So 0.1 means only the tokens comprising the top 10%
          #     probability mass are considered.
          #
          #     We generally recommend altering this or temperature but not both.
          #
          #   @option params [OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy, nil] :truncation_strategy Body param: Controls for how a thread will be truncated prior to the run. Use
          #     this to control the intial context window of the run.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          def create(thread_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunCreateParams.dump_request(params)
            if parsed[:stream]
              message = "Please use `#create_streaming` for the streaming use case."
              raise ArgumentError.new(message)
            end
            query_params = [:include]
            @client.request(
              method: :post,
              path: ["threads/%0s/runs", thread_id],
              query: parsed.slice(*query_params),
              body: parsed.except(*query_params),
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # Create a run.
          #
          # @param thread_id [String] Path param: The ID of the thread to run.
          #
          # @param params [OpenAI::Models::Beta::Threads::RunCreateParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :assistant_id Body param: The ID of the
          #     [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
          #     execute this run.
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
          #   @option params [String, nil] :additional_instructions Body param: Appends additional instructions at the end of the instructions for
          #     the run. This is useful for modifying the behavior on a per-run basis without
          #     overriding other instructions.
          #
          #   @option params [Array<OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage>, nil] :additional_messages Body param: Adds additional messages to the thread before creating the run.
          #
          #   @option params [String, nil] :instructions Body param: Overrides the
          #     [instructions](https://platform.openai.com/docs/api-reference/assistants/createAssistant)
          #     of the assistant. This is useful for modifying the behavior on a per-run basis.
          #
          #   @option params [Integer, nil] :max_completion_tokens Body param: The maximum number of completion tokens that may be used over the
          #     course of the run. The run will make a best effort to use only the number of
          #     completion tokens specified, across multiple turns of the run. If the run
          #     exceeds the number of completion tokens specified, the run will end with status
          #     `incomplete`. See `incomplete_details` for more info.
          #
          #   @option params [Integer, nil] :max_prompt_tokens Body param: The maximum number of prompt tokens that may be used over the course
          #     of the run. The run will make a best effort to use only the number of prompt
          #     tokens specified, across multiple turns of the run. If the run exceeds the
          #     number of prompt tokens specified, the run will end with status `incomplete`.
          #     See `incomplete_details` for more info.
          #
          #   @option params [Hash{Symbol=>String}, nil] :metadata Body param: Set of 16 key-value pairs that can be attached to an object. This
          #     can be useful for storing additional information about the object in a
          #     structured format, and querying for objects via API or the dashboard.
          #
          #     Keys are strings with a maximum length of 64 characters. Values are strings with
          #     a maximum length of 512 characters.
          #
          #   @option params [String, Symbol, OpenAI::Models::ChatModel, nil] :model Body param: The ID of the
          #     [Model](https://platform.openai.com/docs/api-reference/models) to be used to
          #     execute this run. If a value is provided here, it will override the model
          #     associated with the assistant. If not, the model associated with the assistant
          #     will be used.
          #
          #   @option params [Boolean] :parallel_tool_calls Body param: Whether to enable
          #     [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          #     during tool use.
          #
          #   @option params [Symbol, OpenAI::Models::ReasoningEffort, nil] :reasoning_effort Body param: **o-series models only**
          #
          #     Constrains effort on reasoning for
          #     [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          #     supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
          #     result in faster responses and fewer tokens used on reasoning in a response.
          #
          #   @option params [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil] :response_format Body param: Specifies the format that the model must output. Compatible with
          #     [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          #     [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          #     and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          #     Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #     Outputs which ensures the model will match your supplied JSON schema. Learn more
          #     in the
          #     [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #     Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          #     message the model generates is valid JSON.
          #
          #     **Important:** when using JSON mode, you **must** also instruct the model to
          #     produce JSON yourself via a system or user message. Without this, the model may
          #     generate an unending stream of whitespace until the generation reaches the token
          #     limit, resulting in a long-running and seemingly "stuck" request. Also note that
          #     the message content may be partially cut off if `finish_reason="length"`, which
          #     indicates the generation exceeded `max_tokens` or the conversation exceeded the
          #     max context length.
          #
          #   @option params [Float, nil] :temperature Body param: What sampling temperature to use, between 0 and 2. Higher values
          #     like 0.8 will make the output more random, while lower values like 0.2 will make
          #     it more focused and deterministic.
          #
          #   @option params [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil] :tool_choice Body param: Controls which (if any) tool is called by the model. `none` means
          #     the model will not call any tools and instead generates a message. `auto` is the
          #     default value and means the model can pick between generating a message or
          #     calling one or more tools. `required` means the model must call one or more
          #     tools before responding to the user. Specifying a particular tool like
          #     `{"type": "file_search"}` or
          #     `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #     call that tool.
          #
          #   @option params [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil] :tools Body param: Override the tools the assistant can use for this run. This is
          #     useful for modifying the behavior on a per-run basis.
          #
          #   @option params [Float, nil] :top_p Body param: An alternative to sampling with temperature, called nucleus
          #     sampling, where the model considers the results of the tokens with top_p
          #     probability mass. So 0.1 means only the tokens comprising the top 10%
          #     probability mass are considered.
          #
          #     We generally recommend altering this or temperature but not both.
          #
          #   @option params [OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy, nil] :truncation_strategy Body param: Controls for how a thread will be truncated prior to the run. Use
          #     this to control the intial context window of the run.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::Stream<OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent>]
          def create_streaming(thread_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunCreateParams.dump_request(params)
            unless parsed.fetch(:stream, true)
              message = "Please use `#create` for the non-streaming use case."
              raise ArgumentError.new(message)
            end
            parsed.store(:stream, true)
            query_params = [:include]
            @client.request(
              method: :post,
              path: ["threads/%0s/runs", thread_id],
              query: parsed.slice(*query_params),
              headers: {"accept" => "text/event-stream"},
              body: parsed.except(*query_params),
              stream: OpenAI::Stream,
              model: OpenAI::Models::Beta::AssistantStreamEvent,
              options: options
            )
          end

          # Retrieves a run.
          #
          # @param run_id [String] The ID of the run to retrieve.
          #
          # @param params [OpenAI::Models::Beta::Threads::RunRetrieveParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :thread_id The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
          #     that was run.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          def retrieve(run_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunRetrieveParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :get,
              path: ["threads/%0s/runs/%1s", thread_id, run_id],
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # Modifies a run.
          #
          # @param run_id [String] Path param: The ID of the run to modify.
          #
          # @param params [OpenAI::Models::Beta::Threads::RunUpdateParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :thread_id Path param: The ID of the
          #     [thread](https://platform.openai.com/docs/api-reference/threads) that was run.
          #
          #   @option params [Hash{Symbol=>String}, nil] :metadata Body param: Set of 16 key-value pairs that can be attached to an object. This
          #     can be useful for storing additional information about the object in a
          #     structured format, and querying for objects via API or the dashboard.
          #
          #     Keys are strings with a maximum length of 64 characters. Values are strings with
          #     a maximum length of 512 characters.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          def update(run_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunUpdateParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :post,
              path: ["threads/%0s/runs/%1s", thread_id, run_id],
              body: parsed,
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # Returns a list of runs belonging to a thread.
          #
          # @param thread_id [String] The ID of the thread the run belongs to.
          #
          # @param params [OpenAI::Models::Beta::Threads::RunListParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :after A cursor for use in pagination. `after` is an object ID that defines your place
          #     in the list. For instance, if you make a list request and receive 100 objects,
          #     ending with obj_foo, your subsequent call can include after=obj_foo in order to
          #     fetch the next page of the list.
          #
          #   @option params [String] :before A cursor for use in pagination. `before` is an object ID that defines your place
          #     in the list. For instance, if you make a list request and receive 100 objects,
          #     starting with obj_foo, your subsequent call can include before=obj_foo in order
          #     to fetch the previous page of the list.
          #
          #   @option params [Integer] :limit A limit on the number of objects to be returned. Limit can range between 1 and
          #     100, and the default is 20.
          #
          #   @option params [Symbol, OpenAI::Models::Beta::Threads::RunListParams::Order] :order Sort order by the `created_at` timestamp of the objects. `asc` for ascending
          #     order and `desc` for descending order.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::CursorPage<OpenAI::Models::Beta::Threads::Run>]
          def list(thread_id, params = {})
            parsed, options = OpenAI::Models::Beta::Threads::RunListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["threads/%0s/runs", thread_id],
              query: parsed,
              page: OpenAI::CursorPage,
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # Cancels a run that is `in_progress`.
          #
          # @param run_id [String] The ID of the run to cancel.
          #
          # @param params [OpenAI::Models::Beta::Threads::RunCancelParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :thread_id The ID of the thread to which this run belongs.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          def cancel(run_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunCancelParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :post,
              path: ["threads/%0s/runs/%1s/cancel", thread_id, run_id],
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # When a run has the `status: "requires_action"` and `required_action.type` is
          #   `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          #   tool calls once they're all completed. All outputs must be submitted in a single
          #   request.
          #
          # @param run_id [String] Path param: The ID of the run that requires the tool output submission.
          #
          # @param params [OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :thread_id Path param: The ID of the
          #     [thread](https://platform.openai.com/docs/api-reference/threads) to which this
          #     run belongs.
          #
          #   @option params [Array<OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput>] :tool_outputs Body param: A list of tools for which the outputs are being submitted.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          def submit_tool_outputs(run_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams.dump_request(params)
            if parsed[:stream]
              message = "Please use `#submit_tool_outputs_streaming` for the streaming use case."
              raise ArgumentError.new(message)
            end
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :post,
              path: ["threads/%0s/runs/%1s/submit_tool_outputs", thread_id, run_id],
              body: parsed,
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # When a run has the `status: "requires_action"` and `required_action.type` is
          #   `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          #   tool calls once they're all completed. All outputs must be submitted in a single
          #   request.
          #
          # @param run_id [String] Path param: The ID of the run that requires the tool output submission.
          #
          # @param params [OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :thread_id Path param: The ID of the
          #     [thread](https://platform.openai.com/docs/api-reference/threads) to which this
          #     run belongs.
          #
          #   @option params [Array<OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput>] :tool_outputs Body param: A list of tools for which the outputs are being submitted.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::Stream<OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent>]
          def submit_tool_outputs_streaming(run_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams.dump_request(params)
            unless parsed.fetch(:stream, true)
              message = "Please use `#submit_tool_outputs` for the non-streaming use case."
              raise ArgumentError.new(message)
            end
            parsed.store(:stream, true)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :post,
              path: ["threads/%0s/runs/%1s/submit_tool_outputs", thread_id, run_id],
              headers: {"accept" => "text/event-stream"},
              body: parsed,
              stream: OpenAI::Stream,
              model: OpenAI::Models::Beta::AssistantStreamEvent,
              options: options
            )
          end

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
