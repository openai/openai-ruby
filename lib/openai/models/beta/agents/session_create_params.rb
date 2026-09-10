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
          #   Initial input submitted when creating a session.
          #
          #   @return [String, Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>, nil]
          optional :input, union: -> { OpenAI::Beta::Agents::SessionCreateParams::Input }, nil?: true

          # @!attribute metadata
          #   Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #   characters. Omission or null defaults to an empty map.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!attribute vault_ids
          #   The IDs of vaults made available to the session.
          #
          #   @return [Array<String>, nil]
          optional :vault_ids, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!method initialize(environment:, agent: nil, agent_id: nil, input: nil, metadata: nil, vault_ids: nil, request_options: {})
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
          #     Initial input submitted when creating a session.
          #
          #   @param metadata [Hash{Symbol=>String}, nil]
          #     Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #     characters. Omission or null defaults to an empty map.
          #
          #   @param vault_ids [Array<String>, nil]
          #     The IDs of vaults made available to the session.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          class Agent < OpenAI::Internal::Type::BaseModel
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
            #   Explicit configuration for creating and coordinating subagents.
            #
            #   @return [OpenAI::Models::Beta::MultiAgentConfigParam, nil]
            optional :multi_agent, -> { OpenAI::Beta::MultiAgentConfigParam }, nil?: true

            # @!attribute reasoning
            #   Reasoning configuration for the agent.
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
            #   Tools available to the agent. Omit to inherit, or pass null to clear them.
            #
            #   @return [Array<OpenAI::Models::Beta::AgentToolParam::Function, OpenAI::Models::Beta::AgentToolParam::ToolSearch, OpenAI::Models::Beta::AgentToolParam::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentToolParam::Mcp, OpenAI::Models::Beta::AgentToolParam::WebSearch>, nil]
            optional(
              :tools,
              -> {
                OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentToolParam]
              },
              nil?: true
            )

            # @!method initialize(instructions: nil, model: nil, multi_agent: nil, reasoning: nil, service_tier: nil, text: nil, tools: nil)
            #   Agent configuration. With `agent_id`, supplied fields override the saved agent
            #   for this session. Without `agent_id`, `model` is required.
            #
            #   @param instructions [String, nil]
            #     Additional instructions appended to the agent's default base instructions. Omit
            #     to leave unchanged.
            #
            #   @param model [String]
            #     The model to use for the agent. The requested model name is preserved.
            #
            #   @param multi_agent [OpenAI::Models::Beta::MultiAgentConfigParam, nil]
            #     Explicit configuration for creating and coordinating subagents.
            #
            #   @param reasoning [OpenAI::Models::Beta::AgentReasoningParam, nil]
            #     Reasoning configuration for the agent.
            #
            #   @param service_tier [Symbol, OpenAI::Models::Beta::Agents::SessionCreateParams::Agent::ServiceTier, nil]
            #     The service tier used for model requests.
            #
            #   @param text [OpenAI::Models::Beta::AgentTextParam, nil]
            #     Configuration for text generated by the agent.
            #
            #   @param tools [Array<OpenAI::Models::Beta::AgentToolParam::Function, OpenAI::Models::Beta::AgentToolParam::ToolSearch, OpenAI::Models::Beta::AgentToolParam::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentToolParam::Mcp, OpenAI::Models::Beta::AgentToolParam::WebSearch>, nil]
            #     Tools available to the agent. Omit to inherit, or pass null to clear them.

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

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # Initial input submitted when creating a session.
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
        end
      end
    end
  end
end
