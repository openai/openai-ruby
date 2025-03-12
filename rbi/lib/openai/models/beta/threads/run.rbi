# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class Run < OpenAI::BaseModel
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          sig { returns(String) }
          def assistant_id
          end

          sig { params(_: String).returns(String) }
          def assistant_id=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def cancelled_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def cancelled_at=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def completed_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def completed_at=(_)
          end

          sig { returns(Integer) }
          def created_at
          end

          sig { params(_: Integer).returns(Integer) }
          def created_at=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def expires_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def expires_at=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def failed_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def failed_at=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::IncompleteDetails)) }
          def incomplete_details
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Run::IncompleteDetails))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Run::IncompleteDetails))
          end
          def incomplete_details=(_)
          end

          sig { returns(String) }
          def instructions
          end

          sig { params(_: String).returns(String) }
          def instructions=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::LastError)) }
          def last_error
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Run::LastError))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Run::LastError))
          end
          def last_error=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def max_completion_tokens
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def max_completion_tokens=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def max_prompt_tokens
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def max_prompt_tokens=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata
          end

          sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata=(_)
          end

          sig { returns(String) }
          def model
          end

          sig { params(_: String).returns(String) }
          def model=(_)
          end

          sig { returns(Symbol) }
          def object
          end

          sig { params(_: Symbol).returns(Symbol) }
          def object=(_)
          end

          sig { returns(T::Boolean) }
          def parallel_tool_calls
          end

          sig { params(_: T::Boolean).returns(T::Boolean) }
          def parallel_tool_calls=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::RequiredAction)) }
          def required_action
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Run::RequiredAction))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Run::RequiredAction))
          end
          def required_action=(_)
          end

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

          sig { returns(T.nilable(Integer)) }
          def started_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def started_at=(_)
          end

          sig { returns(Symbol) }
          def status
          end

          sig { params(_: Symbol).returns(Symbol) }
          def status=(_)
          end

          sig { returns(String) }
          def thread_id
          end

          sig { params(_: String).returns(String) }
          def thread_id=(_)
          end

          sig { returns(T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice))) }
          def tool_choice
          end

          sig do
            params(_: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)))
              .returns(T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)))
          end
          def tool_choice=(_)
          end

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

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::TruncationStrategy)) }
          def truncation_strategy
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Run::TruncationStrategy))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Run::TruncationStrategy))
          end
          def truncation_strategy=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Run::Usage)) }
          def usage
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Run::Usage))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Run::Usage))
          end
          def usage=(_)
          end

          sig { returns(T.nilable(Float)) }
          def temperature
          end

          sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
          def temperature=(_)
          end

          sig { returns(T.nilable(Float)) }
          def top_p
          end

          sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
          def top_p=(_)
          end

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
            sig { returns(T.nilable(Symbol)) }
            def reason
            end

            sig { params(_: Symbol).returns(Symbol) }
            def reason=(_)
            end

            sig { params(reason: Symbol).returns(T.attached_class) }
            def self.new(reason: nil)
            end

            sig { override.returns({reason: Symbol}) }
            def to_hash
            end

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
            sig { returns(Symbol) }
            def code
            end

            sig { params(_: Symbol).returns(Symbol) }
            def code=(_)
            end

            sig { returns(String) }
            def message
            end

            sig { params(_: String).returns(String) }
            def message=(_)
            end

            sig { params(code: Symbol, message: String).returns(T.attached_class) }
            def self.new(code:, message:)
            end

            sig { override.returns({code: Symbol, message: String}) }
            def to_hash
            end

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
            sig { returns(OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs) }
            def submit_tool_outputs
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs)
                .returns(OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs)
            end
            def submit_tool_outputs=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

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
              sig { returns(T::Array[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall]) }
              def tool_calls
              end

              sig do
                params(_: T::Array[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall])
                  .returns(T::Array[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall])
              end
              def tool_calls=(_)
              end

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
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { returns(T.nilable(Integer)) }
            def last_messages
            end

            sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def last_messages=(_)
            end

            sig { params(type: Symbol, last_messages: T.nilable(Integer)).returns(T.attached_class) }
            def self.new(type:, last_messages: nil)
            end

            sig { override.returns({type: Symbol, last_messages: T.nilable(Integer)}) }
            def to_hash
            end

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
            sig { returns(Integer) }
            def completion_tokens
            end

            sig { params(_: Integer).returns(Integer) }
            def completion_tokens=(_)
            end

            sig { returns(Integer) }
            def prompt_tokens
            end

            sig { params(_: Integer).returns(Integer) }
            def prompt_tokens=(_)
            end

            sig { returns(Integer) }
            def total_tokens
            end

            sig { params(_: Integer).returns(Integer) }
            def total_tokens=(_)
            end

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
