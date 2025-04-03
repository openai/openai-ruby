# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStep < OpenAI::Internal::Type::BaseModel
            # The identifier of the run step, which can be referenced in API endpoints.
            sig { returns(String) }
            attr_accessor :id

            # The ID of the
            #   [assistant](https://platform.openai.com/docs/api-reference/assistants)
            #   associated with the run step.
            sig { returns(String) }
            attr_accessor :assistant_id

            # The Unix timestamp (in seconds) for when the run step was cancelled.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :cancelled_at

            # The Unix timestamp (in seconds) for when the run step completed.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :completed_at

            # The Unix timestamp (in seconds) for when the run step was created.
            sig { returns(Integer) }
            attr_accessor :created_at

            # The Unix timestamp (in seconds) for when the run step expired. A step is
            #   considered expired if the parent run is expired.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :expired_at

            # The Unix timestamp (in seconds) for when the run step failed.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :failed_at

            # The last error associated with this run step. Will be `null` if there are no
            #   errors.
            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError)) }
            attr_reader :last_error

            sig do
              params(
                last_error: T.nilable(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError, OpenAI::Internal::AnyHash))
              )
                .void
            end
            attr_writer :last_error

            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            #   for storing additional information about the object in a structured format, and
            #   querying for objects via API or the dashboard.
            #
            #   Keys are strings with a maximum length of 64 characters. Values are strings with
            #   a maximum length of 512 characters.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :metadata

            # The object type, which is always `thread.run.step`.
            sig { returns(Symbol) }
            attr_accessor :object

            # The ID of the [run](https://platform.openai.com/docs/api-reference/runs) that
            #   this run step is a part of.
            sig { returns(String) }
            attr_accessor :run_id

            # The status of the run step, which can be either `in_progress`, `cancelled`,
            #   `failed`, `completed`, or `expired`.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol) }
            attr_accessor :status

            # The details of the run step.
            sig do
              returns(
                T.any(
                  OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails,
                  OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails
                )
              )
            end
            attr_accessor :step_details

            # The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
            #   that was run.
            sig { returns(String) }
            attr_accessor :thread_id

            # The type of run step, which can be either `message_creation` or `tool_calls`.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol) }
            attr_accessor :type

            # Usage statistics related to the run step. This value will be `null` while the
            #   run step's status is `in_progress`.
            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage)) }
            attr_reader :usage

            sig do
              params(
                usage: T.nilable(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage, OpenAI::Internal::AnyHash))
              )
                .void
            end
            attr_writer :usage

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
                last_error: T.nilable(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError, OpenAI::Internal::AnyHash)),
                metadata: T.nilable(T::Hash[Symbol, String]),
                run_id: String,
                status: OpenAI::Models::Beta::Threads::Runs::RunStep::Status::OrSymbol,
                step_details: T.any(
                  OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails
                ),
                thread_id: String,
                type: OpenAI::Models::Beta::Threads::Runs::RunStep::Type::OrSymbol,
                usage: T.nilable(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep::Usage, OpenAI::Internal::AnyHash)),
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

            class LastError < OpenAI::Internal::Type::BaseModel
              # One of `server_error` or `rate_limit_exceeded`.
              sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol) }
              attr_accessor :code

              # A human-readable description of the error.
              sig { returns(String) }
              attr_accessor :message

              # The last error associated with this run step. Will be `null` if there are no
              #   errors.
              sig do
                params(code: OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::OrSymbol, message: String)
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
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code) }
                OrSymbol =
                  T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol) }

                SERVER_ERROR =
                  T.let(:server_error, OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol)
                RATE_LIMIT_EXCEEDED =
                  T.let(:rate_limit_exceeded, OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol)

                sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol]) }
                def self.values
                end
              end
            end

            # The status of the run step, which can be either `in_progress`, `cancelled`,
            #   `failed`, `completed`, or `expired`.
            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::Status) }
              OrSymbol =
                T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol) }

              IN_PROGRESS = T.let(:in_progress, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)
              CANCELLED = T.let(:cancelled, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)
              FAILED = T.let(:failed, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)
              COMPLETED = T.let(:completed, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)
              EXPIRED = T.let(:expired, OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Runs::RunStep::Status::TaggedSymbol]) }
              def self.values
              end
            end

            # The details of the run step.
            module StepDetails
              extend OpenAI::Internal::Type::Union

              sig do
                override
                  .returns(
                    [OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails, OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails]
                  )
              end
              def self.variants
              end
            end

            # The type of run step, which can be either `message_creation` or `tool_calls`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::Type) }
              OrSymbol =
                T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol) }

              MESSAGE_CREATION =
                T.let(:message_creation, OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol)
              TOOL_CALLS = T.let(:tool_calls, OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Runs::RunStep::Type::TaggedSymbol]) }
              def self.values
              end
            end

            class Usage < OpenAI::Internal::Type::BaseModel
              # Number of completion tokens used over the course of the run step.
              sig { returns(Integer) }
              attr_accessor :completion_tokens

              # Number of prompt tokens used over the course of the run step.
              sig { returns(Integer) }
              attr_accessor :prompt_tokens

              # Total number of tokens used (prompt + completion).
              sig { returns(Integer) }
              attr_accessor :total_tokens

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
