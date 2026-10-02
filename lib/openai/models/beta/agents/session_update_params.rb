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
          #   Model settings for subsequent turns. Omitted fields stay unchanged.
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

          # @!method initialize(session_id:, agent: nil, metadata: nil, request_options: {})
          #   @param session_id [String]
          #
          #   @param agent [OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent]
          #     Model settings for subsequent turns. Omitted fields stay unchanged.
          #
          #   @param metadata [Hash{Symbol=>String}, nil]
          #     Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
          #     Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #     characters.
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

            # @!method initialize(model: nil, reasoning: nil, service_tier: nil)
            #   Model settings for subsequent turns. Omitted fields stay unchanged.
            #
            #   @param model [String]
            #     The model for subsequent turns. Omit to keep the current model.
            #
            #   @param reasoning [OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent::Reasoning]
            #     Reasoning settings to update. Omit to keep the current effort.
            #
            #   @param service_tier [Symbol, OpenAI::Models::Beta::Agents::SessionUpdateParams::Agent::ServiceTier, nil]
            #     Omit to keep the current tier. Null resets it to auto.

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

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
