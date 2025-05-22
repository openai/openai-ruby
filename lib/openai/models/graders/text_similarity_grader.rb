# frozen_string_literal: true

module OpenAI
  module Models
    module Graders
      class TextSimilarityGrader < OpenAI::Internal::Type::BaseModel
        # @!attribute evaluation_metric
        #   The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`,
        #   `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
        #
        #   @return [Symbol, OpenAI::Models::Graders::TextSimilarityGrader::EvaluationMetric]
        required :evaluation_metric, enum: -> { OpenAI::Graders::TextSimilarityGrader::EvaluationMetric }

        # @!attribute input
        #   The text being graded.
        #
        #   @return [String]
        required :input, String

        # @!attribute name
        #   The name of the grader.
        #
        #   @return [String]
        required :name, String

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

        # @!method initialize(evaluation_metric:, input:, name:, reference:, type: :text_similarity)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Graders::TextSimilarityGrader} for more details.
        #
        #   A TextSimilarityGrader object which grades text based on similarity metrics.
        #
        #   @param evaluation_metric [Symbol, OpenAI::Models::Graders::TextSimilarityGrader::EvaluationMetric] The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`, `r
        #
        #   @param input [String] The text being graded.
        #
        #   @param name [String] The name of the grader.
        #
        #   @param reference [String] The text being graded against.
        #
        #   @param type [Symbol, :text_similarity] The type of grader.

        # The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`,
        # `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
        #
        # @see OpenAI::Models::Graders::TextSimilarityGrader#evaluation_metric
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

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    TextSimilarityGrader = Graders::TextSimilarityGrader
  end
end
