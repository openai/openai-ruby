# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses#create
      #
      # @see OpenAI::Resources::Responses#create_streaming
      class Response < OpenAI::BaseModel
        # @!attribute id
        #   Unique identifier for this Response.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   Unix timestamp (in seconds) of when this Response was created.
        #
        #   @return [Float]
        required :created_at, Float

        # @!attribute error
        #   An error object returned when the model fails to generate a Response.
        #
        #   @return [OpenAI::Models::Responses::ResponseError, nil]
        required :error, -> { OpenAI::Models::Responses::ResponseError }, nil?: true

        # @!attribute incomplete_details
        #   Details about why the response is incomplete.
        #
        #   @return [OpenAI::Models::Responses::Response::IncompleteDetails, nil]
        required :incomplete_details, -> { OpenAI::Models::Responses::Response::IncompleteDetails }, nil?: true

        # @!attribute instructions
        #   Inserts a system (or developer) message as the first item in the model's
        #     context.
        #
        #     When using along with `previous_response_id`, the instructions from a previous
        #     response will not be carried over to the next response. This makes it simple to
        #     swap out system (or developer) messages in new responses.
        #
        #   @return [String, nil]
        required :instructions, String, nil?: true

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        required :metadata, OpenAI::HashOf[String], nil?: true

        # @!attribute model
        #   Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
        #     wide range of models with different capabilities, performance characteristics,
        #     and price points. Refer to the
        #     [model guide](https://platform.openai.com/docs/models) to browse and compare
        #     available models.
        #
        #   @return [String, Symbol, OpenAI::Models::ChatModel]
        required :model, union: -> { OpenAI::Models::ResponsesModel }

        # @!attribute object
        #   The object type of this resource - always set to `response`.
        #
        #   @return [Symbol, :response]
        required :object, const: :response

        # @!attribute output
        #   An array of content items generated by the model.
        #
        #     - The length and order of items in the `output` array is dependent on the
        #       model's response.
        #     - Rather than accessing the first item in the `output` array and assuming it's
        #       an `assistant` message with the content generated by the model, you might
        #       consider using the `output_text` property where supported in SDKs.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem>]
        required :output, -> { OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseOutputItem] }

        # @!attribute parallel_tool_calls
        #   Whether to allow the model to run tool calls in parallel.
        #
        #   @return [Boolean]
        required :parallel_tool_calls, OpenAI::BooleanModel

        # @!attribute temperature
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #     make the output more random, while lower values like 0.2 will make it more
        #     focused and deterministic. We generally recommend altering this or `top_p` but
        #     not both.
        #
        #   @return [Float, nil]
        required :temperature, Float, nil?: true

        # @!attribute tool_choice
        #   How the model should select which tool (or tools) to use when generating a
        #     response. See the `tools` parameter to see how to specify which tools the model
        #     can call.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction]
        required :tool_choice, union: -> { OpenAI::Models::Responses::Response::ToolChoice }

        # @!attribute tools
        #   An array of tools the model may call while generating a response. You can
        #     specify which tool to use by setting the `tool_choice` parameter.
        #
        #     The two categories of tools you can provide the model are:
        #
        #     - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #       capabilities, like
        #       [web search](https://platform.openai.com/docs/guides/tools-web-search) or
        #       [file search](https://platform.openai.com/docs/guides/tools-file-search).
        #       Learn more about
        #       [built-in tools](https://platform.openai.com/docs/guides/tools).
        #     - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #       the model to call your own code. Learn more about
        #       [function calling](https://platform.openai.com/docs/guides/function-calling).
        #
        #   @return [Array<OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool>]
        required :tools, -> { OpenAI::ArrayOf[union: OpenAI::Models::Responses::Tool] }

        # @!attribute top_p
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #     model considers the results of the tokens with top_p probability mass. So 0.1
        #     means only the tokens comprising the top 10% probability mass are considered.
        #
        #     We generally recommend altering this or `temperature` but not both.
        #
        #   @return [Float, nil]
        required :top_p, Float, nil?: true

        # @!attribute max_output_tokens
        #   An upper bound for the number of tokens that can be generated for a response,
        #     including visible output tokens and
        #     [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @return [Integer, nil]
        optional :max_output_tokens, Integer, nil?: true

        # @!attribute previous_response_id
        #   The unique ID of the previous response to the model. Use this to create
        #     multi-turn conversations. Learn more about
        #     [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        #
        #   @return [String, nil]
        optional :previous_response_id, String, nil?: true

        # @!attribute reasoning
        #   **o-series models only**
        #
        #     Configuration options for
        #     [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @return [OpenAI::Models::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Models::Reasoning }, nil?: true

        # @!attribute [r] status
        #   The status of the response generation. One of `completed`, `failed`,
        #     `in_progress`, or `incomplete`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseStatus, nil]
        optional :status, enum: -> { OpenAI::Models::Responses::ResponseStatus }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Responses::ResponseStatus]
        #   attr_writer :status

        # @!attribute [r] text
        #   Configuration options for a text response from the model. Can be plain text or
        #     structured JSON data. Learn more:
        #
        #     - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #     - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        #
        #   @return [OpenAI::Models::Responses::ResponseTextConfig, nil]
        optional :text, -> { OpenAI::Models::Responses::ResponseTextConfig }

        # @!parse
        #   # @return [OpenAI::Models::Responses::ResponseTextConfig]
        #   attr_writer :text

        # @!attribute truncation
        #   The truncation strategy to use for the model response.
        #
        #     - `auto`: If the context of this response and previous ones exceeds the model's
        #       context window size, the model will truncate the response to fit the context
        #       window by dropping input items in the middle of the conversation.
        #     - `disabled` (default): If a model response will exceed the context window size
        #       for a model, the request will fail with a 400 error.
        #
        #   @return [Symbol, OpenAI::Models::Responses::Response::Truncation, nil]
        optional :truncation, enum: -> { OpenAI::Models::Responses::Response::Truncation }, nil?: true

        # @!attribute [r] usage
        #   Represents token usage details including input tokens, output tokens, a
        #     breakdown of output tokens, and the total tokens used.
        #
        #   @return [OpenAI::Models::Responses::ResponseUsage, nil]
        optional :usage, -> { OpenAI::Models::Responses::ResponseUsage }

        # @!parse
        #   # @return [OpenAI::Models::Responses::ResponseUsage]
        #   attr_writer :usage

        # @!attribute [r] user
        #   A unique identifier representing your end-user, which can help OpenAI to monitor
        #     and detect abuse.
        #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        #
        #   @return [String, nil]
        optional :user, String

        # @!parse
        #   # @return [String]
        #   attr_writer :user

        # @!parse
        #   # @param id [String]
        #   # @param created_at [Float]
        #   # @param error [OpenAI::Models::Responses::ResponseError, nil]
        #   # @param incomplete_details [OpenAI::Models::Responses::Response::IncompleteDetails, nil]
        #   # @param instructions [String, nil]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param model [String, Symbol, OpenAI::Models::ChatModel]
        #   # @param output [Array<OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem>]
        #   # @param parallel_tool_calls [Boolean]
        #   # @param temperature [Float, nil]
        #   # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction]
        #   # @param tools [Array<OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool>]
        #   # @param top_p [Float, nil]
        #   # @param max_output_tokens [Integer, nil]
        #   # @param previous_response_id [String, nil]
        #   # @param reasoning [OpenAI::Models::Reasoning, nil]
        #   # @param status [Symbol, OpenAI::Models::Responses::ResponseStatus]
        #   # @param text [OpenAI::Models::Responses::ResponseTextConfig]
        #   # @param truncation [Symbol, OpenAI::Models::Responses::Response::Truncation, nil]
        #   # @param usage [OpenAI::Models::Responses::ResponseUsage]
        #   # @param user [String]
        #   # @param object [Symbol, :response]
        #   #
        #   def initialize(
        #     id:,
        #     created_at:,
        #     error:,
        #     incomplete_details:,
        #     instructions:,
        #     metadata:,
        #     model:,
        #     output:,
        #     parallel_tool_calls:,
        #     temperature:,
        #     tool_choice:,
        #     tools:,
        #     top_p:,
        #     max_output_tokens: nil,
        #     previous_response_id: nil,
        #     reasoning: nil,
        #     status: nil,
        #     text: nil,
        #     truncation: nil,
        #     usage: nil,
        #     user: nil,
        #     object: :response,
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @see OpenAI::Models::Responses::Response#incomplete_details
        class IncompleteDetails < OpenAI::BaseModel
          # @!attribute [r] reason
          #   The reason why the response is incomplete.
          #
          #   @return [Symbol, OpenAI::Models::Responses::Response::IncompleteDetails::Reason, nil]
          optional :reason, enum: -> { OpenAI::Models::Responses::Response::IncompleteDetails::Reason }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Responses::Response::IncompleteDetails::Reason]
          #   attr_writer :reason

          # @!parse
          #   # Details about why the response is incomplete.
          #   #
          #   # @param reason [Symbol, OpenAI::Models::Responses::Response::IncompleteDetails::Reason]
          #   #
          #   def initialize(reason: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # The reason why the response is incomplete.
          #
          # @see OpenAI::Models::Responses::Response::IncompleteDetails#reason
          module Reason
            extend OpenAI::Enum

            MAX_OUTPUT_TOKENS = :max_output_tokens
            CONTENT_FILTER = :content_filter

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end

        # How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        #
        # @see OpenAI::Models::Responses::Response#tool_choice
        module ToolChoice
          extend OpenAI::Union

          # Controls which (if any) tool is called by the model.
          #
          # `none` means the model will not call any tool and instead generates a message.
          #
          # `auto` means the model can pick between generating a message or calling one or
          # more tools.
          #
          # `required` means the model must call one or more tools.
          variant enum: -> { OpenAI::Models::Responses::ToolChoiceOptions }

          # Indicates that the model should use a built-in tool to generate a response.
          # [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
          variant -> { OpenAI::Models::Responses::ToolChoiceTypes }

          # Use this option to force the model to call a specific function.
          variant -> { OpenAI::Models::Responses::ToolChoiceFunction }

          # @!parse
          #   # @return [Array(Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction)]
          #   def self.variants; end
        end

        # The truncation strategy to use for the model response.
        #
        #   - `auto`: If the context of this response and previous ones exceeds the model's
        #     context window size, the model will truncate the response to fit the context
        #     window by dropping input items in the middle of the conversation.
        #   - `disabled` (default): If a model response will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        #
        # @see OpenAI::Models::Responses::Response#truncation
        module Truncation
          extend OpenAI::Enum

          AUTO = :auto
          DISABLED = :disabled

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
