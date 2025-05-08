# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Alpha
        # @see OpenAI::Resources::FineTuning::Alpha::Graders#validate
        class GraderValidateResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute grader
          #   The grader used for the fine-tuning job.
          #
          #   @return [OpenAI::Graders::StringCheckGrader, OpenAI::Graders::TextSimilarityGrader, OpenAI::Graders::PythonGrader, OpenAI::Graders::ScoreModelGrader, OpenAI::Graders::MultiGrader, nil]
          optional :grader, union: -> { OpenAI::Models::FineTuning::Alpha::GraderValidateResponse::Grader }

          # @!method initialize(grader: nil)
          #   @param grader [OpenAI::Graders::StringCheckGrader, OpenAI::Graders::TextSimilarityGrader, OpenAI::Graders::PythonGrader, OpenAI::Graders::ScoreModelGrader, OpenAI::Graders::MultiGrader] The grader used for the fine-tuning job.

          # The grader used for the fine-tuning job.
          #
          # @see OpenAI::Models::FineTuning::Alpha::GraderValidateResponse#grader
          module Grader
            extend OpenAI::Internal::Type::Union

            # A StringCheckGrader object that performs a string comparison between input and reference using a specified operation.
            variant -> { OpenAI::Graders::StringCheckGrader }

            # A TextSimilarityGrader object which grades text based on similarity metrics.
            variant -> { OpenAI::Graders::TextSimilarityGrader }

            # A PythonGrader object that runs a python script on the input.
            variant -> { OpenAI::Graders::PythonGrader }

            # A ScoreModelGrader object that uses a model to assign a score to the input.
            variant -> { OpenAI::Graders::ScoreModelGrader }

            # A MultiGrader object combines the output of multiple graders to produce a single score.
            variant -> { OpenAI::Graders::MultiGrader }

            # @!method self.variants
            #   @return [Array(OpenAI::Graders::StringCheckGrader, OpenAI::Graders::TextSimilarityGrader, OpenAI::Graders::PythonGrader, OpenAI::Graders::ScoreModelGrader, OpenAI::Graders::MultiGrader)]
          end
        end
      end
    end
  end
end
