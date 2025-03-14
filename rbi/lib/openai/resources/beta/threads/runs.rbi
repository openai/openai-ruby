# typed: strong

module OpenAI
  module Resources
    class Beta
      class Threads
        class Runs
          sig { returns(OpenAI::Resources::Beta::Threads::Runs::Steps) }
          def steps
          end

          # Create a run.
          sig do
            params(
              thread_id: String,
              assistant_id: String,
              include: T::Array[Symbol],
              additional_instructions: T.nilable(String),
              additional_messages: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage]),
              instructions: T.nilable(String),
              max_completion_tokens: T.nilable(Integer),
              max_prompt_tokens: T.nilable(Integer),
              metadata: T.nilable(OpenAI::Models::Metadata),
              model: T.nilable(T.any(String, Symbol)),
              parallel_tool_calls: T::Boolean,
              reasoning_effort: T.nilable(Symbol),
              response_format: T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              ),
              temperature: T.nilable(Float),
              tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
              tools: T.nilable(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::FileSearchTool,
                  OpenAI::Models::Beta::FunctionTool
                )
                ]
              ),
              top_p: T.nilable(Float),
              truncation_strategy: T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy),
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::Threads::Run)
          end
          def create(
            thread_id,
            assistant_id:,
            include: nil,
            additional_instructions: nil,
            additional_messages: nil,
            instructions: nil,
            max_completion_tokens: nil,
            max_prompt_tokens: nil,
            metadata: nil,
            model: nil,
            parallel_tool_calls: nil,
            reasoning_effort: nil,
            response_format: nil,
            temperature: nil,
            tool_choice: nil,
            tools: nil,
            top_p: nil,
            truncation_strategy: nil,
            request_options: {}
          )
          end

          # Create a run.
          sig do
            params(
              thread_id: String,
              assistant_id: String,
              include: T::Array[Symbol],
              additional_instructions: T.nilable(String),
              additional_messages: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage]),
              instructions: T.nilable(String),
              max_completion_tokens: T.nilable(Integer),
              max_prompt_tokens: T.nilable(Integer),
              metadata: T.nilable(OpenAI::Models::Metadata),
              model: T.nilable(T.any(String, Symbol)),
              parallel_tool_calls: T::Boolean,
              reasoning_effort: T.nilable(Symbol),
              response_format: T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              ),
              temperature: T.nilable(Float),
              tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
              tools: T.nilable(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::FileSearchTool,
                  OpenAI::Models::Beta::FunctionTool
                )
                ]
              ),
              top_p: T.nilable(Float),
              truncation_strategy: T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy),
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(
                OpenAI::Stream[
                T.any(
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete,
                  OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent
                )
                ]
              )
          end
          def create_streaming(
            thread_id,
            assistant_id:,
            include: nil,
            additional_instructions: nil,
            additional_messages: nil,
            instructions: nil,
            max_completion_tokens: nil,
            max_prompt_tokens: nil,
            metadata: nil,
            model: nil,
            parallel_tool_calls: nil,
            reasoning_effort: nil,
            response_format: nil,
            temperature: nil,
            tool_choice: nil,
            tools: nil,
            top_p: nil,
            truncation_strategy: nil,
            request_options: {}
          )
          end

          # Retrieves a run.
          sig do
            params(
              run_id: String,
              thread_id: String,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::Threads::Run)
          end
          def retrieve(run_id, thread_id:, request_options: {})
          end

          # Modifies a run.
          sig do
            params(
              run_id: String,
              thread_id: String,
              metadata: T.nilable(OpenAI::Models::Metadata),
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::Threads::Run)
          end
          def update(run_id, thread_id:, metadata: nil, request_options: {})
          end

          # Returns a list of runs belonging to a thread.
          sig do
            params(
              thread_id: String,
              after: String,
              before: String,
              limit: Integer,
              order: Symbol,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::CursorPage[OpenAI::Models::Beta::Threads::Run])
          end
          def list(thread_id, after: nil, before: nil, limit: nil, order: nil, request_options: {})
          end

          # Cancels a run that is `in_progress`.
          sig do
            params(
              run_id: String,
              thread_id: String,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::Threads::Run)
          end
          def cancel(run_id, thread_id:, request_options: {})
          end

          # When a run has the `status: "requires_action"` and `required_action.type` is
          #   `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          #   tool calls once they're all completed. All outputs must be submitted in a single
          #   request.
          sig do
            params(
              run_id: String,
              thread_id: String,
              tool_outputs: T::Array[OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput],
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::Threads::Run)
          end
          def submit_tool_outputs(run_id, thread_id:, tool_outputs:, request_options: {})
          end

          # When a run has the `status: "requires_action"` and `required_action.type` is
          #   `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          #   tool calls once they're all completed. All outputs must be submitted in a single
          #   request.
          sig do
            params(
              run_id: String,
              thread_id: String,
              tool_outputs: T::Array[OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput],
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(
                OpenAI::Stream[
                T.any(
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted,
                  OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete,
                  OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent
                )
                ]
              )
          end
          def submit_tool_outputs_streaming(run_id, thread_id:, tool_outputs:, request_options: {})
          end

          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
