# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Sessions#create
        #
        # @see OpenAI::Resources::Beta::Agents::Sessions#create_streaming
        class SessionCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute environment
          #   An inline execution environment or a reference to an environment template.
          #
          #   @return [OpenAI::Models::Beta::EnvironmentParam::None, OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted, OpenAI::Models::Beta::EnvironmentParam::SelfHosted]
          required :environment, union: -> { OpenAI::Beta::EnvironmentParam }

          # @!attribute agent
          #   Agent configuration. With `agent_id`, supplied fields override the saved agent
          #   for this session. Without `agent_id`, `model` is required.
          #
          #   @return [OpenAI::Models::Beta::Agents::SessionCreateParams::Agent, nil]
          optional :agent, -> { OpenAI::Beta::Agents::SessionCreateParams::Agent }

          # @!attribute agent_id
          #   The ID of a saved reusable agent. Omit `agent` to use its configuration
          #   unchanged.
          #
          #   @return [String, nil]
          optional :agent_id, String

          # @!attribute input
          #   Initial input to submit when the session is created. A string is shorthand for a
          #   single user message. Required when `environment.type` is `none`, or when
          #   `stream` is `true` for an environment that is not `self_hosted`; optional for
          #   self-hosted and non-streaming execution environments.
          #
          #   @return [String, Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>, nil]
          optional :input, union: -> { OpenAI::Beta::Agents::SessionCreateParams::Input }, nil?: true

          # @!attribute metadata
          #   Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #   characters. Omission or null defaults to an empty map.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!attribute spend_control
          #   Optional spending limit in USD cents. Omission or null creates an unlimited
          #   session.
          #
          #   @return [OpenAI::Models::Beta::Agents::SessionCreateParams::SpendControl, nil]
          optional(
            :spend_control,
            -> {
              OpenAI::Beta::Agents::SessionCreateParams::SpendControl
            },
            nil?: true
          )

          # @!attribute vault_ids
          #   The IDs of vaults made available to the session.
          #
          #   @return [Array<String>, nil]
          optional :vault_ids, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!method initialize(environment:, agent: nil, agent_id: nil, input: nil, metadata: nil, spend_control: nil, vault_ids: nil, request_options: {})
          #   @param environment [OpenAI::Models::Beta::EnvironmentParam::None, OpenAI::Models::Beta::EnvironmentParam::OpenAIHosted, OpenAI::Models::Beta::EnvironmentParam::SelfHosted]
          #     An inline execution environment or a reference to an environment template.
          #
          #   @param agent [OpenAI::Models::Beta::Agents::SessionCreateParams::Agent]
          #     Agent configuration. With `agent_id`, supplied fields override the saved agent
          #     for this session. Without `agent_id`, `model` is required.
          #
          #   @param agent_id [String]
          #     The ID of a saved reusable agent. Omit `agent` to use its configuration
          #     unchanged.
          #
          #   @param input [String, Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>, nil]
          #     Initial input to submit when the session is created. A string is shorthand for a
          #     single user message. Required when `environment.type` is `none`, or when
          #     `stream` is `true` for an environment that is not `self_hosted`; optional for
          #     self-hosted and non-streaming execution environments.
          #
          #   @param metadata [Hash{Symbol=>String}, nil]
          #     Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #     characters. Omission or null defaults to an empty map.
          #
          #   @param spend_control [OpenAI::Models::Beta::Agents::SessionCreateParams::SpendControl, nil]
          #     Optional spending limit in USD cents. Omission or null creates an unlimited
          #     session.
          #
          #   @param vault_ids [Array<String>, nil]
          #     The IDs of vaults made available to the session.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          class Agent < OpenAI::Internal::Type::BaseModel
            # @!attribute compaction
            #   Context compaction settings. Omit to keep the current settings. A supplied
            #   object replaces the settings; null or an empty object enables background
            #   compaction.
            #
            #   @return [OpenAI::Models::Beta::Agents::SessionCreateParams::Agent::Compaction, nil]
            optional(
              :compaction,
              -> {
                OpenAI::Beta::Agents::SessionCreateParams::Agent::Compaction
              },
              nil?: true
            )

            # @!attribute experimental
            #   Experimental settings to merge by key. Omitted settings keep their current
            #   values.
            #
            #   @return [OpenAI::Models::Beta::Agents::SessionCreateParams::Agent::Experimental, nil]
            optional :experimental, -> { OpenAI::Beta::Agents::SessionCreateParams::Agent::Experimental }

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
            #   @return [Symbol, OpenAI::Models::Beta::Agents::SessionCreateParams::Agent::ServiceTier, nil]
            optional(
              :service_tier,
              enum: -> { OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier },
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
            #   Agent configuration. With `agent_id`, supplied fields override the saved agent
            #   for this session. Without `agent_id`, `model` is required.
            #
            #   @param compaction [OpenAI::Models::Beta::Agents::SessionCreateParams::Agent::Compaction, nil]
            #     Context compaction settings. Omit to keep the current settings. A supplied
            #     object replaces the settings; null or an empty object enables background
            #     compaction.
            #
            #   @param experimental [OpenAI::Models::Beta::Agents::SessionCreateParams::Agent::Experimental]
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
            #   @param service_tier [Symbol, OpenAI::Models::Beta::Agents::SessionCreateParams::Agent::ServiceTier, nil]
            #     The service tier used for model requests.
            #
            #   @param text [OpenAI::Models::Beta::AgentTextParam, nil]
            #     Configuration for text generated by the agent.
            #
            #   @param tools [Array<OpenAI::Models::Beta::AgentToolParam::Function, OpenAI::Models::Beta::AgentToolParam::ToolSearch, OpenAI::Models::Beta::AgentToolParam::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentToolParam::Mcp, OpenAI::Models::Beta::AgentToolParam::WebSearch, OpenAI::Models::Beta::AgentToolParam::ComputerUse, OpenAI::Models::Beta::AgentToolParam::Automations>, nil]
            #     Tools available to the agent. Omit to inherit, or pass null to clear them. The
            #     resolved tool list must fit within 3 MiB (3,145,728 bytes) of compact UTF-8
            #     JSON.

            # @see OpenAI::Models::Beta::Agents::SessionCreateParams::Agent#compaction
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

            # @see OpenAI::Models::Beta::Agents::SessionCreateParams::Agent#experimental
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
            # @see OpenAI::Models::Beta::Agents::SessionCreateParams::Agent#service_tier
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

          # Initial input to submit when the session is created. A string is shorthand for a
          # single user message. Required when `environment.type` is `none`, or when
          # `stream` is `true` for an environment that is not `self_hosted`; optional for
          # self-hosted and non-streaming execution environments.
          module Input
            extend OpenAI::Internal::Type::Union

            variant String

            variant -> { OpenAI::Models::Beta::Agents::SessionCreateParams::Input::AgentSessionInputMessageParamArray }

            # @!method self.variants
            #   @return [Array(String, Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>)]

            # @type [OpenAI::Internal::Type::Converter]
            AgentSessionInputMessageParamArray = OpenAI::Internal::Type::ArrayOf[
              -> { OpenAI::Beta::AgentSessionInputMessageParam }
            ]
          end

          class SpendControl < OpenAI::Internal::Type::BaseModel
            # @!attribute limit
            #   Positive USD cents, or null to remove the limit.
            #
            #   @return [Integer, nil]
            required :limit, Integer, nil?: true

            # @!method initialize(limit:)
            #   Optional spending limit in USD cents. Omission or null creates an unlimited
            #   session.
            #
            #   @param limit [Integer, nil]
            #     Positive USD cents, or null to remove the limit.
          end
        end
      end
    end
  end
end
