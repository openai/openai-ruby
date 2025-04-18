# frozen_string_literal: true

module OpenAI
  module Models
    class EvalTextSimilarityGrader < OpenAI::Internal::Type::BaseModel
      # @!attribute evaluation_metric
      #   The evaluation metric to use. One of `cosine`, `fuzzy_match`, `bleu`, `gleu`,
      #   `meteor`, `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
      #
      #   @return [Symbol, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric]
      required :evaluation_metric, enum: -> { OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric }

      # @!attribute input
      #   The text being graded.
      #
      #   @return [String]
      required :input, String

      # @!attribute pass_threshold
      #   A float score where a value greater than or equal indicates a passing grade.
      #
      #   @return [Float]
      required :pass_threshold, Float

      # @!attribute reference
      #   The text being graded against.
      #
      #   @return [String]
      required :reference, String

      # @!attribute type
      #   The type of grader.
      #
      #   @return [Symbol, :text_similarity]
      required :type, const: :text_similarity

      # @!attribute name
      #   The name of the grader.
      #
      #   @return [String, nil]
      optional :name, String

      # @!method initialize(evaluation_metric:, input:, pass_threshold:, reference:, name: nil, type: :text_similarity)
      #   A TextSimilarityGrader object which grades text based on similarity metrics.
      #
      #   @param evaluation_metric [Symbol, OpenAI::Models::EvalTextSimilarityGrader::EvaluationMetric]
      #   @param input [String]
      #   @param pass_threshold [Float]
      #   @param reference [String]
      #   @param name [String]
      #   @param type [Symbol, :text_similarity]

      # The evaluation metric to use. One of `cosine`, `fuzzy_match`, `bleu`, `gleu`,
      # `meteor`, `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
      #
      # @see OpenAI::Models::EvalTextSimilarityGrader#evaluation_metric
      module EvaluationMetric
        extend OpenAI::Internal::Type::Enum

        FUZZY_MATCH = :fuzzy_match
        BLEU = :bleu
        GLEU = :gleu
        METEOR = :meteor
        ROUGE_1 = :rouge_1
        ROUGE_2 = :rouge_2
        ROUGE_3 = :rouge_3
        ROUGE_4 = :rouge_4
        ROUGE_5 = :rouge_5
        ROUGE_L = :rouge_l
        COSINE = :cosine

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
