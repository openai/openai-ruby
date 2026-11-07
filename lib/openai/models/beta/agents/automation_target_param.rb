# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # The session an automation invocation targets.
        module AutomationTargetParam
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Create a session for each invocation.
          variant :new_session, -> { OpenAI::Beta::Agents::AutomationTargetParam::NewSession }

          # Deliver instructions to an existing session.
          variant :existing_session, -> { OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession }

          class NewSession < OpenAI::Internal::Type::BaseModel
            # @!attribute environment
            #   The execution environment for each new session.
            #
            #   @return [OpenAI::Models::Beta::EnvironmentParam::None, OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted, OpenAI::Models::Beta::EnvironmentParam::SelfHosted]
            required :environment, union: -> { OpenAI::Beta::EnvironmentParam }

            # @!attribute input
            #   Initial user messages submitted with each new session.
            #
            #   @return [Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>]
            required :input, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::AgentSessionInputMessageParam] }

            # @!attribute type
            #   The type of the object. Always `new_session`.
            #
            #   @return [Symbol, :new_session]
            required :type, const: :new_session

            # @!attribute agent
            #   Inline agent configuration. Provide exactly one of agent and agent_id.
            #
            #   @return [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent, nil]
            optional :agent, -> { OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent }

            # @!attribute agent_id
            #   A saved agent ID. Provide exactly one of agent and agent_id.
            #
            #   @return [String, nil]
            optional :agent_id, String

            # @!attribute metadata
            #   Metadata attached to each new session.
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

            # @!attribute vault_ids
            #   The IDs of vaults made available to each new session.
            #
            #   @return [Array<String>, nil]
            optional :vault_ids, OpenAI::Internal::Type::ArrayOf[String], nil?: true

            # @!method initialize(environment:, input:, agent: nil, agent_id: nil, metadata: nil, vault_ids: nil, type: :new_session)
            #   Create a session for each invocation.
            #
            #   @param environment [OpenAI::Models::Beta::EnvironmentParam::None, OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted, OpenAI::Models::Beta::EnvironmentParam::SelfHosted]
            #     The execution environment for each new session.
            #
            #   @param input [Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>]
            #     Initial user messages submitted with each new session.
            #
            #   @param agent [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent]
            #     Inline agent configuration. Provide exactly one of agent and agent_id.
            #
            #   @param agent_id [String]
            #     A saved agent ID. Provide exactly one of agent and agent_id.
            #
            #   @param metadata [Hash{Symbol=>String}, nil]
            #     Metadata attached to each new session.
            #
            #   @param vault_ids [Array<String>, nil]
            #     The IDs of vaults made available to each new session.
            #
            #   @param type [Symbol, :new_session]
            #     The type of the object. Always `new_session`.

            # @see OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession#agent
            class Agent < OpenAI::Internal::Type::BaseModel
              # @!attribute compaction
              #   Context compaction settings. Omit to keep the current settings. A supplied
              #   object replaces the settings; null or an empty object enables background
              #   compaction.
              #
              #   @return [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent::Compaction, nil]
              optional(
                :compaction,
                -> { OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Compaction },
                nil?: true
              )

              # @!attribute experimental
              #   Experimental settings to merge by key. Omitted settings keep their current
              #   values.
              #
              #   @return [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent::Experimental, nil]
              optional(
                :experimental,
                -> { OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Experimental }
              )

              # @!attribute instructions
              #   Additional instructions appended to the agent's default base instructions. Omit
              #   to leave unchanged.
              #
              #   @return [String, nil]
              optional :instructions, String, nil?: true

              # @!attribute model
              #   The model to use for the agent. The requested model name is preserved.
              #
              #   @return [String, nil]
              optional :model, String

              # @!attribute multi_agent
              #   Configuration for creating and coordinating subagents.
              #
              #   @return [OpenAI::Models::Beta::MultiAgentConfigParam, nil]
              optional :multi_agent, -> { OpenAI::Beta::MultiAgentConfigParam }, nil?: true

              # @!attribute reasoning
              #   Configuration for model reasoning. Omit to keep the current settings; pass
              #   `null` to reset to the model's default effort.
              #
              #   @return [OpenAI::Models::Beta::AgentReasoningParam, nil]
              optional :reasoning, -> { OpenAI::Beta::AgentReasoningParam }, nil?: true

              # @!attribute service_tier
              #   The service tier used for model requests.
              #
              #   @return [Symbol, OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier, nil]
              optional(
                :service_tier,
                enum: -> {
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier
                },
                nil?: true
              )

              # @!attribute text
              #   Configuration for text generated by the agent.
              #
              #   @return [OpenAI::Models::Beta::AgentTextParam, nil]
              optional :text, -> { OpenAI::Beta::AgentTextParam }, nil?: true

              # @!attribute tools
              #   Tools available to the agent. Omit to inherit, or pass null to clear them. The
              #   resolved tool list must fit within 3 MiB (3,145,728 bytes) of compact UTF-8
              #   JSON.
              #
              #   @return [Array<OpenAI::Models::Beta::AgentToolParam::Function, OpenAI::Models::Beta::AgentToolParam::ToolSearch, OpenAI::Models::Beta::AgentToolParam::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentToolParam::Mcp, OpenAI::Models::Beta::AgentToolParam::WebSearch, OpenAI::Models::Beta::AgentToolParam::ComputerUse, OpenAI::Models::Beta::AgentToolParam::Automations>, nil]
              optional(
                :tools,
                -> {
                  OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentToolParam]
                },
                nil?: true
              )

              # @!method initialize(compaction: nil, experimental: nil, instructions: nil, model: nil, multi_agent: nil, reasoning: nil, service_tier: nil, text: nil, tools: nil)
              #   Inline agent configuration. Provide exactly one of agent and agent_id.
              #
              #   @param compaction [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent::Compaction, nil]
              #     Context compaction settings. Omit to keep the current settings. A supplied
              #     object replaces the settings; null or an empty object enables background
              #     compaction.
              #
              #   @param experimental [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent::Experimental]
              #     Experimental settings to merge by key. Omitted settings keep their current
              #     values.
              #
              #   @param instructions [String, nil]
              #     Additional instructions appended to the agent's default base instructions. Omit
              #     to leave unchanged.
              #
              #   @param model [String]
              #     The model to use for the agent. The requested model name is preserved.
              #
              #   @param multi_agent [OpenAI::Models::Beta::MultiAgentConfigParam, nil]
              #     Configuration for creating and coordinating subagents.
              #
              #   @param reasoning [OpenAI::Models::Beta::AgentReasoningParam, nil]
              #     Configuration for model reasoning. Omit to keep the current settings; pass
              #     `null` to reset to the model's default effort.
              #
              #   @param service_tier [Symbol, OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier, nil]
              #     The service tier used for model requests.
              #
              #   @param text [OpenAI::Models::Beta::AgentTextParam, nil]
              #     Configuration for text generated by the agent.
              #
              #   @param tools [Array<OpenAI::Models::Beta::AgentToolParam::Function, OpenAI::Models::Beta::AgentToolParam::ToolSearch, OpenAI::Models::Beta::AgentToolParam::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentToolParam::Mcp, OpenAI::Models::Beta::AgentToolParam::WebSearch, OpenAI::Models::Beta::AgentToolParam::ComputerUse, OpenAI::Models::Beta::AgentToolParam::Automations>, nil]
              #     Tools available to the agent. Omit to inherit, or pass null to clear them. The
              #     resolved tool list must fit within 3 MiB (3,145,728 bytes) of compact UTF-8
              #     JSON.

              # @see OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent#compaction
              class Compaction < OpenAI::Internal::Type::BaseModel
                # @!attribute async
                #   Whether to compact context in the background. Omission or null defaults to true.
                #   Set to false to use blocking compaction. Background compaction may increase
                #   token usage.
                #
                #   @return [Boolean, nil]
                optional :async, OpenAI::Internal::Type::Boolean, nil?: true

                # @!method initialize(async: nil)
                #   Context compaction settings. Omit to keep the current settings. A supplied
                #   object replaces the settings; null or an empty object enables background
                #   compaction.
                #
                #   @param async [Boolean, nil]
                #     Whether to compact context in the background. Omission or null defaults to true.
                #     Set to false to use blocking compaction. Background compaction may increase
                #     token usage.
              end

              # @see OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent#experimental
              class Experimental < OpenAI::Internal::Type::BaseModel
                # @!attribute time_awareness
                #   Whether to give the model periodic current-time reminders. Omit to keep the
                #   current setting.
                #
                #   @return [Boolean, nil]
                optional :time_awareness, OpenAI::Internal::Type::Boolean

                # @!method initialize(time_awareness: nil)
                #   Experimental settings to merge by key. Omitted settings keep their current
                #   values.
                #
                #   @param time_awareness [Boolean]
                #     Whether to give the model periodic current-time reminders. Omit to keep the
                #     current setting.
              end

              # The service tier used for model requests.
              #
              # @see OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession::Agent#service_tier
              module ServiceTier
                extend OpenAI::Internal::Type::Enum

                # Selects the service tier automatically.
                AUTO = :auto

                # Uses the default service tier.
                DEFAULT = :default

                # Uses the flex service tier.
                FLEX = :flex

                # Uses the priority service tier.
                PRIORITY = :priority

                # Uses the fast service tier.
                FAST = :fast

                # Uses the ultrafast service tier.
                ULTRAFAST = :ultrafast

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end
          end

          class ExistingSession < OpenAI::Internal::Type::BaseModel
            # @!attribute instructions
            #   Instructions delivered as an automation notification.
            #
            #   @return [String]
            required :instructions, String

            # @!attribute session_id
            #   The session receiving each invocation.
            #
            #   @return [String]
            required :session_id, String

            # @!attribute type
            #   The type of the object. Always `existing_session`.
            #
            #   @return [Symbol, :existing_session]
            required :type, const: :existing_session

            # @!method initialize(instructions:, session_id:, type: :existing_session)
            #   Deliver instructions to an existing session.
            #
            #   @param instructions [String]
            #     Instructions delivered as an automation notification.
            #
            #   @param session_id [String]
            #     The session receiving each invocation.
            #
            #   @param type [Symbol, :existing_session]
            #     The type of the object. Always `existing_session`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession, OpenAI::Models::Beta::Agents::AutomationTargetParam::ExistingSession)]
        end
      end
    end
  end
end
