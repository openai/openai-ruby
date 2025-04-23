# typed: strong

module OpenAI
  module Models
    class EvalTextSimilarityGrader < OpenAI::Internal::Type::BaseModel
      # The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`,
      # `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
      sig { returns(OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::OrSymbol) }
      attr_accessor :evaluation_metric

      # The text being graded.
      sig { returns(String) }
      attr_accessor :input

      # A float score where a value greater than or equal indicates a passing grade.
      sig { returns(Float) }
      attr_accessor :pass_threshold

      # The text being graded against.
      sig { returns(String) }
      attr_accessor :reference

      # The type of grader.
      sig { returns(Symbol) }
      attr_accessor :type

      # The name of the grader.
      sig { returns(T.nilable(String)) }
      attr_reader :name

      sig { params(name: String).void }
      attr_writer :name

      # A TextSimilarityGrader object which grades text based on similarity metrics.
      sig do
        params(
          evaluation_metric: OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::OrSymbol,
          input: String,
          pass_threshold: Float,
          reference: String,
          name: String,
          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(
        evaluation_metric:,
        input:,
        pass_threshold:,
        reference:,
        name: nil,
        type: :text_similarity
      )
      end

      sig do
        override
          .returns(
            {
              evaluation_metric: OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::OrSymbol,
              input: String,
              pass_threshold: Float,
              reference: String,
              type: Symbol,
              name: String
            }
          )
      end
      def to_hash; end

      # The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`,
      # `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
      module EvaluationMetric
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        FUZZY_MATCH =
          T.let(:fuzzy_match, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol)
        BLEU = T.let(:bleu, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol)
        GLEU = T.let(:gleu, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol)
        METEOR = T.let(:meteor, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol)
        ROUGE_1 = T.let(:rouge_1, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol)
        ROUGE_2 = T.let(:rouge_2, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol)
        ROUGE_3 = T.let(:rouge_3, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol)
        ROUGE_4 = T.let(:rouge_4, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol)
        ROUGE_5 = T.let(:rouge_5, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol)
        ROUGE_L = T.let(:rouge_l, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric::TaggedSymbol]) }
        def self.values; end
      end
    end
  end
end
