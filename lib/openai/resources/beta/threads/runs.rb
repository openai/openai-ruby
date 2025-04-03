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
          # @overload create(thread_id, assistant_id:, include: nil, additional_instructions: nil, additional_messages: nil, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_choice: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
          #
          # @param thread_id [String]
          # @param assistant_id [String]
          # @param include [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>]
          # @param additional_instructions [String, nil]
          # @param additional_messages [Array<OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage>, nil]
          # @param instructions [String, nil]
          # @param max_completion_tokens [Integer, nil]
          # @param max_prompt_tokens [Integer, nil]
          # @param metadata [Hash{Symbol=>String}, nil]
          # @param model [String, Symbol, OpenAI::Models::ChatModel, nil]
          # @param parallel_tool_calls [Boolean]
          # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
          # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
          # @param temperature [Float, nil]
          # @param tool_choice [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil]
          # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
          # @param top_p [Float, nil]
          # @param truncation_strategy [OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy, nil]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunCreateParams
          def create(thread_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunCreateParams.dump_request(params)
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
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # Create a run.
          #
          # @overload create_stream_raw(thread_id, assistant_id:, include: nil, additional_instructions: nil, additional_messages: nil, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_choice: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
          #
          # @param thread_id [String]
          # @param assistant_id [String]
          # @param include [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>]
          # @param additional_instructions [String, nil]
          # @param additional_messages [Array<OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage>, nil]
          # @param instructions [String, nil]
          # @param max_completion_tokens [Integer, nil]
          # @param max_prompt_tokens [Integer, nil]
          # @param metadata [Hash{Symbol=>String}, nil]
          # @param model [String, Symbol, OpenAI::Models::ChatModel, nil]
          # @param parallel_tool_calls [Boolean]
          # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
          # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
          # @param temperature [Float, nil]
          # @param tool_choice [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil]
          # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
          # @param top_p [Float, nil]
          # @param truncation_strategy [OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy, nil]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent>]
          #
          # @see OpenAI::Models::Beta::Threads::RunCreateParams
          def create_stream_raw(thread_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunCreateParams.dump_request(params)
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
              model: OpenAI::Models::Beta::AssistantStreamEvent,
              options: options
            )
          end

          # Retrieves a run.
          #
          # @overload retrieve(run_id, thread_id:, request_options: {})
          #
          # @param run_id [String]
          # @param thread_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunRetrieveParams
          def retrieve(run_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunRetrieveParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :get,
              path: ["threads/%1$s/runs/%2$s", thread_id, run_id],
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # Modifies a run.
          #
          # @overload update(run_id, thread_id:, metadata: nil, request_options: {})
          #
          # @param run_id [String]
          # @param thread_id [String]
          # @param metadata [Hash{Symbol=>String}, nil]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunUpdateParams
          def update(run_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunUpdateParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :post,
              path: ["threads/%1$s/runs/%2$s", thread_id, run_id],
              body: parsed,
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # Returns a list of runs belonging to a thread.
          #
          # @overload list(thread_id, after: nil, before: nil, limit: nil, order: nil, request_options: {})
          #
          # @param thread_id [String]
          # @param after [String]
          # @param before [String]
          # @param limit [Integer]
          # @param order [Symbol, OpenAI::Models::Beta::Threads::RunListParams::Order]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Threads::Run>]
          #
          # @see OpenAI::Models::Beta::Threads::RunListParams
          def list(thread_id, params = {})
            parsed, options = OpenAI::Models::Beta::Threads::RunListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["threads/%1$s/runs", thread_id],
              query: parsed,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # Cancels a run that is `in_progress`.
          #
          # @overload cancel(run_id, thread_id:, request_options: {})
          #
          # @param run_id [String]
          # @param thread_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunCancelParams
          def cancel(run_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunCancelParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :post,
              path: ["threads/%1$s/runs/%2$s/cancel", thread_id, run_id],
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # When a run has the `status: "requires_action"` and `required_action.type` is
          #   `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          #   tool calls once they're all completed. All outputs must be submitted in a single
          #   request.
          #
          # @overload submit_tool_outputs(run_id, thread_id:, tool_outputs:, request_options: {})
          #
          # @param run_id [String]
          # @param thread_id [String]
          # @param tool_outputs [Array<OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput>]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Run]
          #
          # @see OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams
          def submit_tool_outputs(run_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams.dump_request(params)
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
              model: OpenAI::Models::Beta::Threads::Run,
              options: options
            )
          end

          # When a run has the `status: "requires_action"` and `required_action.type` is
          #   `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          #   tool calls once they're all completed. All outputs must be submitted in a single
          #   request.
          #
          # @overload submit_tool_outputs_stream_raw(run_id, thread_id:, tool_outputs:, request_options: {})
          #
          # @param run_id [String]
          # @param thread_id [String]
          # @param tool_outputs [Array<OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput>]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::Stream<OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent>]
          #
          # @see OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams
          def submit_tool_outputs_stream_raw(run_id, params)
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
              path: ["threads/%1$s/runs/%2$s/submit_tool_outputs", thread_id, run_id],
              headers: {"accept" => "text/event-stream"},
              body: parsed,
              stream: OpenAI::Internal::Stream,
              model: OpenAI::Models::Beta::AssistantStreamEvent,
              options: options
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
