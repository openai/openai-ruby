# typed: strong

module OpenAI
  module Resources
    class Beta
      class Threads
        class Runs
          sig { returns(OpenAI::Resources::Beta::Threads::Runs::Steps) }
          attr_reader :steps

          # See {OpenAI::Resources::Beta::Threads::Runs#create_stream_raw} for streaming
          # counterpart.
          #
          # Create a run.
          sig do
            params(
              thread_id: String,
              assistant_id: String,
              include:
                T::Array[OpenAI::Beta::Threads::Runs::RunStepInclude::OrSymbol],
              additional_instructions: T.nilable(String),
              additional_messages:
                T.nilable(
                  T::Array[
                    OpenAI::Beta::Threads::RunCreateParams::AdditionalMessage::OrHash
                  ]
                ),
              instructions: T.nilable(String),
              max_completion_tokens: T.nilable(Integer),
              max_prompt_tokens: T.nilable(Integer),
              metadata: T.nilable(T::Hash[Symbol, String]),
              model: T.nilable(T.any(String, OpenAI::ChatModel::OrSymbol)),
              parallel_tool_calls: T::Boolean,
              reasoning_effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
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
              tool_choice:
                T.nilable(
                  T.any(
                    OpenAI::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                    OpenAI::Beta::AssistantToolChoice::OrHash
                  )
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
                T.nilable(
                  OpenAI::Beta::Threads::RunCreateParams::TruncationStrategy::OrHash
                ),
              stream: T.noreturn,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Beta::Threads::Run)
          end
          def create(
            # Path param: The ID of the thread to run.
            thread_id,
            # Body param: The ID of the
            # [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
            # execute this run.
            assistant_id:,
            # Query param: A list of additional fields to include in the response. Currently
            # the only supported value is
            # `step_details.tool_calls[*].file_search.results[*].content` to fetch the file
            # search result content.
            #
            # See the
            # [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            # for more information.
            include: nil,
            # Body param: Appends additional instructions at the end of the instructions for
            # the run. This is useful for modifying the behavior on a per-run basis without
            # overriding other instructions.
            additional_instructions: nil,
            # Body param: Adds additional messages to the thread before creating the run.
            additional_messages: nil,
            # Body param: Overrides the
            # [instructions](https://platform.openai.com/docs/api-reference/assistants/createAssistant)
            # of the assistant. This is useful for modifying the behavior on a per-run basis.
            instructions: nil,
            # Body param: The maximum number of completion tokens that may be used over the
            # course of the run. The run will make a best effort to use only the number of
            # completion tokens specified, across multiple turns of the run. If the run
            # exceeds the number of completion tokens specified, the run will end with status
            # `incomplete`. See `incomplete_details` for more info.
            max_completion_tokens: nil,
            # Body param: The maximum number of prompt tokens that may be used over the course
            # of the run. The run will make a best effort to use only the number of prompt
            # tokens specified, across multiple turns of the run. If the run exceeds the
            # number of prompt tokens specified, the run will end with status `incomplete`.
            # See `incomplete_details` for more info.
            max_prompt_tokens: nil,
            # Body param: Set of 16 key-value pairs that can be attached to an object. This
            # can be useful for storing additional information about the object in a
            # structured format, and querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            metadata: nil,
            # Body param: The ID of the
            # [Model](https://platform.openai.com/docs/api-reference/models) to be used to
            # execute this run. If a value is provided here, it will override the model
            # associated with the assistant. If not, the model associated with the assistant
            # will be used.
            model: nil,
            # Body param: Whether to enable
            # [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
            # during tool use.
            parallel_tool_calls: nil,
            # Body param: Constrains effort on reasoning for
            # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
            # supported values are `minimal`, `low`, `medium`, and `high`. Reducing reasoning
            # effort can result in faster responses and fewer tokens used on reasoning in a
            # response.
            reasoning_effort: nil,
            # Body param: Specifies the format that the model must output. Compatible with
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
            # Body param: What sampling temperature to use, between 0 and 2. Higher values
            # like 0.8 will make the output more random, while lower values like 0.2 will make
            # it more focused and deterministic.
            temperature: nil,
            # Body param: Controls which (if any) tool is called by the model. `none` means
            # the model will not call any tools and instead generates a message. `auto` is the
            # default value and means the model can pick between generating a message or
            # calling one or more tools. `required` means the model must call one or more
            # tools before responding to the user. Specifying a particular tool like
            # `{"type": "file_search"}` or
            # `{"type": "function", "function": {"name": "my_function"}}` forces the model to
            # call that tool.
            tool_choice: nil,
            # Body param: Override the tools the assistant can use for this run. This is
            # useful for modifying the behavior on a per-run basis.
            tools: nil,
            # Body param: An alternative to sampling with temperature, called nucleus
            # sampling, where the model considers the results of the tokens with top_p
            # probability mass. So 0.1 means only the tokens comprising the top 10%
            # probability mass are considered.
            #
            # We generally recommend altering this or temperature but not both.
            top_p: nil,
            # Body param: Controls for how a thread will be truncated prior to the run. Use
            # this to control the initial context window of the run.
            truncation_strategy: nil,
            # There is no need to provide `stream:`. Instead, use `#create_stream_raw` or
            # `#create` for streaming and non-streaming use cases, respectively.
            stream: false,
            request_options: {}
          )
          end

          # See {OpenAI::Resources::Beta::Threads::Runs#create} for non-streaming
          # counterpart.
          #
          # Create a run.
          sig do
            params(
              thread_id: String,
              assistant_id: String,
              include:
                T::Array[OpenAI::Beta::Threads::Runs::RunStepInclude::OrSymbol],
              additional_instructions: T.nilable(String),
              additional_messages:
                T.nilable(
                  T::Array[
                    OpenAI::Beta::Threads::RunCreateParams::AdditionalMessage::OrHash
                  ]
                ),
              instructions: T.nilable(String),
              max_completion_tokens: T.nilable(Integer),
              max_prompt_tokens: T.nilable(Integer),
              metadata: T.nilable(T::Hash[Symbol, String]),
              model: T.nilable(T.any(String, OpenAI::ChatModel::OrSymbol)),
              parallel_tool_calls: T::Boolean,
              reasoning_effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
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
              tool_choice:
                T.nilable(
                  T.any(
                    OpenAI::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                    OpenAI::Beta::AssistantToolChoice::OrHash
                  )
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
                T.nilable(
                  OpenAI::Beta::Threads::RunCreateParams::TruncationStrategy::OrHash
                ),
              stream: T.noreturn,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::Stream[
                OpenAI::Beta::AssistantStreamEvent::Variants
              ]
            )
          end
          def create_stream_raw(
            # Path param: The ID of the thread to run.
            thread_id,
            # Body param: The ID of the
            # [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
            # execute this run.
            assistant_id:,
            # Query param: A list of additional fields to include in the response. Currently
            # the only supported value is
            # `step_details.tool_calls[*].file_search.results[*].content` to fetch the file
            # search result content.
            #
            # See the
            # [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            # for more information.
            include: nil,
            # Body param: Appends additional instructions at the end of the instructions for
            # the run. This is useful for modifying the behavior on a per-run basis without
            # overriding other instructions.
            additional_instructions: nil,
            # Body param: Adds additional messages to the thread before creating the run.
            additional_messages: nil,
            # Body param: Overrides the
            # [instructions](https://platform.openai.com/docs/api-reference/assistants/createAssistant)
            # of the assistant. This is useful for modifying the behavior on a per-run basis.
            instructions: nil,
            # Body param: The maximum number of completion tokens that may be used over the
            # course of the run. The run will make a best effort to use only the number of
            # completion tokens specified, across multiple turns of the run. If the run
            # exceeds the number of completion tokens specified, the run will end with status
            # `incomplete`. See `incomplete_details` for more info.
            max_completion_tokens: nil,
            # Body param: The maximum number of prompt tokens that may be used over the course
            # of the run. The run will make a best effort to use only the number of prompt
            # tokens specified, across multiple turns of the run. If the run exceeds the
            # number of prompt tokens specified, the run will end with status `incomplete`.
            # See `incomplete_details` for more info.
            max_prompt_tokens: nil,
            # Body param: Set of 16 key-value pairs that can be attached to an object. This
            # can be useful for storing additional information about the object in a
            # structured format, and querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            metadata: nil,
            # Body param: The ID of the
            # [Model](https://platform.openai.com/docs/api-reference/models) to be used to
            # execute this run. If a value is provided here, it will override the model
            # associated with the assistant. If not, the model associated with the assistant
            # will be used.
            model: nil,
            # Body param: Whether to enable
            # [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
            # during tool use.
            parallel_tool_calls: nil,
            # Body param: Constrains effort on reasoning for
            # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
            # supported values are `minimal`, `low`, `medium`, and `high`. Reducing reasoning
            # effort can result in faster responses and fewer tokens used on reasoning in a
            # response.
            reasoning_effort: nil,
            # Body param: Specifies the format that the model must output. Compatible with
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
            # Body param: What sampling temperature to use, between 0 and 2. Higher values
            # like 0.8 will make the output more random, while lower values like 0.2 will make
            # it more focused and deterministic.
            temperature: nil,
            # Body param: Controls which (if any) tool is called by the model. `none` means
            # the model will not call any tools and instead generates a message. `auto` is the
            # default value and means the model can pick between generating a message or
            # calling one or more tools. `required` means the model must call one or more
            # tools before responding to the user. Specifying a particular tool like
            # `{"type": "file_search"}` or
            # `{"type": "function", "function": {"name": "my_function"}}` forces the model to
            # call that tool.
            tool_choice: nil,
            # Body param: Override the tools the assistant can use for this run. This is
            # useful for modifying the behavior on a per-run basis.
            tools: nil,
            # Body param: An alternative to sampling with temperature, called nucleus
            # sampling, where the model considers the results of the tokens with top_p
            # probability mass. So 0.1 means only the tokens comprising the top 10%
            # probability mass are considered.
            #
            # We generally recommend altering this or temperature but not both.
            top_p: nil,
            # Body param: Controls for how a thread will be truncated prior to the run. Use
            # this to control the initial context window of the run.
            truncation_strategy: nil,
            # There is no need to provide `stream:`. Instead, use `#create_stream_raw` or
            # `#create` for streaming and non-streaming use cases, respectively.
            stream: true,
            request_options: {}
          )
          end

          # Retrieves a run.
          sig do
            params(
              run_id: String,
              thread_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Beta::Threads::Run)
          end
          def retrieve(
            # The ID of the run to retrieve.
            run_id,
            # The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
            # that was run.
            thread_id:,
            request_options: {}
          )
          end

          # Modifies a run.
          sig do
            params(
              run_id: String,
              thread_id: String,
              metadata: T.nilable(T::Hash[Symbol, String]),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Beta::Threads::Run)
          end
          def update(
            # Path param: The ID of the run to modify.
            run_id,
            # Path param: The ID of the
            # [thread](https://platform.openai.com/docs/api-reference/threads) that was run.
            thread_id:,
            # Body param: Set of 16 key-value pairs that can be attached to an object. This
            # can be useful for storing additional information about the object in a
            # structured format, and querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            metadata: nil,
            request_options: {}
          )
          end

          # Returns a list of runs belonging to a thread.
          sig do
            params(
              thread_id: String,
              after: String,
              before: String,
              limit: Integer,
              order: OpenAI::Beta::Threads::RunListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Threads::Run])
          end
          def list(
            # The ID of the thread the run belongs to.
            thread_id,
            # A cursor for use in pagination. `after` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # ending with obj_foo, your subsequent call can include after=obj_foo in order to
            # fetch the next page of the list.
            after: nil,
            # A cursor for use in pagination. `before` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # starting with obj_foo, your subsequent call can include before=obj_foo in order
            # to fetch the previous page of the list.
            before: nil,
            # A limit on the number of objects to be returned. Limit can range between 1 and
            # 100, and the default is 20.
            limit: nil,
            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            # order and `desc` for descending order.
            order: nil,
            request_options: {}
          )
          end

          # Cancels a run that is `in_progress`.
          sig do
            params(
              run_id: String,
              thread_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Beta::Threads::Run)
          end
          def cancel(
            # The ID of the run to cancel.
            run_id,
            # The ID of the thread to which this run belongs.
            thread_id:,
            request_options: {}
          )
          end

          # See {OpenAI::Resources::Beta::Threads::Runs#submit_tool_outputs_stream_raw} for
          # streaming counterpart.
          #
          # When a run has the `status: "requires_action"` and `required_action.type` is
          # `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          # tool calls once they're all completed. All outputs must be submitted in a single
          # request.
          sig do
            params(
              run_id: String,
              thread_id: String,
              tool_outputs:
                T::Array[
                  OpenAI::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput::OrHash
                ],
              stream: T.noreturn,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Beta::Threads::Run)
          end
          def submit_tool_outputs(
            # Path param: The ID of the run that requires the tool output submission.
            run_id,
            # Path param: The ID of the
            # [thread](https://platform.openai.com/docs/api-reference/threads) to which this
            # run belongs.
            thread_id:,
            # Body param: A list of tools for which the outputs are being submitted.
            tool_outputs:,
            # There is no need to provide `stream:`. Instead, use
            # `#submit_tool_outputs_stream_raw` or `#submit_tool_outputs` for streaming and
            # non-streaming use cases, respectively.
            stream: false,
            request_options: {}
          )
          end

          # See {OpenAI::Resources::Beta::Threads::Runs#submit_tool_outputs} for
          # non-streaming counterpart.
          #
          # When a run has the `status: "requires_action"` and `required_action.type` is
          # `submit_tool_outputs`, this endpoint can be used to submit the outputs from the
          # tool calls once they're all completed. All outputs must be submitted in a single
          # request.
          sig do
            params(
              run_id: String,
              thread_id: String,
              tool_outputs:
                T::Array[
                  OpenAI::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput::OrHash
                ],
              stream: T.noreturn,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::Stream[
                OpenAI::Beta::AssistantStreamEvent::Variants
              ]
            )
          end
          def submit_tool_outputs_stream_raw(
            # Path param: The ID of the run that requires the tool output submission.
            run_id,
            # Path param: The ID of the
            # [thread](https://platform.openai.com/docs/api-reference/threads) to which this
            # run belongs.
            thread_id:,
            # Body param: A list of tools for which the outputs are being submitted.
            tool_outputs:,
            # There is no need to provide `stream:`. Instead, use
            # `#submit_tool_outputs_stream_raw` or `#submit_tool_outputs` for streaming and
            # non-streaming use cases, respectively.
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
end
