# typed: strong

module OpenAI
  module Resources
    class FineTuning
      class Alpha
        class Graders
          # Run a grader.
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
                OpenAI::FineTuning::Alpha::GraderRunParams::ReferenceAnswer::Variants,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Models::FineTuning::Alpha::GraderRunResponse)
          end
          def run(
            # The grader used for the fine-tuning job.
            grader:,
            # The model sample to be evaluated.
            model_sample:,
            # The reference answer for the evaluation.
            reference_answer:,
            request_options: {}
          )
          end

          # Validate a grader.
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
            ).returns(OpenAI::Models::FineTuning::Alpha::GraderValidateResponse)
          end
          def validate(
            # The grader used for the fine-tuning job.
            grader:,
            request_options: {}
          )
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
