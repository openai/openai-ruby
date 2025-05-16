# typed: strong

module OpenAI
  module Resources
    class Beta
      class Threads
        sig { returns(OpenAI::Resources::Beta::Threads::Runs) }
        attr_reader :runs

        sig { returns(OpenAI::Resources::Beta::Threads::Messages) }
        attr_reader :messages

        # Create a thread.
        sig do
          params(
            messages:
              T::Array[OpenAI::Beta::ThreadCreateParams::Message::OrHash],
            metadata: T.nilable(T::Hash[Symbol, String]),
            tool_resources:
              T.nilable(
                OpenAI::Beta::ThreadCreateParams::ToolResources::OrHash
              ),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Beta::Thread)
        end
        def create(
          # A list of [messages](https://platform.openai.com/docs/api-reference/messages) to
          # start the thread with.
          messages: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # A set of resources that are made available to the assistant's tools in this
          # thread. The resources are specific to the type of tool. For example, the
          # `code_interpreter` tool requires a list of file IDs, while the `file_search`
          # tool requires a list of vector store IDs.
          tool_resources: nil,
          request_options: {}
        )
        end

        # Retrieves a thread.
        sig do
          params(
            thread_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Beta::Thread)
        end
        def retrieve(
          # The ID of the thread to retrieve.
          thread_id,
          request_options: {}
        )
        end

        # Modifies a thread.
        sig do
          params(
            thread_id: String,
            metadata: T.nilable(T::Hash[Symbol, String]),
            tool_resources:
              T.nilable(
                OpenAI::Beta::ThreadUpdateParams::ToolResources::OrHash
              ),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Beta::Thread)
        end
        def update(
          # The ID of the thread to modify. Only the `metadata` can be modified.
          thread_id,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # A set of resources that are made available to the assistant's tools in this
          # thread. The resources are specific to the type of tool. For example, the
          # `code_interpreter` tool requires a list of file IDs, while the `file_search`
          # tool requires a list of vector store IDs.
          tool_resources: nil,
          request_options: {}
        )
        end

        # Delete a thread.
        sig do
          params(
            thread_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Beta::ThreadDeleted)
        end
        def delete(
          # The ID of the thread to delete.
          thread_id,
          request_options: {}
        )
        end

        # See {OpenAI::Resources::Beta::Threads#stream_raw} for streaming counterpart.
        #
        # Create a thread and run it in one request.
        sig do
          params(
            assistant_id: String,
            instructions: T.nilable(String),
            max_completion_tokens: T.nilable(Integer),
            max_prompt_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: T.nilable(T.any(String, OpenAI::ChatModel::OrSymbol)),
            parallel_tool_calls: T::Boolean,
            response_format:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::ResponseFormatText::OrHash,
                  OpenAI::ResponseFormatJSONObject::OrHash,
                  OpenAI::ResponseFormatJSONSchema::OrHash
                )
              ),
            temperature: T.nilable(Float),
            thread: OpenAI::Beta::ThreadCreateAndRunParams::Thread::OrHash,
            tool_choice:
              T.nilable(
                T.any(
                  OpenAI::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                  OpenAI::Beta::AssistantToolChoice::OrHash
                )
              ),
            tool_resources:
              T.nilable(
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::OrHash
              ),
            tools:
              T.nilable(
                T::Array[
                  T.any(
                    OpenAI::Beta::CodeInterpreterTool::OrHash,
                    OpenAI::Beta::FileSearchTool::OrHash,
                    OpenAI::Beta::FunctionTool::OrHash
                  )
                ]
              ),
            top_p: T.nilable(Float),
            truncation_strategy:
              T.nilable(OpenAI::Beta::TruncationObject::OrHash),
            stream: T.noreturn,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Beta::Threads::Run)
        end
        def create_and_run(
          # The ID of the
          # [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
          # execute this run.
          assistant_id:,
          # Override the default system message of the assistant. This is useful for
          # modifying the behavior on a per-run basis.
          instructions: nil,
          # The maximum number of completion tokens that may be used over the course of the
          # run. The run will make a best effort to use only the number of completion tokens
          # specified, across multiple turns of the run. If the run exceeds the number of
          # completion tokens specified, the run will end with status `incomplete`. See
          # `incomplete_details` for more info.
          max_completion_tokens: nil,
          # The maximum number of prompt tokens that may be used over the course of the run.
          # The run will make a best effort to use only the number of prompt tokens
          # specified, across multiple turns of the run. If the run exceeds the number of
          # prompt tokens specified, the run will end with status `incomplete`. See
          # `incomplete_details` for more info.
          max_prompt_tokens: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
          # be used to execute this run. If a value is provided here, it will override the
          # model associated with the assistant. If not, the model associated with the
          # assistant will be used.
          model: nil,
          # Whether to enable
          # [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          # during tool use.
          parallel_tool_calls: nil,
          # Specifies the format that the model must output. Compatible with
          # [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          # [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          # and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          # Outputs which ensures the model will match your supplied JSON schema. Learn more
          # in the
          # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          # Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          # message the model generates is valid JSON.
          #
          # **Important:** when using JSON mode, you **must** also instruct the model to
          # produce JSON yourself via a system or user message. Without this, the model may
          # generate an unending stream of whitespace until the generation reaches the token
          # limit, resulting in a long-running and seemingly "stuck" request. Also note that
          # the message content may be partially cut off if `finish_reason="length"`, which
          # indicates the generation exceeded `max_tokens` or the conversation exceeded the
          # max context length.
          response_format: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          # make the output more random, while lower values like 0.2 will make it more
          # focused and deterministic.
          temperature: nil,
          # Options to create a new thread. If no thread is provided when running a request,
          # an empty thread will be created.
          thread: nil,
          # Controls which (if any) tool is called by the model. `none` means the model will
          # not call any tools and instead generates a message. `auto` is the default value
          # and means the model can pick between generating a message or calling one or more
          # tools. `required` means the model must call one or more tools before responding
          # to the user. Specifying a particular tool like `{"type": "file_search"}` or
          # `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          # call that tool.
          tool_choice: nil,
          # A set of resources that are used by the assistant's tools. The resources are
          # specific to the type of tool. For example, the `code_interpreter` tool requires
          # a list of file IDs, while the `file_search` tool requires a list of vector store
          # IDs.
          tool_resources: nil,
          # Override the tools the assistant can use for this run. This is useful for
          # modifying the behavior on a per-run basis.
          tools: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          # model considers the results of the tokens with top_p probability mass. So 0.1
          # means only the tokens comprising the top 10% probability mass are considered.
          #
          # We generally recommend altering this or temperature but not both.
          top_p: nil,
          # Controls for how a thread will be truncated prior to the run. Use this to
          # control the intial context window of the run.
          truncation_strategy: nil,
          # There is no need to provide `stream:`. Instead, use `#stream_raw` or
          # `#create_and_run` for streaming and non-streaming use cases, respectively.
          stream: false,
          request_options: {}
        )
        end

        # See {OpenAI::Resources::Beta::Threads#create_and_run} for non-streaming
        # counterpart.
        #
        # Create a thread and run it in one request.
        sig do
          params(
            assistant_id: String,
            instructions: T.nilable(String),
            max_completion_tokens: T.nilable(Integer),
            max_prompt_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: T.nilable(T.any(String, OpenAI::ChatModel::OrSymbol)),
            parallel_tool_calls: T::Boolean,
            response_format:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::ResponseFormatText::OrHash,
                  OpenAI::ResponseFormatJSONObject::OrHash,
                  OpenAI::ResponseFormatJSONSchema::OrHash
                )
              ),
            temperature: T.nilable(Float),
            thread: OpenAI::Beta::ThreadCreateAndRunParams::Thread::OrHash,
            tool_choice:
              T.nilable(
                T.any(
                  OpenAI::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                  OpenAI::Beta::AssistantToolChoice::OrHash
                )
              ),
            tool_resources:
              T.nilable(
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::OrHash
              ),
            tools:
              T.nilable(
                T::Array[
                  T.any(
                    OpenAI::Beta::CodeInterpreterTool::OrHash,
                    OpenAI::Beta::FileSearchTool::OrHash,
                    OpenAI::Beta::FunctionTool::OrHash
                  )
                ]
              ),
            top_p: T.nilable(Float),
            truncation_strategy:
              T.nilable(OpenAI::Beta::TruncationObject::OrHash),
            stream: T.noreturn,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(
            OpenAI::Internal::Stream[
              T.any(
                OpenAI::Beta::AssistantStreamEvent::ThreadCreated,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunCreated,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunQueued,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunInProgress,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunRequiresAction,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunCompleted,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunIncomplete,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunFailed,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelling,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelled,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunExpired,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCreated,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunStepInProgress,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunStepDelta,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCompleted,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunStepFailed,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCancelled,
                OpenAI::Beta::AssistantStreamEvent::ThreadRunStepExpired,
                OpenAI::Beta::AssistantStreamEvent::ThreadMessageCreated,
                OpenAI::Beta::AssistantStreamEvent::ThreadMessageInProgress,
                OpenAI::Beta::AssistantStreamEvent::ThreadMessageDelta,
                OpenAI::Beta::AssistantStreamEvent::ThreadMessageCompleted,
                OpenAI::Beta::AssistantStreamEvent::ThreadMessageIncomplete,
                OpenAI::Beta::AssistantStreamEvent::ErrorEvent
              )
            ]
          )
        end
        def stream_raw(
          # The ID of the
          # [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
          # execute this run.
          assistant_id:,
          # Override the default system message of the assistant. This is useful for
          # modifying the behavior on a per-run basis.
          instructions: nil,
          # The maximum number of completion tokens that may be used over the course of the
          # run. The run will make a best effort to use only the number of completion tokens
          # specified, across multiple turns of the run. If the run exceeds the number of
          # completion tokens specified, the run will end with status `incomplete`. See
          # `incomplete_details` for more info.
          max_completion_tokens: nil,
          # The maximum number of prompt tokens that may be used over the course of the run.
          # The run will make a best effort to use only the number of prompt tokens
          # specified, across multiple turns of the run. If the run exceeds the number of
          # prompt tokens specified, the run will end with status `incomplete`. See
          # `incomplete_details` for more info.
          max_prompt_tokens: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
          # be used to execute this run. If a value is provided here, it will override the
          # model associated with the assistant. If not, the model associated with the
          # assistant will be used.
          model: nil,
          # Whether to enable
          # [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          # during tool use.
          parallel_tool_calls: nil,
          # Specifies the format that the model must output. Compatible with
          # [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          # [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          # and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          # Outputs which ensures the model will match your supplied JSON schema. Learn more
          # in the
          # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          # Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          # message the model generates is valid JSON.
          #
          # **Important:** when using JSON mode, you **must** also instruct the model to
          # produce JSON yourself via a system or user message. Without this, the model may
          # generate an unending stream of whitespace until the generation reaches the token
          # limit, resulting in a long-running and seemingly "stuck" request. Also note that
          # the message content may be partially cut off if `finish_reason="length"`, which
          # indicates the generation exceeded `max_tokens` or the conversation exceeded the
          # max context length.
          response_format: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          # make the output more random, while lower values like 0.2 will make it more
          # focused and deterministic.
          temperature: nil,
          # Options to create a new thread. If no thread is provided when running a request,
          # an empty thread will be created.
          thread: nil,
          # Controls which (if any) tool is called by the model. `none` means the model will
          # not call any tools and instead generates a message. `auto` is the default value
          # and means the model can pick between generating a message or calling one or more
          # tools. `required` means the model must call one or more tools before responding
          # to the user. Specifying a particular tool like `{"type": "file_search"}` or
          # `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          # call that tool.
          tool_choice: nil,
          # A set of resources that are used by the assistant's tools. The resources are
          # specific to the type of tool. For example, the `code_interpreter` tool requires
          # a list of file IDs, while the `file_search` tool requires a list of vector store
          # IDs.
          tool_resources: nil,
          # Override the tools the assistant can use for this run. This is useful for
          # modifying the behavior on a per-run basis.
          tools: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          # model considers the results of the tokens with top_p probability mass. So 0.1
          # means only the tokens comprising the top 10% probability mass are considered.
          #
          # We generally recommend altering this or temperature but not both.
          top_p: nil,
          # Controls for how a thread will be truncated prior to the run. Use this to
          # control the intial context window of the run.
          truncation_strategy: nil,
          # There is no need to provide `stream:`. Instead, use `#stream_raw` or
          # `#create_and_run` for streaming and non-streaming use cases, respectively.
          stream: true,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
