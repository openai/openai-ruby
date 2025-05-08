# typed: strong

module OpenAI
  module Models
    TextSimilarityGrader = Graders::TextSimilarityGrader

    module Graders
      class TextSimilarityGrader < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`,
        # `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
        sig do
          returns(
            OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::OrSymbol
          )
        end
        attr_accessor :evaluation_metric

        # The text being graded.
        sig { returns(String) }
        attr_accessor :input

        # The name of the grader.
        sig { returns(String) }
        attr_accessor :name

        # The text being graded against.
        sig { returns(String) }
        attr_accessor :reference

        # The type of grader.
        sig { returns(Symbol) }
        attr_accessor :type

        # A TextSimilarityGrader object which grades text based on similarity metrics.
        sig do
          params(
            evaluation_metric:
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::OrSymbol,
            input: String,
            name: String,
            reference: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`,
          # `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
          evaluation_metric:,
          # The text being graded.
          input:,
          # The name of the grader.
          name:,
          # The text being graded against.
          reference:,
          # The type of grader.
          type: :text_similarity
        )
        end

        sig do
          override.returns(
            {
              evaluation_metric:
                OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::OrSymbol,
              input: String,
              name: String,
              reference: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`,
        # `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
        module EvaluationMetric
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Graders::TextSimilarityGrader::EvaluationMetric
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          FUZZY_MATCH =
            T.let(
              :fuzzy_match,
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
            )
          BLEU =
            T.let(
              :bleu,
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
            )
          GLEU =
            T.let(
              :gleu,
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
            )
          METEOR =
            T.let(
              :meteor,
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
            )
          ROUGE_1 =
            T.let(
              :rouge_1,
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
            )
          ROUGE_2 =
            T.let(
              :rouge_2,
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
            )
          ROUGE_3 =
            T.let(
              :rouge_3,
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
            )
          ROUGE_4 =
            T.let(
              :rouge_4,
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
            )
          ROUGE_5 =
            T.let(
              :rouge_5,
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
            )
          ROUGE_L =
            T.let(
              :rouge_l,
              OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
