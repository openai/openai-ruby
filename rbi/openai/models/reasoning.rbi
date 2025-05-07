# typed: strong

module OpenAI
  module Models
    class Reasoning < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

      # **o-series models only**
      #
      # Constrains effort on reasoning for
      # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
      # supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
      # result in faster responses and fewer tokens used on reasoning in a response.
      sig { returns(T.nilable(OpenAI::ReasoningEffort::OrSymbol)) }
      attr_accessor :effort

      # **Deprecated:** use `summary` instead.
      #
      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      sig { returns(T.nilable(OpenAI::Reasoning::GenerateSummary::OrSymbol)) }
      attr_accessor :generate_summary

      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      sig { returns(T.nilable(OpenAI::Reasoning::Summary::OrSymbol)) }
      attr_accessor :summary

      # **o-series models only**
      #
      # Configuration options for
      # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
      sig do
        params(
          effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
          generate_summary:
            T.nilable(OpenAI::Reasoning::GenerateSummary::OrSymbol),
          summary: T.nilable(OpenAI::Reasoning::Summary::OrSymbol)
        ).returns(T.attached_class)
      end
      def self.new(
        # **o-series models only**
        #
        # Constrains effort on reasoning for
        # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        # supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
        # result in faster responses and fewer tokens used on reasoning in a response.
        effort: nil,
        # **Deprecated:** use `summary` instead.
        #
        # A summary of the reasoning performed by the model. This can be useful for
        # debugging and understanding the model's reasoning process. One of `auto`,
        # `concise`, or `detailed`.
        generate_summary: nil,
        # A summary of the reasoning performed by the model. This can be useful for
        # debugging and understanding the model's reasoning process. One of `auto`,
        # `concise`, or `detailed`.
        summary: nil
      )
      end

      sig do
        override.returns(
          {
            effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
            generate_summary:
              T.nilable(OpenAI::Reasoning::GenerateSummary::OrSymbol),
            summary: T.nilable(OpenAI::Reasoning::Summary::OrSymbol)
          }
        )
      end
      def to_hash
      end

      # **Deprecated:** use `summary` instead.
      #
      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      module GenerateSummary
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Reasoning::GenerateSummary) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        AUTO = T.let(:auto, OpenAI::Reasoning::GenerateSummary::TaggedSymbol)
        CONCISE =
          T.let(:concise, OpenAI::Reasoning::GenerateSummary::TaggedSymbol)
        DETAILED =
          T.let(:detailed, OpenAI::Reasoning::GenerateSummary::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Reasoning::GenerateSummary::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # A summary of the reasoning performed by the model. This can be useful for
      # debugging and understanding the model's reasoning process. One of `auto`,
      # `concise`, or `detailed`.
      module Summary
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Reasoning::Summary) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        AUTO = T.let(:auto, OpenAI::Reasoning::Summary::TaggedSymbol)
        CONCISE = T.let(:concise, OpenAI::Reasoning::Summary::TaggedSymbol)
        DETAILED = T.let(:detailed, OpenAI::Reasoning::Summary::TaggedSymbol)

        sig do
          override.returns(T::Array[OpenAI::Reasoning::Summary::TaggedSymbol])
        end
        def self.values
        end
      end
    end
  end
end
