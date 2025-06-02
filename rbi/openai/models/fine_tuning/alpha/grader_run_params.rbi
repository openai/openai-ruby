# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Alpha
        class GraderRunParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::FineTuning::Alpha::GraderRunParams,
                OpenAI::Internal::AnyHash
              )
            end

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

          # The model sample to be evaluated. This value will be used to populate the
          # `sample` namespace. See
          # [the guide](https://platform.openai.com/docs/guides/graders) for more details.
          # The `output_json` variable will be populated if the model sample is a valid JSON
          # string.
          sig { returns(String) }
          attr_accessor :model_sample

          # The dataset item provided to the grader. This will be used to populate the
          # `item` namespace. See
          # [the guide](https://platform.openai.com/docs/guides/graders) for more details.
          sig { returns(T.nilable(T.anything)) }
          attr_reader :item

          sig { params(item: T.anything).void }
          attr_writer :item

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
            ).returns(T.attached_class)
          end
          def self.new(
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
                item: T.anything,
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
        end
      end
    end
  end
end
