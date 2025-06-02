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
              item: T.anything,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Models::FineTuning::Alpha::GraderRunResponse)
          end
          def run(
            # The grader used for the fine-tuning job.
            grader:,
            # The model sample to be evaluated. This value will be used to populate the
            # `sample` namespace. See
            # [the guide](https://platform.openai.com/docs/guides/graders) for more details.
            # The `output_json` variable will be populated if the model sample is a valid JSON
            # string.
            model_sample:,
            # The dataset item provided to the grader. This will be used to populate the
            # `item` namespace. See
            # [the guide](https://platform.openai.com/docs/guides/graders) for more details.
            item: nil,
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
