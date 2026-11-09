# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        class AutomationAgentConfig < OpenAI::Internal::Type::BaseModel
          # @!attribute instructions
          #   Custom instructions, or null when absent.
          #
          #   @return [String, nil]
          required :instructions, String, nil?: true

          # @!attribute model
          #   The requested model name.
          #
          #   @return [String]
          required :model, String

          # @!attribute multi_agent
          #   The configuration for creating and coordinating subagents.
          #
          #   @return [OpenAI::Models::Beta::MultiAgentConfig]
          required :multi_agent, -> { OpenAI::Beta::MultiAgentConfig }

          # @!attribute reasoning
          #   The configured reasoning policy.
          #
          #   @return [OpenAI::Models::Beta::AgentReasoning]
          required :reasoning, -> { OpenAI::Beta::AgentReasoning }

          # @!attribute service_tier
          #   The configured service-tier policy.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::AutomationAgentConfig::ServiceTier]
          required :service_tier, enum: -> { OpenAI::Beta::Agents::AutomationAgentConfig::ServiceTier }

          # @!attribute text
          #   The configured output format and verbosity.
          #
          #   @return [OpenAI::Models::Beta::AgentText]
          required :text, -> { OpenAI::Beta::AgentText }

          # @!attribute tools
          #   Configured tools, excluding confidential credentials.
          #
          #   @return [Array<OpenAI::Models::Beta::AgentTool::Function, OpenAI::Models::Beta::AgentTool::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentTool::Mcp, OpenAI::Models::Beta::AgentTool::WebSearch, OpenAI::Models::Beta::AgentTool::ComputerUse, OpenAI::Models::Beta::AgentTool::Automations>]
          required :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentTool] }

          # @!attribute compaction
          #   The effective context compaction settings.
          #
          #   @return [OpenAI::Models::Beta::Agents::AutomationAgentConfig::Compaction, nil]
          optional :compaction, -> { OpenAI::Beta::Agents::AutomationAgentConfig::Compaction }

          # @!attribute experimental
          #   The effective experimental settings for the agent.
          #
          #   @return [OpenAI::Models::Beta::Agents::AutomationAgentConfig::Experimental, nil]
          optional :experimental, -> { OpenAI::Beta::Agents::AutomationAgentConfig::Experimental }

          # @!method initialize(instructions:, model:, multi_agent:, reasoning:, service_tier:, text:, tools:, compaction: nil, experimental: nil)
          #   Inline agent configuration without a generated session-local identity.
          #
          #   @param instructions [String, nil]
          #     Custom instructions, or null when absent.
          #
          #   @param model [String]
          #     The requested model name.
          #
          #   @param multi_agent [OpenAI::Models::Beta::MultiAgentConfig]
          #     The configuration for creating and coordinating subagents.
          #
          #   @param reasoning [OpenAI::Models::Beta::AgentReasoning]
          #     The configured reasoning policy.
          #
          #   @param service_tier [Symbol, OpenAI::Models::Beta::Agents::AutomationAgentConfig::ServiceTier]
          #     The configured service-tier policy.
          #
          #   @param text [OpenAI::Models::Beta::AgentText]
          #     The configured output format and verbosity.
          #
          #   @param tools [Array<OpenAI::Models::Beta::AgentTool::Function, OpenAI::Models::Beta::AgentTool::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentTool::Mcp, OpenAI::Models::Beta::AgentTool::WebSearch, OpenAI::Models::Beta::AgentTool::ComputerUse, OpenAI::Models::Beta::AgentTool::Automations>]
          #     Configured tools, excluding confidential credentials.
          #
          #   @param compaction [OpenAI::Models::Beta::Agents::AutomationAgentConfig::Compaction]
          #     The effective context compaction settings.
          #
          #   @param experimental [OpenAI::Models::Beta::Agents::AutomationAgentConfig::Experimental]
          #     The effective experimental settings for the agent.

          # The configured service-tier policy.
          #
          # @see OpenAI::Models::Beta::Agents::AutomationAgentConfig#service_tier
          module ServiceTier
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            DEFAULT = :default
            FLEX = :flex
            PRIORITY = :priority
            FAST = :fast
            ULTRAFAST = :ultrafast

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Beta::Agents::AutomationAgentConfig#compaction
          class Compaction < OpenAI::Internal::Type::BaseModel
            # @!attribute async
            #   Whether context is compacted in the background. Defaults to true.
            #
            #   @return [Boolean]
            required :async, OpenAI::Internal::Type::Boolean

            # @!method initialize(async:)
            #   The effective context compaction settings.
            #
            #   @param async [Boolean]
            #     Whether context is compacted in the background. Defaults to true.
          end

          # @see OpenAI::Models::Beta::Agents::AutomationAgentConfig#experimental
          class Experimental < OpenAI::Internal::Type::BaseModel
            # @!attribute time_awareness
            #   Whether the model receives periodic current-time reminders.
            #
            #   @return [Boolean]
            required :time_awareness, OpenAI::Internal::Type::Boolean

            # @!method initialize(time_awareness:)
            #   The effective experimental settings for the agent.
            #
            #   @param time_awareness [Boolean]
            #     Whether the model receives periodic current-time reminders.
          end
        end
      end
    end
  end
end
