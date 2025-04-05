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
          #     [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #     execution of this run.
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
          #     incomplete.
          #
          #   @return [OpenAI::Models::Beta::Threads::Run::IncompleteDetails, nil]
          required :incomplete_details, -> { OpenAI::Models::Beta::Threads::Run::IncompleteDetails }, nil?: true

          # @!attribute instructions
          #   The instructions that the
          #     [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #     this run.
          #
          #   @return [String]
          required :instructions, String

          # @!attribute last_error
          #   The last error associated with this run. Will be `null` if there are no errors.
          #
          #   @return [OpenAI::Models::Beta::Threads::Run::LastError, nil]
          required :last_error, -> { OpenAI::Models::Beta::Threads::Run::LastError }, nil?: true

          # @!attribute max_completion_tokens
          #   The maximum number of completion tokens specified to have been used over the
          #     course of the run.
          #
          #   @return [Integer, nil]
          required :max_completion_tokens, Integer, nil?: true

          # @!attribute max_prompt_tokens
          #   The maximum number of prompt tokens specified to have been used over the course
          #     of the run.
          #
          #   @return [Integer, nil]
          required :max_prompt_tokens, Integer, nil?: true

          # @!attribute metadata
          #   Set of 16 key-value pairs that can be attached to an object. This can be useful
          #     for storing additional information about the object in a structured format, and
          #     querying for objects via API or the dashboard.
          #
          #     Keys are strings with a maximum length of 64 characters. Values are strings with
          #     a maximum length of 512 characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          required :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!attribute model
          #   The model that the
          #     [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #     this run.
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
          #     [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          #     during tool use.
          #
          #   @return [Boolean]
          required :parallel_tool_calls, OpenAI::Internal::Type::Boolean

          # @!attribute required_action
          #   Details on the action required to continue the run. Will be `null` if no action
          #     is required.
          #
          #   @return [OpenAI::Models::Beta::Threads::Run::RequiredAction, nil]
          required :required_action, -> { OpenAI::Models::Beta::Threads::Run::RequiredAction }, nil?: true

          # @!attribute response_format
          #   Specifies the format that the model must output. Compatible with
          #     [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          #     [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          #     and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          #     Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #     Outputs which ensures the model will match your supplied JSON schema. Learn more
          #     in the
          #     [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #     Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          #     message the model generates is valid JSON.
          #
          #     **Important:** when using JSON mode, you **must** also instruct the model to
          #     produce JSON yourself via a system or user message. Without this, the model may
          #     generate an unending stream of whitespace until the generation reaches the token
          #     limit, resulting in a long-running and seemingly "stuck" request. Also note that
          #     the message content may be partially cut off if `finish_reason="length"`, which
          #     indicates the generation exceeded `max_tokens` or the conversation exceeded the
          #     max context length.
          #
          #   @return [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
          required :response_format, union: -> { OpenAI::Models::Beta::AssistantResponseFormatOption }, nil?: true

          # @!attribute started_at
          #   The Unix timestamp (in seconds) for when the run was started.
          #
          #   @return [Integer, nil]
          required :started_at, Integer, nil?: true

          # @!attribute status
          #   The status of the run, which can be either `queued`, `in_progress`,
          #     `requires_action`, `cancelling`, `cancelled`, `failed`, `completed`,
          #     `incomplete`, or `expired`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::RunStatus]
          required :status, enum: -> { OpenAI::Models::Beta::Threads::RunStatus }

          # @!attribute thread_id
          #   The ID of the [thread](https://platform.openai.com/docs/api-reference/threads)
          #     that was executed on as a part of this run.
          #
          #   @return [String]
          required :thread_id, String

          # @!attribute tool_choice
          #   Controls which (if any) tool is called by the model. `none` means the model will
          #     not call any tools and instead generates a message. `auto` is the default value
          #     and means the model can pick between generating a message or calling one or more
          #     tools. `required` means the model must call one or more tools before responding
          #     to the user. Specifying a particular tool like `{"type": "file_search"}` or
          #     `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #     call that tool.
          #
          #   @return [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil]
          required :tool_choice, union: -> { OpenAI::Models::Beta::AssistantToolChoiceOption }, nil?: true

          # @!attribute tools
          #   The list of tools that the
          #     [assistant](https://platform.openai.com/docs/api-reference/assistants) used for
          #     this run.
          #
          #   @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
          required :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::AssistantTool] }

          # @!attribute truncation_strategy
          #   Controls for how a thread will be truncated prior to the run. Use this to
          #     control the intial context window of the run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Run::TruncationStrategy, nil]
          required :truncation_strategy, -> { OpenAI::Models::Beta::Threads::Run::TruncationStrategy }, nil?: true

          # @!attribute usage
          #   Usage statistics related to the run. This value will be `null` if the run is not
          #     in a terminal state (i.e. `in_progress`, `queued`, etc.).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run::Usage, nil]
          required :usage, -> { OpenAI::Models::Beta::Threads::Run::Usage }, nil?: true

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

          # @!parse
          #   # Represents an execution run on a
          #   #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #   #
          #   # @param id [String]
          #   # @param assistant_id [String]
          #   # @param cancelled_at [Integer, nil]
          #   # @param completed_at [Integer, nil]
          #   # @param created_at [Integer]
          #   # @param expires_at [Integer, nil]
          #   # @param failed_at [Integer, nil]
          #   # @param incomplete_details [OpenAI::Models::Beta::Threads::Run::IncompleteDetails, nil]
          #   # @param instructions [String]
          #   # @param last_error [OpenAI::Models::Beta::Threads::Run::LastError, nil]
          #   # @param max_completion_tokens [Integer, nil]
          #   # @param max_prompt_tokens [Integer, nil]
          #   # @param metadata [Hash{Symbol=>String}, nil]
          #   # @param model [String]
          #   # @param parallel_tool_calls [Boolean]
          #   # @param required_action [OpenAI::Models::Beta::Threads::Run::RequiredAction, nil]
          #   # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
          #   # @param started_at [Integer, nil]
          #   # @param status [Symbol, OpenAI::Models::Beta::Threads::RunStatus]
          #   # @param thread_id [String]
          #   # @param tool_choice [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil]
          #   # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
          #   # @param truncation_strategy [OpenAI::Models::Beta::Threads::Run::TruncationStrategy, nil]
          #   # @param usage [OpenAI::Models::Beta::Threads::Run::Usage, nil]
          #   # @param temperature [Float, nil]
          #   # @param top_p [Float, nil]
          #   # @param object [Symbol, :"thread.run"]
          #   #
          #   def initialize(
          #     id:,
          #     assistant_id:,
          #     cancelled_at:,
          #     completed_at:,
          #     created_at:,
          #     expires_at:,
          #     failed_at:,
          #     incomplete_details:,
          #     instructions:,
          #     last_error:,
          #     max_completion_tokens:,
          #     max_prompt_tokens:,
          #     metadata:,
          #     model:,
          #     parallel_tool_calls:,
          #     required_action:,
          #     response_format:,
          #     started_at:,
          #     status:,
          #     thread_id:,
          #     tool_choice:,
          #     tools:,
          #     truncation_strategy:,
          #     usage:,
          #     temperature: nil,
          #     top_p: nil,
          #     object: :"thread.run",
          #     **
          #   )
          #     super
          #   end

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::Beta::Threads::Run#incomplete_details
          class IncompleteDetails < OpenAI::Internal::Type::BaseModel
            # @!attribute [r] reason
            #   The reason why the run is incomplete. This will point to which specific token
            #     limit was reached over the course of the run.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason, nil]
            optional :reason, enum: -> { OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason }

            # @!parse
            #   # @return [Symbol, OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason]
            #   attr_writer :reason

            # @!parse
            #   # Details on why the run is incomplete. Will be `null` if the run is not
            #   #   incomplete.
            #   #
            #   # @param reason [Symbol, OpenAI::Models::Beta::Threads::Run::IncompleteDetails::Reason]
            #   #
            #   def initialize(reason: nil, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            # The reason why the run is incomplete. This will point to which specific token
            #   limit was reached over the course of the run.
            #
            # @see OpenAI::Models::Beta::Threads::Run::IncompleteDetails#reason
            module Reason
              extend OpenAI::Internal::Type::Enum

              MAX_COMPLETION_TOKENS = :max_completion_tokens
              MAX_PROMPT_TOKENS = :max_prompt_tokens

              finalize!

              # @!parse
              #   # @return [Array<Symbol>]
              #   def self.values; end
            end
          end

          # @see OpenAI::Models::Beta::Threads::Run#last_error
          class LastError < OpenAI::Internal::Type::BaseModel
            # @!attribute code
            #   One of `server_error`, `rate_limit_exceeded`, or `invalid_prompt`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Threads::Run::LastError::Code]
            required :code, enum: -> { OpenAI::Models::Beta::Threads::Run::LastError::Code }

            # @!attribute message
            #   A human-readable description of the error.
            #
            #   @return [String]
            required :message, String

            # @!parse
            #   # The last error associated with this run. Will be `null` if there are no errors.
            #   #
            #   # @param code [Symbol, OpenAI::Models::Beta::Threads::Run::LastError::Code]
            #   # @param message [String]
            #   #
            #   def initialize(code:, message:, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            # One of `server_error`, `rate_limit_exceeded`, or `invalid_prompt`.
            #
            # @see OpenAI::Models::Beta::Threads::Run::LastError#code
            module Code
              extend OpenAI::Internal::Type::Enum

              SERVER_ERROR = :server_error
              RATE_LIMIT_EXCEEDED = :rate_limit_exceeded
              INVALID_PROMPT = :invalid_prompt

              finalize!

              # @!parse
              #   # @return [Array<Symbol>]
              #   def self.values; end
            end
          end

          # @see OpenAI::Models::Beta::Threads::Run#required_action
          class RequiredAction < OpenAI::Internal::Type::BaseModel
            # @!attribute submit_tool_outputs
            #   Details on the tool outputs needed for this run to continue.
            #
            #   @return [OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs]
            required :submit_tool_outputs,
                     -> { OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs }

            # @!attribute type
            #   For now, this is always `submit_tool_outputs`.
            #
            #   @return [Symbol, :submit_tool_outputs]
            required :type, const: :submit_tool_outputs

            # @!parse
            #   # Details on the action required to continue the run. Will be `null` if no action
            #   #   is required.
            #   #
            #   # @param submit_tool_outputs [OpenAI::Models::Beta::Threads::Run::RequiredAction::SubmitToolOutputs]
            #   # @param type [Symbol, :submit_tool_outputs]
            #   #
            #   def initialize(submit_tool_outputs:, type: :submit_tool_outputs, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            # @see OpenAI::Models::Beta::Threads::Run::RequiredAction#submit_tool_outputs
            class SubmitToolOutputs < OpenAI::Internal::Type::BaseModel
              # @!attribute tool_calls
              #   A list of the relevant tool calls.
              #
              #   @return [Array<OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall>]
              required :tool_calls,
                       -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall] }

              # @!parse
              #   # Details on the tool outputs needed for this run to continue.
              #   #
              #   # @param tool_calls [Array<OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall>]
              #   #
              #   def initialize(tool_calls:, **) = super

              # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
            end
          end

          # @see OpenAI::Models::Beta::Threads::Run#truncation_strategy
          class TruncationStrategy < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The truncation strategy to use for the thread. The default is `auto`. If set to
            #     `last_messages`, the thread will be truncated to the n most recent messages in
            #     the thread. When set to `auto`, messages in the middle of the thread will be
            #     dropped to fit the context length of the model, `max_prompt_tokens`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type]
            required :type, enum: -> { OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type }

            # @!attribute last_messages
            #   The number of most recent messages from the thread when constructing the context
            #     for the run.
            #
            #   @return [Integer, nil]
            optional :last_messages, Integer, nil?: true

            # @!parse
            #   # Controls for how a thread will be truncated prior to the run. Use this to
            #   #   control the intial context window of the run.
            #   #
            #   # @param type [Symbol, OpenAI::Models::Beta::Threads::Run::TruncationStrategy::Type]
            #   # @param last_messages [Integer, nil]
            #   #
            #   def initialize(type:, last_messages: nil, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            # The truncation strategy to use for the thread. The default is `auto`. If set to
            #   `last_messages`, the thread will be truncated to the n most recent messages in
            #   the thread. When set to `auto`, messages in the middle of the thread will be
            #   dropped to fit the context length of the model, `max_prompt_tokens`.
            #
            # @see OpenAI::Models::Beta::Threads::Run::TruncationStrategy#type
            module Type
              extend OpenAI::Internal::Type::Enum

              AUTO = :auto
              LAST_MESSAGES = :last_messages

              finalize!

              # @!parse
              #   # @return [Array<Symbol>]
              #   def self.values; end
            end
          end

          # @see OpenAI::Models::Beta::Threads::Run#usage
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

            # @!parse
            #   # Usage statistics related to the run. This value will be `null` if the run is not
            #   #   in a terminal state (i.e. `in_progress`, `queued`, etc.).
            #   #
            #   # @param completion_tokens [Integer]
            #   # @param prompt_tokens [Integer]
            #   # @param total_tokens [Integer]
            #   #
            #   def initialize(completion_tokens:, prompt_tokens:, total_tokens:, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
          end
        end
      end
    end
  end
end
