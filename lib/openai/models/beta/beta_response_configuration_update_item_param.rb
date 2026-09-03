# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseConfigurationUpdateItemParam < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The item type. Always `configuration_update`.
        #
        #   @return [Symbol, :configuration_update]
        required :type, const: :configuration_update

        # @!attribute id
        #   The unique ID of the configuration update item.
        #
        #   @return [String, nil]
        optional :id, String, nil?: true

        # @!attribute agent
        #   The agent that produced this item.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Agent }, nil?: true

        # @!attribute reasoning
        #   Updates to reasoning configuration. Only effort is supported.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning }

        # @!method initialize(id: nil, agent: nil, reasoning: nil, type: :configuration_update)
        #   An update to the conversation's response configuration. The configuration
        #   remains in effect for subsequent responses until it is replaced by another
        #   configuration update.
        #
        #   @param id [String, nil] The unique ID of the configuration update item.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Agent, nil] The agent that produced this item.
        #
        #   @param reasoning [OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning] Updates to reasoning configuration. Only effort is supported.
        #
        #   @param type [Symbol, :configuration_update] The item type. Always `configuration_update`.

        # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam#agent
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

        # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam#reasoning
        class Reasoning < OpenAI::Internal::Type::BaseModel
          # @!attribute effort
          #   The reasoning effort to use for subsequent responses until another configuration
          #   update replaces it.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort, nil]
          optional(
            :effort,
            enum: -> { OpenAI::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort },
            nil?: true
          )

          # @!method initialize(effort: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning} for
          #   more details.
          #
          #   Updates to reasoning configuration. Only effort is supported.
          #
          #   @param effort [Symbol, OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning::Effort, nil] The reasoning effort to use for subsequent responses until another

          # The reasoning effort to use for subsequent responses until another configuration
          # update replaces it.
          #
          # @see OpenAI::Models::Beta::BetaResponseConfigurationUpdateItemParam::Reasoning#effort
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

    BetaResponseConfigurationUpdateItemParam = Beta::BetaResponseConfigurationUpdateItemParam
  end
end
