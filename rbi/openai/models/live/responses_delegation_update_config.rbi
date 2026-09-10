# typed: strong

module OpenAI
  module Models

    module Live

      class ResponsesDelegationUpdateConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ResponsesDelegationUpdateConfig,
            OpenAI::Internal::AnyHash
          )
        end

        # Instructions for the delegated Responses model, separate from Live instructions.
        # See
        # [backend prompting](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # Maximum number of output tokens for each delegated response.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :max_output_tokens

        # The Responses backend model to use for subsequent delegated requests. Omit to
        # keep the current backend model.
        sig { returns(T.nilable(String)) }
        attr_reader :model

        sig { params(model: String).void }
        attr_writer :model

        # Whether the delegated Responses model may request multiple tool calls in a
        # single response.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :parallel_tool_calls

        # Reasoning settings passed to each delegated Responses request.
        sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::OrHash)).void }
        attr_writer :reasoning

        # Service tier for delegated Responses requests.
        sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier::OrSymbol)) }
        attr_accessor :service_tier

        # Text generation settings passed to each delegated Responses request.
        sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Text)) }
        attr_reader :text

        sig { params(text: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Text::OrHash)).void }
        attr_writer :text

        # Controls which tool the Responses backend uses when handling a task delegated by
        # the Live model.
        sig {
          returns(
            T.nilable(
              T.any(
                OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum::OrSymbol,
                OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam,
                OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam
              )
            )
          )
        }
        attr_reader :tool_choice

        sig {
          params(
            tool_choice: T.any(
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum::OrSymbol,
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam::OrHash,
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam::OrHash
            )
          )
            .void
        }
        attr_writer :tool_choice

        # Tools available to the Responses backend while it handles tasks delegated by the
        # Live model.
        sig {
          returns(
            T.nilable(
              T::Array[
                T.any(OpenAI::Live::FunctionTool, OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch)
              ]
            )
          )
        }
        attr_reader :tools

        sig {
          params(
            tools: T::Array[
              T.any(
                OpenAI::Live::FunctionTool::OrHash,
                OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch::OrHash
              )
            ]
          )
            .void
        }
        attr_writer :tools

        # Updates to the Responses backend of an existing Live session. Omitted settings
        # retain their current values.
        sig do
          params(

            instructions: T.nilable(String),

            max_output_tokens: T.nilable(Integer),

            model: String,

            parallel_tool_calls: T.nilable(T::Boolean),

            reasoning: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::OrHash),

            service_tier: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier::OrSymbol),

            text: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Text::OrHash),

            tool_choice: T.any(
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum::OrSymbol,
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam::OrHash,
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam::OrHash
            ),

            tools: T::Array[
              T.any(
                OpenAI::Live::FunctionTool::OrHash,
                OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch::OrHash
              )
            ]
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Instructions for the delegated Responses model, separate from Live instructions.
          # See
          # [backend prompting](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
          instructions: nil,

          # Maximum number of output tokens for each delegated response.
          max_output_tokens: nil,

          # The Responses backend model to use for subsequent delegated requests. Omit to
          # keep the current backend model.
          model: nil,

          # Whether the delegated Responses model may request multiple tool calls in a
          # single response.
          parallel_tool_calls: nil,

          # Reasoning settings passed to each delegated Responses request.
          reasoning: nil,

          # Service tier for delegated Responses requests.
          service_tier: nil,

          # Text generation settings passed to each delegated Responses request.
          text: nil,

          # Controls which tool the Responses backend uses when handling a task delegated by
          # the Live model.
          tool_choice: nil,

          # Tools available to the Responses backend while it handles tasks delegated by the
          # Live model.

          tools: nil
        )
        end

        sig do
          override.returns(
            {
              instructions: T.nilable(String),
              max_output_tokens: T.nilable(Integer),
              model: String,
              parallel_tool_calls: T.nilable(T::Boolean),
              reasoning: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning),
              service_tier: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier::OrSymbol),
              text: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Text),
              tool_choice: T.any(
                OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum::OrSymbol,
                OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam,
                OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam
              ),
              tools: T::Array[
                T.any(OpenAI::Live::FunctionTool, OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch)
              ]
            }
          )
        end
        def to_hash
        end

        class Reasoning < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning,
              OpenAI::Internal::AnyHash
            )
          end

          # How much reasoning effort the delegated Responses model should use. Supported
          # values depend on the backend model.
          sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort::OrSymbol)) }
          attr_accessor :effort

          # The reasoning summary to request from the delegated Responses model, when
          # supported.
          sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary::OrSymbol)) }
          attr_accessor :summary

          # Reasoning settings passed to each delegated Responses request.
          sig do
            params(

              effort: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort::OrSymbol),

              summary: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary::OrSymbol)
            )
              .returns(T.attached_class)
          end
          def self.new(

            # How much reasoning effort the delegated Responses model should use. Supported
            # values depend on the backend model.
            effort: nil,

            # The reasoning summary to request from the delegated Responses model, when
            # supported.

            summary: nil
          )
          end

          sig do
            override.returns(
              {
                effort: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort::OrSymbol),
                summary: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary::OrSymbol)
              }
            )
          end
          def to_hash
          end

          # How much reasoning effort the delegated Responses model should use. Supported
          # values depend on the backend model.
          module Effort
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            NONE = T.let(:none, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort::TaggedSymbol)
            MINIMAL = T.let(:minimal, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort::TaggedSymbol)
            LOW = T.let(:low, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort::TaggedSymbol)
            MEDIUM = T.let(:medium, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort::TaggedSymbol)
            XHIGH = T.let(:xhigh, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Effort::TaggedSymbol])
            }
            def self.values
            end
          end

          # The reasoning summary to request from the delegated Responses model, when
          # supported.
          module Summary
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CONCISE = T.let(:concise, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary::TaggedSymbol)
            DETAILED = T.let(:detailed, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary::TaggedSymbol)
            AUTO = T.let(:auto, OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary::TaggedSymbol)

            sig {
              override.returns(
                T::Array[OpenAI::Live::ResponsesDelegationUpdateConfig::Reasoning::Summary::TaggedSymbol]
              )
            }
            def self.values
            end
          end
        end

        # Service tier for delegated Responses requests.
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO = T.let(:auto, OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier::TaggedSymbol)
          DEFAULT = T.let(:default, OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier::TaggedSymbol)
          FAST_TIER_TEMP_PILOT = T.let(
            :fast_tier_temp_pilot,
            OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier::TaggedSymbol
          )
          FLEX = T.let(:flex, OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier::TaggedSymbol)
          PRIORITY = T.let(:priority, OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier::TaggedSymbol)
          ULTRAFAST = T.let(:ultrafast, OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Live::ResponsesDelegationUpdateConfig::ServiceTier::TaggedSymbol]) }
          def self.values
          end
        end

        class Text < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ResponsesDelegationUpdateConfig::Text,
              OpenAI::Internal::AnyHash
            )
          end

          # The amount of detail in text generated by the Responses backend. This does not
          # configure the Live model’s spoken delivery.
          sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Text::Verbosity::OrSymbol)) }
          attr_accessor :verbosity

          # Text generation settings passed to each delegated Responses request.
          sig do
            params(

              verbosity: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Text::Verbosity::OrSymbol)
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The amount of detail in text generated by the Responses backend. This does not
            # configure the Live model’s spoken delivery.

            verbosity: nil
          )
          end

          sig do
            override.returns(
              {verbosity: T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig::Text::Verbosity::OrSymbol)}
            )
          end
          def to_hash
          end

          # The amount of detail in text generated by the Responses backend. This does not
          # configure the Live model’s spoken delivery.
          module Verbosity
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Live::ResponsesDelegationUpdateConfig::Text::Verbosity)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            LOW = T.let(:low, OpenAI::Live::ResponsesDelegationUpdateConfig::Text::Verbosity::TaggedSymbol)
            MEDIUM = T.let(:medium, OpenAI::Live::ResponsesDelegationUpdateConfig::Text::Verbosity::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Live::ResponsesDelegationUpdateConfig::Text::Verbosity::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Live::ResponsesDelegationUpdateConfig::Text::Verbosity::TaggedSymbol])
            }
            def self.values
            end
          end
        end

        # Controls which tool the Responses backend uses when handling a task delegated by
        # the Live model.
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum::TaggedSymbol,
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam,
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam
            )
          }

          module LiveToolChoiceEnum
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO = T.let(
              :auto,
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum::TaggedSymbol
            )
            NONE = T.let(
              :none,
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum::TaggedSymbol
            )
            REQUIRED = T.let(
              :required,
              OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum::TaggedSymbol
            )

            sig {
              override.returns(
                T::Array[OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveToolChoiceEnum::TaggedSymbol]
              )
            }
            def self.values
            end
          end

          class LiveFunctionToolChoiceParam < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveFunctionToolChoiceParam,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :name

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                name: String,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              name:,

              type: :function
            )
            end

            sig do
              override.returns(
                {name: String, type: Symbol}
              )
            end
            def to_hash
            end

          end

          class LiveMCPToolChoiceParam < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::LiveMCPToolChoiceParam,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :name

            sig { returns(String) }
            attr_accessor :server_label

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                name: String,

                server_label: String,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              name:,

              server_label:,

              type: :mcp
            )
            end

            sig do
              override.returns(
                {name: String, server_label: String, type: Symbol}
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::Variants]) }
          def self.variants
          end

        end

        # A function tool available to the Responses backend when the Live model delegates
        # a task.
        module Tool
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(OpenAI::Live::FunctionTool, OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch)
          }

          class WebSearch < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::WebSearch,
                OpenAI::Internal::AnyHash
              )
            end

            # The tool type. Always `web_search`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A web search tool available to the Live session’s Responses backend.
            sig do
              params(

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The tool type. Always `web_search`.

              type: :web_search
            )
            end

            sig do
              override.returns(
                {type: Symbol}
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Live::ResponsesDelegationUpdateConfig::Tool::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
