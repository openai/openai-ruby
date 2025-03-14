# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class Run < OpenAI::BaseModel
          # The identifier, which can be referenced in API endpoints.
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          # The ID of the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   execution of this run.
          sig { returns(String) }
          def assistant_id
          end

          sig { params(_: String).returns(String) }
          def assistant_id=(_)
          end

          # The Unix timestamp (in seconds) for when the run was cancelled.
          sig { returns(T.nilable(Integer)) }
          def cancelled_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def cancelled_at=(_)
          end

          # The Unix timestamp (in seconds) for when the run was completed.
          sig { returns(T.nilable(Integer)) }
          def completed_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def completed_at=(_)
          end

          # The Unix timestamp (in seconds) for when the run was created.
          sig { returns(Integer) }
          def created_at
          end

          sig { params(_: Integer).returns(Integer) }
          def created_at=(_)
          end

          # The Unix timestamp (in seconds) for when the run will expire.
          sig { returns(T.nilable(Integer)) }
          def expires_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def expires_at=(_)
          end

          # The Unix timestamp (in seconds) for when the run failed.
          sig { returns(T.nilable(Integer)) }
          def failed_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def failed_at=(_)
          end

          # Details on why the run is incomplete. Will be `null` if the run is not
          #   incomplete.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::IncompleteDetails)) }
          def incomplete_details
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Run::IncompleteDetails))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Run::IncompleteDetails))
          end
          def incomplete_details=(_)
          end

          # The instructions that the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   this run.
          sig { returns(String) }
          def instructions
          end

          sig { params(_: String).returns(String) }
          def instructions=(_)
          end

          # The last error associated with this run. Will be `null` if there are no errors.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::LastError)) }
          def last_error
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Run::LastError))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Run::LastError))
          end
          def last_error=(_)
          end

          # The maximum number of completion tokens specified to have been used over the
          #   course of the run.
          sig { returns(T.nilable(Integer)) }
          def max_completion_tokens
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def max_completion_tokens=(_)
          end

          # The maximum number of prompt tokens specified to have been used over the course
          #   of the run.
          sig { returns(T.nilable(Integer)) }
          def max_prompt_tokens
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def max_prompt_tokens=(_)
          end

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          sig { returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata
          end

          sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata=(_)
          end

          # The model that the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   this run.
          sig { returns(String) }
          def model
          end

          sig { params(_: String).returns(String) }
          def model=(_)
          end

          # The object type, which is always `thread.run`.
          sig { returns(Symbol) }
          def object
          end

          sig { params(_: Symbol).returns(Symbol) }
          def object=(_)
          end

          # Whether to enable
          #   [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          #   during tool use.
          sig { returns(T::Boolean) }
          def parallel_tool_calls
          end

          sig { params(_: T::Boolean).returns(T::Boolean) }
          def parallel_tool_calls=(_)
          end

          # Details on the action required to continue the run. Will be `null` if no action
          #   is required.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::RequiredAction)) }
          def required_action
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Run::RequiredAction))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Run::RequiredAction))
          end
          def required_action=(_)
          end

          # Specifies the format that the model must output. Compatible with
          #   [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          #   [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          #   and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #   Outputs which ensures the model will match your supplied JSON schema. Learn more
          #   in the
          #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
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
          sig do
            returns(
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              )
            )
          end
          def response_format
          end

          sig do
            params(
              _: T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              )
            )
              .returns(
                T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Models::ResponseFormatText,
                    OpenAI::Models::ResponseFormatJSONObject,
                    OpenAI::Models::ResponseFormatJSONSchema
                  )
                )
              )
          end
          def response_format=(_)
          end

          # The Unix timestamp (in seconds) for when the run was started.
          sig { returns(T.nilable(Integer)) }
          def started_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def started_at=(_)
          end

          # The status of the run, which can be either `queued`, `in_progress`,
          #   `requires_action`, `cancelling`, `cancelled`, `failed`, `completed`,
          #   `incomplete`, or `expired`.
          sig { returns(Symbol) }
          def status
          end

          sig { params(_: Symbol).returns(Symbol) }
          def status=(_)
          end

          # The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
          #   that was executed on as a part of this run.
          sig { returns(String) }
          def thread_id
          end

          sig { params(_: String).returns(String) }
          def thread_id=(_)
          end

          # Controls which (if any) tool is called by the model. `none` means the model will
          #   not call any tools and instead generates a message. `auto` is the default value
          #   and means the model can pick between generating a message or calling one or more
          #   tools. `required` means the model must call one or more tools before responding
          #   to the user. Specifying a particular tool like `{"type": "file_search"}` or
          #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #   call that tool.
          sig { returns(T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice))) }
          def tool_choice
          end

          sig do
            params(_: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)))
              .returns(T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)))
          end
          def tool_choice=(_)
          end

          # The list of tools that the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   this run.
          sig do
            returns(
              T::Array[
              T.any(
                OpenAI::Models::Beta::CodeInterpreterTool,
                OpenAI::Models::Beta::FileSearchTool,
                OpenAI::Models::Beta::FunctionTool
              )
              ]
            )
          end
          def tools
          end

          sig do
            params(
              _: T::Array[
              T.any(
                OpenAI::Models::Beta::CodeInterpreterTool,
                OpenAI::Models::Beta::FileSearchTool,
                OpenAI::Models::Beta::FunctionTool
              )
              ]
            )
              .returns(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::FileSearchTool,
                  OpenAI::Models::Beta::FunctionTool
                )
                ]
              )
          end
          def tools=(_)
          end

          # Controls for how a thread will be truncated prior to the run. Use this to
          #   control the intial context window of the run.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::TruncationStrategy)) }
          def truncation_strategy
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Run::TruncationStrategy))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Run::TruncationStrategy))
          end
          def truncation_strategy=(_)
          end

          # Usage statistics related to the run. This value will be `null` if the run is not
          #   in a terminal state (i.e. `in_progress`, `queued`, etc.).
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::Usage)) }
          def usage
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Run::Usage))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Run::Usage))
          end
          def usage=(_)
          end

          # The sampling temperature used for this run. If not set, defaults to 1.
          sig { returns(T.nilable(Float)) }
          def temperature
          end

          sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
          def temperature=(_)
          end

          # The nucleus sampling value used for this run. If not set, defaults to 1.
          sig { returns(T.nilable(Float)) }
          def top_p
          end

          sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
          def top_p=(_)
          end

          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          sig do
            params(
              id: String,
              assistant_id: String,
              cancelled_at: T.nilable(Integer),
              completed_at: T.nilable(Integer),
              created_at: Integer,
              expires_at: T.nilable(Integer),
              failed_at: T.nilable(Integer),
              incomplete_details: T.nilable(OpenAI::Models::Beta::Threads::Run::IncompleteDetails),
              instructions: String,
              last_error: T.nilable(OpenAI::Models::Beta::Threads::Run::LastError),
              max_completion_tokens: T.nilable(Integer),
              max_prompt_tokens: T.nilable(Integer),
              metadata: T.nilable(OpenAI::Models::Metadata),
              model: String,
              parallel_tool_calls: T::Boolean,
              required_action: T.nilable(OpenAI::Models::Beta::Threads::Run::RequiredAction),
              response_format: T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              ),
              started_at: T.nilable(Integer),
              status: Symbol,
              thread_id: String,
              tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
              tools: T::Array[
              T.any(
                OpenAI::Models::Beta::CodeInterpreterTool,
                OpenAI::Models::Beta::FileSearchTool,
                OpenAI::Models::Beta::FunctionTool
              )
              ],
              truncation_strategy: T.nilable(OpenAI::Models::Beta::Threads::Run::TruncationStrategy),
              usage: T.nilable(OpenAI::Models::Beta::Threads::Run::Usage),
              temperature: T.nilable(Float),
              top_p: T.nilable(Float),
              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(
            id:,
            assistant_id:,
            cancelled_at:,
            completed_at:,
            created_at:,
            expires_at:,
            failed_at:,
            incomplete_details:,
            instructions:,
            last_error:,
            max_completion_tokens:,
            max_prompt_tokens:,
            metadata:,
            model:,
            parallel_tool_calls:,
            required_action:,
            response_format:,
            started_at:,
            status:,
            thread_id:,
            tool_choice:,
            tools:,
            truncation_strategy:,
            usage:,
            temperature: nil,
            top_p: nil,
            object: :"thread.run"
          )
          end

          sig do
            override
              .returns(
                {
                  id: String,
                  assistant_id: String,
                  cancelled_at: T.nilable(Integer),
                  completed_at: T.nilable(Integer),
                  created_at: Integer,
                  expires_at: T.nilable(Integer),
                  failed_at: T.nilable(Integer),
                  incomplete_details: T.nilable(OpenAI::Models::Beta::Threads::Run::IncompleteDetails),
                  instructions: String,
                  last_error: T.nilable(OpenAI::Models::Beta::Threads::Run::LastError),
                  max_completion_tokens: T.nilable(Integer),
                  max_prompt_tokens: T.nilable(Integer),
                  metadata: T.nilable(OpenAI::Models::Metadata),
                  model: String,
                  object: Symbol,
                  parallel_tool_calls: T::Boolean,
                  required_action: T.nilable(OpenAI::Models::Beta::Threads::Run::RequiredAction),
                  response_format: T.nilable(
                    T.any(
                      Symbol,
                      OpenAI::Models::ResponseFormatText,
                      OpenAI::Models::ResponseFormatJSONObject,
                      OpenAI::Models::ResponseFormatJSONSchema
                    )
                  ),
                  started_at: T.nilable(Integer),
                  status: Symbol,
                  thread_id: String,
                  tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
                  tools: T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::FileSearchTool,
                    OpenAI::Models::Beta::FunctionTool
                  )
                  ],
                  truncation_strategy: T.nilable(OpenAI::Models::Beta::Threads::Run::TruncationStrategy),
                  usage: T.nilable(OpenAI::Models::Beta::Threads::Run::Usage),
                  temperature: T.nilable(Float),
                  top_p: T.nilable(Float)
                }
              )
          end
          def to_hash
          end

          class IncompleteDetails < OpenAI::BaseModel
            # The reason why the run is incomplete. This will point to which specific token
            #   limit was reached over the course of the run.
            sig { returns(T.nilable(Symbol)) }
            def reason
            end

            sig { params(_: Symbol).returns(Symbol) }
            def reason=(_)
            end

            # Details on why the run is incomplete. Will be `null` if the run is not
            #   incomplete.
            sig { params(reason: Symbol).returns(T.attached_class) }
            def self.new(reason: nil)
            end

            sig { override.returns({reason: Symbol}) }
            def to_hash
            end

            # The reason why the run is incomplete. This will point to which specific token
            #   limit was reached over the course of the run.
            class Reason < OpenAI::Enum
              abstract!

              MAX_COMPLETION_TOKENS = :max_completion_tokens
              MAX_PROMPT_TOKENS = :max_prompt_tokens

              class << self
                sig { override.returns(T::Array[Symbol]) }
                def values
                end
              end
            end
          end

          class LastError < OpenAI::BaseModel
            # One of `server_error`, `rate_limit_exceeded`, or `invalid_prompt`.
            sig { returns(Symbol) }
            def code
            end

            sig { params(_: Symbol).returns(Symbol) }
            def code=(_)
            end

            # A human-readable description of the error.
            sig { returns(String) }
            def message
            end

            sig { params(_: String).returns(String) }
            def message=(_)
            end

            # The last error associated with this run. Will be `null` if there are no errors.
            sig { params(code: Symbol, message: String).returns(T.attached_class) }
            def self.new(code:, message:)
            end

            sig { override.returns({code: Symbol, message: String}) }
            def to_hash
            end

            # One of `server_error`, `rate_limit_exceeded`, or `invalid_prompt`.
            class Code < OpenAI::Enum
              abstract!

              SERVER_ERROR = :server_error
              RATE_LIMIT_EXCEEDED = :rate_limit_exceeded
              INVALID_PROMPT = :invalid_prompt

              class << self
                sig { override.returns(T::Array[Symbol]) }
                def values
                end
              end
            end
          end

          class RequiredAction < OpenAI::BaseModel
            # Details on the tool outputs needed for this run to continue.
            sig { returns(OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs) }
            def submit_tool_outputs
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs)
                .returns(OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs)
            end
            def submit_tool_outputs=(_)
            end

            # For now, this is always `submit_tool_outputs`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # Details on the action required to continue the run. Will be `null` if no action
            #   is required.
            sig do
              params(
                submit_tool_outputs: OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(submit_tool_outputs:, type: :submit_tool_outputs)
            end

            sig do
              override
                .returns(
                  {submit_tool_outputs: OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs, type: Symbol}
                )
            end
            def to_hash
            end

            class SubmitToolOutputs < OpenAI::BaseModel
              # A list of the relevant tool calls.
              sig { returns(T::Array[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall]) }
              def tool_calls
              end

              sig do
                params(_: T::Array[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall])
                  .returns(T::Array[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall])
              end
              def tool_calls=(_)
              end

              # Details on the tool outputs needed for this run to continue.
              sig do
                params(tool_calls: T::Array[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall])
                  .returns(T.attached_class)
              end
              def self.new(tool_calls:)
              end

              sig { override.returns({tool_calls: T::Array[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall]}) }
              def to_hash
              end
            end
          end

          class TruncationStrategy < OpenAI::BaseModel
            # The truncation strategy to use for the thread. The default is `auto`. If set to
            #   `last_messages`, the thread will be truncated to the n most recent messages in
            #   the thread. When set to `auto`, messages in the middle of the thread will be
            #   dropped to fit the context length of the model, `max_prompt_tokens`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The number of most recent messages from the thread when constructing the context
            #   for the run.
            sig { returns(T.nilable(Integer)) }
            def last_messages
            end

            sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def last_messages=(_)
            end

            # Controls for how a thread will be truncated prior to the run. Use this to
            #   control the intial context window of the run.
            sig { params(type: Symbol, last_messages: T.nilable(Integer)).returns(T.attached_class) }
            def self.new(type:, last_messages: nil)
            end

            sig { override.returns({type: Symbol, last_messages: T.nilable(Integer)}) }
            def to_hash
            end

            # The truncation strategy to use for the thread. The default is `auto`. If set to
            #   `last_messages`, the thread will be truncated to the n most recent messages in
            #   the thread. When set to `auto`, messages in the middle of the thread will be
            #   dropped to fit the context length of the model, `max_prompt_tokens`.
            class Type < OpenAI::Enum
              abstract!

              AUTO = :auto
              LAST_MESSAGES = :last_messages

              class << self
                sig { override.returns(T::Array[Symbol]) }
                def values
                end
              end
            end
          end

          class Usage < OpenAI::BaseModel
            # Number of completion tokens used over the course of the run.
            sig { returns(Integer) }
            def completion_tokens
            end

            sig { params(_: Integer).returns(Integer) }
            def completion_tokens=(_)
            end

            # Number of prompt tokens used over the course of the run.
            sig { returns(Integer) }
            def prompt_tokens
            end

            sig { params(_: Integer).returns(Integer) }
            def prompt_tokens=(_)
            end

            # Total number of tokens used (prompt + completion).
            sig { returns(Integer) }
            def total_tokens
            end

            sig { params(_: Integer).returns(Integer) }
            def total_tokens=(_)
            end

            # Usage statistics related to the run. This value will be `null` if the run is not
            #   in a terminal state (i.e. `in_progress`, `queued`, etc.).
            sig do
              params(
                completion_tokens: Integer,
                prompt_tokens: Integer,
                total_tokens: Integer
              ).returns(T.attached_class)
            end
            def self.new(completion_tokens:, prompt_tokens:, total_tokens:)
            end

            sig do
              override.returns({completion_tokens: Integer, prompt_tokens: Integer, total_tokens: Integer})
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
