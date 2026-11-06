# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ResponsesDelegationUpdateConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute instructions
        #   Instructions for the delegated Responses model, separate from Live instructions.
        #   See
        #   [backend prompting](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
        #
        #   @return [String, nil]
        optional :instructions, String, nil?: true

        # @!attribute max_output_tokens
        #   Maximum number of output tokens for each delegated response.
        #
        #   @return [Integer, nil]
        optional :max_output_tokens, Integer, nil?: true

        # @!attribute model
        #   The Responses backend model to use for subsequent delegated requests. Omit to
        #   keep the current backend model.
        #
        #   @return [String, nil]
        optional :model, String

        # @!attribute parallel_tool_calls
        #   Whether the delegated Responses model may request multiple tool calls in a
        #   single response.
        #
        #   @return [Boolean, nil]
        optional :parallel_tool_calls, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute reasoning
        #   Reasoning settings passed to each delegated Responses request.
        #
        #   @return [OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning }, nil?: true

        # @!attribute service_tier
        #   Service tier for delegated Responses requests.
        #
        #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ServiceTier, nil]
        optional(
          :service_tier,
          enum: -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier },
          nil?: true
        )

        # @!attribute text
        #   Text generation settings passed to each delegated Responses request.
        #
        #   @return [OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Text, nil]
        optional :text, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Text }, nil?: true

        # @!attribute tool_choice
        #   Controls which tool the Responses backend uses when handling a task delegated by
        #   the Live model.
        #
        #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::FileSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::WebSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::WebSearchPreview, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::Computer, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::Shell, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::Custom, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::ApplyPatch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam, nil]
        optional :tool_choice, union: -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice }

        # @!attribute tools
        #   Tools available to the Responses backend while it handles tasks delegated by the
        #   Live model.
        #
        #   @return [Array<OpenAI::Models::Live::FunctionTool, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::FileSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Mcp, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Custom, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Namespace, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ToolSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Computer, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ApplyPatch>, nil]
        optional(
          :tools,
          -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::ResponsesDelegationUpdateConfig::Tool] }
        )

        # @!method initialize(instructions: nil, max_output_tokens: nil, model: nil, parallel_tool_calls: nil, reasoning: nil, service_tier: nil, text: nil, tool_choice: nil, tools: nil)
        #   Updates to the Responses backend of an existing Live session. Omitted settings
        #   retain their current values.
        #
        #   @param instructions [String, nil]
        #     Instructions for the delegated Responses model, separate from Live instructions.
        #     See
        #     [backend prompting](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
        #
        #   @param max_output_tokens [Integer, nil]
        #     Maximum number of output tokens for each delegated response.
        #
        #   @param model [String]
        #     The Responses backend model to use for subsequent delegated requests. Omit to
        #     keep the current backend model.
        #
        #   @param parallel_tool_calls [Boolean, nil]
        #     Whether the delegated Responses model may request multiple tool calls in a
        #     single response.
        #
        #   @param reasoning [OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Reasoning, nil]
        #     Reasoning settings passed to each delegated Responses request.
        #
        #   @param service_tier [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ServiceTier, nil]
        #     Service tier for delegated Responses requests.
        #
        #   @param text [OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Text, nil]
        #     Text generation settings passed to each delegated Responses request.
        #
        #   @param tool_choice [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::FileSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::WebSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::WebSearchPreview, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::Computer, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::Shell, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::Custom, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::ApplyPatch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam]
        #     Controls which tool the Responses backend uses when handling a task delegated by
        #     the Live model.
        #
        #   @param tools [Array<OpenAI::Models::Live::FunctionTool, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::FileSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Mcp, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Custom, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Namespace, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ToolSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Computer, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ApplyPatch>]
        #     Tools available to the Responses backend while it handles tasks delegated by the
        #     Live model.

        # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig#reasoning
        class Reasoning < OpenAI::Internal::Type::BaseModel
          # @!attribute effort
          #   How much reasoning effort the delegated Responses model should use. Supported
          #   values depend on the backend model.
          #
          #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort, nil]
          optional(
            :effort,
            enum: -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort },
            nil?: true
          )

          # @!attribute summary
          #   The reasoning summary to request from the delegated Responses model, when
          #   supported.
          #
          #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary, nil]
          optional(
            :summary,
            enum: -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary },
            nil?: true
          )

          # @!method initialize(effort: nil, summary: nil)
          #   Reasoning settings passed to each delegated Responses request.
          #
          #   @param effort [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort, nil]
          #     How much reasoning effort the delegated Responses model should use. Supported
          #     values depend on the backend model.
          #
          #   @param summary [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary, nil]
          #     The reasoning summary to request from the delegated Responses model, when
          #     supported.

          # How much reasoning effort the delegated Responses model should use. Supported
          # values depend on the backend model.
          #
          # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Reasoning#effort
          module Effort
            extend OpenAI::Internal::Type::Enum

            NONE = :none
            MINIMAL = :minimal
            LOW = :low
            MEDIUM = :medium
            HIGH = :high
            XHIGH = :xhigh

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The reasoning summary to request from the delegated Responses model, when
          # supported.
          #
          # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Reasoning#summary
          module Summary
            extend OpenAI::Internal::Type::Enum

            CONCISE = :concise
            DETAILED = :detailed
            AUTO = :auto

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # Service tier for delegated Responses requests.
        #
        # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig#service_tier
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DEFAULT = :default
          FAST_TIER_TEMP_PILOT = :fast_tier_temp_pilot
          FLEX = :flex
          PRIORITY = :priority
          ULTRAFAST = :ultrafast

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig#text
        class Text < OpenAI::Internal::Type::BaseModel
          # @!attribute verbosity
          #   The amount of detail in text generated by the Responses backend. This does not
          #   configure the Live model’s spoken delivery.
          #
          #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Text::Verbosity, nil]
          optional(
            :verbosity,
            enum: -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Text::Verbosity },
            nil?: true
          )

          # @!method initialize(verbosity: nil)
          #   Text generation settings passed to each delegated Responses request.
          #
          #   @param verbosity [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Text::Verbosity, nil]
          #     The amount of detail in text generated by the Responses backend. This does not
          #     configure the Live model’s spoken delivery.

          # The amount of detail in text generated by the Responses backend. This does not
          # configure the Live model’s spoken delivery.
          #
          # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Text#verbosity
          module Verbosity
            extend OpenAI::Internal::Type::Enum

            LOW = :low
            MEDIUM = :medium
            HIGH = :high

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # Controls which tool the Responses backend uses when handling a task delegated by
        # the Live model.
        #
        # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig#tool_choice
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          variant enum: -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::FileSearch }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::WebSearch }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::WebSearchPreview }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::ImageGeneration }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::Computer }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::CodeInterpreter }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::ProgrammaticToolCalling }

          # Forces the model to call the shell tool when a tool call is required.
          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::Shell }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::Custom }

          # Forces the model to call the apply_patch tool when executing a tool call.
          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::ApplyPatch }

          variant -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam }

          module LiveToolChoiceEnum
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            NONE = :none
            REQUIRED = :required

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          class LiveFunctionToolChoiceParam < OpenAI::Internal::Type::BaseModel
            # @!attribute name
            #
            #   @return [String]
            required :name, String

            # @!attribute type
            #
            #   @return [Symbol, :function]
            required :type, const: :function

            # @!method initialize(name:, type: :function)
            #   @param name [String]
            #   @param type [Symbol, :function]
          end

          class LiveMCPToolChoiceParam < OpenAI::Internal::Type::BaseModel
            # @!attribute name
            #
            #   @return [String]
            required :name, String

            # @!attribute server_label
            #
            #   @return [String]
            required :server_label, String

            # @!attribute type
            #
            #   @return [Symbol, :mcp]
            required :type, const: :mcp

            # @!method initialize(name:, server_label:, type: :mcp)
            #   @param name [String]
            #   @param server_label [String]
            #   @param type [Symbol, :mcp]
          end

          class FileSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool to call. Always `file_search`.
            #
            #   @return [Symbol, :file_search]
            required :type, const: :file_search

            # @!method initialize(type: :file_search)
            #   @param type [Symbol, :file_search]
            #     The tool to call. Always `file_search`.
          end

          class WebSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool to call. Always `web_search`.
            #
            #   @return [Symbol, :web_search]
            required :type, const: :web_search

            # @!method initialize(type: :web_search)
            #   @param type [Symbol, :web_search]
            #     The tool to call. Always `web_search`.
          end

          class WebSearchPreview < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool to call. Always `web_search_preview`.
            #
            #   @return [Symbol, :web_search_preview]
            required :type, const: :web_search_preview

            # @!method initialize(type: :web_search_preview)
            #   @param type [Symbol, :web_search_preview]
            #     The tool to call. Always `web_search_preview`.
          end

          class ImageGeneration < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool to call. Always `image_generation`.
            #
            #   @return [Symbol, :image_generation]
            required :type, const: :image_generation

            # @!method initialize(type: :image_generation)
            #   @param type [Symbol, :image_generation]
            #     The tool to call. Always `image_generation`.
          end

          class Computer < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool to call. Always `computer`.
            #
            #   @return [Symbol, :computer]
            required :type, const: :computer

            # @!method initialize(type: :computer)
            #   @param type [Symbol, :computer]
            #     The tool to call. Always `computer`.
          end

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool to call. Always `code_interpreter`.
            #
            #   @return [Symbol, :code_interpreter]
            required :type, const: :code_interpreter

            # @!method initialize(type: :code_interpreter)
            #   @param type [Symbol, :code_interpreter]
            #     The tool to call. Always `code_interpreter`.
          end

          class ProgrammaticToolCalling < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool to call. Always `programmatic_tool_calling`.
            #
            #   @return [Symbol, :programmatic_tool_calling]
            required :type, const: :programmatic_tool_calling

            # @!method initialize(type: :programmatic_tool_calling)
            #   @param type [Symbol, :programmatic_tool_calling]
            #     The tool to call. Always `programmatic_tool_calling`.
          end

          class Shell < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool to call. Always `shell`.
            #
            #   @return [Symbol, :shell]
            required :type, const: :shell

            # @!method initialize(type: :shell)
            #   Forces the model to call the shell tool when a tool call is required.
            #
            #   @param type [Symbol, :shell]
            #     The tool to call. Always `shell`.
          end

          class Custom < OpenAI::Internal::Type::BaseModel
            # @!attribute name
            #   The name of the custom tool to call.
            #
            #   @return [String]
            required :name, String

            # @!attribute type
            #   The tool to call. Always `custom`.
            #
            #   @return [Symbol, :custom]
            required :type, const: :custom

            # @!method initialize(name:, type: :custom)
            #   @param name [String]
            #     The name of the custom tool to call.
            #
            #   @param type [Symbol, :custom]
            #     The tool to call. Always `custom`.
          end

          class ApplyPatch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool to call. Always `apply_patch`.
            #
            #   @return [Symbol, :apply_patch]
            required :type, const: :apply_patch

            # @!method initialize(type: :apply_patch)
            #   Forces the model to call the apply_patch tool when executing a tool call.
            #
            #   @param type [Symbol, :apply_patch]
            #     The tool to call. Always `apply_patch`.
          end

          class LiveAllowedToolsChoiceParam < OpenAI::Internal::Type::BaseModel
            # @!attribute tools
            #   The tools that the delegated Responses model may call.
            #
            #   @return [Array<OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Function, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Mcp, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::FileSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::WebSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::WebSearchPreview, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Computer, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Shell, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Custom, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ApplyPatch>]
            required(
              :tools,
              -> {
                OpenAI::Internal::Type::ArrayOf[
                  union: OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool
                ]
              }
            )

            # @!attribute type
            #   The tool choice type. Always `allowed_tools`.
            #
            #   @return [Symbol, :allowed_tools]
            required :type, const: :allowed_tools

            # @!attribute mode
            #   How to select a tool from the allowed set.
            #
            #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Mode, nil]
            optional(
              :mode,
              enum: -> {
                OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Mode
              },
              nil?: true
            )

            # @!method initialize(tools:, mode: nil, type: :allowed_tools)
            #   @param tools [Array<OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Function, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Mcp, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::FileSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::WebSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::WebSearchPreview, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Computer, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Shell, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Custom, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ApplyPatch>]
            #     The tools that the delegated Responses model may call.
            #
            #   @param mode [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Mode, nil]
            #     How to select a tool from the allowed set.
            #
            #   @param type [Symbol, :allowed_tools]
            #     The tool choice type. Always `allowed_tools`.

            # Forces the model to call the shell tool when a tool call is required.
            module Tool
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant(
                :function,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Function
                }
              )

              variant(
                :mcp,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Mcp
                }
              )

              variant(
                :file_search,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::FileSearch
                }
              )

              variant(
                :web_search,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::WebSearch
                }
              )

              variant(
                :web_search_preview,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::WebSearchPreview
                }
              )

              variant(
                :image_generation,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ImageGeneration
                }
              )

              variant(
                :computer,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Computer
                }
              )

              variant(
                :code_interpreter,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::CodeInterpreter
                }
              )

              variant(
                :programmatic_tool_calling,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ProgrammaticToolCalling
                }
              )

              # Forces the model to call the shell tool when a tool call is required.
              variant(
                :shell,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Shell
                }
              )

              variant(
                :custom,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Custom
                }
              )

              # Forces the model to call the apply_patch tool when executing a tool call.
              variant(
                :apply_patch,
                -> {
                  OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ApplyPatch
                }
              )

              class Function < OpenAI::Internal::Type::BaseModel
                # @!attribute name
                #
                #   @return [String]
                required :name, String

                # @!attribute type
                #
                #   @return [Symbol, :function]
                required :type, const: :function

                # @!method initialize(name:, type: :function)
                #   @param name [String]
                #   @param type [Symbol, :function]
              end

              class Mcp < OpenAI::Internal::Type::BaseModel
                # @!attribute name
                #
                #   @return [String]
                required :name, String

                # @!attribute server_label
                #
                #   @return [String]
                required :server_label, String

                # @!attribute type
                #
                #   @return [Symbol, :mcp]
                required :type, const: :mcp

                # @!method initialize(name:, server_label:, type: :mcp)
                #   @param name [String]
                #   @param server_label [String]
                #   @param type [Symbol, :mcp]
              end

              class FileSearch < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The tool to call. Always `file_search`.
                #
                #   @return [Symbol, :file_search]
                required :type, const: :file_search

                # @!method initialize(type: :file_search)
                #   @param type [Symbol, :file_search]
                #     The tool to call. Always `file_search`.
              end

              class WebSearch < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The tool to call. Always `web_search`.
                #
                #   @return [Symbol, :web_search]
                required :type, const: :web_search

                # @!method initialize(type: :web_search)
                #   @param type [Symbol, :web_search]
                #     The tool to call. Always `web_search`.
              end

              class WebSearchPreview < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The tool to call. Always `web_search_preview`.
                #
                #   @return [Symbol, :web_search_preview]
                required :type, const: :web_search_preview

                # @!method initialize(type: :web_search_preview)
                #   @param type [Symbol, :web_search_preview]
                #     The tool to call. Always `web_search_preview`.
              end

              class ImageGeneration < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The tool to call. Always `image_generation`.
                #
                #   @return [Symbol, :image_generation]
                required :type, const: :image_generation

                # @!method initialize(type: :image_generation)
                #   @param type [Symbol, :image_generation]
                #     The tool to call. Always `image_generation`.
              end

              class Computer < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The tool to call. Always `computer`.
                #
                #   @return [Symbol, :computer]
                required :type, const: :computer

                # @!method initialize(type: :computer)
                #   @param type [Symbol, :computer]
                #     The tool to call. Always `computer`.
              end

              class CodeInterpreter < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The tool to call. Always `code_interpreter`.
                #
                #   @return [Symbol, :code_interpreter]
                required :type, const: :code_interpreter

                # @!method initialize(type: :code_interpreter)
                #   @param type [Symbol, :code_interpreter]
                #     The tool to call. Always `code_interpreter`.
              end

              class ProgrammaticToolCalling < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The tool to call. Always `programmatic_tool_calling`.
                #
                #   @return [Symbol, :programmatic_tool_calling]
                required :type, const: :programmatic_tool_calling

                # @!method initialize(type: :programmatic_tool_calling)
                #   @param type [Symbol, :programmatic_tool_calling]
                #     The tool to call. Always `programmatic_tool_calling`.
              end

              class Shell < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The tool to call. Always `shell`.
                #
                #   @return [Symbol, :shell]
                required :type, const: :shell

                # @!method initialize(type: :shell)
                #   Forces the model to call the shell tool when a tool call is required.
                #
                #   @param type [Symbol, :shell]
                #     The tool to call. Always `shell`.
              end

              class Custom < OpenAI::Internal::Type::BaseModel
                # @!attribute name
                #   The name of the custom tool to call.
                #
                #   @return [String]
                required :name, String

                # @!attribute type
                #   The tool to call. Always `custom`.
                #
                #   @return [Symbol, :custom]
                required :type, const: :custom

                # @!method initialize(name:, type: :custom)
                #   @param name [String]
                #     The name of the custom tool to call.
                #
                #   @param type [Symbol, :custom]
                #     The tool to call. Always `custom`.
              end

              class ApplyPatch < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The tool to call. Always `apply_patch`.
                #
                #   @return [Symbol, :apply_patch]
                required :type, const: :apply_patch

                # @!method initialize(type: :apply_patch)
                #   Forces the model to call the apply_patch tool when executing a tool call.
                #
                #   @param type [Symbol, :apply_patch]
                #     The tool to call. Always `apply_patch`.
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Function, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Mcp, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::FileSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::WebSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::WebSearchPreview, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Computer, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Shell, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::Custom, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam::Tool::ApplyPatch)]
            end

            # How to select a tool from the allowed set.
            #
            # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam#mode
            module Mode
              extend OpenAI::Internal::Type::Enum

              NONE = :none
              AUTO = :auto
              REQUIRED = :required

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @!method self.variants
          #   @return [Array(Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::FileSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::WebSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::WebSearchPreview, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::Computer, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::Shell, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::Custom, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::ApplyPatch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveAllowedToolsChoiceParam)]
        end

        # A function tool available to the Responses backend when the Live model delegates
        # a task.
        module Tool
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A function tool available to the Responses backend when the Live model delegates a task.
          variant :function, -> { OpenAI::Live::FunctionTool }

          # A web search tool available to the Live session’s Responses backend.
          variant :web_search, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch }

          variant :file_search, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::FileSearch }

          variant :code_interpreter, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::CodeInterpreter }

          # A Responses shell tool. Use a hosted container or return local shell results with response.item.create. Domain secrets are not supported.
          variant :shell, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell }

          variant :image_generation, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::ImageGeneration }

          variant :mcp, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Mcp }

          variant :custom, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Custom }

          variant :namespace, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Namespace }

          variant :tool_search, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::ToolSearch }

          variant(
            :programmatic_tool_calling,
            -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::ProgrammaticToolCalling }
          )

          variant :computer, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Computer }

          variant :apply_patch, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::ApplyPatch }

          class WebSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The tool type. Always `web_search`.
            #
            #   @return [Symbol, :web_search]
            required :type, const: :web_search

            # @!method initialize(type: :web_search)
            #   A web search tool available to the Live session’s Responses backend.
            #
            #   @param type [Symbol, :web_search]
            #     The tool type. Always `web_search`.
          end

          class FileSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :file_search]
            required :type, const: :file_search

            # @!method initialize(type: :file_search)
            #   @param type [Symbol, :file_search]
          end

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :code_interpreter]
            required :type, const: :code_interpreter

            # @!method initialize(type: :code_interpreter)
            #   @param type [Symbol, :code_interpreter]
          end

          class Shell < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :shell]
            required :type, const: :shell

            # @!attribute environment
            #
            #   @return [OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerReference, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::Local, nil]
            optional(
              :environment,
              union: -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment },
              nil?: true
            )

            # @!method initialize(environment: nil, type: :shell)
            #   A Responses shell tool. Use a hosted container or return local shell results
            #   with response.item.create. Domain secrets are not supported.
            #
            #   @param environment [OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerReference, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::Local, nil]
            #   @param type [Symbol, :shell]

            # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell#environment
            module Environment
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant(
                :container_auto,
                -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto }
              )

              variant(
                :container_reference,
                -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerReference }
              )

              variant :local, -> { OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::Local }

              class ContainerAuto < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   Automatically creates a container for this request
                #
                #   @return [Symbol, :container_auto]
                required :type, const: :container_auto

                # @!attribute file_ids
                #   An optional list of uploaded files to make available to your code.
                #
                #   @return [Array<String>, nil]
                optional :file_ids, OpenAI::Internal::Type::ArrayOf[String], nil?: true

                # @!attribute memory_limit
                #   The memory limit for the container.
                #
                #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit, nil]
                optional(
                  :memory_limit,
                  enum: -> {
                    OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit
                  },
                  nil?: true
                )

                # @!attribute network_policy
                #   Network access policy for the container.
                #
                #   @return [OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist, nil]
                optional(
                  :network_policy,
                  union: -> {
                    OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy
                  },
                  nil?: true
                )

                # @!attribute skills
                #   An optional list of skills referenced by id or inline data.
                #
                #   @return [Array<OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline>, nil]
                optional(
                  :skills,
                  -> {
                    OpenAI::Internal::Type::ArrayOf[
                      union: OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill
                    ]
                  },
                  nil?: true
                )

                # @!method initialize(file_ids: nil, memory_limit: nil, network_policy: nil, skills: nil, type: :container_auto)
                #   @param file_ids [Array<String>, nil]
                #     An optional list of uploaded files to make available to your code.
                #
                #   @param memory_limit [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::MemoryLimit, nil]
                #     The memory limit for the container.
                #
                #   @param network_policy [OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist, nil]
                #     Network access policy for the container.
                #
                #   @param skills [Array<OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline>, nil]
                #     An optional list of skills referenced by id or inline data.
                #
                #   @param type [Symbol, :container_auto]
                #     Automatically creates a container for this request

                # The memory limit for the container.
                #
                # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto#memory_limit
                module MemoryLimit
                  extend OpenAI::Internal::Type::Enum

                  MEMORY_LIMIT_1G = :"1g"
                  MEMORY_LIMIT_4G = :"4g"
                  MEMORY_LIMIT_16G = :"16g"
                  MEMORY_LIMIT_64G = :"64g"

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end

                # Network access policy for the container.
                #
                # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto#network_policy
                module NetworkPolicy
                  extend OpenAI::Internal::Type::Union

                  discriminator :type

                  variant(
                    :disabled,
                    -> {
                      OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled
                    }
                  )

                  variant(
                    :allowlist,
                    -> {
                      OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist
                    }
                  )

                  class Disabled < OpenAI::Internal::Type::BaseModel
                    # @!attribute type
                    #   Disable outbound network access. Always `disabled`.
                    #
                    #   @return [Symbol, :disabled]
                    required :type, const: :disabled

                    # @!method initialize(type: :disabled)
                    #   @param type [Symbol, :disabled]
                    #     Disable outbound network access. Always `disabled`.
                  end

                  class Allowlist < OpenAI::Internal::Type::BaseModel
                    # @!attribute allowed_domains
                    #   A list of allowed domains when type is `allowlist`.
                    #
                    #   @return [Array<String>]
                    required :allowed_domains, OpenAI::Internal::Type::ArrayOf[String]

                    # @!attribute type
                    #   Allow outbound network access only to specified domains. Always `allowlist`.
                    #
                    #   @return [Symbol, :allowlist]
                    required :type, const: :allowlist

                    # @!method initialize(allowed_domains:, type: :allowlist)
                    #   @param allowed_domains [Array<String>]
                    #     A list of allowed domains when type is `allowlist`.
                    #
                    #   @param type [Symbol, :allowlist]
                    #     Allow outbound network access only to specified domains. Always `allowlist`.
                  end

                  # @!method self.variants
                  #   @return [Array(OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Disabled, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::NetworkPolicy::Allowlist)]
                end

                module Skill
                  extend OpenAI::Internal::Type::Union

                  discriminator :type

                  variant(
                    :skill_reference,
                    -> {
                      OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference
                    }
                  )

                  variant(
                    :inline,
                    -> {
                      OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline
                    }
                  )

                  class SkillReference < OpenAI::Internal::Type::BaseModel
                    # @!attribute skill_id
                    #   The ID of the referenced skill.
                    #
                    #   @return [String]
                    required :skill_id, String

                    # @!attribute type
                    #   References a skill created with the /v1/skills endpoint.
                    #
                    #   @return [Symbol, :skill_reference]
                    required :type, const: :skill_reference

                    # @!attribute version
                    #   Optional skill version. Use a positive integer or 'latest'. Omit for default.
                    #
                    #   @return [String, nil]
                    optional :version, String, nil?: true

                    # @!method initialize(skill_id:, version: nil, type: :skill_reference)
                    #   @param skill_id [String]
                    #     The ID of the referenced skill.
                    #
                    #   @param version [String, nil]
                    #     Optional skill version. Use a positive integer or 'latest'. Omit for default.
                    #
                    #   @param type [Symbol, :skill_reference]
                    #     References a skill created with the /v1/skills endpoint.
                  end

                  class Inline < OpenAI::Internal::Type::BaseModel
                    # @!attribute description
                    #   The description of the skill.
                    #
                    #   @return [String]
                    required :description, String

                    # @!attribute name
                    #   The name of the skill.
                    #
                    #   @return [String]
                    required :name, String

                    # @!attribute source
                    #   Inline skill payload
                    #
                    #   @return [OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source]
                    required(
                      :source,
                      -> {
                        OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source
                      }
                    )

                    # @!attribute type
                    #   Defines an inline skill for this request.
                    #
                    #   @return [Symbol, :inline]
                    required :type, const: :inline

                    # @!method initialize(description:, name:, source:, type: :inline)
                    #   @param description [String]
                    #     The description of the skill.
                    #
                    #   @param name [String]
                    #     The name of the skill.
                    #
                    #   @param source [OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source]
                    #     Inline skill payload
                    #
                    #   @param type [Symbol, :inline]
                    #     Defines an inline skill for this request.

                    # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline#source
                    class Source < OpenAI::Internal::Type::BaseModel
                      # @!attribute data
                      #   Base64-encoded skill zip bundle.
                      #
                      #   @return [String]
                      required :data, String

                      # @!attribute media_type
                      #   The media type of the inline skill payload. Must be `application/zip`.
                      #
                      #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source::MediaType]
                      required(
                        :media_type,
                        enum: -> {
                          OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source::MediaType
                        }
                      )

                      # @!attribute type
                      #   The type of the inline skill source. Must be `base64`.
                      #
                      #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source::Type]
                      required(
                        :type,
                        enum: -> {
                          OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source::Type
                        }
                      )

                      # @!method initialize(data:, media_type:, type:)
                      #   Inline skill payload
                      #
                      #   @param data [String]
                      #     Base64-encoded skill zip bundle.
                      #
                      #   @param media_type [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source::MediaType]
                      #     The media type of the inline skill payload. Must be `application/zip`.
                      #
                      #   @param type [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source::Type]
                      #     The type of the inline skill source. Must be `base64`.

                      # The media type of the inline skill payload. Must be `application/zip`.
                      #
                      # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source#media_type
                      module MediaType
                        extend OpenAI::Internal::Type::Enum

                        APPLICATION_ZIP = :"application/zip"

                        # @!method self.values
                        #   @return [Array<Symbol>]
                      end

                      # The type of the inline skill source. Must be `base64`.
                      #
                      # @see OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline::Source#type
                      module Type
                        extend OpenAI::Internal::Type::Enum

                        BASE64 = :base64

                        # @!method self.values
                        #   @return [Array<Symbol>]
                      end
                    end
                  end

                  # @!method self.variants
                  #   @return [Array(OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::SkillReference, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto::Skill::Inline)]
                end
              end

              class ContainerReference < OpenAI::Internal::Type::BaseModel
                # @!attribute container_id
                #   The ID of the referenced container.
                #
                #   @return [String]
                required :container_id, String

                # @!attribute type
                #   References a container created with the /v1/containers endpoint
                #
                #   @return [Symbol, :container_reference]
                required :type, const: :container_reference

                # @!method initialize(container_id:, type: :container_reference)
                #   @param container_id [String]
                #     The ID of the referenced container.
                #
                #   @param type [Symbol, :container_reference]
                #     References a container created with the /v1/containers endpoint
              end

              class Local < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   Use a local computer environment.
                #
                #   @return [Symbol, :local]
                required :type, const: :local

                # @!attribute skills
                #   An optional list of skills.
                #
                #   @return [Array<OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::Local::Skill>, nil]
                optional(
                  :skills,
                  -> {
                    OpenAI::Internal::Type::ArrayOf[
                      OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::Local::Skill
                    ]
                  },
                  nil?: true
                )

                # @!method initialize(skills: nil, type: :local)
                #   @param skills [Array<OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::Local::Skill>, nil]
                #     An optional list of skills.
                #
                #   @param type [Symbol, :local]
                #     Use a local computer environment.
                class Skill < OpenAI::Internal::Type::BaseModel
                  # @!attribute description
                  #   The description of the skill.
                  #
                  #   @return [String]
                  required :description, String

                  # @!attribute name
                  #   The name of the skill.
                  #
                  #   @return [String]
                  required :name, String

                  # @!attribute path
                  #   The path to the directory containing the skill.
                  #
                  #   @return [String]
                  required :path, String

                  # @!method initialize(description:, name:, path:)
                  #   @param description [String]
                  #     The description of the skill.
                  #
                  #   @param name [String]
                  #     The name of the skill.
                  #
                  #   @param path [String]
                  #     The path to the directory containing the skill.
                end
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerAuto, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::ContainerReference, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell::Environment::Local)]
            end
          end

          class ImageGeneration < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :image_generation]
            required :type, const: :image_generation

            # @!method initialize(type: :image_generation)
            #   @param type [Symbol, :image_generation]
          end

          class Mcp < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :mcp]
            required :type, const: :mcp

            # @!method initialize(type: :mcp)
            #   @param type [Symbol, :mcp]
          end

          class Custom < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :custom]
            required :type, const: :custom

            # @!method initialize(type: :custom)
            #   @param type [Symbol, :custom]
          end

          class Namespace < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :namespace]
            required :type, const: :namespace

            # @!method initialize(type: :namespace)
            #   @param type [Symbol, :namespace]
          end

          class ToolSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :tool_search]
            required :type, const: :tool_search

            # @!method initialize(type: :tool_search)
            #   @param type [Symbol, :tool_search]
          end

          class ProgrammaticToolCalling < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :programmatic_tool_calling]
            required :type, const: :programmatic_tool_calling

            # @!method initialize(type: :programmatic_tool_calling)
            #   @param type [Symbol, :programmatic_tool_calling]
          end

          class Computer < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :computer]
            required :type, const: :computer

            # @!method initialize(type: :computer)
            #   @param type [Symbol, :computer]
          end

          class ApplyPatch < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :apply_patch]
            required :type, const: :apply_patch

            # @!method initialize(type: :apply_patch)
            #   @param type [Symbol, :apply_patch]
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Live::FunctionTool, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::FileSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::CodeInterpreter, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Shell, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ImageGeneration, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Mcp, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Custom, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Namespace, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ToolSearch, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ProgrammaticToolCalling, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::Computer, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::ApplyPatch)]
        end
      end
    end
  end
end
