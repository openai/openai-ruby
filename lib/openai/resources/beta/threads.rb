# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        # @return [OpenAI::Resources::Beta::Threads::Runs]
        attr_reader :runs

        # @return [OpenAI::Resources::Beta::Threads::Messages]
        attr_reader :messages

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::ThreadCreateParams} for more details.
        #
        # Create a thread.
        #
        # @overload create(messages: nil, metadata: nil, tool_resources: nil, request_options: {})
        #
        # @param messages [Array<OpenAI::Beta::ThreadCreateParams::Message>] A list of [messages](https://platform.openai.com/docs/api-reference/messages) to
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        # @param tool_resources [OpenAI::Beta::ThreadCreateParams::ToolResources, nil] A set of resources that are made available to the assistant's tools in this thre
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Beta::Thread]
        #
        # @see OpenAI::Models::Beta::ThreadCreateParams
        def create(params = {})
          parsed, options = OpenAI::Beta::ThreadCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "threads",
            body: parsed,
            model: OpenAI::Beta::Thread,
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Retrieves a thread.
        #
        # @overload retrieve(thread_id, request_options: {})
        #
        # @param thread_id [String] The ID of the thread to retrieve.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Beta::Thread]
        #
        # @see OpenAI::Models::Beta::ThreadRetrieveParams
        def retrieve(thread_id, params = {})
          @client.request(
            method: :get,
            path: ["threads/%1$s", thread_id],
            model: OpenAI::Beta::Thread,
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **params[:request_options].to_h}
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::ThreadUpdateParams} for more details.
        #
        # Modifies a thread.
        #
        # @overload update(thread_id, metadata: nil, tool_resources: nil, request_options: {})
        #
        # @param thread_id [String] The ID of the thread to modify. Only the `metadata` can be modified.
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        # @param tool_resources [OpenAI::Beta::ThreadUpdateParams::ToolResources, nil] A set of resources that are made available to the assistant's tools in this thre
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Beta::Thread]
        #
        # @see OpenAI::Models::Beta::ThreadUpdateParams
        def update(thread_id, params = {})
          parsed, options = OpenAI::Beta::ThreadUpdateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["threads/%1$s", thread_id],
            body: parsed,
            model: OpenAI::Beta::Thread,
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # Delete a thread.
        #
        # @overload delete(thread_id, request_options: {})
        #
        # @param thread_id [String] The ID of the thread to delete.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Beta::ThreadDeleted]
        #
        # @see OpenAI::Models::Beta::ThreadDeleteParams
        def delete(thread_id, params = {})
          @client.request(
            method: :delete,
            path: ["threads/%1$s", thread_id],
            model: OpenAI::Beta::ThreadDeleted,
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **params[:request_options].to_h}
          )
        end

        # See {OpenAI::Resources::Beta::Threads#stream_raw} for streaming counterpart.
        #
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::ThreadCreateAndRunParams} for more details.
        #
        # Create a thread and run it in one request.
        #
        # @overload create_and_run(assistant_id:, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, response_format: nil, temperature: nil, thread: nil, tool_choice: nil, tool_resources: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
        #
        # @param assistant_id [String] The ID of the [assistant](https://platform.openai.com/docs/api-reference/assista
        #
        # @param instructions [String, nil] Override the default system message of the assistant. This is useful for modifyi
        #
        # @param max_completion_tokens [Integer, nil] The maximum number of completion tokens that may be used over the course of the
        #
        # @param max_prompt_tokens [Integer, nil] The maximum number of prompt tokens that may be used over the course of the run.
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        # @param model [String, Symbol, OpenAI::ChatModel, nil] The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
        #
        # @param parallel_tool_calls [Boolean] Whether to enable [parallel function calling](https://platform.openai.com/docs/g
        #
        # @param response_format [Symbol, :auto, OpenAI::ResponseFormatText, OpenAI::ResponseFormatJSONObject, OpenAI::ResponseFormatJSONSchema, nil] Specifies the format that the model must output. Compatible with [GPT-4o](https:
        #
        # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
        #
        # @param thread [OpenAI::Beta::ThreadCreateAndRunParams::Thread] Options to create a new thread. If no thread is provided when running a
        #
        # @param tool_choice [Symbol, OpenAI::Beta::AssistantToolChoiceOption::Auto, OpenAI::Beta::AssistantToolChoice, nil] Controls which (if any) tool is called by the model.
        #
        # @param tool_resources [OpenAI::Beta::ThreadCreateAndRunParams::ToolResources, nil] A set of resources that are used by the assistant's tools. The resources are spe
        #
        # @param tools [Array<OpenAI::Beta::CodeInterpreterTool, OpenAI::Beta::FileSearchTool, OpenAI::Beta::FunctionTool>, nil] Override the tools the assistant can use for this run. This is useful for modify
        #
        # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling, where the
        #
        # @param truncation_strategy [OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy, nil] Controls for how a thread will be truncated prior to the run. Use this to contro
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Beta::Threads::Run]
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
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # See {OpenAI::Resources::Beta::Threads#create_and_run} for non-streaming
        # counterpart.
        #
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::ThreadCreateAndRunParams} for more details.
        #
        # Create a thread and run it in one request.
        #
        # @overload stream_raw(assistant_id:, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, response_format: nil, temperature: nil, thread: nil, tool_choice: nil, tool_resources: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
        #
        # @param assistant_id [String] The ID of the [assistant](https://platform.openai.com/docs/api-reference/assista
        #
        # @param instructions [String, nil] Override the default system message of the assistant. This is useful for modifyi
        #
        # @param max_completion_tokens [Integer, nil] The maximum number of completion tokens that may be used over the course of the
        #
        # @param max_prompt_tokens [Integer, nil] The maximum number of prompt tokens that may be used over the course of the run.
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        # @param model [String, Symbol, OpenAI::ChatModel, nil] The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
        #
        # @param parallel_tool_calls [Boolean] Whether to enable [parallel function calling](https://platform.openai.com/docs/g
        #
        # @param response_format [Symbol, :auto, OpenAI::ResponseFormatText, OpenAI::ResponseFormatJSONObject, OpenAI::ResponseFormatJSONSchema, nil] Specifies the format that the model must output. Compatible with [GPT-4o](https:
        #
        # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
        #
        # @param thread [OpenAI::Beta::ThreadCreateAndRunParams::Thread] Options to create a new thread. If no thread is provided when running a
        #
        # @param tool_choice [Symbol, OpenAI::Beta::AssistantToolChoiceOption::Auto, OpenAI::Beta::AssistantToolChoice, nil] Controls which (if any) tool is called by the model.
        #
        # @param tool_resources [OpenAI::Beta::ThreadCreateAndRunParams::ToolResources, nil] A set of resources that are used by the assistant's tools. The resources are spe
        #
        # @param tools [Array<OpenAI::Beta::CodeInterpreterTool, OpenAI::Beta::FileSearchTool, OpenAI::Beta::FunctionTool>, nil] Override the tools the assistant can use for this run. This is useful for modify
        #
        # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling, where the
        #
        # @param truncation_strategy [OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy, nil] Controls for how a thread will be truncated prior to the run. Use this to contro
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Stream<OpenAI::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Beta::AssistantStreamEvent::ErrorEvent>]
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
            headers: {"accept" => "text/event-stream"},
            body: parsed,
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Beta::AssistantStreamEvent,
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
