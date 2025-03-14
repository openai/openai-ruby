# typed: strong

module OpenAI
  module Resources
    class Beta
      class Threads
        sig { returns(OpenAI::Resources::Beta::Threads::Runs) }
        def runs
        end

        sig { returns(OpenAI::Resources::Beta::Threads::Messages) }
        def messages
        end

        # Create a thread.
        sig do
          params(
            messages: T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message],
            metadata: T.nilable(OpenAI::Models::Metadata),
            tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::Thread)
        end
        def create(messages: nil, metadata: nil, tool_resources: nil, request_options: {})
        end

        # Retrieves a thread.
        sig do
          params(
            thread_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::Thread)
        end
        def retrieve(thread_id, request_options: {})
        end

        # Modifies a thread.
        sig do
          params(
            thread_id: String,
            metadata: T.nilable(OpenAI::Models::Metadata),
            tool_resources: T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::Thread)
        end
        def update(thread_id, metadata: nil, tool_resources: nil, request_options: {})
        end

        # Delete a thread.
        sig do
          params(
            thread_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::ThreadDeleted)
        end
        def delete(thread_id, request_options: {})
        end

        # Create a thread and run it in one request.
        sig do
          params(
            assistant_id: String,
            instructions: T.nilable(String),
            max_completion_tokens: T.nilable(Integer),
            max_prompt_tokens: T.nilable(Integer),
            metadata: T.nilable(OpenAI::Models::Metadata),
            model: T.nilable(T.any(String, Symbol)),
            parallel_tool_calls: T::Boolean,
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            thread: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread,
            tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
            tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources),
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
            truncation_strategy: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Beta::Threads::Run)
        end
        def create_and_run(
          assistant_id:,
          instructions: nil,
          max_completion_tokens: nil,
          max_prompt_tokens: nil,
          metadata: nil,
          model: nil,
          parallel_tool_calls: nil,
          response_format: nil,
          temperature: nil,
          thread: nil,
          tool_choice: nil,
          tool_resources: nil,
          tools: nil,
          top_p: nil,
          truncation_strategy: nil,
          request_options: {}
        )
        end

        # Create a thread and run it in one request.
        sig do
          params(
            assistant_id: String,
            instructions: T.nilable(String),
            max_completion_tokens: T.nilable(Integer),
            max_prompt_tokens: T.nilable(Integer),
            metadata: T.nilable(OpenAI::Models::Metadata),
            model: T.nilable(T.any(String, Symbol)),
            parallel_tool_calls: T::Boolean,
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            thread: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread,
            tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
            tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources),
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
            truncation_strategy: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy),
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
        def create_and_run_streaming(
          assistant_id:,
          instructions: nil,
          max_completion_tokens: nil,
          max_prompt_tokens: nil,
          metadata: nil,
          model: nil,
          parallel_tool_calls: nil,
          response_format: nil,
          temperature: nil,
          thread: nil,
          tool_choice: nil,
          tool_resources: nil,
          tools: nil,
          top_p: nil,
          truncation_strategy: nil,
          request_options: {}
        )
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
