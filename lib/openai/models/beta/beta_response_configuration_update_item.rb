# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseConfigurationUpdateItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the configuration update item.
        #
        #   @return [String]
        required :id, String

        # @!attribute type
        #   The item type. Always `configuration_update`.
        #
        #   @return [Symbol, :configuration_update]
        required :type, const: :configuration_update

        # @!attribute agent
        #   The agent that produced this item.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseConfigurationUpdateItem::Agent }

        # @!attribute reasoning
        #   The reasoning configuration applied by this update.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning }

        # @!method initialize(id:, agent: nil, reasoning: nil, type: :configuration_update)
        #   A configuration update that applies to subsequent responses until it is replaced
        #   by another configuration update.
        #
        #   @param id [String] The unique ID of the configuration update item.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem::Agent] The agent that produced this item.
        #
        #   @param reasoning [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem::Reasoning] The reasoning configuration applied by this update.
        #
        #   @param type [Symbol, :configuration_update] The item type. Always `configuration_update`.

        # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that produced this item.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
        end

        # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem#reasoning
        class Reasoning < OpenAI::Internal::Type::BaseModel
          # @!attribute effort
          #   The reasoning effort used for subsequent responses until another configuration
          #   update replaces it.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort, nil]
          optional(
            :effort,
            enum: -> { OpenAI::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort },
            nil?: true
          )

          # @!method initialize(effort: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem::Reasoning} for more
          #   details.
          #
          #   The reasoning configuration applied by this update.
          #
          #   @param effort [Symbol, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem::Reasoning::Effort, nil] The reasoning effort used for subsequent responses until another

          # The reasoning effort used for subsequent responses until another configuration
          # update replaces it.
          #
          # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItem::Reasoning#effort
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
      end
    end

    BetaResponseConfigurationUpdateItem = Beta::BetaResponseConfigurationUpdateItem
  end
end
