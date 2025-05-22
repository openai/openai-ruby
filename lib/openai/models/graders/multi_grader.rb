# frozen_string_literal: true

module OpenAI
  module Models
    module Graders
      class MultiGrader < OpenAI::Internal::Type::BaseModel
        # @!attribute calculate_output
        #   A formula to calculate the output based on grader results.
        #
        #   @return [String]
        required :calculate_output, String

        # @!attribute graders
        #
        #   @return [Hash{Symbol=>OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::LabelModelGrader}]
        required :graders, -> { OpenAI::Internal::Type::HashOf[union: OpenAI::Graders::MultiGrader::Grader] }

        # @!attribute name
        #   The name of the grader.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   The object type, which is always `multi`.
        #
        #   @return [Symbol, :multi]
        required :type, const: :multi

        # @!method initialize(calculate_output:, graders:, name:, type: :multi)
        #   A MultiGrader object combines the output of multiple graders to produce a single
        #   score.
        #
        #   @param calculate_output [String] A formula to calculate the output based on grader results.
        #
        #   @param graders [Hash{Symbol=>OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::LabelModelGrader}]
        #
        #   @param name [String] The name of the grader.
        #
        #   @param type [Symbol, :multi] The object type, which is always `multi`.

        # A StringCheckGrader object that performs a string comparison between input and
        # reference using a specified operation.
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

          # A LabelModelGrader object which uses a model to assign labels to each item
          # in the evaluation.
          variant -> { OpenAI::Graders::LabelModelGrader }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::LabelModelGrader)]
        end
      end
    end

    MultiGrader = Graders::MultiGrader
  end
end
