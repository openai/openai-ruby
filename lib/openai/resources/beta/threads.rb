# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        # @return [OpenAI::Resources::Beta::Threads::Runs]
        attr_reader :runs

        # @return [OpenAI::Resources::Beta::Threads::Messages]
        attr_reader :messages

        # Create a thread.
        #
        # @param params [OpenAI::Models::Beta::ThreadCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [Array<OpenAI::Models::Beta::ThreadCreateParams::Message>] :messages A list of [messages](https://platform.openai.com/docs/api-reference/messages) to
        #     start the thread with.
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [OpenAI::Models::Beta::ThreadCreateParams::ToolResources, nil] :tool_resources A set of resources that are made available to the assistant's tools in this
        #     thread. The resources are specific to the type of tool. For example, the
        #     `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #     tool requires a list of vector store IDs.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::Thread]
        def create(params = {})
          parsed, options = OpenAI::Models::Beta::ThreadCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "threads",
            body: parsed,
            model: OpenAI::Models::Beta::Thread,
            options: options
          )
        end

        # Retrieves a thread.
        #
        # @param thread_id [String] The ID of the thread to retrieve.
        #
        # @param params [OpenAI::Models::Beta::ThreadRetrieveParams, Hash{Symbol=>Object}] .
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::Thread]
        def retrieve(thread_id, params = {})
          @client.request(
            method: :get,
            path: ["threads/%1$s", thread_id],
            model: OpenAI::Models::Beta::Thread,
            options: params[:request_options]
          )
        end

        # Modifies a thread.
        #
        # @param thread_id [String] The ID of the thread to modify. Only the `metadata` can be modified.
        #
        # @param params [OpenAI::Models::Beta::ThreadUpdateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources, nil] :tool_resources A set of resources that are made available to the assistant's tools in this
        #     thread. The resources are specific to the type of tool. For example, the
        #     `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #     tool requires a list of vector store IDs.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::Thread]
        def update(thread_id, params = {})
          parsed, options = OpenAI::Models::Beta::ThreadUpdateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["threads/%1$s", thread_id],
            body: parsed,
            model: OpenAI::Models::Beta::Thread,
            options: options
          )
        end

        # Delete a thread.
        #
        # @param thread_id [String] The ID of the thread to delete.
        #
        # @param params [OpenAI::Models::Beta::ThreadDeleteParams, Hash{Symbol=>Object}] .
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::ThreadDeleted]
        def delete(thread_id, params = {})
          @client.request(
            method: :delete,
            path: ["threads/%1$s", thread_id],
            model: OpenAI::Models::Beta::ThreadDeleted,
            options: params[:request_options]
          )
        end

        # Create a thread and run it in one request.
        #
        # @param params [OpenAI::Models::Beta::ThreadCreateAndRunParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :assistant_id The ID of the
        #     [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
        #     execute this run.
        #
        #   @option params [String, nil] :instructions Override the default system message of the assistant. This is useful for
        #     modifying the behavior on a per-run basis.
        #
        #   @option params [Integer, nil] :max_completion_tokens The maximum number of completion tokens that may be used over the course of the
        #     run. The run will make a best effort to use only the number of completion tokens
        #     specified, across multiple turns of the run. If the run exceeds the number of
        #     completion tokens specified, the run will end with status `incomplete`. See
        #     `incomplete_details` for more info.
        #
        #   @option params [Integer, nil] :max_prompt_tokens The maximum number of prompt tokens that may be used over the course of the run.
        #     The run will make a best effort to use only the number of prompt tokens
        #     specified, across multiple turns of the run. If the run exceeds the number of
        #     prompt tokens specified, the run will end with status `incomplete`. See
        #     `incomplete_details` for more info.
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [String, Symbol, OpenAI::Models::ChatModel, nil] :model The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
        #     be used to execute this run. If a value is provided here, it will override the
        #     model associated with the assistant. If not, the model associated with the
        #     assistant will be used.
        #
        #   @option params [Boolean] :parallel_tool_calls Whether to enable
        #     [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
        #     during tool use.
        #
        #   @option params [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil] :response_format Specifies the format that the model must output. Compatible with
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
        #   @option params [Float, nil] :temperature What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #     make the output more random, while lower values like 0.2 will make it more
        #     focused and deterministic.
        #
        #   @option params [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread] :thread Options to create a new thread. If no thread is provided when running a request,
        #     an empty thread will be created.
        #
        #   @option params [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil] :tool_choice Controls which (if any) tool is called by the model. `none` means the model will
        #     not call any tools and instead generates a message. `auto` is the default value
        #     and means the model can pick between generating a message or calling one or more
        #     tools. `required` means the model must call one or more tools before responding
        #     to the user. Specifying a particular tool like `{"type": "file_search"}` or
        #     `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #     call that tool.
        #
        #   @option params [OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources, nil] :tool_resources A set of resources that are used by the assistant's tools. The resources are
        #     specific to the type of tool. For example, the `code_interpreter` tool requires
        #     a list of file IDs, while the `file_search` tool requires a list of vector store
        #     IDs.
        #
        #   @option params [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil] :tools Override the tools the assistant can use for this run. This is useful for
        #     modifying the behavior on a per-run basis.
        #
        #   @option params [Float, nil] :top_p An alternative to sampling with temperature, called nucleus sampling, where the
        #     model considers the results of the tokens with top_p probability mass. So 0.1
        #     means only the tokens comprising the top 10% probability mass are considered.
        #
        #     We generally recommend altering this or temperature but not both.
        #
        #   @option params [OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy, nil] :truncation_strategy Controls for how a thread will be truncated prior to the run. Use this to
        #     control the intial context window of the run.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::Threads::Run]
        def create_and_run(params)
          parsed, options = OpenAI::Models::Beta::ThreadCreateAndRunParams.dump_request(params)
          if parsed[:stream]
            message = "Please use `#create_and_run_streaming` for the streaming use case."
            raise ArgumentError.new(message)
          end
          @client.request(
            method: :post,
            path: "threads/runs",
            body: parsed,
            model: OpenAI::Models::Beta::Threads::Run,
            options: options
          )
        end

        # Create a thread and run it in one request.
        #
        # @param params [OpenAI::Models::Beta::ThreadCreateAndRunParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :assistant_id The ID of the
        #     [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
        #     execute this run.
        #
        #   @option params [String, nil] :instructions Override the default system message of the assistant. This is useful for
        #     modifying the behavior on a per-run basis.
        #
        #   @option params [Integer, nil] :max_completion_tokens The maximum number of completion tokens that may be used over the course of the
        #     run. The run will make a best effort to use only the number of completion tokens
        #     specified, across multiple turns of the run. If the run exceeds the number of
        #     completion tokens specified, the run will end with status `incomplete`. See
        #     `incomplete_details` for more info.
        #
        #   @option params [Integer, nil] :max_prompt_tokens The maximum number of prompt tokens that may be used over the course of the run.
        #     The run will make a best effort to use only the number of prompt tokens
        #     specified, across multiple turns of the run. If the run exceeds the number of
        #     prompt tokens specified, the run will end with status `incomplete`. See
        #     `incomplete_details` for more info.
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [String, Symbol, OpenAI::Models::ChatModel, nil] :model The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
        #     be used to execute this run. If a value is provided here, it will override the
        #     model associated with the assistant. If not, the model associated with the
        #     assistant will be used.
        #
        #   @option params [Boolean] :parallel_tool_calls Whether to enable
        #     [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
        #     during tool use.
        #
        #   @option params [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil] :response_format Specifies the format that the model must output. Compatible with
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
        #   @option params [Float, nil] :temperature What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #     make the output more random, while lower values like 0.2 will make it more
        #     focused and deterministic.
        #
        #   @option params [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread] :thread Options to create a new thread. If no thread is provided when running a request,
        #     an empty thread will be created.
        #
        #   @option params [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil] :tool_choice Controls which (if any) tool is called by the model. `none` means the model will
        #     not call any tools and instead generates a message. `auto` is the default value
        #     and means the model can pick between generating a message or calling one or more
        #     tools. `required` means the model must call one or more tools before responding
        #     to the user. Specifying a particular tool like `{"type": "file_search"}` or
        #     `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #     call that tool.
        #
        #   @option params [OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources, nil] :tool_resources A set of resources that are used by the assistant's tools. The resources are
        #     specific to the type of tool. For example, the `code_interpreter` tool requires
        #     a list of file IDs, while the `file_search` tool requires a list of vector store
        #     IDs.
        #
        #   @option params [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil] :tools Override the tools the assistant can use for this run. This is useful for
        #     modifying the behavior on a per-run basis.
        #
        #   @option params [Float, nil] :top_p An alternative to sampling with temperature, called nucleus sampling, where the
        #     model considers the results of the tokens with top_p probability mass. So 0.1
        #     means only the tokens comprising the top 10% probability mass are considered.
        #
        #     We generally recommend altering this or temperature but not both.
        #
        #   @option params [OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy, nil] :truncation_strategy Controls for how a thread will be truncated prior to the run. Use this to
        #     control the intial context window of the run.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Stream<OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent>]
        def create_and_run_streaming(params)
          parsed, options = OpenAI::Models::Beta::ThreadCreateAndRunParams.dump_request(params)
          unless parsed.fetch(:stream, true)
            message = "Please use `#create_and_run` for the non-streaming use case."
            raise ArgumentError.new(message)
          end
          parsed.store(:stream, true)
          @client.request(
            method: :post,
            path: "threads/runs",
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
          @runs = OpenAI::Resources::Beta::Threads::Runs.new(client: client)
          @messages = OpenAI::Resources::Beta::Threads::Messages.new(client: client)
        end
      end
    end
  end
end
