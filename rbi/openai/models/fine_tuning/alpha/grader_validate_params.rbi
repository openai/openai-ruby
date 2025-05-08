# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Alpha
        class GraderValidateParams < OpenAI::Internal::Type::BaseModel
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
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The grader used for the fine-tuning job.
            grader:,
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
                  OpenAI::FineTuning::Alpha::GraderValidateParams::Grader::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end
      end
    end
  end
end
