# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        class Runs
          # @return [OpenAI::Resources::Beta::Threads::Runs::Steps]
          attr_reader :steps

          # See {OpenAI::Resources::Beta::Threads::Runs#create_stream_raw} for streaming
          # counterpart.
          #
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::RunCreateParams} for more details.
          #
          # Create a run.
          #
          # @overload create(thread_id, assistant_id:, include: nil, additional_instructions: nil, additional_messages: nil, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_choice: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
          #
          # @param thread_id [String] Path param: The ID of the thread to run.
          #
          # @param assistant_id [String] Body param: The ID of the [assistant](https://platform.openai.com/docs/api-refer
          #
          # @param include [Array<Symbol, OpenAI::Beta::Threads::Runs::RunStepInclude>] Query param: A list of additional fields to include in the response. Currently t
          #
          # @param additional_instructions [String, nil] Body param: Appends additional instructions at the end of the instructions for t
          #
          # @param additional_messages [Array<OpenAI::Beta::Threads::RunCreateParams::AdditionalMessage>, nil] Body param: Adds additional messages to the thread before creating the run.
          #
          # @param instructions [String, nil] Body param: Overrides the [instructions](https://platform.openai.com/docs/api-re
          #
          # @param max_completion_tokens [Integer, nil] Body param: The maximum number of completion tokens that may be used over the co
          #
          # @param max_prompt_tokens [Integer, nil] Body param: The maximum number of prompt tokens that may be used over the course
          #
          # @param metadata [Hash{Symbol=>String}, nil] Body param: Set of 16 key-value pairs that can be attached to an object. This ca
          #
          # @param model [String, Symbol, OpenAI::ChatModel, nil] Body param: The ID of the [Model](https://platform.openai.com/docs/api-reference
          #
          # @param parallel_tool_calls [Boolean] Body param: Whether to enable [parallel function calling](https://platform.opena
          #
          # @param reasoning_effort [Symbol, OpenAI::ReasoningEffort, nil] Body param: **o-series models only**
          #
          # @param response_format [Symbol, :auto, OpenAI::ResponseFormatText, OpenAI::ResponseFormatJSONObject, OpenAI::ResponseFormatJSONSchema, nil] Body param: Specifies the format that the model must output. Compatible with [GP
          #
          # @param temperature [Float, nil] Body param: What sampling temperature to use, between 0 and 2. Higher values lik
          #
          # @param tool_choice [Symbol, OpenAI::Beta::AssistantToolChoiceOption::Auto, OpenAI::Beta::AssistantToolChoice, nil] Body param: Controls which (if any) tool is called by the model.
          #
          # @param tools [Array<OpenAI::Beta::CodeInterpreterTool, OpenAI::Beta::FileSearchTool, OpenAI::Beta::FunctionTool>, nil] Body param: Override the tools the assistant can use for this run. This is usefu
          #
          # @param top_p [Float, nil] Body param: An alternative to sampling with temperature, called nucleus sampling
          #
          # @param truncation_strategy [OpenAI::Beta::Threads::RunCreateParams::TruncationStrategy, nil] Body param: Controls for how a thread will be truncated prior to the run. Use th
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunCreateParams
          def create(thread_id, params)
            parsed, options = OpenAI::Beta::Threads::RunCreateParams.dump_request(params)
            if parsed[:stream]
              message = "Please use `#create_stream_raw` for the streaming use case."
              raise ArgumentError.new(message)
            end
            query_params = [:include]
            @client.request(
              method: :post,
              path: ["threads/%1$s/runs", thread_id],
              query: parsed.slice(*query_params),
              body: parsed.except(*query_params),
              model: OpenAI::Beta::Threads::Run,
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # See {OpenAI::Resources::Beta::Threads::Runs#create} for non-streaming
          # counterpart.
          #
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::RunCreateParams} for more details.
          #
          # Create a run.
          #
          # @overload create_stream_raw(thread_id, assistant_id:, include: nil, additional_instructions: nil, additional_messages: nil, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_choice: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
          #
          # @param thread_id [String] Path param: The ID of the thread to run.
          #
          # @param assistant_id [String] Body param: The ID of the [assistant](https://platform.openai.com/docs/api-refer
          #
          # @param include [Array<Symbol, OpenAI::Beta::Threads::Runs::RunStepInclude>] Query param: A list of additional fields to include in the response. Currently t
          #
          # @param additional_instructions [String, nil] Body param: Appends additional instructions at the end of the instructions for t
          #
          # @param additional_messages [Array<OpenAI::Beta::Threads::RunCreateParams::AdditionalMessage>, nil] Body param: Adds additional messages to the thread before creating the run.
          #
          # @param instructions [String, nil] Body param: Overrides the [instructions](https://platform.openai.com/docs/api-re
          #
          # @param max_completion_tokens [Integer, nil] Body param: The maximum number of completion tokens that may be used over the co
          #
          # @param max_prompt_tokens [Integer, nil] Body param: The maximum number of prompt tokens that may be used over the course
          #
          # @param metadata [Hash{Symbol=>String}, nil] Body param: Set of 16 key-value pairs that can be attached to an object. This ca
          #
          # @param model [String, Symbol, OpenAI::ChatModel, nil] Body param: The ID of the [Model](https://platform.openai.com/docs/api-reference
          #
          # @param parallel_tool_calls [Boolean] Body param: Whether to enable [parallel function calling](https://platform.opena
          #
          # @param reasoning_effort [Symbol, OpenAI::ReasoningEffort, nil] Body param: **o-series models only**
          #
          # @param response_format [Symbol, :auto, OpenAI::ResponseFormatText, OpenAI::ResponseFormatJSONObject, OpenAI::ResponseFormatJSONSchema, nil] Body param: Specifies the format that the model must output. Compatible with [GP
          #
          # @param temperature [Float, nil] Body param: What sampling temperature to use, between 0 and 2. Higher values lik
          #
          # @param tool_choice [Symbol, OpenAI::Beta::AssistantToolChoiceOption::Auto, OpenAI::Beta::AssistantToolChoice, nil] Body param: Controls which (if any) tool is called by the model.
          #
          # @param tools [Array<OpenAI::Beta::CodeInterpreterTool, OpenAI::Beta::FileSearchTool, OpenAI::Beta::FunctionTool>, nil] Body param: Override the tools the assistant can use for this run. This is usefu
          #
          # @param top_p [Float, nil] Body param: An alternative to sampling with temperature, called nucleus sampling
          #
          # @param truncation_strategy [OpenAI::Beta::Threads::RunCreateParams::TruncationStrategy, nil] Body param: Controls for how a thread will be truncated prior to the run. Use th
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::Stream<OpenAI::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Beta::AssistantStreamEvent::ErrorEvent>]
          #
          # @see OpenAI::Models::Beta::Threads::RunCreateParams
          def create_stream_raw(thread_id, params)
            parsed, options = OpenAI::Beta::Threads::RunCreateParams.dump_request(params)
            unless parsed.fetch(:stream, true)
              message = "Please use `#create` for the non-streaming use case."
              raise ArgumentError.new(message)
            end
            parsed.store(:stream, true)
            query_params = [:include]
            @client.request(
              method: :post,
              path: ["threads/%1$s/runs", thread_id],
              query: parsed.slice(*query_params),
              headers: {"accept" => "text/event-stream"},
              body: parsed.except(*query_params),
              stream: OpenAI::Internal::Stream,
              model: OpenAI::Beta::AssistantStreamEvent,
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::RunRetrieveParams} for more details.
          #
          # Retrieves a run.
          #
          # @overload retrieve(run_id, thread_id:, request_options: {})
          #
          # @param run_id [String] The ID of the run to retrieve.
          #
          # @param thread_id [String] The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) t
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunRetrieveParams
          def retrieve(run_id, params)
            parsed, options = OpenAI::Beta::Threads::RunRetrieveParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :get,
              path: ["threads/%1$s/runs/%2$s", thread_id, run_id],
              model: OpenAI::Beta::Threads::Run,
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::RunUpdateParams} for more details.
          #
          # Modifies a run.
          #
          # @overload update(run_id, thread_id:, metadata: nil, request_options: {})
          #
          # @param run_id [String] Path param: The ID of the run to modify.
          #
          # @param thread_id [String] Path param: The ID of the [thread](https://platform.openai.com/docs/api-referenc
          #
          # @param metadata [Hash{Symbol=>String}, nil] Body param: Set of 16 key-value pairs that can be attached to an object. This ca
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunUpdateParams
          def update(run_id, params)
            parsed, options = OpenAI::Beta::Threads::RunUpdateParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :post,
              path: ["threads/%1$s/runs/%2$s", thread_id, run_id],
              body: parsed,
              model: OpenAI::Beta::Threads::Run,
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::RunListParams} for more details.
          #
          # Returns a list of runs belonging to a thread.
          #
          # @overload list(thread_id, after: nil, before: nil, limit: nil, order: nil, request_options: {})
          #
          # @param thread_id [String] The ID of the thread the run belongs to.
          #
          # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
          #
          # @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
          #
          # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
          #
          # @param order [Symbol, OpenAI::Beta::Threads::RunListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Beta::Threads::Run>]
          #
          # @see OpenAI::Models::Beta::Threads::RunListParams
          def list(thread_id, params = {})
            parsed, options = OpenAI::Beta::Threads::RunListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["threads/%1$s/runs", thread_id],
              query: parsed,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Beta::Threads::Run,
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # Cancels a run that is `in_progress`.
          #
          # @overload cancel(run_id, thread_id:, request_options: {})
          #
          # @param run_id [String] The ID of the run to cancel.
          #
          # @param thread_id [String] The ID of the thread to which this run belongs.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunCancelParams
          def cancel(run_id, params)
            parsed, options = OpenAI::Beta::Threads::RunCancelParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :post,
              path: ["threads/%1$s/runs/%2$s/cancel", thread_id, run_id],
              model: OpenAI::Beta::Threads::Run,
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # See {OpenAI::Resources::Beta::Threads::Runs#submit_tool_outputs_stream_raw} for
          # streaming counterpart.
          #
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams} for more details.
          #
          # When a run has the `status: "requires_action"` and `required_action.type` is
          # `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          # tool calls once they're all completed. All outputs must be submitted in a single
          # request.
          #
          # @overload submit_tool_outputs(run_id, thread_id:, tool_outputs:, request_options: {})
          #
          # @param run_id [String] Path param: The ID of the run that requires the tool output submission.
          #
          # @param thread_id [String] Path param: The ID of the [thread](https://platform.openai.com/docs/api-referenc
          #
          # @param tool_outputs [Array<OpenAI::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput>] Body param: A list of tools for which the outputs are being submitted.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams
          def submit_tool_outputs(run_id, params)
            parsed, options = OpenAI::Beta::Threads::RunSubmitToolOutputsParams.dump_request(params)
            if parsed[:stream]
              message = "Please use `#submit_tool_outputs_stream_raw` for the streaming use case."
              raise ArgumentError.new(message)
            end
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :post,
              path: ["threads/%1$s/runs/%2$s/submit_tool_outputs", thread_id, run_id],
              body: parsed,
              model: OpenAI::Beta::Threads::Run,
              options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
            )
          end

          # See {OpenAI::Resources::Beta::Threads::Runs#submit_tool_outputs} for
          # non-streaming counterpart.
          #
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams} for more details.
          #
          # When a run has the `status: "requires_action"` and `required_action.type` is
          # `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          # tool calls once they're all completed. All outputs must be submitted in a single
          # request.
          #
          # @overload submit_tool_outputs_stream_raw(run_id, thread_id:, tool_outputs:, request_options: {})
          #
          # @param run_id [String] Path param: The ID of the run that requires the tool output submission.
          #
          # @param thread_id [String] Path param: The ID of the [thread](https://platform.openai.com/docs/api-referenc
          #
          # @param tool_outputs [Array<OpenAI::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput>] Body param: A list of tools for which the outputs are being submitted.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::Stream<OpenAI::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Beta::AssistantStreamEvent::ErrorEvent>]
          #
          # @see OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams
          def submit_tool_outputs_stream_raw(run_id, params)
            parsed, options = OpenAI::Beta::Threads::RunSubmitToolOutputsParams.dump_request(params)
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
              path: ["threads/%1$s/runs/%2$s/submit_tool_outputs", thread_id, run_id],
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
            @steps = OpenAI::Resources::Beta::Threads::Runs::Steps.new(client: client)
          end
        end
      end
    end
  end
end
