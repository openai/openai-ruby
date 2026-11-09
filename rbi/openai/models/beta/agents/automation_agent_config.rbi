# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class AutomationAgentConfig < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::AutomationAgentConfig,
              OpenAI::Internal::AnyHash
            )
          end

          # Custom instructions, or null when absent.
          sig { returns(T.nilable(String)) }
          attr_accessor :instructions

          # The requested model name.
          sig { returns(String) }
          attr_accessor :model

          # The configuration for creating and coordinating subagents.
          sig { returns(OpenAI::Beta::MultiAgentConfig) }
          attr_reader :multi_agent

          sig { params(multi_agent: OpenAI::Beta::MultiAgentConfig::OrHash).void }
          attr_writer :multi_agent

          # The configured reasoning policy.
          sig { returns(OpenAI::Beta::AgentReasoning) }
          attr_reader :reasoning

          sig { params(reasoning: OpenAI::Beta::AgentReasoning::OrHash).void }
          attr_writer :reasoning

          # The configured service-tier policy.
          sig { returns(OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier::TaggedSymbol) }
          attr_accessor :service_tier

          # The configured output format and verbosity.
          sig { returns(OpenAI::Beta::AgentText) }
          attr_reader :text

          sig { params(text: OpenAI::Beta::AgentText::OrHash).void }
          attr_writer :text

          # Configured tools, excluding confidential credentials.
          sig { returns(T::Array[OpenAI::Beta::AgentTool::Variants]) }
          attr_accessor :tools

          # The effective context compaction settings.
          sig { returns(T.nilable(OpenAI::Beta::Agents::AutomationAgentConfig::Compaction)) }
          attr_reader :compaction

          sig { params(compaction: OpenAI::Beta::Agents::AutomationAgentConfig::Compaction::OrHash).void }
          attr_writer :compaction

          # The effective experimental settings for the agent.
          sig { returns(T.nilable(OpenAI::Beta::Agents::AutomationAgentConfig::Experimental)) }
          attr_reader :experimental

          sig { params(experimental: OpenAI::Beta::Agents::AutomationAgentConfig::Experimental::OrHash).void }
          attr_writer :experimental

          # Inline agent configuration without a generated session-local identity.
          sig do
            params(

              instructions: T.nilable(String),

              model: String,

              multi_agent: OpenAI::Beta::MultiAgentConfig::OrHash,

              reasoning: OpenAI::Beta::AgentReasoning::OrHash,

              service_tier: OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier::OrSymbol,

              text: OpenAI::Beta::AgentText::OrHash,

              tools: T::Array[
                T.any(
                  OpenAI::Beta::AgentTool::Function::OrHash,
                  OpenAI::Beta::AgentTool::ProgrammaticToolCalling::OrHash,
                  OpenAI::Beta::AgentTool::Mcp::OrHash,
                  OpenAI::Beta::AgentTool::WebSearch::OrHash,
                  OpenAI::Beta::AgentTool::ComputerUse::OrHash,
                  OpenAI::Beta::AgentTool::Automations::OrHash
                )
              ],

              compaction: OpenAI::Beta::Agents::AutomationAgentConfig::Compaction::OrHash,

              experimental: OpenAI::Beta::Agents::AutomationAgentConfig::Experimental::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Custom instructions, or null when absent.
            instructions:,

            # The requested model name.
            model:,

            # The configuration for creating and coordinating subagents.
            multi_agent:,

            # The configured reasoning policy.
            reasoning:,

            # The configured service-tier policy.
            service_tier:,

            # The configured output format and verbosity.
            text:,

            # Configured tools, excluding confidential credentials.
            tools:,

            # The effective context compaction settings.
            compaction: nil,

            # The effective experimental settings for the agent.

            experimental: nil
          )
          end

          sig do
            override.returns(
              {
                instructions: T.nilable(String),
                model: String,
                multi_agent: OpenAI::Beta::MultiAgentConfig,
                reasoning: OpenAI::Beta::AgentReasoning,
                service_tier: OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier::TaggedSymbol,
                text: OpenAI::Beta::AgentText,
                tools: T::Array[OpenAI::Beta::AgentTool::Variants],
                compaction: OpenAI::Beta::Agents::AutomationAgentConfig::Compaction,
                experimental: OpenAI::Beta::Agents::AutomationAgentConfig::Experimental
              }
            )
          end
          def to_hash
          end

          # The configured service-tier policy.
          module ServiceTier
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO = T.let(:auto, OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier::TaggedSymbol)
            DEFAULT = T.let(:default, OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier::TaggedSymbol)
            FLEX = T.let(:flex, OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier::TaggedSymbol)
            PRIORITY = T.let(:priority, OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier::TaggedSymbol)
            FAST = T.let(:fast, OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier::TaggedSymbol)
            ULTRAFAST = T.let(:ultrafast, OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier::TaggedSymbol]) }
            def self.values
            end
          end

          class Compaction < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationAgentConfig::Compaction,
                OpenAI::Internal::AnyHash
              )
            end

            # Whether context is compacted in the background. Defaults to true.
            sig { returns(T::Boolean) }
            attr_accessor :async

            # The effective context compaction settings.
            sig do
              params(

                async: T::Boolean
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Whether context is compacted in the background. Defaults to true.

              async:
            )
            end

            sig do
              override.returns(
                {async: T::Boolean}
              )
            end
            def to_hash
            end

          end

          class Experimental < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationAgentConfig::Experimental,
                OpenAI::Internal::AnyHash
              )
            end

            # Whether the model receives periodic current-time reminders.
            sig { returns(T::Boolean) }
            attr_accessor :time_awareness

            # The effective experimental settings for the agent.
            sig do
              params(

                time_awareness: T::Boolean
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Whether the model receives periodic current-time reminders.

              time_awareness:
            )
            end

            sig do
              override.returns(
                {time_awareness: T::Boolean}
              )
            end
            def to_hash
            end

          end

        end

      end

    end

  end
end
