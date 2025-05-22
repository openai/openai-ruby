# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      class ReinforcementMethod < OpenAI::Internal::Type::BaseModel
        # @!attribute grader
        #   The grader used for the fine-tuning job.
        #
        #   @return [OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::MultiGrader]
        required :grader, union: -> { OpenAI::FineTuning::ReinforcementMethod::Grader }

        # @!attribute hyperparameters
        #   The hyperparameters used for the reinforcement fine-tuning job.
        #
        #   @return [OpenAI::Models::FineTuning::ReinforcementHyperparameters, nil]
        optional :hyperparameters, -> { OpenAI::FineTuning::ReinforcementHyperparameters }

        # @!method initialize(grader:, hyperparameters: nil)
        #   Configuration for the reinforcement fine-tuning method.
        #
        #   @param grader [OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::MultiGrader] The grader used for the fine-tuning job.
        #
        #   @param hyperparameters [OpenAI::Models::FineTuning::ReinforcementHyperparameters] The hyperparameters used for the reinforcement fine-tuning job.

        # The grader used for the fine-tuning job.
        #
        # @see OpenAI::Models::FineTuning::ReinforcementMethod#grader
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
          #   @return [Array(OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::MultiGrader)]
        end
      end
    end
  end
end
