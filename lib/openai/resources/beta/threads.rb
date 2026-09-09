# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      # @deprecated The Assistants API is deprecated in favor of the Responses API
      #
      # Build Assistants that can call models and use tools.
      class Threads
        # Build Assistants that can call models and use tools.
        # @return [OpenAI::Resources::Beta::Threads::Runs]
        attr_reader :runs

        # Build Assistants that can call models and use tools.
        # @return [OpenAI::Resources::Beta::Threads::Messages]
        attr_reader :messages

        # @deprecated The Assistants API is deprecated in favor of the Responses API
        #
        # Create a thread.
        #
        # @overload create(messages: nil, metadata: nil, tool_resources: nil, request_options: {})
        #
        # @param messages [Array<OpenAI::Models::Beta::ThreadCreateParams::Message>]
        #   A list of
        #   [messages](https://developers.openai.com/api/docs/assistants/migration) to start
        #   the thread with.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param tool_resources [OpenAI::Models::Beta::ThreadCreateParams::ToolResources, nil]
        #   A set of resources that are made available to the assistant's tools in this
        #   thread. The resources are specific to the type of tool. For example, the
        #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #   tool requires a list of vector store IDs.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::Thread]
        #
        # @see OpenAI::Models::Beta::ThreadCreateParams
        def create(params = {})
          parsed, options = OpenAI::Beta::ThreadCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "threads",
            body: parsed,
            model: OpenAI::Beta::Thread,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # @deprecated The Assistants API is deprecated in favor of the Responses API
        #
        # Retrieves a thread.
        #
        # @overload retrieve(thread_id, request_options: {})
        #
        # @param thread_id [String]
        #   The ID of the thread to retrieve.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::Thread]
        #
        # @see OpenAI::Models::Beta::ThreadRetrieveParams
        def retrieve(thread_id, params = {})
          @client.request(
            method: :get,
            path: ["threads/%1$s", thread_id],
            model: OpenAI::Beta::Thread,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **params[:request_options].to_h}
          )
        end

        # @deprecated The Assistants API is deprecated in favor of the Responses API
        #
        # Modifies a thread.
        #
        # @overload update(thread_id, metadata: nil, tool_resources: nil, request_options: {})
        #
        # @param thread_id [String]
        #   The ID of the thread to modify. Only the `metadata` can be modified.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param tool_resources [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources, nil]
        #   A set of resources that are made available to the assistant's tools in this
        #   thread. The resources are specific to the type of tool. For example, the
        #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #   tool requires a list of vector store IDs.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::Thread]
        #
        # @see OpenAI::Models::Beta::ThreadUpdateParams
        def update(thread_id, params = {})
          parsed, options = OpenAI::Beta::ThreadUpdateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["threads/%1$s", thread_id],
            body: parsed,
            model: OpenAI::Beta::Thread,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # @deprecated The Assistants API is deprecated in favor of the Responses API
        #
        # Delete a thread.
        #
        # @overload delete(thread_id, request_options: {})
        #
        # @param thread_id [String]
        #   The ID of the thread to delete.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::ThreadDeleted]
        #
        # @see OpenAI::Models::Beta::ThreadDeleteParams
        def delete(thread_id, params = {})
          @client.request(
            method: :delete,
            path: ["threads/%1$s", thread_id],
            model: OpenAI::Beta::ThreadDeleted,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **params[:request_options].to_h}
          )
        end

        # @deprecated The Assistants API is deprecated in favor of the Responses API
        #
        # See {OpenAI::Resources::Beta::Threads#stream_raw} for streaming counterpart.
        #
        # Create a thread and run it in one request.
        #
        # @overload create_and_run(assistant_id:, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, response_format: nil, temperature: nil, thread: nil, tool_choice: nil, tool_resources: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
        #
        # @param assistant_id [String]
        #   The ID of the
        #   [assistant](https://developers.openai.com/api/docs/assistants/migration) to use
        #   to execute this run.
        #
        # @param instructions [String, nil]
        #   Override the default system message of the assistant. This is useful for
        #   modifying the behavior on a per-run basis.
        #
        # @param max_completion_tokens [Integer, nil]
        #   The maximum number of completion tokens that may be used over the course of the
        #   run. The run will make a best effort to use only the number of completion tokens
        #   specified, across multiple turns of the run. If the run exceeds the number of
        #   completion tokens specified, the run will end with status `incomplete`. See
        #   `incomplete_details` for more info.
        #
        # @param max_prompt_tokens [Integer, nil]
        #   The maximum number of prompt tokens that may be used over the course of the run.
        #   The run will make a best effort to use only the number of prompt tokens
        #   specified, across multiple turns of the run. If the run exceeds the number of
        #   prompt tokens specified, the run will end with status `incomplete`. See
        #   `incomplete_details` for more info.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param model [String, Symbol, OpenAI::Models::ChatModel, nil]
        #   The ID of the
        #   [Model](https://developers.openai.com/api/reference/resources/models) to be used
        #   to execute this run. If a value is provided here, it will override the model
        #   associated with the assistant. If not, the model associated with the assistant
        #   will be used.
        #
        # @param parallel_tool_calls [Boolean]
        #   Whether to enable
        #   [parallel function calling](https://developers.openai.com/api/docs/guides/function-calling#parallel-function-calling)
        #   during tool use.
        #
        # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        #   Specifies the format that the model must output. Compatible with
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
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic.
        #
        # @param thread [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread]
        #   Options to create a new thread. If no thread is provided when running a request,
        #   an empty thread will be created.
        #
        # @param tool_choice [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil]
        #   Controls which (if any) tool is called by the model. `none` means the model will
        #   not call any tools and instead generates a message. `auto` is the default value
        #   and means the model can pick between generating a message or calling one or more
        #   tools. `required` means the model must call one or more tools before responding
        #   to the user. Specifying a particular tool like `{"type": "file_search"}` or
        #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #   call that tool.
        #
        # @param tool_resources [OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources, nil]
        #   A set of resources that are used by the assistant's tools. The resources are
        #   specific to the type of tool. For example, the `code_interpreter` tool requires
        #   a list of file IDs, while the `file_search` tool requires a list of vector store
        #   IDs.
        #
        # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
        #   Override the tools the assistant can use for this run. This is useful for
        #   modifying the behavior on a per-run basis.
        #
        # @param top_p [Float, nil]
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or temperature but not both.
        #
        # @param truncation_strategy [OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy, nil]
        #   Controls for how a thread will be truncated prior to the run. Use this to
        #   control the initial context window of the run.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::Threads::Run]
        #
        # @see OpenAI::Models::Beta::ThreadCreateAndRunParams
        def create_and_run(params)
          parsed, options = OpenAI::Beta::ThreadCreateAndRunParams.dump_request(params)
          if parsed[:stream]
            message = "Please use `#stream_raw` for the streaming use case."
            raise ArgumentError.new(message)
          end

          @client.request(
            method: :post,
            path: "threads/runs",
            body: parsed,
            model: OpenAI::Beta::Threads::Run,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # @deprecated The Assistants API is deprecated in favor of the Responses API
        #
        # See {OpenAI::Resources::Beta::Threads#create_and_run} for non-streaming
        # counterpart.
        #
        # Create a thread and run it in one request.
        #
        # @overload stream_raw(assistant_id:, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, response_format: nil, temperature: nil, thread: nil, tool_choice: nil, tool_resources: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
        #
        # @param assistant_id [String]
        #   The ID of the
        #   [assistant](https://developers.openai.com/api/docs/assistants/migration) to use
        #   to execute this run.
        #
        # @param instructions [String, nil]
        #   Override the default system message of the assistant. This is useful for
        #   modifying the behavior on a per-run basis.
        #
        # @param max_completion_tokens [Integer, nil]
        #   The maximum number of completion tokens that may be used over the course of the
        #   run. The run will make a best effort to use only the number of completion tokens
        #   specified, across multiple turns of the run. If the run exceeds the number of
        #   completion tokens specified, the run will end with status `incomplete`. See
        #   `incomplete_details` for more info.
        #
        # @param max_prompt_tokens [Integer, nil]
        #   The maximum number of prompt tokens that may be used over the course of the run.
        #   The run will make a best effort to use only the number of prompt tokens
        #   specified, across multiple turns of the run. If the run exceeds the number of
        #   prompt tokens specified, the run will end with status `incomplete`. See
        #   `incomplete_details` for more info.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param model [String, Symbol, OpenAI::Models::ChatModel, nil]
        #   The ID of the
        #   [Model](https://developers.openai.com/api/reference/resources/models) to be used
        #   to execute this run. If a value is provided here, it will override the model
        #   associated with the assistant. If not, the model associated with the assistant
        #   will be used.
        #
        # @param parallel_tool_calls [Boolean]
        #   Whether to enable
        #   [parallel function calling](https://developers.openai.com/api/docs/guides/function-calling#parallel-function-calling)
        #   during tool use.
        #
        # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        #   Specifies the format that the model must output. Compatible with
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
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic.
        #
        # @param thread [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread]
        #   Options to create a new thread. If no thread is provided when running a request,
        #   an empty thread will be created.
        #
        # @param tool_choice [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil]
        #   Controls which (if any) tool is called by the model. `none` means the model will
        #   not call any tools and instead generates a message. `auto` is the default value
        #   and means the model can pick between generating a message or calling one or more
        #   tools. `required` means the model must call one or more tools before responding
        #   to the user. Specifying a particular tool like `{"type": "file_search"}` or
        #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #   call that tool.
        #
        # @param tool_resources [OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources, nil]
        #   A set of resources that are used by the assistant's tools. The resources are
        #   specific to the type of tool. For example, the `code_interpreter` tool requires
        #   a list of file IDs, while the `file_search` tool requires a list of vector store
        #   IDs.
        #
        # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
        #   Override the tools the assistant can use for this run. This is useful for
        #   modifying the behavior on a per-run basis.
        #
        # @param top_p [Float, nil]
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or temperature but not both.
        #
        # @param truncation_strategy [OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy, nil]
        #   Controls for how a thread will be truncated prior to the run. Use this to
        #   control the initial context window of the run.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent>]
        #
        # @see OpenAI::Models::Beta::ThreadCreateAndRunParams
        def stream_raw(params)
          parsed, options = OpenAI::Beta::ThreadCreateAndRunParams.dump_request(params)
          unless parsed.fetch(:stream, true)
            message = "Please use `#create_and_run` for the non-streaming use case."
            raise ArgumentError.new(message)
          end

          parsed.store(:stream, true)
          @client.request(
            method: :post,
            path: "threads/runs",
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
          @runs = OpenAI::Resources::Beta::Threads::Runs.new(client: client)
          @messages = OpenAI::Resources::Beta::Threads::Messages.new(client: client)
        end
      end
    end
  end
end
