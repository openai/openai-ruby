# frozen_string_literal: true

module OpenAI
  module Models
    class Reasoning < OpenAI::Internal::Type::BaseModel
      # @!attribute effort
      #   **o-series models only**
      #
      #   Constrains effort on reasoning for
      #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
      #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
      #   result in faster responses and fewer tokens used on reasoning in a response.
      #
      #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
      optional :effort, enum: -> { OpenAI::Models::ReasoningEffort }, nil?: true

      # @!attribute generate_summary
      #   **Deprecated:** use `summary` instead.
      #
      #   A summary of the reasoning performed by the model. This can be useful for
      #   debugging and understanding the model's reasoning process. One of `auto`,
      #   `concise`, or `detailed`.
      #
      #   @return [Symbol, OpenAI::Models::Reasoning::GenerateSummary, nil]
      optional :generate_summary, enum: -> { OpenAI::Models::Reasoning::GenerateSummary }, nil?: true

      # @!attribute summary
      #   A summary of the reasoning performed by the model. This can be useful for
      #   debugging and understanding the model's reasoning process. One of `auto`,
      #   `concise`, or `detailed`.
      #
      #   @return [Symbol, OpenAI::Models::Reasoning::Summary, nil]
      optional :summary, enum: -> { OpenAI::Models::Reasoning::Summary }, nil?: true

      # @!parse
      #   # **o-series models only**
      #   #
      #   # Configuration options for
      #   # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
      #   #
      #   # @param effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
      #   # @param generate_summary [Symbol, OpenAI::Models::Reasoning::GenerateSummary, nil]
      #   # @param summary [Symbol, OpenAI::Models::Reasoning::Summary, nil]
      #   #
      #   def initialize(effort: nil, generate_summary: nil, summary: nil, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

      # @deprecated
      #
      # **Deprecated:** use `summary` instead.
      #
      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      #
      # @see OpenAI::Models::Reasoning#generate_summary
      module GenerateSummary
        extend OpenAI::Internal::Type::Enum

        AUTO = :auto
        CONCISE = :concise
        DETAILED = :detailed

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end

      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      #
      # @see OpenAI::Models::Reasoning#summary
      module Summary
        extend OpenAI::Internal::Type::Enum

        AUTO = :auto
        CONCISE = :concise
        DETAILED = :detailed

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end
    end
  end
end
