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
        #   @return [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam, nil]
        optional :tool_choice, union: -> { OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice }

        # @!attribute tools
        #   Tools available to the Responses backend while it handles tasks delegated by the
        #   Live model.
        #
        #   @return [Array<OpenAI::Models::Live::FunctionTool, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch>, nil]
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
        #   @param tool_choice [Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam]
        #     Controls which tool the Responses backend uses when handling a task delegated by
        #     the Live model.
        #
        #   @param tools [Array<OpenAI::Models::Live::FunctionTool, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch>]
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

          # @!method self.variants
          #   @return [Array(Symbol, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam)]
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

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Live::FunctionTool, OpenAI::Models::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch)]
        end
      end
    end
  end
end
