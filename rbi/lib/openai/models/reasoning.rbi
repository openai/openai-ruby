# typed: strong

module OpenAI
  module Models
    class Reasoning < OpenAI::BaseModel
      # **o-series models only**
      #
      #   Constrains effort on reasoning for
      #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
      #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
      #   result in faster responses and fewer tokens used on reasoning in a response.
      sig { returns(T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol)) }
      def effort
      end

      sig do
        params(_: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol))
          .returns(T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol))
      end
      def effort=(_)
      end

      # **computer_use_preview only**
      #
      #   A summary of the reasoning performed by the model. This can be useful for
      #   debugging and understanding the model's reasoning process. One of `concise` or
      #   `detailed`.
      sig { returns(T.nilable(OpenAI::Models::Reasoning::GenerateSummary::OrSymbol)) }
      def generate_summary
      end

      sig do
        params(_: T.nilable(OpenAI::Models::Reasoning::GenerateSummary::OrSymbol))
          .returns(T.nilable(OpenAI::Models::Reasoning::GenerateSummary::OrSymbol))
      end
      def generate_summary=(_)
      end

      # **o-series models only**
      #
      #   Configuration options for
      #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
      sig do
        params(
          effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
          generate_summary: T.nilable(OpenAI::Models::Reasoning::GenerateSummary::OrSymbol)
        )
          .returns(T.attached_class)
      end
      def self.new(effort: nil, generate_summary: nil)
      end

      sig do
        override
          .returns(
            {
              effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
              generate_summary: T.nilable(OpenAI::Models::Reasoning::GenerateSummary::OrSymbol)
            }
          )
      end
      def to_hash
      end

      # **computer_use_preview only**
      #
      #   A summary of the reasoning performed by the model. This can be useful for
      #   debugging and understanding the model's reasoning process. One of `concise` or
      #   `detailed`.
      module GenerateSummary
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Reasoning::GenerateSummary) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Reasoning::GenerateSummary::TaggedSymbol) }

        CONCISE = T.let(:concise, OpenAI::Models::Reasoning::GenerateSummary::TaggedSymbol)
        DETAILED = T.let(:detailed, OpenAI::Models::Reasoning::GenerateSummary::TaggedSymbol)

        class << self
          sig { override.returns(T::Array[OpenAI::Models::Reasoning::GenerateSummary::TaggedSymbol]) }
          def values
          end
        end
      end
    end
  end
end
