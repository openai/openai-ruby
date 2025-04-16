# typed: strong

module OpenAI
  module Models
    class Reasoning < OpenAI::Internal::Type::BaseModel
      # **o-series models only**
      #
      # Constrains effort on reasoning for
      # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
      # supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
      # result in faster responses and fewer tokens used on reasoning in a response.
      sig { returns(T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol)) }
      attr_accessor :effort

      # **Deprecated:** use `summary` instead.
      #
      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      sig { returns(T.nilable(OpenAI::Models::Reasoning::GenerateSummary::OrSymbol)) }
      attr_accessor :generate_summary

      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      sig { returns(T.nilable(OpenAI::Models::Reasoning::Summary::OrSymbol)) }
      attr_accessor :summary

      # **o-series models only**
      #
      # Configuration options for
      # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
      sig do
        params(
          effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
          generate_summary: T.nilable(OpenAI::Models::Reasoning::GenerateSummary::OrSymbol),
          summary: T.nilable(OpenAI::Models::Reasoning::Summary::OrSymbol)
        )
          .returns(T.attached_class)
      end
      def self.new(effort: nil, generate_summary: nil, summary: nil); end

      sig do
        override
          .returns(
            {
              effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
              generate_summary: T.nilable(OpenAI::Models::Reasoning::GenerateSummary::OrSymbol),
              summary: T.nilable(OpenAI::Models::Reasoning::Summary::OrSymbol)
            }
          )
      end
      def to_hash; end

      # **Deprecated:** use `summary` instead.
      #
      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      module GenerateSummary
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Reasoning::GenerateSummary) }
        OrSymbol =
          T.type_alias { T.any(Symbol, String, OpenAI::Models::Reasoning::GenerateSummary::TaggedSymbol) }

        AUTO = T.let(:auto, OpenAI::Models::Reasoning::GenerateSummary::TaggedSymbol)
        CONCISE = T.let(:concise, OpenAI::Models::Reasoning::GenerateSummary::TaggedSymbol)
        DETAILED = T.let(:detailed, OpenAI::Models::Reasoning::GenerateSummary::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::Reasoning::GenerateSummary::TaggedSymbol]) }
        def self.values; end
      end

      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      module Summary
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Reasoning::Summary) }
        OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::Reasoning::Summary::TaggedSymbol) }

        AUTO = T.let(:auto, OpenAI::Models::Reasoning::Summary::TaggedSymbol)
        CONCISE = T.let(:concise, OpenAI::Models::Reasoning::Summary::TaggedSymbol)
        DETAILED = T.let(:detailed, OpenAI::Models::Reasoning::Summary::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::Reasoning::Summary::TaggedSymbol]) }
        def self.values; end
      end
    end
  end
end
