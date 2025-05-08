# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Alpha
        class GraderRunParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # The grader used for the fine-tuning job.
          sig do
            returns(
              T.any(
                OpenAI::Graders::StringCheckGrader,
                OpenAI::Graders::TextSimilarityGrader,
                OpenAI::Graders::PythonGrader,
                OpenAI::Graders::ScoreModelGrader,
                OpenAI::Graders::MultiGrader
              )
            )
          end
          attr_accessor :grader

          # The model sample to be evaluated.
          sig { returns(String) }
          attr_accessor :model_sample

          # The reference answer for the evaluation.
          sig do
            returns(T.any(String, T.anything, T::Array[T.anything], Float))
          end
          attr_accessor :reference_answer

          sig do
            params(
              grader:
                T.any(
                  OpenAI::Graders::StringCheckGrader::OrHash,
                  OpenAI::Graders::TextSimilarityGrader::OrHash,
                  OpenAI::Graders::PythonGrader::OrHash,
                  OpenAI::Graders::ScoreModelGrader::OrHash,
                  OpenAI::Graders::MultiGrader::OrHash
                ),
              model_sample: String,
              reference_answer:
                T.any(String, T.anything, T::Array[T.anything], Float),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The grader used for the fine-tuning job.
            grader:,
            # The model sample to be evaluated.
            model_sample:,
            # The reference answer for the evaluation.
            reference_answer:,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                grader:
                  T.any(
                    OpenAI::Graders::StringCheckGrader,
                    OpenAI::Graders::TextSimilarityGrader,
                    OpenAI::Graders::PythonGrader,
                    OpenAI::Graders::ScoreModelGrader,
                    OpenAI::Graders::MultiGrader
                  ),
                model_sample: String,
                reference_answer:
                  T.any(String, T.anything, T::Array[T.anything], Float),
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # The grader used for the fine-tuning job.
          module Grader
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Graders::StringCheckGrader,
                  OpenAI::Graders::TextSimilarityGrader,
                  OpenAI::Graders::PythonGrader,
                  OpenAI::Graders::ScoreModelGrader,
                  OpenAI::Graders::MultiGrader
                )
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::FineTuning::Alpha::GraderRunParams::Grader::Variants
                ]
              )
            end
            def self.variants
            end
          end

          # The reference answer for the evaluation.
          module ReferenceAnswer
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(String, T.anything, T::Array[T.anything], Float)
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::FineTuning::Alpha::GraderRunParams::ReferenceAnswer::Variants
                ]
              )
            end
            def self.variants
            end

            UnionMember2Array =
              T.let(
                OpenAI::Internal::Type::ArrayOf[
                  OpenAI::Internal::Type::Unknown
                ],
                OpenAI::Internal::Type::Converter
              )
          end
        end
      end
    end
  end
end
