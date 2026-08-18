# typed: strong

module OpenAI
  module Models

    module FineTuning

      module Alpha

        class GraderValidateResponse < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Models::FineTuning::Alpha::GraderValidateResponse,
              OpenAI::Internal::AnyHash
            )
          end

          # The grader used for the fine-tuning job.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::Alpha::GraderValidateResponse::Grader::Variants)) }
          attr_reader :grader

          sig {
            params(
              grader: T.any(
                OpenAI::Graders::StringCheckGrader::OrHash,
                OpenAI::Graders::TextSimilarityGrader::OrHash,
                OpenAI::Graders::PythonGrader::OrHash,
                OpenAI::Graders::ScoreModelGrader::OrHash,
                OpenAI::Graders::MultiGrader::OrHash
              )
            )
              .void
          }
          attr_writer :grader

          sig do
            params(

              grader: T.any(
                OpenAI::Graders::StringCheckGrader::OrHash,
                OpenAI::Graders::TextSimilarityGrader::OrHash,
                OpenAI::Graders::PythonGrader::OrHash,
                OpenAI::Graders::ScoreModelGrader::OrHash,
                OpenAI::Graders::MultiGrader::OrHash
              )
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The grader used for the fine-tuning job.

            grader: nil
          )
          end

          sig do
            override.returns(
              {grader: OpenAI::Models::FineTuning::Alpha::GraderValidateResponse::Grader::Variants}
            )
          end
          def to_hash
          end

          # The grader used for the fine-tuning job.
          module Grader
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Graders::StringCheckGrader,
                OpenAI::Graders::TextSimilarityGrader,
                OpenAI::Graders::PythonGrader,
                OpenAI::Graders::ScoreModelGrader,
                OpenAI::Graders::MultiGrader
              )
            }

            sig {
              override.returns(T::Array[OpenAI::Models::FineTuning::Alpha::GraderValidateResponse::Grader::Variants])
            }
            def self.variants
            end

          end

        end

      end

    end

  end
end
