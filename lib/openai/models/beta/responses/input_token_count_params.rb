# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Responses
        # @see OpenAI::Resources::Beta::Responses::InputTokens#count
        class InputTokenCountParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute conversation
          #   The conversation that this response belongs to. Items from this conversation are
          #   prepended to `input_items` for this response request. Input items and output
          #   items from this response are automatically added to this conversation after this
          #   response completes.
          #
          #   @return [String, OpenAI::Models::Beta::BetaResponseConversationParam, nil]
          optional :conversation,
                   union: -> { OpenAI::Beta::Responses::InputTokenCountParams::Conversation },
                   nil?: true

          # @!attribute input
          #   Text, image, or file inputs to the model, used to generate a response
          #
          #   @return [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>, nil]
          optional :input, union: -> { OpenAI::Beta::Responses::InputTokenCountParams::Input }, nil?: true

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

          # @!attribute personality
          #   A model-owned style preset to apply to this request. Omit this parameter to use
          #   the model's default style. Supported values may expand over time. Values must be
          #   at most 64 characters.
          #
          #   @return [String, Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Personality, nil]
          optional :personality, union: -> { OpenAI::Beta::Responses::InputTokenCountParams::Personality }

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
          #   @return [OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning, nil]
          optional :reasoning, -> { OpenAI::Beta::Responses::InputTokenCountParams::Reasoning }, nil?: true

          # @!attribute text
          #   Configuration options for a text response from the model. Can be plain text or
          #   structured JSON data. Learn more:
          #
          #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
          #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
          #
          #   @return [OpenAI::Models::Beta::Responses::InputTokenCountParams::Text, nil]
          optional :text, -> { OpenAI::Beta::Responses::InputTokenCountParams::Text }, nil?: true

          # @!attribute tool_choice
          #   Controls which tool the model should use, if any.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell, nil]
          optional :tool_choice,
                   union: -> { OpenAI::Beta::Responses::InputTokenCountParams::ToolChoice },
                   nil?: true

          # @!attribute tools
          #   An array of tools the model may call while generating a response. You can
          #   specify which tool to use by setting the `tool_choice` parameter.
          #
          #   @return [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>, nil]
          optional :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaTool] }, nil?: true

          # @!attribute truncation
          #   @deprecated
          #
          #   The truncation strategy to use for the model response. - `auto`: If the input to
          #   this Response exceeds the model's context window size, the model will truncate
          #   the response to fit the context window by dropping items from the beginning of
          #   the conversation. - `disabled` (default): If the input size will exceed the
          #   context window size for a model, the request will fail with a 400 error.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Truncation, nil]
          optional :truncation, enum: -> { OpenAI::Beta::Responses::InputTokenCountParams::Truncation }

          # @!attribute betas
          #
          #   @return [Array<Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Beta>, nil]
          optional :betas,
                   -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::Responses::InputTokenCountParams::Beta] }

          # @!method initialize(conversation: nil, input: nil, instructions: nil, model: nil, parallel_tool_calls: nil, personality: nil, previous_response_id: nil, reasoning: nil, text: nil, tool_choice: nil, tools: nil, truncation: nil, betas: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::Responses::InputTokenCountParams} for more details.
          #
          #   @param conversation [String, OpenAI::Models::Beta::BetaResponseConversationParam, nil] The conversation that this response belongs to. Items from this conversation are
          #
          #   @param input [String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>, nil] Text, image, or file inputs to the model, used to generate a response
          #
          #   @param instructions [String, nil] A system (or developer) message inserted into the model's context.
          #
          #   @param model [String, nil] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a w
          #
          #   @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
          #
          #   @param personality [String, Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Personality] A model-owned style preset to apply to this request. Omit this parameter to use
          #
          #   @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to create multi-tu
          #
          #   @param reasoning [OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning, nil] **gpt-5 and o-series models only** Configuration options for [reasoning models](
          #
          #   @param text [OpenAI::Models::Beta::Responses::InputTokenCountParams::Text, nil] Configuration options for a text response from the model. Can be plain
          #
          #   @param tool_choice [Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell, nil] Controls which tool the model should use, if any.
          #
          #   @param tools [Array<OpenAI::Models::Beta::BetaFunctionTool, OpenAI::Models::Beta::BetaFileSearchTool, OpenAI::Models::Beta::BetaComputerTool, OpenAI::Models::Beta::BetaComputerUsePreviewTool, OpenAI::Models::Beta::BetaTool::Mcp, OpenAI::Models::Beta::BetaTool::CodeInterpreter, OpenAI::Models::Beta::BetaTool::ProgrammaticToolCalling, OpenAI::Models::Beta::BetaTool::ImageGeneration, OpenAI::Models::Beta::BetaTool::LocalShell, OpenAI::Models::Beta::BetaFunctionShellTool, OpenAI::Models::Beta::BetaCustomTool, OpenAI::Models::Beta::BetaNamespaceTool, OpenAI::Models::Beta::BetaToolSearchTool, OpenAI::Models::Beta::BetaApplyPatchTool, OpenAI::Models::Beta::BetaWebSearchTool, OpenAI::Models::Beta::BetaWebSearchPreviewTool>, nil] An array of tools the model may call while generating a response. You can specif
          #
          #   @param truncation [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Truncation] The truncation strategy to use for the model response. - `auto`: If the input to
          #
          #   @param betas [Array<Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Beta>]
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
            variant -> { OpenAI::Beta::BetaResponseConversationParam }

            # @!method self.variants
            #   @return [Array(String, OpenAI::Models::Beta::BetaResponseConversationParam)]
          end

          # Text, image, or file inputs to the model, used to generate a response
          module Input
            extend OpenAI::Internal::Type::Union

            # A text input to the model, equivalent to a text input with the `user` role.
            variant String

            # A list of one or many input items to the model, containing different content types.
            variant -> { OpenAI::Models::Beta::Responses::InputTokenCountParams::Input::BetaResponseInputItemArray }

            # @!method self.variants
            #   @return [Array(String, Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>)]

            # @type [OpenAI::Internal::Type::Converter]
            BetaResponseInputItemArray =
              OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Beta::BetaResponseInputItem }]
          end

          # A model-owned style preset to apply to this request. Omit this parameter to use
          # the model's default style. Supported values may expand over time. Values must be
          # at most 64 characters.
          module Personality
            extend OpenAI::Internal::Type::Union

            variant String

            variant const: -> { OpenAI::Models::Beta::Responses::InputTokenCountParams::Personality::FRIENDLY }

            variant const: -> { OpenAI::Models::Beta::Responses::InputTokenCountParams::Personality::PRAGMATIC }

            # @!method self.variants
            #   @return [Array(String, Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { T.any(String, OpenAI::Beta::Responses::InputTokenCountParams::Personality::TaggedSymbol) }
            end

            # @!group

            FRIENDLY = :friendly
            PRAGMATIC = :pragmatic

            # @!endgroup
          end

          class Reasoning < OpenAI::Internal::Type::BaseModel
            # @!attribute context
            #   Controls which reasoning items are rendered back to the model on later turns. If
            #   omitted or set to `auto`, the model determines the context mode. The `gpt-5.6`
            #   model family defaults to `all_turns`; earlier models default to `current_turn`.
            #
            #   When returned on a response, this is the effective reasoning context mode used
            #   for the response.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::Context, nil]
            optional :context,
                     enum: -> { OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Context },
                     nil?: true

            # @!attribute effort
            #   Constrains effort on reasoning for reasoning models. Currently supported values
            #   are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
            #   reasoning effort can result in faster responses and fewer tokens used on
            #   reasoning in a response. Not all reasoning models support every value. See the
            #   [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
            #   model-specific support.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::Effort, nil]
            optional :effort,
                     enum: -> { OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort },
                     nil?: true

            # @!attribute generate_summary
            #   @deprecated
            #
            #   **Deprecated:** use `summary` instead.
            #
            #   A summary of the reasoning performed by the model. This can be useful for
            #   debugging and understanding the model's reasoning process. One of `auto`,
            #   `concise`, or `detailed`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary, nil]
            optional :generate_summary,
                     enum: -> { OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary },
                     nil?: true

            # @!attribute mode
            #   Controls the reasoning execution mode for the request.
            #
            #   When returned on a response, this is the effective execution mode.
            #
            #   @return [String, Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::Mode, nil]
            optional :mode, union: -> { OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode }

            # @!attribute summary
            #   A summary of the reasoning performed by the model. This can be useful for
            #   debugging and understanding the model's reasoning process. One of `auto`,
            #   `concise`, or `detailed`.
            #
            #   `concise` is supported for `computer-use-preview` models and all reasoning
            #   models after `gpt-5`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::Summary, nil]
            optional :summary,
                     enum: -> { OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Summary },
                     nil?: true

            # @!method initialize(context: nil, effort: nil, generate_summary: nil, mode: nil, summary: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning} for more
            #   details.
            #
            #   **gpt-5 and o-series models only** Configuration options for
            #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
            #
            #   @param context [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::Context, nil] Controls which reasoning items are rendered back to the model on later turns.
            #
            #   @param effort [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::Effort, nil] Constrains effort on reasoning for reasoning models. Currently supported
            #
            #   @param generate_summary [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary, nil] **Deprecated:** use `summary` instead.
            #
            #   @param mode [String, Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::Mode] Controls the reasoning execution mode for the request.
            #
            #   @param summary [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::Summary, nil] A summary of the reasoning performed by the model. This can be

            # Controls which reasoning items are rendered back to the model on later turns. If
            # omitted or set to `auto`, the model determines the context mode. The `gpt-5.6`
            # model family defaults to `all_turns`; earlier models default to `current_turn`.
            #
            # When returned on a response, this is the effective reasoning context mode used
            # for the response.
            #
            # @see OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning#context
            module Context
              extend OpenAI::Internal::Type::Enum

              AUTO = :auto
              CURRENT_TURN = :current_turn
              ALL_TURNS = :all_turns

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # Constrains effort on reasoning for reasoning models. Currently supported values
            # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
            # reasoning effort can result in faster responses and fewer tokens used on
            # reasoning in a response. Not all reasoning models support every value. See the
            # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
            # model-specific support.
            #
            # @see OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning#effort
            module Effort
              extend OpenAI::Internal::Type::Enum

              NONE = :none
              MINIMAL = :minimal
              LOW = :low
              MEDIUM = :medium
              HIGH = :high
              XHIGH = :xhigh
              MAX = :max

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # @deprecated
            #
            # **Deprecated:** use `summary` instead.
            #
            # A summary of the reasoning performed by the model. This can be useful for
            # debugging and understanding the model's reasoning process. One of `auto`,
            # `concise`, or `detailed`.
            #
            # @see OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning#generate_summary
            module GenerateSummary
              extend OpenAI::Internal::Type::Enum

              AUTO = :auto
              CONCISE = :concise
              DETAILED = :detailed

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # Controls the reasoning execution mode for the request.
            #
            # When returned on a response, this is the effective execution mode.
            #
            # @see OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning#mode
            module Mode
              extend OpenAI::Internal::Type::Union

              variant String

              variant const: -> { OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::Mode::STANDARD }

              variant const: -> { OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning::Mode::PRO }

              # @!method self.variants
              #   @return [Array(String, Symbol)]

              define_sorbet_constant!(:Variants) do
                T.type_alias { T.any(String, OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode::TaggedSymbol) }
              end

              # @!group

              STANDARD = :standard
              PRO = :pro

              # @!endgroup
            end

            # A summary of the reasoning performed by the model. This can be useful for
            # debugging and understanding the model's reasoning process. One of `auto`,
            # `concise`, or `detailed`.
            #
            # `concise` is supported for `computer-use-preview` models and all reasoning
            # models after `gpt-5`.
            #
            # @see OpenAI::Models::Beta::Responses::InputTokenCountParams::Reasoning#summary
            module Summary
              extend OpenAI::Internal::Type::Enum

              AUTO = :auto
              CONCISE = :concise
              DETAILED = :detailed

              # @!method self.values
              #   @return [Array<Symbol>]
            end
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
            #   @return [OpenAI::Models::Beta::BetaResponseFormatTextConfig::Text, OpenAI::Models::Beta::BetaResponseFormatTextJSONSchemaConfig, OpenAI::Models::Beta::BetaResponseFormatTextConfig::JSONObject, nil]
            optional :format_, union: -> { OpenAI::Beta::BetaResponseFormatTextConfig }, api_name: :format

            # @!attribute verbosity
            #   Constrains the verbosity of the model's response. Lower values will result in
            #   more concise responses, while higher values will result in more verbose
            #   responses. Currently supported values are `low`, `medium`, and `high`. The
            #   default is `medium`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Text::Verbosity, nil]
            optional :verbosity,
                     enum: -> { OpenAI::Beta::Responses::InputTokenCountParams::Text::Verbosity },
                     nil?: true

            # @!method initialize(format_: nil, verbosity: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::Responses::InputTokenCountParams::Text} for more details.
            #
            #   Configuration options for a text response from the model. Can be plain text or
            #   structured JSON data. Learn more:
            #
            #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
            #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
            #
            #   @param format_ [OpenAI::Models::Beta::BetaResponseFormatTextConfig::Text, OpenAI::Models::Beta::BetaResponseFormatTextJSONSchemaConfig, OpenAI::Models::Beta::BetaResponseFormatTextConfig::JSONObject] An object specifying the format that the model must output.
            #
            #   @param verbosity [Symbol, OpenAI::Models::Beta::Responses::InputTokenCountParams::Text::Verbosity, nil] Constrains the verbosity of the model's response. Lower values will result in

            # Constrains the verbosity of the model's response. Lower values will result in
            # more concise responses, while higher values will result in more verbose
            # responses. Currently supported values are `low`, `medium`, and `high`. The
            # default is `medium`.
            #
            # @see OpenAI::Models::Beta::Responses::InputTokenCountParams::Text#verbosity
            module Verbosity
              extend OpenAI::Internal::Type::Enum

              LOW = :low
              MEDIUM = :medium
              HIGH = :high

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # Controls which tool the model should use, if any.
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
            variant enum: -> { OpenAI::Beta::BetaToolChoiceOptions }

            # Constrains the tools available to the model to a pre-defined set.
            variant -> { OpenAI::Beta::BetaToolChoiceAllowed }

            # Indicates that the model should use a built-in tool to generate a response.
            # [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
            variant -> { OpenAI::Beta::BetaToolChoiceTypes }

            # Use this option to force the model to call a specific function.
            variant -> { OpenAI::Beta::BetaToolChoiceFunction }

            # Use this option to force the model to call a specific tool on a remote MCP server.
            variant -> { OpenAI::Beta::BetaToolChoiceMcp }

            # Use this option to force the model to call a specific custom tool.
            variant -> { OpenAI::Beta::BetaToolChoiceCustom }

            variant -> { OpenAI::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam }

            # Forces the model to call the apply_patch tool when executing a tool call.
            variant -> { OpenAI::Beta::BetaToolChoiceApplyPatch }

            # Forces the model to call the shell tool when a tool call is required.
            variant -> { OpenAI::Beta::BetaToolChoiceShell }

            class BetaSpecificProgrammaticToolCallingParam < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The tool to call. Always `programmatic_tool_calling`.
              #
              #   @return [Symbol, :programmatic_tool_calling]
              required :type, const: :programmatic_tool_calling

              # @!method initialize(type: :programmatic_tool_calling)
              #   @param type [Symbol, :programmatic_tool_calling] The tool to call. Always `programmatic_tool_calling`.
            end

            # @!method self.variants
            #   @return [Array(Symbol, OpenAI::Models::Beta::BetaToolChoiceOptions, OpenAI::Models::Beta::BetaToolChoiceAllowed, OpenAI::Models::Beta::BetaToolChoiceTypes, OpenAI::Models::Beta::BetaToolChoiceFunction, OpenAI::Models::Beta::BetaToolChoiceMcp, OpenAI::Models::Beta::BetaToolChoiceCustom, OpenAI::Models::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam, OpenAI::Models::Beta::BetaToolChoiceApplyPatch, OpenAI::Models::Beta::BetaToolChoiceShell)]
          end

          # @deprecated
          #
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

          module Beta
            extend OpenAI::Internal::Type::Enum

            RESPONSES_MULTI_AGENT_V1 = :"responses_multi_agent=v1"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
