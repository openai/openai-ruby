# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class Run < OpenAI::Internal::Type::BaseModel
          # The identifier, which can be referenced in API endpoints.
          sig { returns(String) }
          attr_accessor :id

          # The ID of the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   execution of this run.
          sig { returns(String) }
          attr_accessor :assistant_id

          # The Unix timestamp (in seconds) for when the run was cancelled.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :cancelled_at

          # The Unix timestamp (in seconds) for when the run was completed.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :completed_at

          # The Unix timestamp (in seconds) for when the run was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # The Unix timestamp (in seconds) for when the run will expire.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :expires_at

          # The Unix timestamp (in seconds) for when the run failed.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :failed_at

          # Details on why the run is incomplete. Will be `null` if the run is not
          #   incomplete.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::IncompleteDetails)) }
          attr_reader :incomplete_details

          sig do
            params(
              incomplete_details: T.nilable(T.any(OpenAI::Models::Beta::Threads::Run::IncompleteDetails, OpenAI::Internal::AnyHash))
            )
              .void
          end
          attr_writer :incomplete_details

          # The instructions that the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   this run.
          sig { returns(String) }
          attr_accessor :instructions

          # The last error associated with this run. Will be `null` if there are no errors.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::LastError)) }
          attr_reader :last_error

          sig do
            params(
              last_error: T.nilable(T.any(OpenAI::Models::Beta::Threads::Run::LastError, OpenAI::Internal::AnyHash))
            )
              .void
          end
          attr_writer :last_error

          # The maximum number of completion tokens specified to have been used over the
          #   course of the run.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :max_completion_tokens

          # The maximum number of prompt tokens specified to have been used over the course
          #   of the run.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :max_prompt_tokens

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :metadata

          # The model that the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   this run.
          sig { returns(String) }
          attr_accessor :model

          # The object type, which is always `thread.run`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Whether to enable
          #   [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          #   during tool use.
          sig { returns(T::Boolean) }
          attr_accessor :parallel_tool_calls

          # Details on the action required to continue the run. Will be `null` if no action
          #   is required.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::RequiredAction)) }
          attr_reader :required_action

          sig do
            params(
              required_action: T.nilable(T.any(OpenAI::Models::Beta::Threads::Run::RequiredAction, OpenAI::Internal::AnyHash))
            )
              .void
          end
          attr_writer :required_action

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
          attr_accessor :response_format

          # The Unix timestamp (in seconds) for when the run was started.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :started_at

          # The status of the run, which can be either `queued`, `in_progress`,
          #   `requires_action`, `cancelling`, `cancelled`, `failed`, `completed`,
          #   `incomplete`, or `expired`.
          sig { returns(OpenAI::Models::Beta::Threads::RunStatus::TaggedSymbol) }
          attr_accessor :status

          # The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
          #   that was executed on as a part of this run.
          sig { returns(String) }
          attr_accessor :thread_id

          # Controls which (if any) tool is called by the model. `none` means the model will
          #   not call any tools and instead generates a message. `auto` is the default value
          #   and means the model can pick between generating a message or calling one or more
          #   tools. `required` means the model must call one or more tools before responding
          #   to the user. Specifying a particular tool like `{"type": "file_search"}` or
          #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #   call that tool.
          sig do
            returns(
              T.nilable(
                T.any(
                  OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol,
                  OpenAI::Models::Beta::AssistantToolChoice
                )
              )
            )
          end
          attr_accessor :tool_choice

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
          attr_accessor :tools

          # Controls for how a thread will be truncated prior to the run. Use this to
          #   control the intial context window of the run.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::TruncationStrategy)) }
          attr_reader :truncation_strategy

          sig do
            params(
              truncation_strategy: T.nilable(T.any(OpenAI::Models::Beta::Threads::Run::TruncationStrategy, OpenAI::Internal::AnyHash))
            )
              .void
          end
          attr_writer :truncation_strategy

          # Usage statistics related to the run. This value will be `null` if the run is not
          #   in a terminal state (i.e. `in_progress`, `queued`, etc.).
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::Usage)) }
          attr_reader :usage

          sig { params(usage: T.nilable(T.any(OpenAI::Models::Beta::Threads::Run::Usage, OpenAI::Internal::AnyHash))).void }
          attr_writer :usage

          # The sampling temperature used for this run. If not set, defaults to 1.
          sig { returns(T.nilable(Float)) }
          attr_accessor :temperature

          # The nucleus sampling value used for this run. If not set, defaults to 1.
          sig { returns(T.nilable(Float)) }
          attr_accessor :top_p

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
              incomplete_details: T.nilable(T.any(OpenAI::Models::Beta::Threads::Run::IncompleteDetails, OpenAI::Internal::AnyHash)),
              instructions: String,
              last_error: T.nilable(T.any(OpenAI::Models::Beta::Threads::Run::LastError, OpenAI::Internal::AnyHash)),
              max_completion_tokens: T.nilable(Integer),
              max_prompt_tokens: T.nilable(Integer),
              metadata: T.nilable(T::Hash[Symbol, String]),
              model: String,
              parallel_tool_calls: T::Boolean,
              required_action: T.nilable(T.any(OpenAI::Models::Beta::Threads::Run::RequiredAction, OpenAI::Internal::AnyHash)),
              response_format: T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              ),
              started_at: T.nilable(Integer),
              status: OpenAI::Models::Beta::Threads::RunStatus::OrSymbol,
              thread_id: String,
              tool_choice: T.nilable(
                T.any(
                  OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                  OpenAI::Models::Beta::AssistantToolChoice,
                  OpenAI::Internal::AnyHash
                )
              ),
              tools: T::Array[
              T.any(
                OpenAI::Models::Beta::CodeInterpreterTool,
                OpenAI::Internal::AnyHash,
                OpenAI::Models::Beta::FileSearchTool,
                OpenAI::Models::Beta::FunctionTool
              )
              ],
              truncation_strategy: T.nilable(T.any(OpenAI::Models::Beta::Threads::Run::TruncationStrategy, OpenAI::Internal::AnyHash)),
              usage: T.nilable(T.any(OpenAI::Models::Beta::Threads::Run::Usage, OpenAI::Internal::AnyHash)),
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
                  metadata: T.nilable(T::Hash[Symbol, String]),
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
                  status: OpenAI::Models::Beta::Threads::RunStatus::TaggedSymbol,
                  thread_id: String,
                  tool_choice: T.nilable(
                    T.any(
                      OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol,
                      OpenAI::Models::Beta::AssistantToolChoice
                    )
                  ),
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

          class IncompleteDetails < OpenAI::Internal::Type::BaseModel
            # The reason why the run is incomplete. This will point to which specific token
            #   limit was reached over the course of the run.
            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason::TaggedSymbol)) }
            attr_reader :reason

            sig { params(reason: OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason::OrSymbol).void }
            attr_writer :reason

            # Details on why the run is incomplete. Will be `null` if the run is not
            #   incomplete.
            sig do
              params(reason: OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason::OrSymbol)
                .returns(T.attached_class)
            end
            def self.new(reason: nil)
            end

            sig { override.returns({reason: OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason::TaggedSymbol}) }
            def to_hash
            end

            # The reason why the run is incomplete. This will point to which specific token
            #   limit was reached over the course of the run.
            module Reason
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason) }
              OrSymbol =
                T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason::TaggedSymbol) }

              MAX_COMPLETION_TOKENS =
                T.let(:max_completion_tokens, OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason::TaggedSymbol)
              MAX_PROMPT_TOKENS =
                T.let(:max_prompt_tokens, OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason::TaggedSymbol]) }
              def self.values
              end
            end
          end

          class LastError < OpenAI::Internal::Type::BaseModel
            # One of `server_error`, `rate_limit_exceeded`, or `invalid_prompt`.
            sig { returns(OpenAI::Models::Beta::Threads::Run::LastError::Code::TaggedSymbol) }
            attr_accessor :code

            # A human-readable description of the error.
            sig { returns(String) }
            attr_accessor :message

            # The last error associated with this run. Will be `null` if there are no errors.
            sig do
              params(code: OpenAI::Models::Beta::Threads::Run::LastError::Code::OrSymbol, message: String)
                .returns(T.attached_class)
            end
            def self.new(code:, message:)
            end

            sig do
              override
                .returns({code: OpenAI::Models::Beta::Threads::Run::LastError::Code::TaggedSymbol, message: String})
            end
            def to_hash
            end

            # One of `server_error`, `rate_limit_exceeded`, or `invalid_prompt`.
            module Code
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Run::LastError::Code) }
              OrSymbol =
                T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::Threads::Run::LastError::Code::TaggedSymbol) }

              SERVER_ERROR = T.let(:server_error, OpenAI::Models::Beta::Threads::Run::LastError::Code::TaggedSymbol)
              RATE_LIMIT_EXCEEDED =
                T.let(:rate_limit_exceeded, OpenAI::Models::Beta::Threads::Run::LastError::Code::TaggedSymbol)
              INVALID_PROMPT =
                T.let(:invalid_prompt, OpenAI::Models::Beta::Threads::Run::LastError::Code::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Run::LastError::Code::TaggedSymbol]) }
              def self.values
              end
            end
          end

          class RequiredAction < OpenAI::Internal::Type::BaseModel
            # Details on the tool outputs needed for this run to continue.
            sig { returns(OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs) }
            attr_reader :submit_tool_outputs

            sig do
              params(
                submit_tool_outputs: T.any(OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs, OpenAI::Internal::AnyHash)
              )
                .void
            end
            attr_writer :submit_tool_outputs

            # For now, this is always `submit_tool_outputs`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Details on the action required to continue the run. Will be `null` if no action
            #   is required.
            sig do
              params(
                submit_tool_outputs: T.any(OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs, OpenAI::Internal::AnyHash),
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

            class SubmitToolOutputs < OpenAI::Internal::Type::BaseModel
              # A list of the relevant tool calls.
              sig { returns(T::Array[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall]) }
              attr_accessor :tool_calls

              # Details on the tool outputs needed for this run to continue.
              sig do
                params(
                  tool_calls: T::Array[T.any(OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall, OpenAI::Internal::AnyHash)]
                )
                  .returns(T.attached_class)
              end
              def self.new(tool_calls:)
              end

              sig { override.returns({tool_calls: T::Array[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall]}) }
              def to_hash
              end
            end
          end

          class TruncationStrategy < OpenAI::Internal::Type::BaseModel
            # The truncation strategy to use for the thread. The default is `auto`. If set to
            #   `last_messages`, the thread will be truncated to the n most recent messages in
            #   the thread. When set to `auto`, messages in the middle of the thread will be
            #   dropped to fit the context length of the model, `max_prompt_tokens`.
            sig { returns(OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type::TaggedSymbol) }
            attr_accessor :type

            # The number of most recent messages from the thread when constructing the context
            #   for the run.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :last_messages

            # Controls for how a thread will be truncated prior to the run. Use this to
            #   control the intial context window of the run.
            sig do
              params(
                type: OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type::OrSymbol,
                last_messages: T.nilable(Integer)
              )
                .returns(T.attached_class)
            end
            def self.new(type:, last_messages: nil)
            end

            sig do
              override
                .returns(
                  {
                    type: OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type::TaggedSymbol,
                    last_messages: T.nilable(Integer)
                  }
                )
            end
            def to_hash
            end

            # The truncation strategy to use for the thread. The default is `auto`. If set to
            #   `last_messages`, the thread will be truncated to the n most recent messages in
            #   the thread. When set to `auto`, messages in the middle of the thread will be
            #   dropped to fit the context length of the model, `max_prompt_tokens`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type) }
              OrSymbol =
                T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type::TaggedSymbol) }

              AUTO = T.let(:auto, OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type::TaggedSymbol)
              LAST_MESSAGES =
                T.let(:last_messages, OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type::TaggedSymbol]) }
              def self.values
              end
            end
          end

          class Usage < OpenAI::Internal::Type::BaseModel
            # Number of completion tokens used over the course of the run.
            sig { returns(Integer) }
            attr_accessor :completion_tokens

            # Number of prompt tokens used over the course of the run.
            sig { returns(Integer) }
            attr_accessor :prompt_tokens

            # Total number of tokens used (prompt + completion).
            sig { returns(Integer) }
            attr_accessor :total_tokens

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
