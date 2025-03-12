# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        RunStep = T.type_alias { Runs::RunStep }

        module Runs
          class RunStep < OpenAI::BaseModel
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
            def expired_at
            end

            sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def expired_at=(_)
            end

            sig { returns(T.nilable(Integer)) }
            def failed_at
            end

            sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def failed_at=(_)
            end

            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError)) }
            def last_error
            end

            sig do
              params(_: T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError))
                .returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError))
            end
            def last_error=(_)
            end

            sig { returns(T.nilable(OpenAI::Models::Metadata)) }
            def metadata
            end

            sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
            def metadata=(_)
            end

            sig { returns(Symbol) }
            def object
            end

            sig { params(_: Symbol).returns(Symbol) }
            def object=(_)
            end

            sig { returns(String) }
            def run_id
            end

            sig { params(_: String).returns(String) }
            def run_id=(_)
            end

            sig { returns(Symbol) }
            def status
            end

            sig { params(_: Symbol).returns(Symbol) }
            def status=(_)
            end

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

            sig { returns(String) }
            def thread_id
            end

            sig { params(_: String).returns(String) }
            def thread_id=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage)) }
            def usage
            end

            sig do
              params(_: T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage))
                .returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage))
            end
            def usage=(_)
            end

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
                metadata: T.nilable(OpenAI::Models::Metadata),
                run_id: String,
                status: Symbol,
                step_details: T.any(
                  OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails,
                  OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails
                ),
                thread_id: String,
                type: Symbol,
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
                    metadata: T.nilable(OpenAI::Models::Metadata),
                    object: Symbol,
                    run_id: String,
                    status: Symbol,
                    step_details: T.any(
                      OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails,
                      OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails
                    ),
                    thread_id: String,
                    type: Symbol,
                    usage: T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage)
                  }
                )
            end
            def to_hash
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

                class << self
                  sig { override.returns(T::Array[Symbol]) }
                  def values
                  end
                end
              end
            end

            class Status < OpenAI::Enum
              abstract!

              IN_PROGRESS = :in_progress
              CANCELLED = :cancelled
              FAILED = :failed
              COMPLETED = :completed
              EXPIRED = :expired

              class << self
                sig { override.returns(T::Array[Symbol]) }
                def values
                end
              end
            end

            class StepDetails < OpenAI::Union
              abstract!

              class << self
                sig do
                  override
                    .returns(
                      [[Symbol, OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails], [Symbol, OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails]]
                    )
                end
                private def variants
                end
              end
            end

            class Type < OpenAI::Enum
              abstract!

              MESSAGE_CREATION = :message_creation
              TOOL_CALLS = :tool_calls

              class << self
                sig { override.returns(T::Array[Symbol]) }
                def values
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
end
