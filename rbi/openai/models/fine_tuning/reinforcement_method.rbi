# typed: strong

module OpenAI
  module Models
    module FineTuning
      class ReinforcementMethod < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::FineTuning::ReinforcementMethod,
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

        # The hyperparameters used for the reinforcement fine-tuning job.
        sig do
          returns(T.nilable(OpenAI::FineTuning::ReinforcementHyperparameters))
        end
        attr_reader :hyperparameters

        sig do
          params(
            hyperparameters:
              OpenAI::FineTuning::ReinforcementHyperparameters::OrHash
          ).void
        end
        attr_writer :hyperparameters

        # Configuration for the reinforcement fine-tuning method.
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
            hyperparameters:
              OpenAI::FineTuning::ReinforcementHyperparameters::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The grader used for the fine-tuning job.
          grader:,
          # The hyperparameters used for the reinforcement fine-tuning job.
          hyperparameters: nil
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
              hyperparameters: OpenAI::FineTuning::ReinforcementHyperparameters
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
                OpenAI::FineTuning::ReinforcementMethod::Grader::Variants
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
