# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentReasoning < OpenAI::Internal::Type::BaseModel
        # @!attribute effort
        #   The amount of reasoning effort used by an agent.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentReasoning::Effort, nil]
        required :effort, enum: -> { OpenAI::Beta::AgentReasoning::Effort }, nil?: true

        # @!attribute summary
        #   The reasoning summary format requested from an agent.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentReasoning::Summary, nil]
        required :summary, enum: -> { OpenAI::Beta::AgentReasoning::Summary }, nil?: true

        # @!method initialize(effort:, summary:)
        #   The reasoning configuration used by an agent.
        #
        #   @param effort [Symbol, OpenAI::Models::Beta::AgentReasoning::Effort, nil]
        #     The amount of reasoning effort used by an agent.
        #
        #   @param summary [Symbol, OpenAI::Models::Beta::AgentReasoning::Summary, nil]
        #     The reasoning summary format requested from an agent.

        # The amount of reasoning effort used by an agent.
        #
        # @see OpenAI::Models::Beta::AgentReasoning#effort
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

        # The reasoning summary format requested from an agent.
        #
        # @see OpenAI::Models::Beta::AgentReasoning#summary
        module Summary
          extend OpenAI::Internal::Type::Enum

          # Returns a concise reasoning summary when supported.
          CONCISE = :concise

          # Returns a detailed reasoning summary when supported.
          DETAILED = :detailed

          # Automatically selects the most detailed summary supported by the model.
          AUTO = :auto

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
