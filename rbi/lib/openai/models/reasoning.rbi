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
      sig { returns(T.nilable(Symbol)) }
      def effort
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
      def effort=(_)
      end

      # **o-series models only**
      #
      #   A summary of the reasoning performed by the model. This can be useful for
      #   debugging and understanding the model's reasoning process. One of `concise` or
      #   `detailed`.
      sig { returns(T.nilable(Symbol)) }
      def generate_summary
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
      def generate_summary=(_)
      end

      # **o-series models only**
      #
      #   Configuration options for
      #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
      sig { params(effort: T.nilable(Symbol), generate_summary: T.nilable(Symbol)).returns(T.attached_class) }
      def self.new(effort:, generate_summary: nil)
      end

      sig { override.returns({effort: T.nilable(Symbol), generate_summary: T.nilable(Symbol)}) }
      def to_hash
      end

      # **o-series models only**
      #
      #   A summary of the reasoning performed by the model. This can be useful for
      #   debugging and understanding the model's reasoning process. One of `concise` or
      #   `detailed`.
      class GenerateSummary < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        CONCISE = :concise
        DETAILED = :detailed
      end
    end
  end
end
