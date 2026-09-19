# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentReasoning < OpenAI::Internal::Type::BaseModel
        # @!attribute effort
        #   The requested reasoning effort, or `null` when the model selects its own
        #   default.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentReasoning::Effort, nil]
        required :effort, enum: -> { OpenAI::Beta::AgentReasoning::Effort }, nil?: true

        # @!attribute summary
        #   The requested reasoning summary format, or `null` when summaries are disabled.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentReasoning::Summary, nil]
        required :summary, enum: -> { OpenAI::Beta::AgentReasoning::Summary }, nil?: true

        # @!method initialize(effort:, summary:)
        #   The reasoning configuration used by an agent.
        #
        #   @param effort [Symbol, OpenAI::Models::Beta::AgentReasoning::Effort, nil]
        #     The requested reasoning effort, or `null` when the model selects its own
        #     default.
        #
        #   @param summary [Symbol, OpenAI::Models::Beta::AgentReasoning::Summary, nil]
        #     The requested reasoning summary format, or `null` when summaries are disabled.

        # The requested reasoning effort, or `null` when the model selects its own
        # default.
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

        # The requested reasoning summary format, or `null` when summaries are disabled.
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
