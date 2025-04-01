# frozen_string_literal: true

module OpenAI
  module Models
    class Reasoning < OpenAI::BaseModel
      # @!attribute effort
      #   **o-series models only**
      #
      #     Constrains effort on reasoning for
      #     [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
      #     supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
      #     result in faster responses and fewer tokens used on reasoning in a response.
      #
      #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
      optional :effort, enum: -> { OpenAI::Models::ReasoningEffort }, nil?: true

      # @!attribute generate_summary
      #   **computer_use_preview only**
      #
      #     A summary of the reasoning performed by the model. This can be useful for
      #     debugging and understanding the model's reasoning process. One of `concise` or
      #     `detailed`.
      #
      #   @return [Symbol, OpenAI::Models::Reasoning::GenerateSummary, nil]
      optional :generate_summary, enum: -> { OpenAI::Models::Reasoning::GenerateSummary }, nil?: true

      # @!parse
      #   # **o-series models only**
      #   #
      #   #   Configuration options for
      #   #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
      #   #
      #   # @param effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
      #   # @param generate_summary [Symbol, OpenAI::Models::Reasoning::GenerateSummary, nil]
      #   #
      #   def initialize(effort: nil, generate_summary: nil, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # **computer_use_preview only**
      #
      #   A summary of the reasoning performed by the model. This can be useful for
      #   debugging and understanding the model's reasoning process. One of `concise` or
      #   `detailed`.
      #
      # @see OpenAI::Models::Reasoning#generate_summary
      module GenerateSummary
        extend OpenAI::Enum

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
