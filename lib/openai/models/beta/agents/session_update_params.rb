# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Sessions#update
        class SessionUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute session_id
          #
          #   @return [String]
          required :session_id, String

          # @!attribute agent
          #   Agent settings to update on this session. Omitted fields stay unchanged.
          #
          #   @return [OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent, nil]
          optional :agent, -> { OpenAI::Beta::Agents::SessionUpdateParams::Agent }

          # @!attribute metadata
          #   Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
          #   Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #   characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!attribute review
          #   Default action review for new root turns. Existing turns and their subagents
          #   keep their review mode.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::SessionUpdateParams::Review, nil]
          optional :review, enum: -> { OpenAI::Beta::Agents::SessionUpdateParams::Review }

          # @!attribute spend_control
          #   Omit to retain the limit; null or a null limit removes it without resetting
          #   spend.
          #
          #   @return [OpenAI::Models::Beta::Agents::SessionUpdateParams::SpendControl, nil]
          optional(
            :spend_control,
            -> {
              OpenAI::Beta::Agents::SessionUpdateParams::SpendControl
            },
            nil?: true
          )

          # @!method initialize(session_id:, agent: nil, metadata: nil, review: nil, spend_control: nil, request_options: {})
          #   @param session_id [String]
          #
          #   @param agent [OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent]
          #     Agent settings to update on this session. Omitted fields stay unchanged.
          #
          #   @param metadata [Hash{Symbol=>String}, nil]
          #     Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
          #     Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #     characters.
          #
          #   @param review [Symbol, OpenAI::Models::Beta::Agents::SessionUpdateParams::Review]
          #     Default action review for new root turns. Existing turns and their subagents
          #     keep their review mode.
          #
          #   @param spend_control [OpenAI::Models::Beta::Agents::SessionUpdateParams::SpendControl, nil]
          #     Omit to retain the limit; null or a null limit removes it without resetting
          #     spend.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          class Agent < OpenAI::Internal::Type::BaseModel
            # @!attribute model
            #   The model for subsequent turns. Omit to keep the current model.
            #
            #   @return [String, nil]
            optional :model, String

            # @!attribute reasoning
            #   Reasoning settings to update. Omit to keep the current effort.
            #
            #   @return [OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent::Reasoning, nil]
            optional :reasoning, -> { OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning }

            # @!attribute service_tier
            #   Omit to keep the current tier. Null resets it to auto.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent::ServiceTier, nil]
            optional(
              :service_tier,
              enum: -> { OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier },
              nil?: true
            )

            # @!attribute tools
            #   Replaces the session tools. Functions and MCP servers change on the next model
            #   call. Built-in tools change by the next turn. Omit to keep the current tools, or
            #   pass null or an empty array to clear them.
            #
            #   @return [Array<OpenAI::Models::Beta::AgentToolParam::Function, OpenAI::Models::Beta::AgentToolParam::ToolSearch, OpenAI::Models::Beta::AgentToolParam::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentToolParam::Mcp, OpenAI::Models::Beta::AgentToolParam::WebSearch, OpenAI::Models::Beta::AgentToolParam::ComputerUse, OpenAI::Models::Beta::AgentToolParam::Automations>, nil]
            optional(
              :tools,
              -> {
                OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentToolParam]
              },
              nil?: true
            )

            # @!method initialize(model: nil, reasoning: nil, service_tier: nil, tools: nil)
            #   Agent settings to update on this session. Omitted fields stay unchanged.
            #
            #   @param model [String]
            #     The model for subsequent turns. Omit to keep the current model.
            #
            #   @param reasoning [OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent::Reasoning]
            #     Reasoning settings to update. Omit to keep the current effort.
            #
            #   @param service_tier [Symbol, OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent::ServiceTier, nil]
            #     Omit to keep the current tier. Null resets it to auto.
            #
            #   @param tools [Array<OpenAI::Models::Beta::AgentToolParam::Function, OpenAI::Models::Beta::AgentToolParam::ToolSearch, OpenAI::Models::Beta::AgentToolParam::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentToolParam::Mcp, OpenAI::Models::Beta::AgentToolParam::WebSearch, OpenAI::Models::Beta::AgentToolParam::ComputerUse, OpenAI::Models::Beta::AgentToolParam::Automations>, nil]
            #     Replaces the session tools. Functions and MCP servers change on the next model
            #     call. Built-in tools change by the next turn. Omit to keep the current tools, or
            #     pass null or an empty array to clear them.

            # @see OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent#reasoning
            class Reasoning < OpenAI::Internal::Type::BaseModel
              # @!attribute effort
              #   Omit to keep the current effort. Null selects the model's default effort.
              #
              #   @return [Symbol, OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort, nil]
              optional(
                :effort,
                enum: -> { OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort },
                nil?: true
              )

              # @!method initialize(effort: nil)
              #   Reasoning settings to update. Omit to keep the current effort.
              #
              #   @param effort [Symbol, OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort, nil]
              #     Omit to keep the current effort. Null selects the model's default effort.

              # Omit to keep the current effort. Null selects the model's default effort.
              #
              # @see OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent::Reasoning#effort
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
            end

            # Omit to keep the current tier. Null resets it to auto.
            #
            # @see OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent#service_tier
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

          # Default action review for new root turns. Existing turns and their subagents
          # keep their review mode.
          module Review
            extend OpenAI::Internal::Type::Enum

            # Keep the existing execution behavior without automatic action review.
            NONE = :none

            # Review eligible actions automatically. Deny manual approval fallbacks.
            AUTO_REVIEW = :auto_review

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          class SpendControl < OpenAI::Internal::Type::BaseModel
            # @!attribute limit
            #   Positive USD cents, or null to remove the limit.
            #
            #   @return [Integer, nil]
            required :limit, Integer, nil?: true

            # @!method initialize(limit:)
            #   Omit to retain the limit; null or a null limit removes it without resetting
            #   spend.
            #
            #   @param limit [Integer, nil]
            #     Positive USD cents, or null to remove the limit.
          end
        end
      end
    end
  end
end
