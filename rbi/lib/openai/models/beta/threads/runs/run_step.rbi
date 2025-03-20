# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStep < OpenAI::BaseModel
            # The identifier of the run step, which can be referenced in API endpoints.
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            # The ID of the
            #   [assistant](https://platform.openai.com/docs/api-reference/assistants)
            #   associated with the run step.
            sig { returns(String) }
            def assistant_id
            end

            sig { params(_: String).returns(String) }
            def assistant_id=(_)
            end

            # The Unix timestamp (in seconds) for when the run step was cancelled.
            sig { returns(T.nilable(Integer)) }
            def cancelled_at
            end

            sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def cancelled_at=(_)
            end

            # The Unix timestamp (in seconds) for when the run step completed.
            sig { returns(T.nilable(Integer)) }
            def completed_at
            end

            sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def completed_at=(_)
            end

            # The Unix timestamp (in seconds) for when the run step was created.
            sig { returns(Integer) }
            def created_at
            end

            sig { params(_: Integer).returns(Integer) }
            def created_at=(_)
            end

            # The Unix timestamp (in seconds) for when the run step expired. A step is
            #   considered expired if the parent run is expired.
            sig { returns(T.nilable(Integer)) }
            def expired_at
            end

            sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def expired_at=(_)
            end

            # The Unix timestamp (in seconds) for when the run step failed.
            sig { returns(T.nilable(Integer)) }
            def failed_at
            end

            sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def failed_at=(_)
            end

            # The last error associated with this run step. Will be `null` if there are no
            #   errors.
            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError)) }
            def last_error
            end

            sig do
              params(
                _: T.nilable(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError, OpenAI::Util::AnyHash))
              )
                .returns(T.nilable(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError, OpenAI::Util::AnyHash)))
            end
            def last_error=(_)
            end

            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            #   for storing additional information about the object in a structured format, and
            #   querying for objects via API or the dashboard.
            #
            #   Keys are strings with a maximum length of 64 characters. Values are strings with
            #   a maximum length of 512 characters.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            def metadata
            end

            sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
            def metadata=(_)
            end

            # The object type, which is always `thread.run.step`.
            sig { returns(Symbol) }
            def object
            end

            sig { params(_: Symbol).returns(Symbol) }
            def object=(_)
            end

            # The ID of the [run](https://platform.openai.com/docs/api-reference/runs) that
            #   this run step is a part of.
            sig { returns(String) }
            def run_id
            end

            sig { params(_: String).returns(String) }
            def run_id=(_)
            end

            # The status of the run step, which can be either `in_progress`, `cancelled`,
            #   `failed`, `completed`, or `expired`.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol) }
            def status
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)
                .returns(OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)
            end
            def status=(_)
            end

            # The details of the run step.
            sig do
              returns(
                T.any(
                  OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails,
                  OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails
                )
              )
            end
            def step_details
            end

            sig do
              params(
                _: T.any(
                  OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails,
                  OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails
                )
              )
                .returns(
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails,
                    OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails
                  )
                )
            end
            def step_details=(_)
            end

            # The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
            #   that was run.
            sig { returns(String) }
            def thread_id
            end

            sig { params(_: String).returns(String) }
            def thread_id=(_)
            end

            # The type of run step, which can be either `message_creation` or `tool_calls`.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol) }
            def type
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol)
                .returns(OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol)
            end
            def type=(_)
            end

            # Usage statistics related to the run step. This value will be `null` while the
            #   run step's status is `in_progress`.
            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage)) }
            def usage
            end

            sig do
              params(_: T.nilable(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage, OpenAI::Util::AnyHash)))
                .returns(T.nilable(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage, OpenAI::Util::AnyHash)))
            end
            def usage=(_)
            end

            # Represents a step in execution of a run.
            sig do
              params(
                id: String,
                assistant_id: String,
                cancelled_at: T.nilable(Integer),
                completed_at: T.nilable(Integer),
                created_at: Integer,
                expired_at: T.nilable(Integer),
                failed_at: T.nilable(Integer),
                last_error: T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError),
                metadata: T.nilable(T::Hash[Symbol, String]),
                run_id: String,
                status: OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol,
                step_details: T.any(
                  OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails,
                  OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails
                ),
                thread_id: String,
                type: OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol,
                usage: T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage),
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
              expired_at:,
              failed_at:,
              last_error:,
              metadata:,
              run_id:,
              status:,
              step_details:,
              thread_id:,
              type:,
              usage:,
              object: :"thread.run.step"
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
                    expired_at: T.nilable(Integer),
                    failed_at: T.nilable(Integer),
                    last_error: T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError),
                    metadata: T.nilable(T::Hash[Symbol, String]),
                    object: Symbol,
                    run_id: String,
                    status: OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol,
                    step_details: T.any(
                      OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails,
                      OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails
                    ),
                    thread_id: String,
                    type: OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol,
                    usage: T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage)
                  }
                )
            end
            def to_hash
            end

            class LastError < OpenAI::BaseModel
              # One of `server_error` or `rate_limit_exceeded`.
              sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol) }
              def code
              end

              sig do
                params(_: OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol)
                  .returns(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol)
              end
              def code=(_)
              end

              # A human-readable description of the error.
              sig { returns(String) }
              def message
              end

              sig { params(_: String).returns(String) }
              def message=(_)
              end

              # The last error associated with this run step. Will be `null` if there are no
              #   errors.
              sig do
                params(code: OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol, message: String)
                  .returns(T.attached_class)
              end
              def self.new(code:, message:)
              end

              sig do
                override
                  .returns(
                    {code: OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol, message: String}
                  )
              end
              def to_hash
              end

              # One of `server_error` or `rate_limit_exceeded`.
              module Code
                extend OpenAI::Enum

                TaggedSymbol =
                  T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code) }
                OrSymbol =
                  T.type_alias { T.any(Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol) }

                SERVER_ERROR =
                  T.let(:server_error, OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol)
                RATE_LIMIT_EXCEEDED =
                  T.let(:rate_limit_exceeded, OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol)

                class << self
                  sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol]) }
                  def values
                  end
                end
              end
            end

            # The status of the run step, which can be either `in_progress`, `cancelled`,
            #   `failed`, `completed`, or `expired`.
            module Status
              extend OpenAI::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::Status) }
              OrSymbol =
                T.type_alias { T.any(Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol) }

              IN_PROGRESS = T.let(:in_progress, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)
              CANCELLED = T.let(:cancelled, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)
              FAILED = T.let(:failed, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)
              COMPLETED = T.let(:completed, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)
              EXPIRED = T.let(:expired, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)

              class << self
                sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol]) }
                def values
                end
              end
            end

            # The details of the run step.
            module StepDetails
              extend OpenAI::Union

              Variants =
                type_template(:out) do
                  {
                    fixed: T.any(
                      OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails,
                      OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails
                    )
                  }
                end

              class << self
                sig do
                  override
                    .returns(
                      [OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails, OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails]
                    )
                end
                def variants
                end
              end
            end

            # The type of run step, which can be either `message_creation` or `tool_calls`.
            module Type
              extend OpenAI::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::Type) }
              OrSymbol =
                T.type_alias { T.any(Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol) }

              MESSAGE_CREATION =
                T.let(:message_creation, OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol)
              TOOL_CALLS = T.let(:tool_calls, OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol)

              class << self
                sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol]) }
                def values
                end
              end
            end

            class Usage < OpenAI::BaseModel
              # Number of completion tokens used over the course of the run step.
              sig { returns(Integer) }
              def completion_tokens
              end

              sig { params(_: Integer).returns(Integer) }
              def completion_tokens=(_)
              end

              # Number of prompt tokens used over the course of the run step.
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

              # Usage statistics related to the run step. This value will be `null` while the
              #   run step's status is `in_progress`.
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

        RunStep = Runs::RunStep
      end
    end
  end
end
