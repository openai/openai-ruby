# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        # @see OpenAI::Resources::Beta::Threads::Runs#create
        #
        # @see OpenAI::Resources::Beta::Threads::Runs#create_stream_raw
        class Run < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints.
          #
          #   @return [String]
          required :id, String

          # @!attribute assistant_id
          #   The ID of the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   execution of this run.
          #
          #   @return [String]
          required :assistant_id, String

          # @!attribute cancelled_at
          #   The Unix timestamp (in seconds) for when the run was cancelled.
          #
          #   @return [Integer, nil]
          required :cancelled_at, Integer, nil?: true

          # @!attribute completed_at
          #   The Unix timestamp (in seconds) for when the run was completed.
          #
          #   @return [Integer, nil]
          required :completed_at, Integer, nil?: true

          # @!attribute created_at
          #   The Unix timestamp (in seconds) for when the run was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute expires_at
          #   The Unix timestamp (in seconds) for when the run will expire.
          #
          #   @return [Integer, nil]
          required :expires_at, Integer, nil?: true

          # @!attribute failed_at
          #   The Unix timestamp (in seconds) for when the run failed.
          #
          #   @return [Integer, nil]
          required :failed_at, Integer, nil?: true

          # @!attribute incomplete_details
          #   Details on why the run is incomplete. Will be `null` if the run is not
          #   incomplete.
          #
          #   @return [OpenAI::Beta::Threads::Run::IncompleteDetails, nil]
          required :incomplete_details, -> { OpenAI::Beta::Threads::Run::IncompleteDetails }, nil?: true

          # @!attribute instructions
          #   The instructions that the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   this run.
          #
          #   @return [String]
          required :instructions, String

          # @!attribute last_error
          #   The last error associated with this run. Will be `null` if there are no errors.
          #
          #   @return [OpenAI::Beta::Threads::Run::LastError, nil]
          required :last_error, -> { OpenAI::Beta::Threads::Run::LastError }, nil?: true

          # @!attribute max_completion_tokens
          #   The maximum number of completion tokens specified to have been used over the
          #   course of the run.
          #
          #   @return [Integer, nil]
          required :max_completion_tokens, Integer, nil?: true

          # @!attribute max_prompt_tokens
          #   The maximum number of prompt tokens specified to have been used over the course
          #   of the run.
          #
          #   @return [Integer, nil]
          required :max_prompt_tokens, Integer, nil?: true

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

          # @!attribute model
          #   The model that the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   this run.
          #
          #   @return [String]
          required :model, String

          # @!attribute object
          #   The object type, which is always `thread.run`.
          #
          #   @return [Symbol, :"thread.run"]
          required :object, const: :"thread.run"

          # @!attribute parallel_tool_calls
          #   Whether to enable
          #   [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          #   during tool use.
          #
          #   @return [Boolean]
          required :parallel_tool_calls, OpenAI::Internal::Type::Boolean

          # @!attribute required_action
          #   Details on the action required to continue the run. Will be `null` if no action
          #   is required.
          #
          #   @return [OpenAI::Beta::Threads::Run::RequiredAction, nil]
          required :required_action, -> { OpenAI::Beta::Threads::Run::RequiredAction }, nil?: true

          # @!attribute response_format
          #   Specifies the format that the model must output. Compatible with
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
          #
          #   @return [Symbol, :auto, OpenAI::ResponseFormatText, OpenAI::ResponseFormatJSONObject, OpenAI::ResponseFormatJSONSchema, nil]
          required :response_format, union: -> { OpenAI::Beta::AssistantResponseFormatOption }, nil?: true

          # @!attribute started_at
          #   The Unix timestamp (in seconds) for when the run was started.
          #
          #   @return [Integer, nil]
          required :started_at, Integer, nil?: true

          # @!attribute status
          #   The status of the run, which can be either `queued`, `in_progress`,
          #   `requires_action`, `cancelling`, `cancelled`, `failed`, `completed`,
          #   `incomplete`, or `expired`.
          #
          #   @return [Symbol, OpenAI::Beta::Threads::RunStatus]
          required :status, enum: -> { OpenAI::Beta::Threads::RunStatus }

          # @!attribute thread_id
          #   The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
          #   that was executed on as a part of this run.
          #
          #   @return [String]
          required :thread_id, String

          # @!attribute tool_choice
          #   Controls which (if any) tool is called by the model. `none` means the model will
          #   not call any tools and instead generates a message. `auto` is the default value
          #   and means the model can pick between generating a message or calling one or more
          #   tools. `required` means the model must call one or more tools before responding
          #   to the user. Specifying a particular tool like `{"type": "file_search"}` or
          #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #   call that tool.
          #
          #   @return [Symbol, OpenAI::Beta::AssistantToolChoiceOption::Auto, OpenAI::Beta::AssistantToolChoice, nil]
          required :tool_choice, union: -> { OpenAI::Beta::AssistantToolChoiceOption }, nil?: true

          # @!attribute tools
          #   The list of tools that the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #   this run.
          #
          #   @return [Array<OpenAI::Beta::CodeInterpreterTool, OpenAI::Beta::FileSearchTool, OpenAI::Beta::FunctionTool>]
          required :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AssistantTool] }

          # @!attribute truncation_strategy
          #   Controls for how a thread will be truncated prior to the run. Use this to
          #   control the intial context window of the run.
          #
          #   @return [OpenAI::Beta::TruncationObject, nil]
          required :truncation_strategy, -> { OpenAI::Beta::TruncationObject }, nil?: true

          # @!attribute usage
          #   Usage statistics related to the run. This value will be `null` if the run is not
          #   in a terminal state (i.e. `in_progress`, `queued`, etc.).
          #
          #   @return [OpenAI::Beta::Threads::Run::Usage, nil]
          required :usage, -> { OpenAI::Beta::Threads::Run::Usage }, nil?: true

          # @!attribute temperature
          #   The sampling temperature used for this run. If not set, defaults to 1.
          #
          #   @return [Float, nil]
          optional :temperature, Float, nil?: true

          # @!attribute top_p
          #   The nucleus sampling value used for this run. If not set, defaults to 1.
          #
          #   @return [Float, nil]
          optional :top_p, Float, nil?: true

          # @!method initialize(id:, assistant_id:, cancelled_at:, completed_at:, created_at:, expires_at:, failed_at:, incomplete_details:, instructions:, last_error:, max_completion_tokens:, max_prompt_tokens:, metadata:, model:, parallel_tool_calls:, required_action:, response_format:, started_at:, status:, thread_id:, tool_choice:, tools:, truncation_strategy:, usage:, temperature: nil, top_p: nil, object: :"thread.run")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::Threads::Run} for more details.
          #
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints.
          #
          #   @param assistant_id [String] The ID of the [assistant](https://platform.openai.com/docs/api-reference/assista
          #
          #   @param cancelled_at [Integer, nil] The Unix timestamp (in seconds) for when the run was cancelled.
          #
          #   @param completed_at [Integer, nil] The Unix timestamp (in seconds) for when the run was completed.
          #
          #   @param created_at [Integer] The Unix timestamp (in seconds) for when the run was created.
          #
          #   @param expires_at [Integer, nil] The Unix timestamp (in seconds) for when the run will expire.
          #
          #   @param failed_at [Integer, nil] The Unix timestamp (in seconds) for when the run failed.
          #
          #   @param incomplete_details [OpenAI::Beta::Threads::Run::IncompleteDetails, nil] Details on why the run is incomplete. Will be `null` if the run is not incomplet
          #
          #   @param instructions [String] The instructions that the [assistant](https://platform.openai.com/docs/api-refer
          #
          #   @param last_error [OpenAI::Beta::Threads::Run::LastError, nil] The last error associated with this run. Will be `null` if there are no errors.
          #
          #   @param max_completion_tokens [Integer, nil] The maximum number of completion tokens specified to have been used over the cou
          #
          #   @param max_prompt_tokens [Integer, nil] The maximum number of prompt tokens specified to have been used over the course
          #
          #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
          #
          #   @param model [String] The model that the [assistant](https://platform.openai.com/docs/api-reference/as
          #
          #   @param parallel_tool_calls [Boolean] Whether to enable [parallel function calling](https://platform.openai.com/docs/g
          #
          #   @param required_action [OpenAI::Beta::Threads::Run::RequiredAction, nil] Details on the action required to continue the run. Will be `null` if no action
          #
          #   @param response_format [Symbol, :auto, OpenAI::ResponseFormatText, OpenAI::ResponseFormatJSONObject, OpenAI::ResponseFormatJSONSchema, nil] Specifies the format that the model must output. Compatible with [GPT-4o](https:
          #
          #   @param started_at [Integer, nil] The Unix timestamp (in seconds) for when the run was started.
          #
          #   @param status [Symbol, OpenAI::Beta::Threads::RunStatus] The status of the run, which can be either `queued`, `in_progress`, `requires_ac
          #
          #   @param thread_id [String] The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) t
          #
          #   @param tool_choice [Symbol, OpenAI::Beta::AssistantToolChoiceOption::Auto, OpenAI::Beta::AssistantToolChoice, nil] Controls which (if any) tool is called by the model.
          #
          #   @param tools [Array<OpenAI::Beta::CodeInterpreterTool, OpenAI::Beta::FileSearchTool, OpenAI::Beta::FunctionTool>] The list of tools that the [assistant](https://platform.openai.com/docs/api-refe
          #
          #   @param truncation_strategy [OpenAI::Beta::TruncationObject, nil] Controls for how a thread will be truncated prior to the run. Use this to contro
          #
          #   @param usage [OpenAI::Beta::Threads::Run::Usage, nil] Usage statistics related to the run. This value will be `null` if the run is not
          #
          #   @param temperature [Float, nil] The sampling temperature used for this run. If not set, defaults to 1.
          #
          #   @param top_p [Float, nil] The nucleus sampling value used for this run. If not set, defaults to 1.
          #
          #   @param object [Symbol, :"thread.run"] The object type, which is always `thread.run`.

          # @see OpenAI::Beta::Threads::Run#incomplete_details
          class IncompleteDetails < OpenAI::Internal::Type::BaseModel
            # @!attribute reason
            #   The reason why the run is incomplete. This will point to which specific token
            #   limit was reached over the course of the run.
            #
            #   @return [Symbol, OpenAI::Beta::Threads::Run::IncompleteDetails::Reason, nil]
            optional :reason, enum: -> { OpenAI::Beta::Threads::Run::IncompleteDetails::Reason }

            # @!method initialize(reason: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Beta::Threads::Run::IncompleteDetails} for more details.
            #
            #   Details on why the run is incomplete. Will be `null` if the run is not
            #   incomplete.
            #
            #   @param reason [Symbol, OpenAI::Beta::Threads::Run::IncompleteDetails::Reason] The reason why the run is incomplete. This will point to which specific token li

            # The reason why the run is incomplete. This will point to which specific token
            # limit was reached over the course of the run.
            #
            # @see OpenAI::Beta::Threads::Run::IncompleteDetails#reason
            module Reason
              extend OpenAI::Internal::Type::Enum

              MAX_COMPLETION_TOKENS = :max_completion_tokens
              MAX_PROMPT_TOKENS = :max_prompt_tokens

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @see OpenAI::Beta::Threads::Run#last_error
          class LastError < OpenAI::Internal::Type::BaseModel
            # @!attribute code
            #   One of `server_error`, `rate_limit_exceeded`, or `invalid_prompt`.
            #
            #   @return [Symbol, OpenAI::Beta::Threads::Run::LastError::Code]
            required :code, enum: -> { OpenAI::Beta::Threads::Run::LastError::Code }

            # @!attribute message
            #   A human-readable description of the error.
            #
            #   @return [String]
            required :message, String

            # @!method initialize(code:, message:)
            #   The last error associated with this run. Will be `null` if there are no errors.
            #
            #   @param code [Symbol, OpenAI::Beta::Threads::Run::LastError::Code] One of `server_error`, `rate_limit_exceeded`, or `invalid_prompt`.
            #
            #   @param message [String] A human-readable description of the error.

            # One of `server_error`, `rate_limit_exceeded`, or `invalid_prompt`.
            #
            # @see OpenAI::Beta::Threads::Run::LastError#code
            module Code
              extend OpenAI::Internal::Type::Enum

              SERVER_ERROR = :server_error
              RATE_LIMIT_EXCEEDED = :rate_limit_exceeded
              INVALID_PROMPT = :invalid_prompt

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @see OpenAI::Beta::Threads::Run#required_action
          class RequiredAction < OpenAI::Internal::Type::BaseModel
            # @!attribute submit_tool_outputs
            #   Details on the tool outputs needed for this run to continue.
            #
            #   @return [OpenAI::Beta::Threads::Run::RequiredAction::SubmitToolOutputs]
            required :submit_tool_outputs,
                     -> {
                       OpenAI::Beta::Threads::Run::RequiredAction::SubmitToolOutputs
                     }

            # @!attribute type
            #   For now, this is always `submit_tool_outputs`.
            #
            #   @return [Symbol, :submit_tool_outputs]
            required :type, const: :submit_tool_outputs

            # @!method initialize(submit_tool_outputs:, type: :submit_tool_outputs)
            #   Details on the action required to continue the run. Will be `null` if no action
            #   is required.
            #
            #   @param submit_tool_outputs [OpenAI::Beta::Threads::Run::RequiredAction::SubmitToolOutputs] Details on the tool outputs needed for this run to continue.
            #
            #   @param type [Symbol, :submit_tool_outputs] For now, this is always `submit_tool_outputs`.

            # @see OpenAI::Beta::Threads::Run::RequiredAction#submit_tool_outputs
            class SubmitToolOutputs < OpenAI::Internal::Type::BaseModel
              # @!attribute tool_calls
              #   A list of the relevant tool calls.
              #
              #   @return [Array<OpenAI::Beta::Threads::RequiredActionFunctionToolCall>]
              required :tool_calls,
                       -> {
                         OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::Threads::RequiredActionFunctionToolCall]
                       }

              # @!method initialize(tool_calls:)
              #   Details on the tool outputs needed for this run to continue.
              #
              #   @param tool_calls [Array<OpenAI::Beta::Threads::RequiredActionFunctionToolCall>] A list of the relevant tool calls.
            end
          end

          # @see OpenAI::Beta::Threads::Run#usage
          class Usage < OpenAI::Internal::Type::BaseModel
            # @!attribute completion_tokens
            #   Number of completion tokens used over the course of the run.
            #
            #   @return [Integer]
            required :completion_tokens, Integer

            # @!attribute prompt_tokens
            #   Number of prompt tokens used over the course of the run.
            #
            #   @return [Integer]
            required :prompt_tokens, Integer

            # @!attribute total_tokens
            #   Total number of tokens used (prompt + completion).
            #
            #   @return [Integer]
            required :total_tokens, Integer

            # @!method initialize(completion_tokens:, prompt_tokens:, total_tokens:)
            #   Usage statistics related to the run. This value will be `null` if the run is not
            #   in a terminal state (i.e. `in_progress`, `queued`, etc.).
            #
            #   @param completion_tokens [Integer] Number of completion tokens used over the course of the run.
            #
            #   @param prompt_tokens [Integer] Number of prompt tokens used over the course of the run.
            #
            #   @param total_tokens [Integer] Total number of tokens used (prompt + completion).
          end
        end
      end
    end
  end
end
