# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # @see OpenAI::Resources::Beta::Threads::Runs::Steps#retrieve
          class RunStep < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier of the run step, which can be referenced in API endpoints.
            #
            #   @return [String]
            required :id, String

            # @!attribute assistant_id
            #   The ID of the
            #   [assistant](https://platform.openai.com/docs/api-reference/assistants)
            #   associated with the run step.
            #
            #   @return [String]
            required :assistant_id, String

            # @!attribute cancelled_at
            #   The Unix timestamp (in seconds) for when the run step was cancelled.
            #
            #   @return [Integer, nil]
            required :cancelled_at, Integer, nil?: true

            # @!attribute completed_at
            #   The Unix timestamp (in seconds) for when the run step completed.
            #
            #   @return [Integer, nil]
            required :completed_at, Integer, nil?: true

            # @!attribute created_at
            #   The Unix timestamp (in seconds) for when the run step was created.
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute expired_at
            #   The Unix timestamp (in seconds) for when the run step expired. A step is
            #   considered expired if the parent run is expired.
            #
            #   @return [Integer, nil]
            required :expired_at, Integer, nil?: true

            # @!attribute failed_at
            #   The Unix timestamp (in seconds) for when the run step failed.
            #
            #   @return [Integer, nil]
            required :failed_at, Integer, nil?: true

            # @!attribute last_error
            #   The last error associated with this run step. Will be `null` if there are no
            #   errors.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep::LastError, nil]
            required :last_error, -> { OpenAI::Beta::Threads::Runs::RunStep::LastError }, nil?: true

            # @!attribute metadata
            #   Set of 16 key-value pairs that can be attached to an object. This can be useful
            #   for storing additional information about the object in a structured format, and
            #   querying for objects via API or the dashboard.
            #
            #   Keys are strings with a maximum length of 64 characters. Values are strings with
            #   a maximum length of 512 characters.
            #
            #   @return [Hash{Symbol=>String}, nil]
            required :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

            # @!attribute object
            #   The object type, which is always `thread.run.step`.
            #
            #   @return [Symbol, :"thread.run.step"]
            required :object, const: :"thread.run.step"

            # @!attribute run_id
            #   The ID of the [run](https://platform.openai.com/docs/api-reference/runs) that
            #   this run step is a part of.
            #
            #   @return [String]
            required :run_id, String

            # @!attribute status
            #   The status of the run step, which can be either `in_progress`, `cancelled`,
            #   `failed`, `completed`, or `expired`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::Status]
            required :status, enum: -> { OpenAI::Beta::Threads::Runs::RunStep::Status }

            # @!attribute step_details
            #   The details of the run step.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails, OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails]
            required :step_details, union: -> { OpenAI::Beta::Threads::Runs::RunStep::StepDetails }

            # @!attribute thread_id
            #   The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
            #   that was run.
            #
            #   @return [String]
            required :thread_id, String

            # @!attribute type
            #   The type of run step, which can be either `message_creation` or `tool_calls`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::Type]
            required :type, enum: -> { OpenAI::Beta::Threads::Runs::RunStep::Type }

            # @!attribute usage
            #   Usage statistics related to the run step. This value will be `null` while the
            #   run step's status is `in_progress`.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep::Usage, nil]
            required :usage, -> { OpenAI::Beta::Threads::Runs::RunStep::Usage }, nil?: true

            # @!method initialize(id:, assistant_id:, cancelled_at:, completed_at:, created_at:, expired_at:, failed_at:, last_error:, metadata:, run_id:, status:, step_details:, thread_id:, type:, usage:, object: :"thread.run.step")
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::Threads::Runs::RunStep} for more details.
            #
            #   Represents a step in execution of a run.
            #
            #   @param id [String] The identifier of the run step, which can be referenced in API endpoints.
            #
            #   @param assistant_id [String] The ID of the [assistant](https://platform.openai.com/docs/api-reference/assista
            #
            #   @param cancelled_at [Integer, nil] The Unix timestamp (in seconds) for when the run step was cancelled.
            #
            #   @param completed_at [Integer, nil] The Unix timestamp (in seconds) for when the run step completed.
            #
            #   @param created_at [Integer] The Unix timestamp (in seconds) for when the run step was created.
            #
            #   @param expired_at [Integer, nil] The Unix timestamp (in seconds) for when the run step expired. A step is conside
            #
            #   @param failed_at [Integer, nil] The Unix timestamp (in seconds) for when the run step failed.
            #
            #   @param last_error [OpenAI::Models::Beta::Threads::Runs::RunStep::LastError, nil] The last error associated with this run step. Will be `null` if there are no err
            #
            #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
            #
            #   @param run_id [String] The ID of the [run](https://platform.openai.com/docs/api-reference/runs) that th
            #
            #   @param status [Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::Status] The status of the run step, which can be either `in_progress`, `cancelled`, `fai
            #
            #   @param step_details [OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails, OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails] The details of the run step.
            #
            #   @param thread_id [String] The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) t
            #
            #   @param type [Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::Type] The type of run step, which can be either `message_creation` or `tool_calls`.
            #
            #   @param usage [OpenAI::Models::Beta::Threads::Runs::RunStep::Usage, nil] Usage statistics related to the run step. This value will be `null` while the ru
            #
            #   @param object [Symbol, :"thread.run.step"] The object type, which is always `thread.run.step`.

            # @see OpenAI::Models::Beta::Threads::Runs::RunStep#last_error
            class LastError < OpenAI::Internal::Type::BaseModel
              # @!attribute code
              #   One of `server_error` or `rate_limit_exceeded`.
              #
              #   @return [Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code]
              required :code, enum: -> { OpenAI::Beta::Threads::Runs::RunStep::LastError::Code }

              # @!attribute message
              #   A human-readable description of the error.
              #
              #   @return [String]
              required :message, String

              # @!method initialize(code:, message:)
              #   The last error associated with this run step. Will be `null` if there are no
              #   errors.
              #
              #   @param code [Symbol, OpenAI::Models::Beta::Threads::Runs::RunStep::LastError::Code] One of `server_error` or `rate_limit_exceeded`.
              #
              #   @param message [String] A human-readable description of the error.

              # One of `server_error` or `rate_limit_exceeded`.
              #
              # @see OpenAI::Models::Beta::Threads::Runs::RunStep::LastError#code
              module Code
                extend OpenAI::Internal::Type::Enum

                SERVER_ERROR = :server_error
                RATE_LIMIT_EXCEEDED = :rate_limit_exceeded

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            # The status of the run step, which can be either `in_progress`, `cancelled`,
            # `failed`, `completed`, or `expired`.
            #
            # @see OpenAI::Models::Beta::Threads::Runs::RunStep#status
            module Status
              extend OpenAI::Internal::Type::Enum

              IN_PROGRESS = :in_progress
              CANCELLED = :cancelled
              FAILED = :failed
              COMPLETED = :completed
              EXPIRED = :expired

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # The details of the run step.
            #
            # @see OpenAI::Models::Beta::Threads::Runs::RunStep#step_details
            module StepDetails
              extend OpenAI::Internal::Type::Union

              discriminator :type

              # Details of the message creation by the run step.
              variant :message_creation, -> { OpenAI::Beta::Threads::Runs::MessageCreationStepDetails }

              # Details of the tool call.
              variant :tool_calls, -> { OpenAI::Beta::Threads::Runs::ToolCallsStepDetails }

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails, OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails)]
            end

            # The type of run step, which can be either `message_creation` or `tool_calls`.
            #
            # @see OpenAI::Models::Beta::Threads::Runs::RunStep#type
            module Type
              extend OpenAI::Internal::Type::Enum

              MESSAGE_CREATION = :message_creation
              TOOL_CALLS = :tool_calls

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # @see OpenAI::Models::Beta::Threads::Runs::RunStep#usage
            class Usage < OpenAI::Internal::Type::BaseModel
              # @!attribute completion_tokens
              #   Number of completion tokens used over the course of the run step.
              #
              #   @return [Integer]
              required :completion_tokens, Integer

              # @!attribute prompt_tokens
              #   Number of prompt tokens used over the course of the run step.
              #
              #   @return [Integer]
              required :prompt_tokens, Integer

              # @!attribute total_tokens
              #   Total number of tokens used (prompt + completion).
              #
              #   @return [Integer]
              required :total_tokens, Integer

              # @!method initialize(completion_tokens:, prompt_tokens:, total_tokens:)
              #   Usage statistics related to the run step. This value will be `null` while the
              #   run step's status is `in_progress`.
              #
              #   @param completion_tokens [Integer] Number of completion tokens used over the course of the run step.
              #
              #   @param prompt_tokens [Integer] Number of prompt tokens used over the course of the run step.
              #
              #   @param total_tokens [Integer] Total number of tokens used (prompt + completion).
            end
          end
        end

        RunStep = Runs::RunStep
      end
    end
  end
end
