# typed: strong

module OpenAI
  module Models
    MultiGrader = Graders::MultiGrader

    module Graders
      class MultiGrader < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Graders::MultiGrader, OpenAI::Internal::AnyHash)
          end

        # A formula to calculate the output based on grader results.
        sig { returns(String) }
        attr_accessor :calculate_output

        # A StringCheckGrader object that performs a string comparison between input and
        # reference using a specified operation.
        sig do
          returns(
            T.any(
              OpenAI::Graders::StringCheckGrader,
              OpenAI::Graders::TextSimilarityGrader,
              OpenAI::Graders::PythonGrader,
              OpenAI::Graders::ScoreModelGrader,
              OpenAI::Graders::LabelModelGrader
            )
          )
        end
        attr_accessor :graders

        # The name of the grader.
        sig { returns(String) }
        attr_accessor :name

        # The object type, which is always `multi`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A MultiGrader object combines the output of multiple graders to produce a single
        # score.
        sig do
          params(
            calculate_output: String,
            graders:
              T.any(
                OpenAI::Graders::StringCheckGrader::OrHash,
                OpenAI::Graders::TextSimilarityGrader::OrHash,
                OpenAI::Graders::PythonGrader::OrHash,
                OpenAI::Graders::ScoreModelGrader::OrHash,
                OpenAI::Graders::LabelModelGrader::OrHash
              ),
            name: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A formula to calculate the output based on grader results.
          calculate_output:,
          # A StringCheckGrader object that performs a string comparison between input and
          # reference using a specified operation.
          graders:,
          # The name of the grader.
          name:,
          # The object type, which is always `multi`.
          type: :multi
        )
        end

        sig do
          override.returns(
            {
              calculate_output: String,
              graders:
                T.any(
                  OpenAI::Graders::StringCheckGrader,
                  OpenAI::Graders::TextSimilarityGrader,
                  OpenAI::Graders::PythonGrader,
                  OpenAI::Graders::ScoreModelGrader,
                  OpenAI::Graders::LabelModelGrader
                ),
              name: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # A StringCheckGrader object that performs a string comparison between input and
        # reference using a specified operation.
        module Graders
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Graders::StringCheckGrader,
                OpenAI::Graders::TextSimilarityGrader,
                OpenAI::Graders::PythonGrader,
                OpenAI::Graders::ScoreModelGrader,
                OpenAI::Graders::LabelModelGrader
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Graders::MultiGrader::Graders::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
