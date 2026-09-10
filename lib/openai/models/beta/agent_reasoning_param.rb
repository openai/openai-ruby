# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentReasoningParam < OpenAI::Internal::Type::BaseModel
        # @!attribute effort
        #   The amount of reasoning effort the model should use.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentReasoningParam::Effort, nil]
        optional :effort, enum: -> { OpenAI::Beta::AgentReasoningParam::Effort }, nil?: true

        # @!attribute summary
        #   The reasoning summary format requested from the model.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentReasoningParam::Summary, nil]
        optional :summary, enum: -> { OpenAI::Beta::AgentReasoningParam::Summary }, nil?: true

        # @!method initialize(effort: nil, summary: nil)
        #   Reasoning configuration for the agent.
        #
        #   @param effort [Symbol, OpenAI::Models::Beta::AgentReasoningParam::Effort, nil]
        #     The amount of reasoning effort the model should use.
        #
        #   @param summary [Symbol, OpenAI::Models::Beta::AgentReasoningParam::Summary, nil]
        #     The reasoning summary format requested from the model.

        # The amount of reasoning effort the model should use.
        #
        # @see OpenAI::Models::Beta::AgentReasoningParam#effort
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

        # The reasoning summary format requested from the model.
        #
        # @see OpenAI::Models::Beta::AgentReasoningParam#summary
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
