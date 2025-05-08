# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        RunStep = Runs::RunStep

        module Runs
          class RunStep < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # The identifier of the run step, which can be referenced in API endpoints.
            sig { returns(String) }
            attr_accessor :id

            # The ID of the
            # [assistant](https://platform.openai.com/docs/api-reference/assistants)
            # associated with the run step.
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
            # considered expired if the parent run is expired.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :expired_at

            # The Unix timestamp (in seconds) for when the run step failed.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :failed_at

            # The last error associated with this run step. Will be `null` if there are no
            # errors.
            sig do
              returns(
                T.nilable(OpenAI::Beta::Threads::Runs::RunStep::LastError)
              )
            end
            attr_reader :last_error

            sig do
              params(
                last_error:
                  T.nilable(
                    OpenAI::Beta::Threads::Runs::RunStep::LastError::OrHash
                  )
              ).void
            end
            attr_writer :last_error

            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            # for storing additional information about the object in a structured format, and
            # querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :metadata

            # The object type, which is always `thread.run.step`.
            sig { returns(Symbol) }
            attr_accessor :object

            # The ID of the [run](https://platform.openai.com/docs/api-reference/runs) that
            # this run step is a part of.
            sig { returns(String) }
            attr_accessor :run_id

            # The status of the run step, which can be either `in_progress`, `cancelled`,
            # `failed`, `completed`, or `expired`.
            sig do
              returns(
                OpenAI::Beta::Threads::Runs::RunStep::Status::TaggedSymbol
              )
            end
            attr_accessor :status

            # The details of the run step.
            sig do
              returns(
                T.any(
                  OpenAI::Beta::Threads::Runs::MessageCreationStepDetails,
                  OpenAI::Beta::Threads::Runs::ToolCallsStepDetails
                )
              )
            end
            attr_accessor :step_details

            # The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
            # that was run.
            sig { returns(String) }
            attr_accessor :thread_id

            # The type of run step, which can be either `message_creation` or `tool_calls`.
            sig do
              returns(OpenAI::Beta::Threads::Runs::RunStep::Type::TaggedSymbol)
            end
            attr_accessor :type

            # Usage statistics related to the run step. This value will be `null` while the
            # run step's status is `in_progress`.
            sig do
              returns(T.nilable(OpenAI::Beta::Threads::Runs::RunStep::Usage))
            end
            attr_reader :usage

            sig do
              params(
                usage:
                  T.nilable(OpenAI::Beta::Threads::Runs::RunStep::Usage::OrHash)
              ).void
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
                last_error:
                  T.nilable(
                    OpenAI::Beta::Threads::Runs::RunStep::LastError::OrHash
                  ),
                metadata: T.nilable(T::Hash[Symbol, String]),
                run_id: String,
                status: OpenAI::Beta::Threads::Runs::RunStep::Status::OrSymbol,
                step_details:
                  T.any(
                    OpenAI::Beta::Threads::Runs::MessageCreationStepDetails::OrHash,
                    OpenAI::Beta::Threads::Runs::ToolCallsStepDetails::OrHash
                  ),
                thread_id: String,
                type: OpenAI::Beta::Threads::Runs::RunStep::Type::OrSymbol,
                usage:
                  T.nilable(
                    OpenAI::Beta::Threads::Runs::RunStep::Usage::OrHash
                  ),
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier of the run step, which can be referenced in API endpoints.
              id:,
              # The ID of the
              # [assistant](https://platform.openai.com/docs/api-reference/assistants)
              # associated with the run step.
              assistant_id:,
              # The Unix timestamp (in seconds) for when the run step was cancelled.
              cancelled_at:,
              # The Unix timestamp (in seconds) for when the run step completed.
              completed_at:,
              # The Unix timestamp (in seconds) for when the run step was created.
              created_at:,
              # The Unix timestamp (in seconds) for when the run step expired. A step is
              # considered expired if the parent run is expired.
              expired_at:,
              # The Unix timestamp (in seconds) for when the run step failed.
              failed_at:,
              # The last error associated with this run step. Will be `null` if there are no
              # errors.
              last_error:,
              # Set of 16 key-value pairs that can be attached to an object. This can be useful
              # for storing additional information about the object in a structured format, and
              # querying for objects via API or the dashboard.
              #
              # Keys are strings with a maximum length of 64 characters. Values are strings with
              # a maximum length of 512 characters.
              metadata:,
              # The ID of the [run](https://platform.openai.com/docs/api-reference/runs) that
              # this run step is a part of.
              run_id:,
              # The status of the run step, which can be either `in_progress`, `cancelled`,
              # `failed`, `completed`, or `expired`.
              status:,
              # The details of the run step.
              step_details:,
              # The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
              # that was run.
              thread_id:,
              # The type of run step, which can be either `message_creation` or `tool_calls`.
              type:,
              # Usage statistics related to the run step. This value will be `null` while the
              # run step's status is `in_progress`.
              usage:,
              # The object type, which is always `thread.run.step`.
              object: :"thread.run.step"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  assistant_id: String,
                  cancelled_at: T.nilable(Integer),
                  completed_at: T.nilable(Integer),
                  created_at: Integer,
                  expired_at: T.nilable(Integer),
                  failed_at: T.nilable(Integer),
                  last_error:
                    T.nilable(OpenAI::Beta::Threads::Runs::RunStep::LastError),
                  metadata: T.nilable(T::Hash[Symbol, String]),
                  object: Symbol,
                  run_id: String,
                  status:
                    OpenAI::Beta::Threads::Runs::RunStep::Status::TaggedSymbol,
                  step_details:
                    T.any(
                      OpenAI::Beta::Threads::Runs::MessageCreationStepDetails,
                      OpenAI::Beta::Threads::Runs::ToolCallsStepDetails
                    ),
                  thread_id: String,
                  type:
                    OpenAI::Beta::Threads::Runs::RunStep::Type::TaggedSymbol,
                  usage: T.nilable(OpenAI::Beta::Threads::Runs::RunStep::Usage)
                }
              )
            end
            def to_hash
            end

            class LastError < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

              # One of `server_error` or `rate_limit_exceeded`.
              sig do
                returns(
                  OpenAI::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol
                )
              end
              attr_accessor :code

              # A human-readable description of the error.
              sig { returns(String) }
              attr_accessor :message

              # The last error associated with this run step. Will be `null` if there are no
              # errors.
              sig do
                params(
                  code:
                    OpenAI::Beta::Threads::Runs::RunStep::LastError::Code::OrSymbol,
                  message: String
                ).returns(T.attached_class)
              end
              def self.new(
                # One of `server_error` or `rate_limit_exceeded`.
                code:,
                # A human-readable description of the error.
                message:
              )
              end

              sig do
                override.returns(
                  {
                    code:
                      OpenAI::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol,
                    message: String
                  }
                )
              end
              def to_hash
              end

              # One of `server_error` or `rate_limit_exceeded`.
              module Code
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Beta::Threads::Runs::RunStep::LastError::Code
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                SERVER_ERROR =
                  T.let(
                    :server_error,
                    OpenAI::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol
                  )
                RATE_LIMIT_EXCEEDED =
                  T.let(
                    :rate_limit_exceeded,
                    OpenAI::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::Threads::Runs::RunStep::LastError::Code::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end
            end

            # The status of the run step, which can be either `in_progress`, `cancelled`,
            # `failed`, `completed`, or `expired`.
            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(Symbol, OpenAI::Beta::Threads::Runs::RunStep::Status)
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              IN_PROGRESS =
                T.let(
                  :in_progress,
                  OpenAI::Beta::Threads::Runs::RunStep::Status::TaggedSymbol
                )
              CANCELLED =
                T.let(
                  :cancelled,
                  OpenAI::Beta::Threads::Runs::RunStep::Status::TaggedSymbol
                )
              FAILED =
                T.let(
                  :failed,
                  OpenAI::Beta::Threads::Runs::RunStep::Status::TaggedSymbol
                )
              COMPLETED =
                T.let(
                  :completed,
                  OpenAI::Beta::Threads::Runs::RunStep::Status::TaggedSymbol
                )
              EXPIRED =
                T.let(
                  :expired,
                  OpenAI::Beta::Threads::Runs::RunStep::Status::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Threads::Runs::RunStep::Status::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            # The details of the run step.
            module StepDetails
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::Threads::Runs::MessageCreationStepDetails,
                    OpenAI::Beta::Threads::Runs::ToolCallsStepDetails
                  )
                end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Threads::Runs::RunStep::StepDetails::Variants
                  ]
                )
              end
              def self.variants
              end
            end

            # The type of run step, which can be either `message_creation` or `tool_calls`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(Symbol, OpenAI::Beta::Threads::Runs::RunStep::Type)
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MESSAGE_CREATION =
                T.let(
                  :message_creation,
                  OpenAI::Beta::Threads::Runs::RunStep::Type::TaggedSymbol
                )
              TOOL_CALLS =
                T.let(
                  :tool_calls,
                  OpenAI::Beta::Threads::Runs::RunStep::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Threads::Runs::RunStep::Type::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            class Usage < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
              # run step's status is `in_progress`.
              sig do
                params(
                  completion_tokens: Integer,
                  prompt_tokens: Integer,
                  total_tokens: Integer
                ).returns(T.attached_class)
              end
              def self.new(
                # Number of completion tokens used over the course of the run step.
                completion_tokens:,
                # Number of prompt tokens used over the course of the run step.
                prompt_tokens:,
                # Total number of tokens used (prompt + completion).
                total_tokens:
              )
              end

              sig do
                override.returns(
                  {
                    completion_tokens: Integer,
                    prompt_tokens: Integer,
                    total_tokens: Integer
                  }
                )
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
