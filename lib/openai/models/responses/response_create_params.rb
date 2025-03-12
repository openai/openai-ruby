# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCreateParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute input
        #   Text, image, or file inputs to the model, used to generate a response.
        #
        #     Learn more:
        #
        #     - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #     - [Image inputs](https://platform.openai.com/docs/guides/images)
        #     - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        #     - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        #     - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        #
        #   @return [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ItemReference>]
        required :input, union: -> { OpenAI::Models::Responses::ResponseCreateParams::Input }

        # @!attribute model
        #   Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
        #     wide range of models with different capabilities, performance characteristics,
        #     and price points. Refer to the
        #     [model guide](https://platform.openai.com/docs/models) to browse and compare
        #     available models.
        #
        #   @return [String, Symbol, OpenAI::Models::ChatModel]
        required :model, union: -> { OpenAI::Models::Responses::ResponseCreateParams::Model }

        # @!attribute include
        #   Specify additional output data to include in the model response. Currently
        #     supported values are:
        #
        #     - `file_search_call.results`: Include the search results of the file search tool
        #       call.
        #     - `message.input_image.image_url`: Include image urls from the input message.
        #     - `computer_call_output.output.image_url`: Include image urls from the computer
        #       call output.
        #
        #   @return [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
        optional :include, -> { OpenAI::ArrayOf[enum: OpenAI::Models::Responses::ResponseIncludable] }, nil?: true

        # @!attribute instructions
        #   Inserts a system (or developer) message as the first item in the model's
        #     context.
        #
        #     When using along with `previous_response_id`, the instructions from a previous
        #     response will be not be carried over to the next response. This makes it simple
        #     to swap out system (or developer) messages in new responses.
        #
        #   @return [String, nil]
        optional :instructions, String, nil?: true

        # @!attribute max_output_tokens
        #   An upper bound for the number of tokens that can be generated for a response,
        #     including visible output tokens and
        #     [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @return [Integer, nil]
        optional :max_output_tokens, Integer, nil?: true

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::HashOf[String], nil?: true

        # @!attribute parallel_tool_calls
        #   Whether to allow the model to run tool calls in parallel.
        #
        #   @return [Boolean, nil]
        optional :parallel_tool_calls, OpenAI::BooleanModel, nil?: true

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

        # @!attribute store
        #   Whether to store the generated model response for later retrieval via API.
        #
        #   @return [Boolean, nil]
        optional :store, OpenAI::BooleanModel, nil?: true

        # @!attribute temperature
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #     make the output more random, while lower values like 0.2 will make it more
        #     focused and deterministic. We generally recommend altering this or `top_p` but
        #     not both.
        #
        #   @return [Float, nil]
        optional :temperature, Float, nil?: true

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

        # @!attribute [r] tool_choice
        #   How the model should select which tool (or tools) to use when generating a
        #     response. See the `tools` parameter to see how to specify which tools the model
        #     can call.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, nil]
        optional :tool_choice, union: -> { OpenAI::Models::Responses::ResponseCreateParams::ToolChoice }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction]
        #   attr_writer :tool_choice

        # @!attribute [r] tools
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
        #   @return [Array<OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool>, nil]
        optional :tools, -> { OpenAI::ArrayOf[union: OpenAI::Models::Responses::Tool] }

        # @!parse
        #   # @return [Array<OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool>]
        #   attr_writer :tools

        # @!attribute top_p
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #     model considers the results of the tokens with top_p probability mass. So 0.1
        #     means only the tokens comprising the top 10% probability mass are considered.
        #
        #     We generally recommend altering this or `temperature` but not both.
        #
        #   @return [Float, nil]
        optional :top_p, Float, nil?: true

        # @!attribute truncation
        #   The truncation strategy to use for the model response.
        #
        #     - `auto`: If the context of this response and previous ones exceeds the model's
        #       context window size, the model will truncate the response to fit the context
        #       window by dropping input items in the middle of the conversation.
        #     - `disabled` (default): If a model response will exceed the context window size
        #       for a model, the request will fail with a 400 error.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil]
        optional :truncation, enum: -> { OpenAI::Models::Responses::ResponseCreateParams::Truncation }, nil?: true

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
        #   # @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ItemReference>]
        #   # @param model [String, Symbol, OpenAI::Models::ChatModel]
        #   # @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
        #   # @param instructions [String, nil]
        #   # @param max_output_tokens [Integer, nil]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param parallel_tool_calls [Boolean, nil]
        #   # @param previous_response_id [String, nil]
        #   # @param reasoning [OpenAI::Models::Reasoning, nil]
        #   # @param store [Boolean, nil]
        #   # @param temperature [Float, nil]
        #   # @param text [OpenAI::Models::Responses::ResponseTextConfig]
        #   # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction]
        #   # @param tools [Array<OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::WebSearchTool>]
        #   # @param top_p [Float, nil]
        #   # @param truncation [Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation, nil]
        #   # @param user [String]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(
        #     input:,
        #     model:,
        #     include: nil,
        #     instructions: nil,
        #     max_output_tokens: nil,
        #     metadata: nil,
        #     parallel_tool_calls: nil,
        #     previous_response_id: nil,
        #     reasoning: nil,
        #     store: nil,
        #     temperature: nil,
        #     text: nil,
        #     tool_choice: nil,
        #     tools: nil,
        #     top_p: nil,
        #     truncation: nil,
        #     user: nil,
        #     request_options: {},
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @abstract
        #
        # Text, image, or file inputs to the model, used to generate a response.
        #
        #   Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Image inputs](https://platform.openai.com/docs/guides/images)
        #   - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        #   - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        #   - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        class Input < OpenAI::Union
          # A text input to the model, equivalent to a text input with the
          # `user` role.
          variant String

          # A list of one or many input items to the model, containing
          # different content types.
          variant -> { OpenAI::Models::Responses::ResponseInput }
        end

        # @abstract
        #
        # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        class Model < OpenAI::Union
          variant String

          # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI
          # offers a wide range of models with different capabilities, performance
          # characteristics, and price points. Refer to the [model guide](https://platform.openai.com/docs/models)
          # to browse and compare available models.
          variant enum: -> { OpenAI::Models::ChatModel }
        end

        # @abstract
        #
        # How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        class ToolChoice < OpenAI::Union
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
        end

        # @abstract
        #
        # The truncation strategy to use for the model response.
        #
        #   - `auto`: If the context of this response and previous ones exceeds the model's
        #     context window size, the model will truncate the response to fit the context
        #     window by dropping input items in the middle of the conversation.
        #   - `disabled` (default): If a model response will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        class Truncation < OpenAI::Enum
          AUTO = :auto
          DISABLED = :disabled

          finalize!
        end
      end
    end
  end
end
