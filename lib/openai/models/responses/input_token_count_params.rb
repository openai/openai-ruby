# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses::InputTokens#count
      class InputTokenCountParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute conversation
        #   The conversation that this response belongs to. Items from this conversation are
        #   prepended to `input_items` for this response request. Input items and output
        #   items from this response are automatically added to this conversation after this
        #   response completes.
        #
        #   @return [String, OpenAI::Models::Responses::ResponseConversationParam, nil]
        optional :conversation,
                 union: -> {
                   OpenAI::Responses::InputTokenCountParams::Conversation
                 },
                 nil?: true

        # @!attribute input
        #   Text, image, or file inputs to the model, used to generate a response
        #
        #   @return [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>, nil]
        optional :input, union: -> { OpenAI::Responses::InputTokenCountParams::Input }, nil?: true

        # @!attribute instructions
        #   A system (or developer) message inserted into the model's context. When used
        #   along with `previous_response_id`, the instructions from a previous response
        #   will not be carried over to the next response. This makes it simple to swap out
        #   system (or developer) messages in new responses.
        #
        #   @return [String, nil]
        optional :instructions, String, nil?: true

        # @!attribute model
        #   Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        #
        #   @return [String, nil]
        optional :model, String, nil?: true

        # @!attribute parallel_tool_calls
        #   Whether to allow the model to run tool calls in parallel.
        #
        #   @return [Boolean, nil]
        optional :parallel_tool_calls, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute previous_response_id
        #   The unique ID of the previous response to the model. Use this to create
        #   multi-turn conversations. Learn more about
        #   [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        #   Cannot be used in conjunction with `conversation`.
        #
        #   @return [String, nil]
        optional :previous_response_id, String, nil?: true

        # @!attribute reasoning
        #   **gpt-5 and o-series models only** Configuration options for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @return [OpenAI::Models::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Reasoning }, nil?: true

        # @!attribute text
        #   Configuration options for a text response from the model. Can be plain text or
        #   structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        #
        #   @return [OpenAI::Models::Responses::InputTokenCountParams::Text, nil]
        optional :text, -> { OpenAI::Responses::InputTokenCountParams::Text }, nil?: true

        # @!attribute tool_choice
        #   How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceAllowed, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, OpenAI::Models::Responses::ToolChoiceCustom, nil]
        optional :tool_choice, union: -> { OpenAI::Responses::InputTokenCountParams::ToolChoice }, nil?: true

        # @!attribute tools
        #   An array of tools the model may call while generating a response. You can
        #   specify which tool to use by setting the `tool_choice` parameter.
        #
        #   @return [Array<OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::CustomTool, OpenAI::Models::Responses::WebSearchTool, OpenAI::Models::Responses::WebSearchPreviewTool>, nil]
        optional :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::Tool] }, nil?: true

        # @!attribute truncation
        #   The truncation strategy to use for the model response. - `auto`: If the input to
        #   this Response exceeds the model's context window size, the model will truncate
        #   the response to fit the context window by dropping items from the beginning of
        #   the conversation. - `disabled` (default): If the input size will exceed the
        #   context window size for a model, the request will fail with a 400 error.
        #
        #   @return [Symbol, OpenAI::Models::Responses::InputTokenCountParams::Truncation, nil]
        optional :truncation, enum: -> { OpenAI::Responses::InputTokenCountParams::Truncation }

        # @!method initialize(conversation: nil, input: nil, instructions: nil, model: nil, parallel_tool_calls: nil, previous_response_id: nil, reasoning: nil, text: nil, tool_choice: nil, tools: nil, truncation: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::InputTokenCountParams} for more details.
        #
        #   @param conversation [String, OpenAI::Models::Responses::ResponseConversationParam, nil] The conversation that this response belongs to. Items from this conversation are
        #
        #   @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>, nil] Text, image, or file inputs to the model, used to generate a response
        #
        #   @param instructions [String, nil] A system (or developer) message inserted into the model's context.
        #
        #   @param model [String, nil] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a w
        #
        #   @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
        #
        #   @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to create multi-tu
        #
        #   @param reasoning [OpenAI::Models::Reasoning, nil] **gpt-5 and o-series models only** Configuration options for [reasoning models](
        #
        #   @param text [OpenAI::Models::Responses::InputTokenCountParams::Text, nil] Configuration options for a text response from the model. Can be plain
        #
        #   @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceAllowed, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, OpenAI::Models::Responses::ToolChoiceCustom, nil] How the model should select which tool (or tools) to use when generating
        #
        #   @param tools [Array<OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::CustomTool, OpenAI::Models::Responses::WebSearchTool, OpenAI::Models::Responses::WebSearchPreviewTool>, nil] An array of tools the model may call while generating a response. You can specif
        #
        #   @param truncation [Symbol, OpenAI::Models::Responses::InputTokenCountParams::Truncation] The truncation strategy to use for the model response. - `auto`: If the input to
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # The conversation that this response belongs to. Items from this conversation are
        # prepended to `input_items` for this response request. Input items and output
        # items from this response are automatically added to this conversation after this
        # response completes.
        module Conversation
          extend OpenAI::Internal::Type::Union

          # The unique ID of the conversation.
          variant String

          # The conversation that this response belongs to.
          variant -> { OpenAI::Responses::ResponseConversationParam }

          # @!method self.variants
          #   @return [Array(String, OpenAI::Models::Responses::ResponseConversationParam)]
        end

        # Text, image, or file inputs to the model, used to generate a response
        module Input
          extend OpenAI::Internal::Type::Union

          # A text input to the model, equivalent to a text input with the `user` role.
          variant String

          variant -> { OpenAI::Models::Responses::InputTokenCountParams::Input::ResponseInputItemArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>)]

          # @type [OpenAI::Internal::Type::Converter]
          ResponseInputItemArray =
            OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Responses::ResponseInputItem }]
        end

        class Text < OpenAI::Internal::Type::BaseModel
          # @!attribute format_
          #   An object specifying the format that the model must output.
          #
          #   Configuring `{ "type": "json_schema" }` enables Structured Outputs, which
          #   ensures the model will match your supplied JSON schema. Learn more in the
          #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #   The default format is `{ "type": "text" }` with no additional options.
          #
          #   **Not recommended for gpt-4o and newer models:**
          #
          #   Setting to `{ "type": "json_object" }` enables the older JSON mode, which
          #   ensures the message the model generates is valid JSON. Using `json_schema` is
          #   preferred for models that support it.
          #
          #   @return [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::Models::ResponseFormatJSONObject, nil]
          optional :format_, union: -> { OpenAI::Responses::ResponseFormatTextConfig }, api_name: :format

          # @!attribute verbosity
          #   Constrains the verbosity of the model's response. Lower values will result in
          #   more concise responses, while higher values will result in more verbose
          #   responses. Currently supported values are `low`, `medium`, and `high`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::InputTokenCountParams::Text::Verbosity, nil]
          optional :verbosity,
                   enum: -> {
                     OpenAI::Responses::InputTokenCountParams::Text::Verbosity
                   },
                   nil?: true

          # @!method initialize(format_: nil, verbosity: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::InputTokenCountParams::Text} for more details.
          #
          #   Configuration options for a text response from the model. Can be plain text or
          #   structured JSON data. Learn more:
          #
          #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
          #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
          #
          #   @param format_ [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::Models::ResponseFormatJSONObject] An object specifying the format that the model must output.
          #
          #   @param verbosity [Symbol, OpenAI::Models::Responses::InputTokenCountParams::Text::Verbosity, nil] Constrains the verbosity of the model's response. Lower values will result in

          # Constrains the verbosity of the model's response. Lower values will result in
          # more concise responses, while higher values will result in more verbose
          # responses. Currently supported values are `low`, `medium`, and `high`.
          #
          # @see OpenAI::Models::Responses::InputTokenCountParams::Text#verbosity
          module Verbosity
            extend OpenAI::Internal::Type::Enum

            LOW = :low
            MEDIUM = :medium
            HIGH = :high

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          # Controls which (if any) tool is called by the model.
          #
          # `none` means the model will not call any tool and instead generates a message.
          #
          # `auto` means the model can pick between generating a message or calling one or
          # more tools.
          #
          # `required` means the model must call one or more tools.
          variant enum: -> { OpenAI::Responses::ToolChoiceOptions }

          # Constrains the tools available to the model to a pre-defined set.
          variant -> { OpenAI::Responses::ToolChoiceAllowed }

          # Indicates that the model should use a built-in tool to generate a response.
          # [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
          variant -> { OpenAI::Responses::ToolChoiceTypes }

          # Use this option to force the model to call a specific function.
          variant -> { OpenAI::Responses::ToolChoiceFunction }

          # Use this option to force the model to call a specific tool on a remote MCP server.
          variant -> { OpenAI::Responses::ToolChoiceMcp }

          # Use this option to force the model to call a specific custom tool.
          variant -> { OpenAI::Responses::ToolChoiceCustom }

          # @!method self.variants
          #   @return [Array(Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceAllowed, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, OpenAI::Models::Responses::ToolChoiceCustom)]
        end

        # The truncation strategy to use for the model response. - `auto`: If the input to
        # this Response exceeds the model's context window size, the model will truncate
        # the response to fit the context window by dropping items from the beginning of
        # the conversation. - `disabled` (default): If the input size will exceed the
        # context window size for a model, the request will fail with a 400 error.
        module Truncation
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DISABLED = :disabled

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
